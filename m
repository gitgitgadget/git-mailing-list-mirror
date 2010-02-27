From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] git-gui: fix "Explore Working Copy" for Windows
	again
Date: Sat, 27 Feb 2010 22:14:30 +0100
Message-ID: <20100227211428.GF33000@book.hvoigt.net>
References: <20100223225243.GC11271@book.hvoigt.net> <cb7bb73a1002232222r354a2ec7l9ea4cfd1c101e8c6@mail.gmail.com> <a5b261831002240412x30490e25wbec74cdbc1d0ebd2@mail.gmail.com> <201002250114.23322.markus.heidelberg@web.de> <20100225204451.GB12637@book.hvoigt.net> <alpine.DEB.1.00.1002260145510.20986@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@googlemail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 27 22:14:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlTzj-0004FA-GQ
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 22:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030882Ab0B0VOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 16:14:34 -0500
Received: from darksea.de ([83.133.111.250]:48617 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030853Ab0B0VOd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 16:14:33 -0500
Received: (qmail 2250 invoked from network); 27 Feb 2010 22:14:31 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 27 Feb 2010 22:14:31 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1002260145510.20986@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141227>

On Fri, Feb 26, 2010 at 01:46:05AM +0100, Johannes Schindelin wrote:
> On Thu, 25 Feb 2010, Heiko Voigt wrote:
> 
> > On Thu, Feb 25, 2010 at 01:14:22AM +0100, Markus Heidelberg wrote:
> > > It has already been fixed in commit 454efb47 (git-gui (Win): make
> > > "Explore Working Copy" more robust, 2009-04-01), but has been broken in
> > > commit 21985a11 (git-gui: handle non-standard worktree locations,
> > > 2010-01-23) by accidentally replacing too much with a new variable.
> > > 
> > > The problem can be reproduced when starting git-gui from within a
> > > subdirectory. The solution is to convert the path name, explorer.exe is
> > > invoked with, to a platform native name.
> > > 
> > > Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> > > ---
> > 
> > I can confirm that this does fix the issue which is actually also 
> > apparent on Windows XP. If no objections occur I would apply this to the 
> > devel branch for msysgit.
> 
> No objections from my side!

Done.

cheers Heiko
