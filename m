From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Mon, 12 May 2008 11:57:48 -0700 (PDT)
Message-ID: <m34p934afu.fsf@localhost.localdomain>
References: <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
	<46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
	<alpine.DEB.1.00.0805060954470.30431@racer>
	<46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
	<alpine.DEB.1.00.0805071223450.30431@racer>
	<7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
	<20080508103436.GB3300@mithlond.arda.local>
	<46dff0320805100202j54b0922cy50a2c93c4eff1757@mail.gmail.com>
	<46dff0320805110616s6df19657r1e4c80634267fd81@mail.gmail.com>
	<7vod7c6c24.fsf@gitster.siamese.dyndns.org>
	<46dff0320805120931u7609a5a2x5433d78e35a62c48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Teemu Likonen" <tlikonen@iki.fi>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 20:58:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvdER-00030O-5G
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 20:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbYELS5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 14:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbYELS5y
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 14:57:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:2018 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbYELS5x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 14:57:53 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1132457nfc.21
        for <git@vger.kernel.org>; Mon, 12 May 2008 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=iOkW+47ZItbbNdPFeIaDxLZDf0dOGgznbV1Pi+PCAJY=;
        b=CFvyG+/AV9h08nTWdGV889Vx/kW0dmtvCgQkp4HmqaJgqk3a05ARwY/xjCJpzTdXbNg0Z8budj3jW4TXPMKyvpuHMxgVPCYS/Ieh//Ha/A4UJI2yk2slVcL3aYz0+n7dYcy/LAxc8/TOM3sVGr+GLsk+CI8zL5qoMNvYXAJCT5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=s0UNO+EXAOTQ+UE+Tp4BQbDd/Xw63uG563QcvTHgrcPDCwp82jMb39FTvjb1HEuuyRfNu5YRUbvudzyaAD9gW1sPKyaorc/K5OpSdjYKsLWgNMqy11jxlCWnjgxcqOesqKk269CKYl/QoWd5mgc+aW33eOFWT+8/SP52U59rMag=
Received: by 10.210.115.15 with SMTP id n15mr7534567ebc.81.1210618670668;
        Mon, 12 May 2008 11:57:50 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.214.115])
        by mx.google.com with ESMTPS id b36sm5119919ika.5.2008.05.12.11.57.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 11:57:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4CIvgfd014080;
	Mon, 12 May 2008 20:57:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4CIvgQ6014076;
	Mon, 12 May 2008 20:57:42 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <46dff0320805120931u7609a5a2x5433d78e35a62c48@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81907>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Mon, May 12, 2008 at 12:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Ping Yin" <pkufranky@gmail.com> writes:
>>
>>> With following patch, the diff output becomes (i don't know which
>>> one is better)
>>>
>>> OpenOffice.org has {+a }user setting for defining the minimum length for
>>> words to be hyphenated. By default the word length is counted from the
>>> whole word - even for compound words. For example the {compound +}word
>>> 'elokuvalippu' is {+considered }12 characters long. The word will be hyphenated like
>>>  'elo-ku-va-lip-pu' in all cases when the minimum word length is set to
>>>  12 or less. If the minimum length is set to 13 or more the word is not
>>>  hyphenated at all.
>>
>>  Yeah, after playing with it a bit, I realize that my original
>>  stated goal of not playing games with "newline suppression" goes
>>  very against what color-words, which is a word oriented diff,
>>  tries to achieve.  It appears that it is necessary to reintroduce
>>  suppressed_newline.
>>
> 
> No matter how well we play with suppressed_newline, we still can't
> achieve the best result by doing word diff between multiple minus
> lines and multiple plus lines.
> 
>  ( i think the result of vimdiff can be considered as the best).

Is the vimdiff algorithm described anywhere? What about wdiff output?
 
> To achieve the best, we have to find the pairs of lines (one minus and
> one plus for each pair) which most match each other, and then do the
> word diff for each pair.

Wouldn't be enough to treat run of plus/minus lines as a single block,
tokenize, do token-based (as opposed to line-based) diff, then show it
using linebreaks of the destination file (pluses line)?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
