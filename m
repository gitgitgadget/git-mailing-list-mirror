From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's new in git-gui.git
Date: Tue, 29 May 2007 22:39:33 -0400
Message-ID: <20070530023933.GL7044@spearce.org>
References: <20070528224949.GC7044@spearce.org> <20070529041108.GG7044@spearce.org> <Pine.LNX.4.64.0705291157540.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 30 04:40:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtE6j-0004xt-W3
	for gcvg-git@gmane.org; Wed, 30 May 2007 04:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbXE3Cji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 22:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbXE3Cjh
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 22:39:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42002 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbXE3Cjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 22:39:37 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtE5s-0003lz-3q; Tue, 29 May 2007 22:39:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B2A7B20FBAE; Tue, 29 May 2007 22:39:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705291157540.4648@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48724>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> On Tue, 29 May 2007, Shawn O. Pearce wrote:
> 
> > Apparently the Linux folks have this new fangled inotify thing that is 
> > also good at telling applications about changed files. It seems the hg 
> > folks are using it to speed up "hg status" by having a background daemon 
> > keep track of which files are dirty, and which aren't.
> 
> An SCM which runs a background process? Please, no.

Well, not required.  Making it required to make things work is
clearly insane.  But letting a user optionally start a background
process to monitor their working directory and cache dirty
flags for files may be faster for some users on some systems
and some workflows.  And it could make git-gui more responsive.
If git-gui starts/stops the "background process" along with its
window opening/closing, who cares that its running?  Especially if
it can be enabled/disabled by a little checkbox thingy?

> Next thing is, you have a daemon running which permanently scans your 
> source code for copynotsoright violations.

I won't.  Maybe a future employer of yours might...  ;-)

-- 
Shawn.
