From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 08:00:25 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511010757040.27915@g5.osdl.org>
References: <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
 <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com>
 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com>
 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net> <20051031224246.GP11488@ca-server1.us.oracle.com>
 <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz>
 <20051101141149.GA26847@watt.suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, catalin.marinas@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 17:07:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWyZA-0005dO-TP
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 17:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVKAQAr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 11:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVKAQAr
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 11:00:47 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750833AbVKAQAq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 11:00:46 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA1G0QW6005662
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 1 Nov 2005 08:00:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA1G0P8o003248;
	Tue, 1 Nov 2005 08:00:25 -0800
To: Chris Mason <mason@suse.com>
In-Reply-To: <20051101141149.GA26847@watt.suse.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10937>



On Tue, 1 Nov 2005, Chris Mason wrote:
> 
> StGIT has the ability to rebase patches via three-way merge.  This is
> still on my todo list for mq.

Btw, I have to say that I was a bit uncertain about doing the rebasing by 
way of a three-way merge, but when I recently did a revert, I was _really_ 
happy with how well "git revert" did the rebasing of the revert. It wasn't 
even a clean merge, but leaving the conflict in the tree and allowing me 
to fix it up made what would otherwise have been a much more complex 
manual operation be 99% automated.

So I'm _neither_ a StGIT not mq user, but I can definitely say that 
rebasing with a three-way merge instead of just trying to apply the patch 
(whether in reverse like in a merge, or just re-apply it straigt) is 
really really nice.

		Linus
