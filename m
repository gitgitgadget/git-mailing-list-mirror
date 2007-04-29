From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] import-tars: be nice to wrong directory modes
Date: Sat, 28 Apr 2007 20:08:42 -0400
Message-ID: <20070429000842.GR5942@spearce.org>
References: <Pine.LNX.4.64.0704290159230.29859@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 29 02:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhwyA-0005Xm-PJ
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 02:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754457AbXD2AIr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 20:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754460AbXD2AIr
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 20:08:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46489 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457AbXD2AIq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 20:08:46 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hhwxu-0004i1-DB; Sat, 28 Apr 2007 20:08:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A7D8920FBAE; Sat, 28 Apr 2007 20:08:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704290159230.29859@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45803>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Some tars seem to have modes 0755 for directories, not 01000755. Do
> not generate an empty object for them, but ignore them.

This fix is small and corrects a rather ugly repository corruption,
so I've applied it to my gfi-maint branch.

-- 
Shawn.
