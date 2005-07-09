From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Fri, 8 Jul 2005 18:43:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
References: <20050708230750.GA23847@buici.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 09 03:44:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr4Nw-0000om-Qb
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 03:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbVGIBn7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 21:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbVGIBn7
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 21:43:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263054AbVGIBn6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 21:43:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j691htjA009218
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 8 Jul 2005 18:43:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j691hsff008647;
	Fri, 8 Jul 2005 18:43:55 -0700
To: Marc Singer <elf@buici.com>
In-Reply-To: <20050708230750.GA23847@buici.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 8 Jul 2005, Marc Singer wrote:
>
> In working through a usage example on my way to producing bonafide
> patches, I've found that commit is complaining.  Here's what I've done.
> 
>   o Fetched and built cogito-0.12
>   o Fetched (rsync) Linus' tree
>   o Created a working directory, linux-2.6
>   o linked .git in the working directory to the .git directory fetched
>     from the net.
>   o # git checkout -f v2.6.11

This won't work.

v2.6.11 isn't a commit, it's a tree, and things will go downhill from 
there. 

Can you base it on 2.6.12-rc2 or later? That's the earliest with some real 
git history.

		Linus
