From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: how to test changes?
Date: Wed, 24 Jan 2007 23:57:30 -0500
Message-ID: <20070125045730.GA20345@spearce.org>
References: <20070125042721.GA6168@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 05:57:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9wgE-0007GH-Ko
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 05:57:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965276AbXAYE5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 23:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965275AbXAYE5f
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 23:57:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49682 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965276AbXAYE5e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 23:57:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H9wfo-0001h4-EH; Wed, 24 Jan 2007 23:57:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 04AEC20FBAE; Wed, 24 Jan 2007 23:57:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070125042721.GA6168@cepheus>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37707>

Uwe Kleine-K?nig <ukleinek@informatik.uni-freiburg.de> wrote:
> I wonder if there is a simpler way to test changes to git than
> installing it.  My problem is that even if I run 

Look at the INSTALL file:

	GIT_EXEC_PATH=`pwd`
	PATH=`pwd`:$PATH
	GITPERLLIB=`pwd`/perl/blib/lib
	export GIT_EXEC_PATH PATH GITPERLLIB

I use this trick all of the time to run git in-place for testing
in various weird repositories.

-- 
Shawn.
