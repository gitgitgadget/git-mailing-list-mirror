From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/2] Make gc a builtin.
Date: Mon, 12 Mar 2007 10:29:36 -0400
Message-ID: <20070312142936.GD15150@spearce.org>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com> <20070312025736.GA28505@thunk.org> <Pine.LNX.4.63.0703121222350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>,
	James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 12 15:29:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQlWz-0007lz-M3
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 15:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965831AbXCLO3n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 10:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965864AbXCLO3n
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 10:29:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43482 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965831AbXCLO3m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 10:29:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQlWm-0006cs-8p; Mon, 12 Mar 2007 10:29:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 67BF020FBAE; Mon, 12 Mar 2007 10:29:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0703121222350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42032>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 11 Mar 2007, Theodore Tso wrote:
> 
> > On Sun, Mar 11, 2007 at 06:06:56PM -0400, James Bowes wrote:
> > > The following two patches make git-gc a builtin command.
> > 
> > What's the advantage in making git-gc a builtin command?
> 
> Portability. Plus, James wanted to get involved in Git development, and 
> building in gc really was the shortest path into that.

Actually, git-gc.sh is pretty portable.  To POSIX systems.
Windows ain't POSIX.  Getting rid of some of those shell scripts
just makes us more portable, even to Windows.  (Yes, people really
do still get forced to use that non-operating system.)

Ted talked about git-commit.sh being more important, but Dsco
clipped it. ;-)

I think git-commit.sh and git-merge.sh should both get ported to
builtins too, as both are somewhat hairy in shell, are quite core
to the system, and would be faster on Windows if written in C
(less forking == more speed there).

But they are so core that any rewrite must be undertaken carefully.

-- 
Shawn.
