From: Shawn Pearce <spearce@spearce.org>
Subject: Re: The git newbie experience
Date: Mon, 15 May 2006 01:31:33 -0400
Message-ID: <20060515053133.GB28068@spearce.org>
References: <446778B8.7080201@inoi.fi> <7vfyjcntro.fsf@assigned-by-dhcp.cox.net> <44680C54.8040206@inoi.fi> <7vy7x3x3ux.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tommi Virtanen <tv@inoi.fi>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 07:31:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfVgI-0007DJ-Ux
	for gcvg-git@gmane.org; Mon, 15 May 2006 07:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWEOFbo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 01:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWEOFbo
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 01:31:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41859 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932235AbWEOFbn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 01:31:43 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FfVg9-0001Qh-F4; Mon, 15 May 2006 01:31:37 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3042E212667; Mon, 15 May 2006 01:31:34 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7x3x3ux.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20020>

Junio C Hamano <junkio@cox.net> wrote:
> Tommi Virtanen <tv@inoi.fi> writes:
> 
> > Oh, I'd love to have a quick stash, that's what we actually ended up
> > doing a lot. Although I'd rather see a real implementation use a branch
> > and not just a diff file, but.. yes please.
> 
> I'd rather do that with a diff file that can be used to do a
> 3-way (see how rebase does it with --full-index diff with am -3).
> No point creating and forgetting to remove a throw away branch
> and getting more complaints.

How is a quick stash different from a topic branch?  I don't see
any difference between the two.  Your working directory was a topic
branch, just an unnamed topic branch.  Why don't you name it and
deal with it once it is named?

I can see new users getting confused about what changes are in
their quick stash or accidentially losing their quick stash by
running it twice in a row.

Teaching new users to always work on a topic branch and committing
before pulling/merging should be the favored workflow.

-- 
Shawn.
