From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] GIT_SSH does not override ssh in git-svn
Date: Mon, 17 Aug 2009 23:38:36 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172336410.8306@pacific.mpi-cbg.de>
References: <4A89C6F8.3010100@fastmail.fm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Karthik R <karthikr@fastmail.fm>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9tu-000895-CH
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167AbZHQVhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 17:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758165AbZHQVhs
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:37:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:44806 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753931AbZHQVhr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 17:37:47 -0400
Received: (qmail invoked by alias); 17 Aug 2009 21:37:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 17 Aug 2009 23:37:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194yvsFe+J4+hq1jCdrqdEiSzM3QafNy8d1cA3eXC
	fKNIpwBtw1Dr91
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A89C6F8.3010100@fastmail.fm>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126292>

Hi,

On Mon, 17 Aug 2009, Karthik R wrote:

> 
> 
> Signed-off-by: Karthik R <karthikr@fastmail.fm>
> ---
> 
> Setting GIT_SSH when using "git svn clone svn+ssh://..." does not override the
> default ssh; SVN_SSH needs to be set instead. Corrected this.
> 
> Also, on Windows, SVN_SSH needs to be set with \ escaped
>  e.g., "C:\\PuTTY\\plink.exe"
> 
> See http://code.google.com/p/msysgit/issues/detail?id=305

This probably all wants to go into the commit message: it is very useful 
information!

Besides, I think you would like to formulate the commit subject more 
positive: "Respect GIT_SSH in git-svn" or some such.  After all, you fix 
the issue.  IOW use the imperative: you command git-svn to behave ;-)

Ciao,
Dscho
