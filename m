From: Shawn Pearce <spearce@spearce.org>
Subject: Re: http git and curl 7.16.0
Date: Wed, 27 Dec 2006 20:42:25 -0500
Message-ID: <20061228014225.GB16612@spearce.org>
References: <7vlkkt5d49.fsf@assigned-by-dhcp.cox.net> <200612280135.kBS1ZL5v004756@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Nick Hengeveld <nickh@reactrix.com>,
	George Sherwood <pilot@beernabeer.com>, skimo@liacs.nl,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 02:42:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzkIE-000357-H0
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 02:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWL1Bmo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 20:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWL1Bmo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 20:42:44 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37276 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964832AbWL1Bmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 20:42:44 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzkHn-0004VH-Vy; Wed, 27 Dec 2006 20:42:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7A13820FB65; Wed, 27 Dec 2006 20:42:25 -0500 (EST)
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200612280135.kBS1ZL5v004756@laptop13.inf.utfsm.cl>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35501>

"Horst H. von Brand" <vonbrand@inf.utfsm.cl> wrote:
> I tried to chop down a tig repo a few commits from the top for checking out
> the crash I'm seeing (only when pulling from a remote repo by HTTP, and it
> is not up to date here) by doing:
> 
>   cp -r tig tig.tst
>   cd tig.tst
>   git reset --hard HEAD~3
>   git prune
> 
> But now git-pull /doesn't/ fetch anything, so I see no crash. What am I
> doing wrong here?

Another ref points at the same commit as what ORIG_HEAD points at,
so there wasn't anything to fetch as you already had that commit.

Its probably a tag, a ref under refs/remotes, or another branch...

-- 
Shawn.
