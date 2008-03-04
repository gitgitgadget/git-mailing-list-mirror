From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] autoconf: Test FREAD_READS_DIRECTORIES
Date: Tue, 4 Mar 2008 14:59:02 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041458220.22527@racer.site>
References: <200803041514.42783.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 04 16:00:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWYd1-0006tt-7p
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 16:00:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755943AbYCDO7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 09:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756419AbYCDO7u
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 09:59:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:59371 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755943AbYCDO7t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 09:59:49 -0500
Received: (qmail invoked by alias); 04 Mar 2008 14:59:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp014) with SMTP; 04 Mar 2008 15:59:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tWkM3Xntthkl1j0pOOpeKUDzJY0oQtguG876AMe
	5w6Ol6vO2hu8pp
X-X-Sender: gene099@racer.site
In-Reply-To: <200803041514.42783.michal.rokos@nextsoft.cz>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76093>

Hi,

On Tue, 4 Mar 2008, Michal Rokos wrote:

> +AC_RUN_IFELSE(
> +	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
> +		[[char c;
> +		FILE *f = fopen(".", "r");
> +		if (! f) return 0;
> +		if (f && fread(&c, 1, 1, f) > 0) return 1]])],
> +	[ac_cv_fread_reads_directories=no],
> +	[ac_cv_fread_reads_directories=yes])

I do not see the issue addressed that I saw on msysGit.

Ciao,
Dscho
