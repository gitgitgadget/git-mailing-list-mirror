From: Dan Holmsand <holmsand@gmail.com>
Subject: Re: Git cancel work
Date: Sun, 24 Apr 2005 15:11:50 +0200
Message-ID: <d4g5ld$4ns$1@sea.gmane.org>
References: <Pine.LNX.4.62.0504240033230.1980@mirrorlynx.com> <20050424124930.GE1507@pasky.ji.cz> <Pine.LNX.4.62.0504240859210.27230@mirrorlynx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Apr 24 15:10:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPgso-0000Ic-4m
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 15:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbVDXNPW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 09:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbVDXNPW
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 09:15:22 -0400
Received: from main.gmane.org ([80.91.229.2]:59837 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262329AbVDXNPS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 09:15:18 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DPgsJ-0000GP-9k
	for git@vger.kernel.org; Sun, 24 Apr 2005 15:10:15 +0200
Received: from 217-211-177-12-o871.telia.com ([217.211.177.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Apr 2005 15:10:15 +0200
Received: from holmsand by 217-211-177-12-o871.telia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Apr 2005 15:10:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 217-211-177-12-o871.telia.com
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.62.0504240859210.27230@mirrorlynx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dan Weber wrote:
> 
> Why does it take so ridiculously long then?

Perhaps because you're using an older version of git-pasky? Newer 
versions use read-tree -m, which speeds up git cancel by several orders 
of magnitude for me.

Btw. gitdiff.sh and gitseek.sh are still using read-tree without "-m", 
so they are still very slow.

For exampel, try "git diff -p" on the kernel. Compare with plain "git diff".

/dan

