From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Wrap RUNTIME_PREFIX warning in a compile-time
 condition
Date: Tue, 23 Feb 2010 11:03:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002231103170.20986@pacific.mpi-cbg.de>
References: <4B839282.1020605@viscovery.net> <alpine.DEB.1.00.1002231041230.20986@pacific.mpi-cbg.de> <4B83A330.5080403@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 10:57:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjrVm-0007t3-Ih
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 10:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918Ab0BWJ44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 04:56:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:52357 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751821Ab0BWJ4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 04:56:55 -0500
Received: (qmail invoked by alias); 23 Feb 2010 09:56:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 23 Feb 2010 10:56:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nxv4fv0kn9skL3ye5Ys1/IVV8i1oKpgyyjNCoDv
	BBIWEM2qRCbS3p
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B83A330.5080403@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140783>

Hi,

On Tue, 23 Feb 2010, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Tue, 23 Feb 2010, Johannes Sixt wrote:
> >> With this patch, individual developers can disable the warning by setting
> >>
> >>    BASIC_CFLAGS += -DNO_WARN_RUNTIME_PREFIX
> >>
> >> in config.mak.
> > 
> > Would this option not prefer to be a runtime option?
> 
> No. The warning is utterly useless IMO and extremely annoying, and the
> only reason that it still survives is because you disagree. ;-)

I have been convinced of things before. It just takes a good argument.

Ciao,
Dscho
