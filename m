From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 5/5] Enable ref log creation in git checkout -b.
Date: Tue, 23 May 2006 23:52:34 -0400
Message-ID: <20060524035234.GA13329@spearce.org>
References: <20060519091716.GM22257@spearce.org> <7vk68fyarn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 05:52:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FikQW-0003JQ-NB
	for gcvg-git@gmane.org; Wed, 24 May 2006 05:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWEXDwj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 23:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWEXDwj
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 23:52:39 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50903 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932183AbWEXDwj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 23:52:39 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FikQ4-0007fz-Dl; Tue, 23 May 2006 23:52:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4270420FB0C; Tue, 23 May 2006 23:52:35 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk68fyarn.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20662>

Junio C Hamano <junkio@cox.net> wrote:
> I've swallowed all 10 and pushed them out in "pu", but could you
> add tests to check the Porcelainish commands you touched with
> this series to make sure they all log correctly?

Sure.  I've been putting it off as I've been busy the past few days
and have also been thinking about trying to rebuild reflog using a
tag/annotation branch style, which might be more generally useful
to others.  So I've been debating about whether or not I should
ask you to pop reflog out of pu indefinately.

> BTW, I noticed that a patch earlier in the series depended on
> something not in "master" (it's rfc2822_date from js/fmt-patch
> series).  Generally I do not want to make a branch hostage of
> another branch by introducing a dependency, but for now I'll
> pull in early part of js/fmt-patch branch into sp/reflog branch
> and see what happens.

Doh.  Sorry about that one.  I saw it in date.c and used it, not
realizing it was only in pu.
 
-- 
Shawn.
