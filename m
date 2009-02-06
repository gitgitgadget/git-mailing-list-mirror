From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fix t1504 on Windows
Date: Fri, 6 Feb 2009 14:26:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902061425180.7377@intel-tinevez-2-302>
References: <498A1E1E.8010901@lsrfire.ath.cx> <498B3F6B.5080002@lsrfire.ath.cx> <498C3328.70804@viscovery.net> <alpine.DEB.1.00.0902061410210.7377@intel-tinevez-2-302> <498C3871.5000507@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 06 14:28:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVQkV-0007Wg-IM
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 14:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbZBFN0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 08:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbZBFN0Y
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 08:26:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:37722 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754010AbZBFN0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 08:26:23 -0500
Received: (qmail invoked by alias); 06 Feb 2009 13:26:20 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp026) with SMTP; 06 Feb 2009 14:26:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oGOAmi5GoMD9muSE0gIn5q6KekyDywfkrXmjZG8
	rpyLjrNCDOnbXS
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <498C3871.5000507@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108702>

Hi,

On Fri, 6 Feb 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> 
> > (I seem to remember that you use your own MSys environment rather than 
> > the msysGit environment.)
> 
> I switched to msysGit, the build environment, soon after you published 
> it. But I don't use rxvt or interactive bash.

Ah.

So the path mangling only hits you when you run a shell script, such as 
the tests?

Ciao,
Dscho
