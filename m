From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull a subtree, embedded trees
Date: Wed, 13 Sep 2006 11:00:28 -0400
Message-ID: <20060913150028.GB29608@spearce.org>
References: <4508020F.2050604@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 13 17:02:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNWEM-00014Q-Fr
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 17:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWIMPAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 11:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWIMPAd
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 11:00:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:32675 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750940AbWIMPAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 11:00:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNWDx-0007Lc-3Q; Wed, 13 Sep 2006 11:00:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6638D20E49A; Wed, 13 Sep 2006 11:00:28 -0400 (EDT)
To: Tim Shimmin <tes@sgi.com>
Content-Disposition: inline
In-Reply-To: <4508020F.2050604@sgi.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26912>

Tim Shimmin <tes@sgi.com> wrote:
> I've written a simple small program to dump out the index
> entries (cache entries).

`git-ls-files --stage` also dumps a number of those details, though
it doesn't dump every available field.

> I just want to see what is exactly stored in the .git
> binary files and how they change when I do various git
> operations.

You may want to review some of the material in
Documentation/core-tutorial.txt and Documentation/technical.
These documents try to describe some of the formats but reviewing
them now it looks like there's still some additional information
that could be written down.

-- 
Shawn.
