From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH next 2/2] Remove python 2.5'isms
Date: Thu, 10 Jun 2010 09:35:48 +0200
Message-ID: <AANLkTimLiLfGAMLp0n86eCIQFViu4veu0aTL6yuA_8f1@mail.gmail.com>
References: <nduJYSHPH3U3cC4hTqPaVi-iLDqB7pemU3zevJMNRmyDsRKmtq_gVu-G9W-She7bPSFG9LafRk0@cipher.nrlssc.navy.mil> 
	<nduJYSHPH3U3cC4hTqPaVieVkcHeedXMjA92T_KB9XTSNMZ0NeKHomHE5LPZ65BzOnHb--wYKXY@cipher.nrlssc.navy.mil> 
	<AANLkTikmdsJwy06WuRwpLEKzZE45VZcvPDDxnW1OCb8K@mail.gmail.com> 
	<4C1094BF.5070907@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	johan@herland.net, davvid@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 10 09:36:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMcJE-0003iQ-39
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 09:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab0FJHgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 03:36:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57529 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558Ab0FJHgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 03:36:09 -0400
Received: by gye5 with SMTP id 5so4491273gye.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 00:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=uMr3znQuUbVPXfqK5/UKsryqHpb05rURmoCtG/JgA4Y=;
        b=ltG6f8d5eerjvZrqBA6ERFO3KsFreJXXzE6LtJ2RXtBnfd6iwdVDhXY1wQhOJ2t9mU
         RIuS6j6AyHIBH01mqhRV3ovuB6SYIXDUIayfR0RQNbgTK3JhfnqnjRz12qkAQPJ8gtYp
         aDpVlsOm83QQE3FZ63UQs35zrdZublGWnuOKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HiRWsEHGao4bDBKGM/8OwmIEFtJd24WROPJoU4o6tS6nlwYQ1FtPay0u1E1hdk0QgU
         pVuhVqoBvX2MYGLHr9EqtCpXPJHddSWiemwXa301TRnu0KLs0+crF5bX7jSKIjbpzlrX
         rzMZojArgNTZFW8Z0RiWBGcXTpH/kJJgz9TYI=
Received: by 10.150.183.21 with SMTP id g21mr1318790ybf.69.1276155368127; Thu, 
	10 Jun 2010 00:36:08 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Thu, 10 Jun 2010 00:35:48 -0700 (PDT)
In-Reply-To: <4C1094BF.5070907@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148837>

Heya,

On Thu, Jun 10, 2010 at 09:31, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Note that due to the use of an iterator (which P2.4 has) rather than a
> list or set, the expression is just as efficient, i.e. calls
> startswith() only as often as necessary.

I like that version a lot better, thanks. And I agree, the check_call
replacement code should just be put into it's own function in a
similar way, and we should use subprocess if it is available.

-- 
Cheers,

Sverre Rabbelier
