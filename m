From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 14:39:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707031437560.4071@racer.site>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021409510.9434@woody.linux-foundation.org>
 <20070702142557.eba61ccd.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021436300.9434@woody.linux-foundation.org>
 <20070702145601.a0dcef0f.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
 <7vhcomuofl.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0707022114000.9434@woody.linux-foundation.org>
 <Pine.LNX.4.64.0707031303130.4071@racer.site> <86y7hxr591.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, quilt-dev@nongnu.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 15:39:42 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ibV-0002iV-Dy
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 15:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753212AbXGCNjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 09:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753256AbXGCNji
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 09:39:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:48990 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753046AbXGCNji (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 09:39:38 -0400
Received: (qmail invoked by alias); 03 Jul 2007 13:39:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 03 Jul 2007 15:39:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zcRcVV3jz8fZGMwcXiiViyravS9NYSrkPEBlHg+
	9a506P+jNwVjrB
X-X-Sender: gene099@racer.site
In-Reply-To: <86y7hxr591.fsf@lola.quinscape.zz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51491>

Hi David,

[please Cc me, since I will be more likely to miss replies if you do not]

On Tue, 3 Jul 2007, David Kastrup wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > But maybe they would be willing to install git to get that wonderful 
> > git-apply program, and that wonderful rename-and-mode-aware git-diff, 
> > and the git-merge-file program, all of which can operate outside of a 
> > git repository. (Take that, hg!)
> 
> As long as git-diff lists all added files in a second non-git dirtree
> as "/dev/null" when doing
> git-diff --name-status -B -M -C dir1 dir2
> its usefulness is limited.
> 
> git-diff --name-status -B -M -C dir1 dir2
> D	dir1/auctex-11.84/CHANGES
> D	dir1/auctex-11.84/COPYING
> D	dir1/auctex-11.84/ChangeLog
> 
> [...]

Yes, directories are a problem. There our DWIMery does not really help. 
But there is a solution: say

	git diff --name-status --no-index -B -M -C dir1 dir2

Hth,
Dscho
