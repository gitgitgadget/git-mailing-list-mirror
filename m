From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Re* [1.8.0] Provide proper remote ref namespaces
Date: Mon, 14 Feb 2011 22:57:24 +0100
Message-ID: <vpqr5bath2z.fsf@bauges.imag.fr>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<201102140036.42197.johan@herland.net>
	<7vfwrrukzq.fsf@alter.siamese.dyndns.org>
	<201102141018.46527.johan@herland.net>
	<7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
	<AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
	<AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
	<AANLkTin5ZcZU8iwPSm4A87bYRrSCcXJVLBFGSr2+j30j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 23:01:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp6Tp-0007B2-Sb
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 23:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680Ab1BNWBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 17:01:08 -0500
Received: from imag.imag.fr ([129.88.30.1]:39194 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079Ab1BNWBH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 17:01:07 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p1ELvPaI021530
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 14 Feb 2011 22:57:25 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Pp6Q9-0006gF-4C; Mon, 14 Feb 2011 22:57:25 +0100
In-Reply-To: <AANLkTin5ZcZU8iwPSm4A87bYRrSCcXJVLBFGSr2+j30j@mail.gmail.com> (Jay Soffian's message of "Mon\, 14 Feb 2011 14\:50\:17 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 14 Feb 2011 22:57:25 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166780>

First, I'd be really glad if push.default changed to "current", that's
what I want 99% of cases, if not more.

Jay Soffian <jaysoffian@gmail.com> writes:

> Alternately, you could take the wall of text approach, which I was
> trying to avoid:
>
>   push.default is unset; its implicit value is changing in 1.8.0 from
>   'matching' to 'current'. To squelch this message and maintain the current
>   behavior post-1.8.0, use 'git config [--global] push.default matching'. To
>   squelch this message and adopt the 1.8.0 behavior now, use
>   'git config [--global] push.default current'. See 'git help config' and
>   search for 'push.default' for further information.

I actually like this, although it's a bit verbose: I think telling the
user "something will change" without telling what is very frustrating,
so the "from 'matching' to 'current'" part seems really good.

I'd remove the [] around the --global, to make the command
cut-and-paste ready. Advanced users know whether to remove the
--global, and newbies don't want to remove it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
