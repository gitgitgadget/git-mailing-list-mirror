From: Shawn Pearce <spearce@spearce.org>
Subject: Re: confusion over the new branch and merge config
Date: Sat, 23 Dec 2006 01:22:09 -0500
Message-ID: <20061223062209.GB9396@spearce.org>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vd56cam66.fsf@assigned-by-dhcp.cox.net> <20061223051210.GA29814@segfault.peff.net> <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 07:22:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy0H0-0003nA-E4
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 07:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbWLWGWU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 01:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbWLWGWU
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 01:22:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36955 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbWLWGWT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 01:22:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy0GU-0007r1-TS; Sat, 23 Dec 2006 01:21:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D2E6C20FB65; Sat, 23 Dec 2006 01:22:09 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqlvuoi4.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35275>

Junio C Hamano <junkio@cox.net> wrote:
> Jeff King <peff@peff.net> writes:
> 
> > BTW, is there some explanation why branch.*.merge specifies a _remote_
> > head? The following would make much more sense to me:
> >
> > [branch "master"]
> > remote = origin
> > merge = refs/remotes/origin/master
> 
> Only *if* you store it in that tracking branch.  The name the
> other party gives _do_ matter to you anyway, because you have to
> _know_ it to fetch.  What it does NOT matter is if you use a
> tracking branch, or if you do, which local tracking branch you
> use to track it.

My $0.02 USD (worth almost nothing these days!):

I agree with Junio.  branch.<n>.merge makes sense as the remote name.

-- 
Shawn.
