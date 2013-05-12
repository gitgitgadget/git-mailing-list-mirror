From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v7 00/10] interactive git clean
Date: Sun, 12 May 2013 19:28:57 +0200
Message-ID: <vpq8v3khzty.fsf@grenoble-inp.fr>
References: <cover.1368011946.git.worldhello.net@gmail.com>
	<CAPig+cR6aa+xODi=8DoiBpqQZM1eBHkGBvGzMGB2PSiT3osMEw@mail.gmail.com>
	<7vwqr9fo9b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 12 19:29:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uba5B-0008K3-M2
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 19:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754741Ab3ELR3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 13:29:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43688 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568Ab3ELR3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 13:29:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r4CHSu77011475
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 12 May 2013 19:28:56 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uba4w-0007hD-8x; Sun, 12 May 2013 19:28:58 +0200
In-Reply-To: <7vwqr9fo9b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 08 May 2013 09:08:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 12 May 2013 19:28:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4CHSu77011475
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368984538.37116@fH5fytl5vdQ8hsyVOETqhg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224058>

Junio C Hamano <gitster@pobox.com> writes:

> Cleaning all unneeded files inside a single interactive session
> should *never* be the goal---that will lead to an over-engineered
> design (e.g. switching "clean -x" flags in the middle? why?).  I
> think Jiang's latest series is already way over-engineered,

I didn't read the end of the series in detail, but I tend to agree with
you. Maybe it's time to remember the YAGNI principle, and keep the
number of options small at least for now (e.g. drop 11/12 git-clean: add
toggle flags interactive action). When users (including us) will have
used "git clean -i" for a while, we'll have a better idea of what is
really needed.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
