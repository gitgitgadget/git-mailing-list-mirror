From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [CORRECTED PATCH] Introduce file with the common default build-time items.
Date: Fri, 15 Jun 2007 01:58:13 -0400
Message-ID: <20070615055813.GG18491@spearce.org>
References: <20070613054316.GN86872@void.codelabs.ru> <20070614043633.GV6073@spearce.org> <20070614095654.GT86872@void.codelabs.ru> <20070614150929.GA18491@spearce.org> <20070614190739.GA3779@void.codelabs.ru> <20070615032204.GC18491@spearce.org> <20070615054002.GD3779@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Fri Jun 15 07:58:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz4pA-00079g-2K
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 07:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbXFOF6S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 01:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbXFOF6S
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 01:58:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37077 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbXFOF6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 01:58:17 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hz4p5-00074R-Do; Fri, 15 Jun 2007 01:58:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C008A20FBAE; Fri, 15 Jun 2007 01:58:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070615054002.GD3779@void.codelabs.ru>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50244>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> Thu, Jun 14, 2007 at 11:22:04PM -0400, Shawn O. Pearce wrote:
> > > OK, it means that git-gui will be totally separated from the
> > > git.git?  And one will download it as the separate tarball?
> > 
> > That's one option.  But Junio and I are also considering keeping
> > it inside the git tarball as well, as many users have gotten used
> > to it being in the core Git distribution.  I think it all depends
> > on if myself (or someone else) adds subproject recursion support
> > into git-archive.  ;-)
> 
> OK, I just wondered what to expect from the 1.6, since I am
> trying to keep FreeBSD port in sync with the latest Git release.

Heh.  Got a crystal ball?

I'm not sure anyone knows what the 1.6 release will look like yet.
Right now I know we're trying to get the submodule user interface
built and stable, before we start eating that dogfood as part of
the core Git code itself.  But we do want to be using our own tools
to build our tools.  ;-)

1.6 is just a number thrown on the wall as its likely that by the
time we get around to having a release worthy of the name 1.6 enough
users will be running a 1.5.2 or newer that has at least some of
the basic plumbing and porcelain for subprojects that it wouldn't
be a problem if we started using it ourselves in the git.git project.

-- 
Shawn.
