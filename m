From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull a subtree, embedded trees
Date: Mon, 18 Sep 2006 02:47:32 -0400
Message-ID: <20060918064732.GB20660@spearce.org>
References: <4508020F.2050604@sgi.com> <ee945j$h3u$1@sea.gmane.org> <450E3399.5070601@sgi.com> <20060918064255.GA20660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 08:47:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPCuq-0006ud-JM
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 08:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965485AbWIRGrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 02:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965490AbWIRGrh
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 02:47:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:22985 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965485AbWIRGrg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 02:47:36 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPCuk-0002RS-03; Mon, 18 Sep 2006 02:47:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B84CC20E48E; Mon, 18 Sep 2006 02:47:32 -0400 (EDT)
To: Timothy Shimmin <tes@sgi.com>
Content-Disposition: inline
In-Reply-To: <20060918064255.GA20660@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27235>

Shawn Pearce <spearce@spearce.org> wrote:
> Timothy Shimmin <tes@sgi.com> wrote:
> > So I added this to a script which walks over the objects directory,
> > to work out what all the object ids are so I can apply git-cat-file
> > to all the objects on my test directory.
> > I guess this will fall down if the objects are stored in a pack :)
> > I'll have to look and see how to extract all the object ids using
> > some command.
> 
> Try this:
> 
> 	git-rev-list --all 

Sorry, that should have been:
      
	git-rev-list --objects --all
	      
damn brain.  I guess its tired and wants some sleep.  :-)

-- 
Shawn.
