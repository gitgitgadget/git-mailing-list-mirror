From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 2 Jan 2007 21:29:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701022127040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vwt4647g0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 21:29:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1qGX-0001sd-7u
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 21:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbXABU3k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 15:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbXABU3k
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 15:29:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:55405 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755408AbXABU3j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 15:29:39 -0500
Received: (qmail invoked by alias); 02 Jan 2007 20:29:38 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp009) with SMTP; 02 Jan 2007 21:29:38 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwt4647g0.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35813>

Hi,

On Mon, 1 Jan 2007, Junio C Hamano wrote:

> * jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
>  + git-merge: preserve and merge local changes when doing fast
>    forward
> 
> Johannes's suggestion to record a tree object instead of LOCAL_DIFF is 
> roger but not wilco yet --- I haven't thought through the issue to see 
> an improvement in the suggestion.  We will be clobbering both index and 
> the working tree, and I think "diff --binary HEAD" and "write-tree" 
> record the equivalent amount of information given a HEAD for recovery.

For recovery, yes. The difference comes in

- that you can use the familiar git operations to recover (git read-tree 
  PRE_MERGE_TREE), and
- that you can do other git operations on the tree, but not on the diff.

Hth,
Dscho
