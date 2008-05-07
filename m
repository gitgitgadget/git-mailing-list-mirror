From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words configurable
Date: Wed, 7 May 2008 22:11:49 +0800
Message-ID: <46dff0320805070711vc4c9a63uba3eaa7743381f20@mail.gmail.com>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>
	 <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
	 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
	 <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
	 <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
	 <alpine.DEB.1.00.0805060954470.30431@racer>
	 <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
	 <alpine.DEB.1.00.0805071223450.30431@racer>
	 <46dff0320805070519m569d9653ja276412fde135f45@mail.gmail.com>
	 <alpine.DEB.1.00.0805071408360.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 07 16:13:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtkNu-0001b2-HR
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 16:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbYEGOLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 10:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbYEGOLx
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 10:11:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:55511 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbYEGOLu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 10:11:50 -0400
Received: by wr-out-0506.google.com with SMTP id c48so108843wra.1
        for <git@vger.kernel.org>; Wed, 07 May 2008 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=eMeFQfRIWp67HDelSsEl0CDTQXKuCnAtHxxNTSyff0o=;
        b=H6wm7GJcGAxsyO8foeTSSlpa9U1jlyPkdfZJ6TnjsVw2adetIMbAvwpekZDwtHurOE7Ab1+OGB+iT1GX5fSfehJGYHXhaUy5yn9uV4/q7JYXltQoAK8rQG8nLVumUtH8G7uG/xgg5qWwKYdmEqcgjCw6A0TKQaxglBgkCcnLiYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N+o47mzumdx6rgAb9C3/pFMU1QRl+sAJ67bjxopBNAqIkALvKdMbG9z5YfKhUQ1XXYZiC2hwZZ8fPcaq83T05YIoz+wPRdpadL6LpHsaQ8RGz9zwqX5THUhDuFZAdpQXFhlX11yAEeitPhNBR/Is00C7IxnVbQCLN+agOmq+wjU=
Received: by 10.100.226.6 with SMTP id y6mr1661868ang.131.1210169509913;
        Wed, 07 May 2008 07:11:49 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Wed, 7 May 2008 07:11:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805071408360.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81437>

On Wed, May 7, 2008 at 9:10 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>  > Sorry, but i can't parse both sentences, especially Bikeshedding and
>  > "punch holes into".
>
>  "punch holes into": find cases where Junio's proposed algorithm breaks
>  down.

I think the --color-words={char,punct,word} covers most of the cases
that junio mentioned, except the case that a token can be a run of
word chars, a run of non-word chars or a run of whitespaces.

If anyone is interested in this case, he can extend --color-words with
a fourth option or tokenizer (i havn't yet found a good name for this
tokenizer).

Of course, if neccessary, one can implement other language-specific tokenizers.

However, i think the 3 tokenizers i mentioned is enough for most cases.

>
>  "bikeshedding": discussing minor implementation details that are not
>  really interesting at this stage.  See also
>  http://en.wikipedia.org/wiki/Bikeshedding.
>

See. THX.


-- 
Ping Yin
