From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Fix msvc build
Date: Thu, 31 Jan 2013 19:57:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1301311956470.32206@s15462909.onlinehome-server.info>
References: <510AB766.4030806@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:57:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0zKV-0004BA-LP
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab3AaS5Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:57:25 -0500
Received: from mout.gmx.net ([212.227.17.20]:52979 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753873Ab3AaS5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:57:24 -0500
Received: from mailout-de.gmx.net ([10.1.76.2]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0Lnmgj-1Ud2dB43NX-00hxEk for
 <git@vger.kernel.org>; Thu, 31 Jan 2013 19:57:23 +0100
Received: (qmail invoked by alias); 31 Jan 2013 18:57:22 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp002) with SMTP; 31 Jan 2013 19:57:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/aMPFoGR3a5LYiLvGHKKxAdLdMeYrEAJIj5aKPwU
	tS9Cmjn4Hv205X
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <510AB766.4030806@ramsay1.demon.co.uk>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215149>

Hi Ramsay,

On Thu, 31 Jan 2013, Ramsay Jones wrote:

> As I mentioned recently, while discussing a cygwin specific patch
> (see "Version 1.8.1 does not compile on Cygwin 1.7.14" thread), the
> MSVC build is broken for me.
> 
> The first 4 patches fix the MSVC build for me. The final patch is
> not really related to fixing the build, but it removed some make
> warnings which were quite irritating ...

Thanks!

> Note that I used the Makefile, with the Visual C++ 2008 command line
> compiler on Windows XP (SP3), to build a vanilla git on MinGW.  I'm not
> subscribed to the msysgit mailing list, nor do I follow the msysgit fork
> of git, so these patches may conflict with commits in their repository.

Maybe you can Cc: the patch series to msysgit@googlegroups.com
nevertheless?

Thanks,
Dscho
