From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Sun, 04 May 2008 13:47:28 -0700 (PDT)
Message-ID: <m3ve1t6bli.fsf@localhost.localdomain>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	<1209815828-6548-1-git-send-email-pkufranky@gmail.com>
	<1209815828-6548-2-git-send-email-pkufranky@gmail.com>
	<1209815828-6548-3-git-send-email-pkufranky@gmail.com>
	<1209815828-6548-4-git-send-email-pkufranky@gmail.com>
	<1209815828-6548-5-git-send-email-pkufranky@gmail.com>
	<7vy76rtfns.fsf@gitster.siamese.dyndns.org>
	<46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>
	<alpine.DEB.1.00.0805041040560.30431@racer>
	<46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
	<7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Ping Yin" <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 04 22:48:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsl8H-0000FX-8W
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 22:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbYEDUrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 16:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbYEDUrc
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 16:47:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:11641 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbYEDUrb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 16:47:31 -0400
Received: by nf-out-0910.google.com with SMTP id d3so983861nfc.21
        for <git@vger.kernel.org>; Sun, 04 May 2008 13:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=s1P9U62uutZYnzzEVUHkKFNghkRfaQ0xQ7jV5cvTtuM=;
        b=ahHrJQmgEySAtyF/uQOfKtSZmWymdUnXx2ly5X1ANou4MQLg5GET0Sueo48NhzJ/UsWL+PFRF+CBG1CbPU0sDE+/vKT5mBRlfr4D4RSBMPdNKTa4KqVw16LM3cqUjP9yPiogR1KK/HujeA7AGPOeNkmEqssvdZC9X3RC+8lo0JY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=w1vmWQMRkUXYV3Xae++dCDLsyJYhSlJfO7272MoCHF0VbehFvMt8X1XK8nbBE2TLxteDvHwDHPL2swQwqfKveV8uDLyEoEcylh6dZ5h8W+obs/jFL1GW9qTs+PiQqFTVX5gaeqoNvhnUMFk+ws7Oe7qRIVLA28gcHVEYgDnkQvk=
Received: by 10.210.34.2 with SMTP id h2mr4982878ebh.110.1209934049529;
        Sun, 04 May 2008 13:47:29 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.224.254])
        by mx.google.com with ESMTPS id z33sm10066478ikz.0.2008.05.04.13.47.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 May 2008 13:47:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m44KlQrS004400;
	Sun, 4 May 2008 22:47:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m44Kl60K004396;
	Sun, 4 May 2008 22:47:07 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81199>

Junio C Hamano <junio@pobox.com> writes:

> Let's step back a bit and try to clarify the problem with a bit of
> illustration.
> 
> The motivation behind "word diff" is because line oriented diff is
> sometimes unwieldy.
> 
>     -Hello world.
>     +Hi, world.
[...]
> We instead can do this word by word (note that I am doing this as a
> thought experiment, to illustrate what the problem is and what should
> conceptually happen, not suggesting this particular implementation):
> 
>     preimage        postimage       word-diff
>     48656c6c6f                      -48656c6c6f Hello
>                     4869            +4869       Hi
>                     2c              +2c         ,
>     20              20               20         ' '
>     776f726c64      776f726c64       776f726c64 world      
>     2e              2e               2e         .
>     0a              0a               0a         '\n'
> 
> Which would give you "/Hello/Hi,/ world.\n".

Would it be possible instead of in-line word diff, use word coloring
to enhance traditional diff format?  Something like

     -/Hello/ world.
     +/Hi,/ world.

(We could use bold, or reverse for marking changed fragment, or use
color only for changed fragment).

IMHO current output is nice, unless you have long lines and not very
wide screen...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
