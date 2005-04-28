From: David Greaves <david@dgreaves.com>
Subject: Re: kernel hacker's git howto
Date: Thu, 28 Apr 2005 11:22:03 +0100
Message-ID: <4270B94B.30604@dgreaves.com>
References: <20050428085657.GA30800@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: kernel list <linux-kernel@vger.kernel.org>, pasky@ucw.cz,
	torvalds@osdl.org, Greg KH <greg@kroah.com>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 12:17:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR656-0006L2-SI
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 12:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVD1KW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 06:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVD1KW1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 06:22:27 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:61864 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261962AbVD1KWQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 06:22:16 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id D25ABE6DAB; Thu, 28 Apr 2005 11:19:42 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 08110-07; Thu, 28 Apr 2005 11:19:42 +0100 (BST)
Received: from oak.dgreaves.com (unknown [217.135.157.53])
	by mail.ukfsn.org (Postfix) with ESMTP
	id EEBD0E6DA6; Thu, 28 Apr 2005 11:19:41 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DR69j-00007Y-OF; Thu, 28 Apr 2005 11:22:03 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20050428085657.GA30800@elf.ucw.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I think a lot of people on the git list would like to see this - please 
CC :)

David

Pavel Machek wrote:

>Hi!
>
>Here's my current version of git HOWTO. I'd like your comments...
>
>	Kernel hacker's guide to git
>	~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      2005 Pavel Machek <pavel@suse.cz>
>
>You can get cogito at http://www.kernel.org/pub/software/scm/cogito/
>. Compile it, and place it somewhere in $PATH. Then you can get kernel
>by running
>
>mkdir clean-cg; cd clean-cg
>cg-init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
>
>... Do cg-update origin to pickup latest changes from Linus. You can
>do cg-diff to see what changes you done in your local tree. cg-cancel
>will kill any such changes, and cg-commit will make them permanent.
>
>To get diff between your working tree and "next tree up", do cg-diff
>-r origin: . If you want to get the same diff but separated
>patch-by-patch, do cg-mkpatch origin: . If you want to pull changes
>from the "up" tree to your working tree, do cg-pull origin followed by
>cg-merge origin.
>
>
>How to set up your trees so that you can cooperate with linus
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>What I did:
>
>Created clean-cg. Initialized straight from Linus (as above). Then I
>created "nice" tree, good for Linus to pull from 
>
>mkdir /data/l/linux-good; cd /data/l/linux-good
>cg-init /data/l/clean-cg
>
>and then my working tree, based on linux-good
>
>mkdir /data/l/linux-cg; cd /data/l/linux-cg
>cg-init /data/l/linux-good
>
>. I do my work in linux-cg. If someone sends me nice patch I should
>pass up, I apply it to linux-good with nice message and do
>
>cd /data/l/linux-cg; cg-pull origin; cg-merge origin
>
>  
>

-- 

