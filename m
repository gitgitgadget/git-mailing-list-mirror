From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Mon, 5 Feb 2007 20:55:41 +0200
Message-ID: <20070205185541.GA16598@mellanox.co.il>
References: <Pine.LNX.4.64.0702051014040.8424@woody.linux-foundation.org>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 05 19:55:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE8zs-0006k7-7j
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 19:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933350AbXBESzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 13:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933353AbXBESzT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 13:55:19 -0500
Received: from p02c11o146.mxlogic.net ([208.65.145.69]:50630 "EHLO
	p02c11o146.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933350AbXBESzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 13:55:18 -0500
Received: from unknown [194.90.237.34] (EHLO p02c11o146.mxlogic.net)
	by p02c11o146.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 69d77c54.2722810800.2943.00-506.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 05 Feb 2007 11:55:18 -0700 (MST)
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o146.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 29d77c54.2712320944.2926.00-009.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 05 Feb 2007 11:55:14 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Feb 2007 20:57:17 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon,  5 Feb 2007 20:52:56 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702051014040.8424@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 05 Feb 2007 18:57:17.0110 (UTC) FILETIME=[74A1ED60:01C74957]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14978.003
X-TM-AS-Result: No--3.088200-4.000000-31
X-Spam: [F=0.0651721307; S=0.065(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38768>

> (In general, even if I clone _everything_, I'd also like to perhaps set 
> the default 'master' branch to track something else than what I'm cloning 
> from. In fact, I think I'd generally prefer cloning everything, but 
> sometimes I'd like to say "I'm going to track the upstreams branch xyzzy 
> rather than their default branch").
> 
> I realize that the
> 
> 	git clone <repo> [<dir>]
> 
> means that we can't have the same syntax as "git pull" (which doesn't take 
> the <dir> part), but that doesn't make the "#branch" syntax any better.
> 
> So I much prefer the
> 
> 	git clone [--default branch] [--branch x]* <repo> [<dir>
> 
> kind of syntax.

Two questions:
- I understand --branch is too large for 1.5.0, but maybe this --default isn't?
- Or, maybe we can have a flag to avoid creating the master branch at all?
  User can combine this with -n, then check which branches exist with "git branch -r"
  and create the branch himself.

-- 
MST
