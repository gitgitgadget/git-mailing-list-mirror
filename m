From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 07 Jun 2013 20:32:14 +0200
Message-ID: <vpqip1pzs9d.fsf@anie.imag.fr>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
	<CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
	<alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
	<CALkWK0nUoF2VX6Ns09vQHYo11520_4r9ikYmkZW108aQm1RpoQ@mail.gmail.com>
	<vpqhah9248u.fsf@anie.imag.fr>
	<CALkWK0mLVxKGvvYmREFyEkp6CgWuOEmML5V4ajF8R0SK62D4Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?iso-8859-1?Q?R?= =?iso-8859-1?Q?en=E9?= Scharfe 
	<rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?iso-8859-1?Q?Nguy=ADn_Th=E1i_Ng=F7c?= <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:33:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1TK-0007Se-IY
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756829Ab3FGSdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 14:33:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48862 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756768Ab3FGSdE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 14:33:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r57IWDrq021765
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Jun 2013 20:32:15 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ul1SR-0002vG-8X; Fri, 07 Jun 2013 20:32:15 +0200
In-Reply-To: <CALkWK0mLVxKGvvYmREFyEkp6CgWuOEmML5V4ajF8R0SK62D4Gg@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 7 Jun 2013 23:54:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 07 Jun 2013 20:32:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r57IWDrq021765
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371234738.08971@+wkbd/3licltCBxQyyYR/Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226661>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> I think he way forward on Windows is an implementation like libgit2 or
> git# with some sort of gui/ide integration.  I never understood why
> users on Windows want to use something as POSIX'y as git.git.

Whether it's based on POSIX is an implementation detail for the user.
The real question is more command-line Vs GUI than POSIX/Win32. Some
Linux users like GUI, some windows users use command-line. I tried IDE
integration with EGIT, and quite frankly I ended-up doing all the Git
stuff in a terminal next to Eclipse.

> Wouldn't they prefer some visual-studio integration thing? *scratches
> head*

Visual Studio now has official Git support from MS (based on libgit2 if
I understood correctly). That's cool, but not a reason to kill msysgit
IMHO ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
