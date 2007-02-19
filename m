From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Teach git-remote to update existing remotes by fetching from them
Date: Mon, 19 Feb 2007 02:32:38 -0500
Message-ID: <20070219073238.GA30030@spearce.org>
References: <E1HIzh2-0001Ph-T2@candygram.thunk.org> <7virdybu9a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 08:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ315-0002E0-2g
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 08:32:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbXBSHcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 02:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbXBSHcn
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 02:32:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52702 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbXBSHcn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 02:32:43 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJ30p-0001Bs-Uw; Mon, 19 Feb 2007 02:32:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9113720FBAE; Mon, 19 Feb 2007 02:32:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7virdybu9a.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40099>

Junio C Hamano <junkio@cox.net> wrote:
> "Theodore Ts'o" <tytso@mit.edu> writes:
> 
> > This allows users to use the command "git remote update" to update all
> > remotes that are being tracked in the repository.
> 
> Sounds like a good idea.  Thanks.

<personalwishlist>

It would be nice to define "gang remotes".  For example I want to
be able to have:

  `git fetch cs`  ==  `git fetch cs-one; git fetch cs-two`
  `git fetch jc`  ==  `git fetch origin; git fetch alt`

Why?  Well, I often have multiple remotes setup to the *same*
repository depending on the SSH hostname I want to use to access
that repository.  This has a lot to do with the way my firewalls
are setup and where I'm physically connected at any given time.

Yes, I really do have multiple remotes setup to the access the
same (remote) physical disk.  :)

Possible syntax:

	[remote "cs"]
		remote = cs-one
		remote = cs-two
	[remote "jc"]
		remote = origin
		remote = alt

</personalwishlist>

Obviously this is more work than Ted's nice little patch.  :)

-- 
Shawn.
