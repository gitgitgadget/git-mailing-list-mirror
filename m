From: Kevin Smith <yarcs@qualitycode.com>
Subject: Cogito vs. Git (was: Mercurial vs Updated git HOWTO for kernel hackers)
Date: Tue, 28 Jun 2005 12:51:24 -0400
Message-ID: <42C1800C.7040506@qualitycode.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624130604.GK17715@g5.random> <42BC112C.1040009@qualitycode.com> <20050628150752.GC1275@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 28 18:48:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnJFx-0001F5-Oi
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 18:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVF1Qxx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 12:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262155AbVF1Qxx
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 12:53:53 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:36534 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S262142AbVF1QxC
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 12:53:02 -0400
Received: from [192.168.15.101] (653221hfc195.tampabay.res.rr.com [65.32.21.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id 5C6763C55;
	Tue, 28 Jun 2005 16:52:54 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050628150752.GC1275@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:
> Cogito's only unusual requirement (well, expectation) is that HEAD is a
> symlink to .git/refs/heads/master, and .git/refs/heads/master should
> reflect your current head. I will try to ease up this restriction so
> that things will mostly work even if you just have HEAD. I think that
> most auxiliary commands (e.g. cg-log - you just have to love it) should
> work on any sensible git tree (but I didn't test it - yet).

So you're saying that aside from that one solveable issue, I could use 
low-level git tools, third-party over-git tools, and cogito, 
interchangebly on a single repo without the tools becoming confused? 
That's cool, and should be made more clear in the cogito readme. I was 
under the impression that cogito was tracking all kinds of extra meta 
magic stuff that git tools wouldn't keep updated.

If I were using cogito, I probably wouldn't want to use the low-level 
git stuff directly, but I might want to use (or maybe even write) some 
other over-git tools.

You might also consider removing the "Core GIT" section from the README, 
because I think it increases the confusion between the two.

Cheers,

Kevin
