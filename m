From: Linus Torvalds <torvalds@osdl.org>
Subject: I want to release a "git-1.0"
Date: Mon, 30 May 2005 13:00:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 30 21:57:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcqN2-00080R-TZ
	for gcvg-git@gmane.org; Mon, 30 May 2005 21:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVE3T6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 15:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbVE3T6s
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 15:58:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:25831 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261727AbVE3T6j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2005 15:58:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4UJwcjA022421
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Mon, 30 May 2005 12:58:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4UJwbC8014211
	for <git@vger.kernel.org>; Mon, 30 May 2005 12:58:38 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, I'm at the point where I really think it's getting close to a 1.0, and
make another tar-ball etc. I obviously feel that it's already way superior
to CVS, but I also realize that somebody who is used to CVS may not 
actually realize that very easily.

So before I do a 1.0 release, I want to write some stupid git tutorial for
a complete beginner that has only used CVS before, with a real example of
how to use raw git, and along those lines I actually want the thing to
show how to do something useful.

So before I do that, is there something people think is just too hard for
somebody coming from the CVS world to understand? I already realized that
the "git-write-tree" + "git-commit-tree" interfaces were just _too_ hard
to put into a sane tutorial.

I was showing off raw git to Steve Chamberlain yesterday, and showing it
to him made some things pretty obvious - one of them being that
"git-init-db" really needed to set up the initial refs etc). So I wrote
this silly "git-commit-script" to make it at least half-way palatable, but
what else do people feel is "too hard"?

I think I'll move the "cvs2git" script thing to git proper before the 1.0 
release (again, in order to have the tutorial able to show what to do if 
you already have an existing CVS tree), what else?

		Linus
