From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-gui: fix "Explore Working Copy" for Windows again
Date: Fri, 26 Feb 2010 01:46:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002260145510.20986@pacific.mpi-cbg.de>
References: <20100223225243.GC11271@book.hvoigt.net> <cb7bb73a1002232222r354a2ec7l9ea4cfd1c101e8c6@mail.gmail.com> <a5b261831002240412x30490e25wbec74cdbc1d0ebd2@mail.gmail.com> <201002250114.23322.markus.heidelberg@web.de>
 <20100225204451.GB12637@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@googlemail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 01:39:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkoEf-0006YE-6L
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 01:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934770Ab0BZAjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 19:39:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:40297 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934688Ab0BZAjK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 19:39:10 -0500
Received: (qmail invoked by alias); 26 Feb 2010 00:39:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 26 Feb 2010 01:39:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GEEBiRtJGkGQTigo8+lArl8bl5gD56/cM8pajUU
	u783fgLRF8wRjv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100225204451.GB12637@book.hvoigt.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141085>

Hi,

On Thu, 25 Feb 2010, Heiko Voigt wrote:

> On Thu, Feb 25, 2010 at 01:14:22AM +0100, Markus Heidelberg wrote:
> > It has already been fixed in commit 454efb47 (git-gui (Win): make
> > "Explore Working Copy" more robust, 2009-04-01), but has been broken in
> > commit 21985a11 (git-gui: handle non-standard worktree locations,
> > 2010-01-23) by accidentally replacing too much with a new variable.
> > 
> > The problem can be reproduced when starting git-gui from within a
> > subdirectory. The solution is to convert the path name, explorer.exe is
> > invoked with, to a platform native name.
> > 
> > Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> > ---
> 
> I can confirm that this does fix the issue which is actually also 
> apparent on Windows XP. If no objections occur I would apply this to the 
> devel branch for msysgit.

No objections from my side!

Thanks,
Dscho
