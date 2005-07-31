From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Sun, 31 Jul 2005 16:33:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507311627280.14342@g5.osdl.org>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.58.0507311305170.29650@g5.osdl.org> <7vr7ded8ax.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507311549300.14342@g5.osdl.org> <7viryqd0eo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 01:36:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzNMD-0005ie-6K
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 01:36:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVGaXgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 19:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVGaXgA
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 19:36:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262081AbVGaXeD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 19:34:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6VNXsjA018367
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 31 Jul 2005 16:33:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6VNXrIm008949;
	Sun, 31 Jul 2005 16:33:53 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7viryqd0eo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 31 Jul 2005, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > No I'm not. Try all the machines behind my firewall.
> 
> Ah, that's true.  Do you push into them?

Yup, I do. I have this thing that I don't do backups, but I end up having 
redundancy instead, so I keep archives on my own machines and inside the 
private osdl network, for example.

Also, I suspect that anybody who uses the "CVS model" with git - ie a
central repository - is not likely to export that central repository any
way: it's the crown jewels, after all. Open source may not have that
mindset, but I'm thinking of how I was forced to use CVS at Transmeta, for
example:  the machine that had the CVS repo was certainly supposed to be
very private indeed.

In the "central repo model" you have another issue - you have potentially
parallell pushes to different branches with no locking what-so-ever (and
that's definitely _supposed_ to work), and I have this suspicion that the 
"update for dumb servers" code isn't really safe in that setting anyway. I 
haven't checked.

			Linus
