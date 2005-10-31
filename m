From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git versus CVS (versus bk)
Date: Mon, 31 Oct 2005 13:35:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0510311323090.27915@g5.osdl.org>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
 <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
 <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org> <20051031195010.GM11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 22:36:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWhJo-0006sh-Cy
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 22:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVJaVft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 16:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbVJaVft
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 16:35:49 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2507 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932531AbVJaVfs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Oct 2005 16:35:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9VLZesC015087
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Oct 2005 13:35:41 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9VLZd7B029139;
	Mon, 31 Oct 2005 13:35:40 -0800
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20051031195010.GM11488@ca-server1.us.oracle.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10891>



On Mon, 31 Oct 2005, Joel Becker wrote:
> 
> 	In the CVS/Subversion world, this merge becomes a single commit
> on the "main" line of development ("trunk", or whatever you call it).
> The merge has no concept of the steps taken to create the change, just
> the actual patch.  This has the disadvantage that you have to work hard
> in the branch namespace to find the actual steps taken (the working
> repository for the feature), but the advantage that a quick look does
> not have to wade through fits and starts as the feature takes shape.

Note that I'm a big proponent of people cleaning up their private 
work-in-progress trees before merging.

In fact, I'll refuse to merge with too dirty a repository. It's ok to have 
some fixes for mistakes, but if you have a lot of ugly stuff, use git to 
first track the development, and then start a new branch that has the 
cleaned-up version in it.

> > So with the distributed model, you don't have to publicly humiliate 
> > yourself when you do something stupid. Similarly, you don't have to 
> 
> because that history will contain all your something stupids, plus your
> fixes for them.

No, exactly because you do _not_ have to publicly humiliate yourself with 
showing what a nincompoop you are.

People should try things out, but they should clean up their worst 
mistakes too. Git allows both.

		Linus
