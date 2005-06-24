From: Kevin Smith <yarcs@qualitycode.com>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 09:57:00 -0400
Message-ID: <42BC112C.1040009@qualitycode.com>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624130604.GK17715@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 24 15:53:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlocU-0000n3-7u
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 15:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVFXN6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Jun 2005 09:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVFXN6k
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jun 2005 09:58:40 -0400
Received: from deuterium.rootr.net ([203.194.209.160]:10289 "EHLO
	vulcan.rootr.net") by vger.kernel.org with ESMTP id S262734AbVFXN5u
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2005 09:57:50 -0400
Received: from [10.10.10.101] (653221hfc154.tampabay.res.rr.com [65.32.21.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vulcan.rootr.net (Postfix) with ESMTP id D69A13C51;
	Fri, 24 Jun 2005 13:57:45 +0000 (UTC)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
In-Reply-To: <20050624130604.GK17715@g5.random>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Andrea Arcangeli wrote:
 > On Fri, Jun 24, 2005 at 08:41:01AM +0200, Petr Baudis wrote:
 >
 >>Cool. Except where the concepts are just different, Cogito mostly
 >>appears at least equally simple to use as Mercurial. Yes, some
 >>features are missing yet. I hope to fix that soon. :-)
 >
 >
 > The user interface and network protocol isn't the big deal, the
 > big deal is the more efficient on-disk storage format IMHO.

For me, efficient storage is not very important, because I mostly deal 
with small projects. Likewise, speed isn't a factor for me, since both 
tools are plenty fast on small repos.

For me, the big advantage of mercurial is that it is written in python, 
instead of shell scripts. I know for some people that's a DISadvantage, 
but I see the following benefits as a result:

- Can run on (native) MS Windows
   (necessary for me because I often work on cross-platform projects)
- Python code can be more clear and expressive (IMHO)

In the long run, I think the python code base will be easier to maintain 
and enhance. A rewrite of cogito in python or ruby would be cool.

One advantage that cogito has is that git viewing/browsing tools can 
operate directly on cogito repos. But a psychological drawback is the 
ongoing confusion between git and cogito. Questions: Would a git-based 
tool that writes to the repo (such as StGIT) mess up a cogito repo? Can 
you switch a repo between git and cogito or back, at any time?

Mercurial's tags use a radical approach, whereas cogito's are more 
conventional. I haven't yet used mercurial's versioned-tags enough yet 
to judge whether they are better, worse, or just different.

I am impressed with the vibrancy of the development communities of both 
projects. Both are able to serve repos on a plain http server. Both are 
easy to use and have decent basic feature sets. Both projects are 
developing test suites.

Mostly, I'm thrilled with this new wave of lightweight distributed SCM 
systems. Most of the established tools tended to be too heavy on 
features and complexity, and have taken a long time to develop. I love 
that a single developer or small team can now create a simple but usable 
distributed SCM in a couple months.

Kevin
