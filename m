From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui blame dividing by zero
Date: Wed, 4 Apr 2007 12:11:01 -0400
Message-ID: <20070404161101.GF4628@spearce.org>
References: <200704041621.51390.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 18:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZ85K-0000tI-Rg
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 18:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbXDDQLo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 12:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbXDDQLT
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 12:11:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47853 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbXDDQLF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 12:11:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZ84X-0000p1-1i; Wed, 04 Apr 2007 12:10:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D332020FBAE; Wed,  4 Apr 2007 12:11:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200704041621.51390.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43751>

Andy Parkins <andyparkins@gmail.com> wrote:
>  $ git-gui blame HEAD somefile.cc
> 
> I just get a window that contains:
> 
> divide by zero
> divide by zero

OK, I'm a total noob sometimes.  That code was obviously getting
0 into a variable, and then blindly dividing by the variable's value.

I just pushed a new patch to my git-gui.git repository, its now in
both the maint and master branches.  Please give that a try.  ;-)

-- 
Shawn.
