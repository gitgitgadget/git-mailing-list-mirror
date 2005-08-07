From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: qgit-0.81
Date: Sat, 6 Aug 2005 17:26:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508061711230.3258@g5.osdl.org>
References: <20050806215323.86191.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 02:26:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1Yzh-00060C-Iw
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 02:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVHGA0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 20:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVHGA0V
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 20:26:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25041 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261375AbVHGA0U (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2005 20:26:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j770QIjA017333
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 6 Aug 2005 17:26:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j770QI4I006212;
	Sat, 6 Aug 2005 17:26:18 -0700
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050806215323.86191.qmail@web26303.mail.ukl.yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 6 Aug 2005, Marco Costalba wrote:
> 
> Some little new stuff too, complete changelog below:
> 
> - added move back/forward in selection history
> 
> - added "hyperlinks" SHA1's in commit messages

Ok, this is nicer than gitk, with the parents showing up in the commit
message and thus easy to go to. You might add children too: it's not
something git itself knows about intrisically, but since you've already 
built the graph, at least you see what children are part of that graph..

Oh, and do people really care _that_ much when the change happened? That's 
a lot of screen real estate wasted on the date stamp of "last change". At 
least I can drag it to the right and hide it that way..

A couple of quick comments:

 - Any chance of having a git archive of qgit? I realize that sourceforge 
   doesn't have git archives, but (a) maybe you can ask and (b) maybe 
   there are alternate places you could put it. It's just sad having to 
   download tar-balls.

 - The qgit graph is not as pretty as the gitk one. Any chance of making 
   the bullets a bit smaller, and having an option to not do the
   "jump-over-bumps"?

 - the "file annotation" window is nice, but it _really_ shouldn't do line
   wrapping. If you make the window narrower, you'll see it wrap and look 
   horrible.. Are all text windows always wrapped in QT?

 - You edit the commit comments heavily, and have no options to unedit. 
   For example, I need the emails in the sign-offs if I ever cut-and-paste 
   to an email client when I sent a "hey, this commit broke so-and-so.."

 - the "format a patch to be sent as email" thing says "at least two 
   revisions needed" when you only have one. Why? One of my more common 
   cases is that I send one commit as a patch, and now I do

	git-diff-tree -p --pretty [commit-id] > ~/diff

   and then just send that. A single commit _does_ describe a valid patch, 
   after all.

No biggie,

		Linus
