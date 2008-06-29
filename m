From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 16/21] Add Robert Harder's public domain Base64 encoding utility
Date: Sun, 29 Jun 2008 14:06:55 -0400
Message-ID: <20080629180655.GH11793@spearce.org>
References: <1214726371-93520-1-git-send-email-spearce@spearce.org> <1214726371-93520-16-git-send-email-spearce@spearce.org> <1214726371-93520-17-git-send-email-spearce@spearce.org> <200806291551.08166.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 20:07:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD1Jc-00077Y-E6
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 20:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931AbYF2SHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 14:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754701AbYF2SHA
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 14:07:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35679 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbYF2SG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 14:06:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KD1IX-0006IP-CM; Sun, 29 Jun 2008 14:06:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 68A0B20FBAE; Sun, 29 Jun 2008 14:06:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200806291551.08166.robin.rosenberg@dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86815>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> 
> Dragging in apache commons libraries seems to be too much at this
> point, one class, so this choice is understandable at this point.
> 
> Other that that Apache Commons are almost ubiquotous these days
> and so be considered at every point when we need external code.

True.  But I have a nearly allergic reaction to Apache code;
for some reason its always sort of not quite there.  Which also
describes jgit so I shouldn't say anything.  ;-)

We can always rip this implementation out if we do wind up taking
in the Apache Commons libraries for other support.  There is only
1 or two calls sites and it should be easy enough to change over
to the Apache Commons implementation.

-- 
Shawn.
