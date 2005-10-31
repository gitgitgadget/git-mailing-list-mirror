From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 13:53:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510311346110.27915@g5.osdl.org>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
 <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
 <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com>
 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net> <20051031213616.GO11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 22:56:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWhay-0003MK-2x
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 22:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbVJaVxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 16:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVJaVxd
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 16:53:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964851AbVJaVxc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 16:53:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9VLrPpi017993
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 13:53:26 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9VLrLVl030153;
	Mon, 31 Oct 2005 13:53:23 -0800
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20051031213616.GO11488@ca-server1.us.oracle.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10894>



On Mon, 31 Oct 2005, Joel Becker wrote:
> 
> 	I could care less about preserving my public image.  I'm an
> idiot, I screw up all the time.  I only care that the tip of my tree is
> respectable.

I definitely care about more than just the tip.

A broken history is a _problem_. Automatic tools like "git bisect" can't 
help you if you have lots of commits in between that are fundamentally 
broken. And even ignoring that, it just makes it harder for everybody to 
understand what the code does when "git-whatchanged" shows total crap that 
was undone.

History is important. It's important enough that you should keep it 
meaningful. And "meaningful" does not mean "show all your mistakes". 

Some people will say that the mistakes are as important as the fixes. I 
call bull on that. Mistakes are mistakes. Dead ends aren't useful, even as 
historical examples. 

At the same time, I'm not a rabid "history must be perfect" freak. 
Mistakes happen. Just fix then and move on.

When you have guests over, I sure hope that you don't walk around in your 
bathrobe, with pieces of your anatomy sticking out that shouldn't stick 
out. Sure, it may be the "real you", but there's a difference between 
being honest, and just being disgusting.

The same is true of SCM history. There's "honesty", and there's "digusting 
mess". At least when it comes to the kernel, I want the "honest" kind of 
history, not the "disgusting" kind.

			Linus
