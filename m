From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Trial git RPM's..
Date: Mon, 11 Jul 2005 18:15:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507111815180.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
 <m1eka574c8.fsf@ebiederm.dsl.xmission.com> <Pine.LNX.4.58.0507110958400.17536@g5.osdl.org>
 <m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 03:22:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds9Tc-0000HB-Jh
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 03:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVGLBQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 21:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbVGLBQx
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 21:16:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52448 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261841AbVGLBPy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 21:15:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6C1FqjA008811
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 18:15:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6C1FqIV013616;
	Mon, 11 Jul 2005 18:15:52 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1vf3gzvvd.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Eric W. Biederman wrote:
> 
> Actually I was looking at doing a git-ident thing that will
> just compute who git thinks you are.  And then git-commit-tree can
> just popen it to share code.  That looks like how the logic has
> been accomplished in other places.

I hate popen() if there's a reasonable functional interface in a library.

popen() is damn inefficient for doing something like this that is all C 
anyway.

		Linus
