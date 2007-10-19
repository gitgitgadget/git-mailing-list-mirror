From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git stash apply usability issues
Date: Thu, 18 Oct 2007 21:31:56 -0400
Message-ID: <20071019013156.GU14735@spearce.org>
References: <47171A21.9030003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 03:32:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iigij-0001C6-C6
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 03:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759534AbXJSBcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 21:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759415AbXJSBcB
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 21:32:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41580 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758923AbXJSBcA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 21:32:00 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IigiF-0004vw-K0; Thu, 18 Oct 2007 21:31:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DABD120FBAE; Thu, 18 Oct 2007 21:31:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47171A21.9030003@viscovery.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61593>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> (2) when 'git stash apply' runs merge-recursive, it treats the current 
> state as 'ours' and the stash as 'theirs'. IMHO it should be the other way 
> round: I have stashed away changes to a binary file. Then committed a 
> different modification to it, and now want to apply the stash. This results 
> in a conflict that leaves the current state in the working tree, but I had 
> preferred that the stashed binary file were in the working tree now.
> 
> What do other git-stash users think about changing the order?

The current order is the same order that git-rebase uses.  I'm not
saying its correct, just that its the same as rebase.  I think rebase
is also backwards and if we change git-stash we should also change
git-rebase at the same time (though probably not in the same commit).

-- 
Shawn.
