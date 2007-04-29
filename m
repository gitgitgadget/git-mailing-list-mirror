From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] import-tars: be nice to wrong directory modes
Date: Sat, 28 Apr 2007 21:11:21 -0400
Message-ID: <20070429011121.GT5942@spearce.org>
References: <Pine.LNX.4.64.0704290159230.29859@racer.site> <20070429000842.GR5942@spearce.org> <7vk5vwhttj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 03:11:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hhxwo-0007vo-7o
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 03:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbXD2BL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 21:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbXD2BL1
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 21:11:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47309 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbXD2BL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 21:11:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HhxwX-00078b-8o; Sat, 28 Apr 2007 21:11:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F35CD20FBAE; Sat, 28 Apr 2007 21:11:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vk5vwhttj.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45806>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >> 
> >> Some tars seem to have modes 0755 for directories, not 01000755. Do
> >> not generate an empty object for them, but ignore them.
> >
> > This fix is small and corrects a rather ugly repository corruption,
> > so I've applied it to my gfi-maint branch.
> 
> Good teamplay.  So you want me to pull gfi-maint to maint and
> gfi-master to master?

Right.

And apply the fsck patch i sent to the list.  ;-)
 
-- 
Shawn.
