From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] tar archive frontend for fast-import.
Date: Thu, 8 Feb 2007 16:01:41 -0500
Message-ID: <20070208210141.GA1047@spearce.org>
References: <20070208203845.GB956@spearce.org> <Pine.LNX.4.63.0702082155210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 08 22:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFGOt-0002fS-LB
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 22:01:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423339AbXBHVBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 16:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423340AbXBHVBs
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 16:01:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33988 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423339AbXBHVBs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 16:01:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFGOd-0002Ua-1n; Thu, 08 Feb 2007 16:01:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 41D6B20FBAE; Thu,  8 Feb 2007 16:01:41 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702082155210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39092>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 8 Feb 2007, Shawn O. Pearce wrote:
> 
> > Each tar is treated as one commit, with the commit timestamp coming
> > from the oldest file modification date found within the tar.
> 
> You mean the youngest, i.e. the newest file, right? (I did not read the 
> code yet...)

Arrggh!  Yes, of course, the youngest/newest file.  The code (and
you) is right, the commit message is wrong.  ;-)

-- 
Shawn.
