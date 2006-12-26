From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 25 Dec 2006 23:21:10 -0500
Message-ID: <20061226042110.GA28084@spearce.org>
References: <7vmz5bfidj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 05:21:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz3oh-0007oQ-DS
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 05:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWLZEVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 23:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWLZEVP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 23:21:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57736 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069AbWLZEVO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 23:21:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gz3oC-000858-Bb; Mon, 25 Dec 2006 23:21:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 37BAF20FB65; Mon, 25 Dec 2006 23:21:11 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmz5bfidj.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35408>

Junio C Hamano <junkio@cox.net> wrote:
> * sp/mmap (Sun Dec 24 00:47:23 2006 -0500) 20 commits
>
> I wanted to have this in 'next' but it appears that this makes
> git-push with a non-trivial amount of data to fail.  v1.5.0 does
> not have to wait for this because this should not change any UI.

Really?  Not good.  Do you have some sort of test case that has
caused this?  I'll try to reproduce it here on my own.

-- 
Shawn.
