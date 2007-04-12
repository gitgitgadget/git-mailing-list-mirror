From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Don't yap about merge-subtree during make
Date: Thu, 12 Apr 2007 01:49:33 -0400
Message-ID: <20070412054933.GB12979@spearce.org>
References: <20070412052118.GA13119@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 07:49:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbsBh-00026y-2X
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 07:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbXDLFti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 01:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbXDLFti
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 01:49:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54258 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274AbXDLFth (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 01:49:37 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HbsBb-0000Dg-BO; Thu, 12 Apr 2007 01:49:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5D0F020FBAE; Thu, 12 Apr 2007 01:49:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070412052118.GA13119@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44324>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> By default we are pretty quiet about the actual commands that
> we are running.  So we should continue to be quiet about the new
> merge-subtree hardlink to merge-recursive.  Technically this is not
> a builtin, but it is close because subtree is actually builtin to
> a non-builtin.  So lets just make things easy and call it a builtin.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>


Such a quick short patch, I forgot -s...  ;-)

-- 
Shawn.
