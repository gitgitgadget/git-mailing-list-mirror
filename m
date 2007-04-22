From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problem with git-clone
Date: Sat, 21 Apr 2007 21:17:43 -0400
Message-ID: <20070422011743.GE17480@spearce.org>
References: <loom.20070421T190848-931@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Parag Warudkar <parag.warudkar@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 03:17:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfQi6-0001IX-Ib
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 03:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbXDVBRs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 21:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbXDVBRs
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 21:17:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36187 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbXDVBRr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 21:17:47 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HfQhq-0002lx-Ru; Sat, 21 Apr 2007 21:17:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2B1AF20FBAE; Sat, 21 Apr 2007 21:17:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <loom.20070421T190848-931@post.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45204>

Parag Warudkar <parag.warudkar@gmail.com> wrote:
> I have a reproducible problem with git-index-pack getting stuck. 
> Is this a known problem fixed in one of the later releases? 

Are you on Mac OS X?  We found that earlier versions of index-pack on
that platform ran poorly unless we used pread().  A change was made
in 1.5.0 to switch to pread for all platforms, which significantly
improved performance.
 
> git --version
> git version 1.4.4.2

I'd upgrade your Git, the current version is 1.5.1.1.

-- 
Shawn.
