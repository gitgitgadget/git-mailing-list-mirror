From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 12:45:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171242060.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <20050417162448.A13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org>
 <20050417195742.D13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171226530.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 21:40:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNFcb-00048o-3Q
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 21:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVDQTnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 15:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVDQTnb
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 15:43:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:42885 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261434AbVDQTn0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 15:43:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HJhIs4012793
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 12:43:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HJhHcb031813;
	Sun, 17 Apr 2005 12:43:17 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.58.0504171226530.7211@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Linus Torvalds wrote:
> 
>  - use "rev-tree" to show reachability

Btw, you don't even have to really remember the head you merged with. If 
you have all my objects, you can just use the current head from whatever 
my repository is, and the "rev-tree" will show all your commit objects 
that aren't in my tree.

The only reason I said "remember the last head you merged" is that that 
way you don't even have to download the objects from my tree, and you can 
make the decision totally locally without looking at what I've done since.

Of course, at some point you want to get my updated objects _anyway_, 
but..

			Linus
