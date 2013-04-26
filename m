From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] clean: confirm before cleaning files and directories
Date: Fri, 26 Apr 2013 10:21:54 +0200
Message-ID: <vpqfvydhfbx.fsf@grenoble-inp.fr>
References: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 10:22:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVdv2-0008Kf-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 10:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab3DZIWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 04:22:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56803 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752229Ab3DZIWE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 04:22:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3Q8LrbN020560
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 26 Apr 2013 10:21:53 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UVduk-0003tZ-Hj; Fri, 26 Apr 2013 10:21:54 +0200
In-Reply-To: <1826d070612808b301f9295838e226e02d8097ad.1366963586.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Fri, 26 Apr 2013 16:07:56 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Apr 2013 10:21:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3Q8LrbN020560
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367569315.68408@5EdzdOv9ufYKBxFy/FtrJg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222509>

Jiang Xin <worldhello.net@gmail.com> writes:

>  * run `git clean` in interactive sessions,
>  * not a dry run,
>  * and not quiet.

Err, does this mean I'll have:

$ git clean
fatal: clean.requireForce defaults to true and neither -n nor -f given; refusing to clean
$ git clean --force
Are you sure [y/n]?

An optional confirmation dialog seems interesting, but activating it by
default even with --force seems really weird.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
