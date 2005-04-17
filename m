From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 15:09:21 -0700
Organization: OSDL
Message-ID: <20050417150921.58d6db68.rddunlap@osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
	<4262DA30.2030500@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:06:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNHth-0008Tl-O9
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 00:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbVDQWJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVDQWJh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:09:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:5543 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261502AbVDQWJb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 18:09:31 -0400
Received: from midway.verizon.net (wbar2.sea1-4-5-049-023.sea1.dsl-verizon.net [4.5.49.23])
	(authenticated bits=0)
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HM9Qs3023090
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 15:09:27 -0700
To: Jochen Roemling <jochen@roemling.net>
In-Reply-To: <4262DA30.2030500@roemling.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005 23:50:40 +0200 Jochen Roemling wrote:

| Linus Torvalds wrote:
| 
| >Ie we have two phases to the merge: first get the objects, with something
| >like
| >
| >	repo=kernel.org:/pub/kernel/people/torvalds/linux-2.6.git
| >	rsync --ignore-existing -acv $(repo)/ .git/
| >  
| >
| Could you place a tarball there for people like me who are no "real" 
| kernel hackers and don't have a kernel.org account? Or is there an 
| "anonymous" account that I'm just to ignorant to know of?

You don't need a kernel.org account to rsync it... this works too:

rsync -avz -e ssh --progress --ignore-existing  rsync://rsync.kernel.org/pub/linux/kernel/people/torvalds/linux-2.6.git/ .git/

| I'm just somebody who is very interested in the new things happening 
| here, but I guess there will be some month to go and a lot of things to 
| learn until you see the first kernel patch that is signed off by me. :-)
| 
| By the way: Does the git repository include all 60.000 changes of just 
| the latest version of the 17.000 file in the kernel?

It's currently just 2.6.12-rc2 (17,000 files) plus changes...

Two people have announced full history gits if you are interested
in that...  Check the git email archives for mail from Ingo Molnar:
Subject: full kernel history, in patchset format

and Thomas Gleixner <tglx@linutronix.de>:
Subject: BK -> git export done

---
~Randy
