From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-fetch and unannotated tags
Date: Thu, 26 Apr 2007 09:04:07 +0100
Message-ID: <200704260904.08447.andyparkins@gmail.com>
References: <200704252004.45112.andyparkins@gmail.com> <200704252142.33756.andyparkins@gmail.com> <7vfy6ow4my.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 10:19:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from pat.uio.no ([129.240.10.15])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgzCN-0006Ik-4L
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 10:19:31 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1HgzCN-00028i-2H
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 10:19:31 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1HgzCL-0004Zi-QU
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 10:19:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933193AbXDZIFd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 04:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933153AbXDZIFd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 04:05:33 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:8478 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933465AbXDZIE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 04:04:59 -0400
Received: by wr-out-0506.google.com with SMTP id 76so532249wra
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 01:04:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FkMOg0+6P0pThHI1TDawZvoryLRfzNduIGaqEbcdLcPtRCzbCP7dtMO+7FMTzQdv/AGRzfkpw4BzTQe1w4S14EAihrHDlO3FqMBRHGHaWMo2i70BttiJK8Z+fQzQBE2jlD8Q6tIgDLJgdqyjPG2DClYa+iDpaB1enpUbQaLDeIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IZdYXGtLR7rS54XJGLvCSMH9eLTKatOcsxHe3GK/Sbnqio+72+ckEmDdXOr4w18wbG6yXNu3JgsyasW9wQxxUtqDK8FZiN3vEcrWH6vqqYeGFdhWe4i8Mmo5Dcrgz/GaU+aKvm3kMc/UyVWSMJ8iMSpejYZ2Ds3ymnH+XkdcAD0=
Received: by 10.82.123.16 with SMTP id v16mr2712027buc.1177574698211;
        Thu, 26 Apr 2007 01:04:58 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y34sm2435832iky.2007.04.26.01.04.33;
        Thu, 26 Apr 2007 01:04:51 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vfy6ow4my.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.5, required=12.0, autolearn=disabled, AWL=1.500,UIO_VGER=-3)
X-UiO-Scanned: 7A46D9ADB3ED388237E80ACA9ADAFD553C855A32
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -14 maxlevel 200 minaction 2 bait 0 mail/h: 43 total 158150 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45617>

On Wednesday 2007 April 25, Junio C Hamano wrote:

> >> You could even modify git-tag to create them for you with some
> >> appropriate switch ...
> >
> > Well yes, but that's the answer to everything isn't it?
>
> The answer to everything you want to change the current
> behaviour is to code something that implement that change.  What
> else is new?

Apologies - I wasn't saying that someone else should add features I want, I 
was saying that locally changing /my/ git-tag isn't very useful.  I already 
get by with git, so when I post suggestions to the mailing list it's usually 
with respect to the wider context.   In this case, patching git-tag to create 
refs/andys-private-tags/ doesn't seem like the right thing to do in mainline 
git :-)

> I suspect that if you look at what git-fetch.sh does in the
> paragraph that follows /^# automated tag following/, it probably
> is not that much change.  At that point,
 ... snip ...

That advice on the other hand is excellent.

Is this something that others would be in favour of?  I'm soliciting for 
reasons why unannotated tags should be auto-followed?

> Take a look at exclude_existing() function in builtin-show-ref.c;
> your additional option to the command would say something like:

I'd be arguing for making not following unannotated tags the default, and then 
supply a switch to make them followed.  Is that too painful?  I think that's 
in keeping with the tradition that unannotated tags are, typically, not 
wanted in a central repository - the default update hook prevents it for 
example.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
