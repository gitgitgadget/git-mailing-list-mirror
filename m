From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Makefile: do not compile git with debugging symbols by default
Date: Thu, 22 Jan 2015 18:36:41 +0100
Message-ID: <vpqa91ahg46.fsf@anie.imag.fr>
References: <1421931037-21368-1-git-send-email-kuleshovmail@gmail.com>
	<20150122130036.GC19681@peff.net>
	<CANCZXo7ocgG27Y48NjYxurVMWOvHkvGqDrLuntkSTxHUK6hcNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 18:37:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YELgv-0002HL-Nu
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 18:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbbAVRhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 12:37:10 -0500
Received: from mx1.imag.fr ([129.88.30.5]:41330 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbbAVRhI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 12:37:08 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t0MHadh0014916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 22 Jan 2015 18:36:39 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t0MHafNu019807;
	Thu, 22 Jan 2015 18:36:41 +0100
In-Reply-To: <CANCZXo7ocgG27Y48NjYxurVMWOvHkvGqDrLuntkSTxHUK6hcNw@mail.gmail.com>
	(Alexander Kuleshov's message of "Thu, 22 Jan 2015 22:51:55 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 22 Jan 2015 18:36:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t0MHadh0014916
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1422553003.02854@ccLNoPIfShKtthbwrjVn0A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262848>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Hello Jeff,
>
> Yes, main point is size of executable.

The Git executable is a few megabytes, i.e. 0.001% the size of a really
small hard disk. The benefit seems really negligible to me.

OTOH, debug information allow users to do better bug reports in case of
crash (gdb, valgrind), which outweights by far the benefit of saving a
handfull of megabytes IMHO.

On a side note, I find it very frustrating when a program I use
crashes, opens a bug report wizard, and end up telling me "sorry, your
distro removed the debug symbols, recompile everything if you want to
report a bug".

I understand that for a few users, the size of executable matters. But
this category of users should be able to find the "strip" target or
something equivalent.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
