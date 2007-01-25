From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Per-file force update
Date: Thu, 25 Jan 2007 12:22:26 -0500
Message-ID: <20070125172226.GB13089@spearce.org>
References: <op.tmpzmzvtzidtg1@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Troy Telford <ttelford.groups@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 18:22:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA8Iz-0000G0-GV
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 18:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030449AbXAYRWa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 12:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbXAYRWa
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 12:22:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40576 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030449AbXAYRW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 12:22:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HA8Iq-0006N6-WB; Thu, 25 Jan 2007 12:22:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5356520FBAE; Thu, 25 Jan 2007 12:22:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <op.tmpzmzvtzidtg1@rygel.lnxi.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37746>

Troy Telford <ttelford.groups@gmail.com> wrote:
> I've got a file that (due to some inner workings) changes whenever it's  
> built.
> 
> This causes a problem with git, causing merge conflicts.
> 
> Is there a way I can configure git to /always/ do the equivalent of 'git  
> pull -f', but only for that one file?

Take the file out of the repository.  If its being rebuilt everytime
you build, why are you tracking it in Git?

Git is for tracking *sources*.  That file sounds like its an output,
which shouldn't be tracked.

-- 
Shawn.
