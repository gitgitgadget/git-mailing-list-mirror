From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GIT on Windows
Date: Wed, 9 May 2007 14:58:35 -0400
Message-ID: <20070509185835.GC3141@spearce.org>
References: <loom.20070509T142518-558@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Panagiotis Issaris <takis.issaris@uhasselt.be>
X-From: git-owner@vger.kernel.org Wed May 09 20:58:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlrN5-0003F6-6Q
	for gcvg-git@gmane.org; Wed, 09 May 2007 20:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751076AbXEIS6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 14:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756067AbXEIS6j
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 14:58:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59161 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbXEIS6i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 14:58:38 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlrMq-0004m2-J0; Wed, 09 May 2007 14:58:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1D15320FBAE; Wed,  9 May 2007 14:58:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <loom.20070509T142518-558@post.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46768>

Panagiotis Issaris <takis.issaris@uhasselt.be> wrote:
> Any clues on the reason for this crash? Is anyone already using GIT on Windows
> on real repositories?

Yes, I'm using Git on Cygwin on real repositories.  My largest there
is about 60 MiB, ~70,000 objects, 10,000 files.  Myself and about
25 others who are required to use Windows use it every day just fine.

I also use HTTP fetch to download the latest git.git changes so I
can build them locally (I don't use the Cygwin package, I compile it
myself from scratch) but I haven't done a clone over HTTP in ages as
I already have a local git.git clone established in a few locations.
I'd build any new clone from my existing local ones first...

-- 
Shawn.
