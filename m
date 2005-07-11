From: Chris Wright <chrisw@osdl.org>
Subject: Re: Trial git RPM's..
Date: Mon, 11 Jul 2005 13:34:06 -0700
Message-ID: <20050711203406.GS5324@shell0.pdx.osdl.net>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org> <m1eka574c8.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 11 22:40:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds54P-0008Kc-Vj
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 22:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVGKUj1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 16:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbVGKUgv
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 16:36:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62879 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262586AbVGKUeP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 16:34:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6BKY7jA020137
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 13:34:11 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6BKY64b030368;
	Mon, 11 Jul 2005 13:34:06 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j6BKY6RC030367;
	Mon, 11 Jul 2005 13:34:06 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
Content-Disposition: inline
In-Reply-To: <m1eka574c8.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Eric W. Biederman (ebiederm@xmission.com) wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Ok, I tagged a "v0.99" thing, and pushed it out. I've also made trial 
> > RPM's of it: src, ppc64 and x86. They're build on whatever random machines 
> > I had, and on the ppc64 I chose to do it on my FC4 machine that has newer 
> > libraries than my YDL one. The x86 thing is FC3, I do believe.
> >
> > I haven't really verified the RPM's in any other way than a trial 
> > installation on one machine, and "gitk" seemed to work. Whoop. The idea 
> > being that this is a good way to check whether the rpm target works, _and_ 
> > cogito can have something to build against.
> 
> A couple of pieces.  The dist target has assumes git-tar-tree is in the
> path.  Making it so you have to have git installed to build the rpm.

Known, and was a reasonable assumption in my environment.  It's simple
bootstrapping issue.

> The man pages are not built. The build dependencies do not call out
> the tools necessary to build the man pages.

That was rather intentional, because the asciidoc package is not common.

thanks,
-chris
