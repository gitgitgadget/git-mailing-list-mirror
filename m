From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Print RUNTIME_PREFIX warning only when GIT_TRACE is
 set
Date: Tue, 23 Feb 2010 13:57:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002231357460.3980@intel-tinevez-2-302>
References: <4B839282.1020605@viscovery.net> <alpine.DEB.1.00.1002231041230.20986@pacific.mpi-cbg.de> <4B83A330.5080403@viscovery.net> <alpine.DEB.1.00.1002231103170.20986@pacific.mpi-cbg.de> <4B83A9A2.5080500@viscovery.net> <alpine.DEB.1.00.1002231201260.3980@intel-tinevez-2-302>
 <4B83BF40.4070802@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 13:58:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjuL3-0006RR-S6
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 13:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab0BWM6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 07:58:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:60714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751980Ab0BWM6C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 07:58:02 -0500
Received: (qmail invoked by alias); 23 Feb 2010 12:58:00 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp068) with SMTP; 23 Feb 2010 13:58:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18N+hR9l3AN0jEqJdMPXmCDxs2Ndm4U5Zkgx78U4L
	AWkkk0zTE++5IU
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4B83BF40.4070802@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140794>

Hi,

On Tue, 23 Feb 2010, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> When RUNTIME_PREFIX is enabled, the installation prefix is derived by
> trying a limited set of known locations where the git executable can
> reside. If none of these is found, a warning is emitted.
> 
> When git is built in a directory that matches neither of these known names,
> the warning would always be emitted when the uninstalled executable is run.
> This is a problem on Windows, where gitk picks the uninstalled git when
> invoked from the build directory and gets confused by the warning.
> 
> Print the warning only when GIT_TRACE is set.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

ACK

And thanks,
Dscho
