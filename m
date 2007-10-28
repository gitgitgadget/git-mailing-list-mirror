From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: tags disappear
Date: Sun, 28 Oct 2007 01:05:46 -0400
Message-ID: <20071028050546.GR14735@spearce.org>
References: <C7372F7E-F29E-4E40-AE96-7AC8CB0EE0CE@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James <jtp@nc.rr.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 06:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im0Lc-000286-Bs
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 06:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbXJ1FFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 01:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbXJ1FFv
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 01:05:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50088 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbXJ1FFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 01:05:51 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Im0LL-00081w-Q7; Sun, 28 Oct 2007 01:05:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5EB2F20FBAE; Sun, 28 Oct 2007 01:05:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <C7372F7E-F29E-4E40-AE96-7AC8CB0EE0CE@nc.rr.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62521>

James <jtp@nc.rr.com> wrote:
> Sorry for the dumb question.  Hoping someone can lead me in the right  
> direction.
> 
> I use git in a pretty basic setup.  One branch, I'm the only user,  
> etc.  When I set up a tag (with a command like "git tag v1.1.6"), and  
> then push the changes to the server, the tag doesn't remain when I  
> clone the tree somewhere else.
> 
> Can anyone explain why, and possibly how to keep tags on a push/clone?

You need to push the tag to the server with:
  git push server tag v1.1.6

But you should make such takes annotated with "git tag -a" so they
are proper objects in their own right, rather than just refs pointing
at commits.

-- 
Shawn.
