From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Bug in gitk - can post the window off screen
Date: Thu, 7 Feb 2008 01:30:20 -0500
Message-ID: <20080207063020.GP24004@spearce.org>
References: <47AAA254.2020008@thorn.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tommy Thorn <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Thu Feb 07 07:31:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN0Hj-0002qh-GC
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 07:30:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbYBGGaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 01:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYBGGaZ
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 01:30:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50744 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbYBGGaY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 01:30:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JN0H8-0002LJ-2B; Thu, 07 Feb 2008 01:30:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C8C3F20FBAE; Thu,  7 Feb 2008 01:30:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47AAA254.2020008@thorn.ws>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72898>

Tommy Thorn <tommy-git@thorn.ws> wrote:
> Just a quick heads-up: I was running a dual screen setup with gitk on my 
> 2nd monitor. When I later started gitk up without the 2nd monitor, the 
> gitk window didn't appear. Given the time between the two sessions, it 
> didn't occur to me what the problem was.
> 
> Gitk should probably validate the "set geometry(main)" variable against 
> the current resolution.

Sad to say but this is a known issue with both gitk and git-gui.
Both applications save the prior geometry and restore it during
the next run, but neither validates the new geometry makes sense
with the current available desktop space.  :-\

-- 
Shawn.
