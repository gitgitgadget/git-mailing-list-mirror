From: Linus Torvalds <torvalds@osdl.org>
Subject: Trial git RPM's..
Date: Sun, 10 Jul 2005 18:18:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507101814210.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jul 11 03:18:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrmwO-00069L-H0
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 03:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262170AbVGKBS3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 21:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVGKBS3
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 21:18:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21924 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262170AbVGKBS2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 21:18:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6B1IQjA029949
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Sun, 10 Jul 2005 18:18:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6B1IPmV011264
	for <git@vger.kernel.org>; Sun, 10 Jul 2005 18:18:26 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, I tagged a "v0.99" thing, and pushed it out. I've also made trial 
RPM's of it: src, ppc64 and x86. They're build on whatever random machines 
I had, and on the ppc64 I chose to do it on my FC4 machine that has newer 
libraries than my YDL one. The x86 thing is FC3, I do believe.

I haven't really verified the RPM's in any other way than a trial 
installation on one machine, and "gitk" seemed to work. Whoop. The idea 
being that this is a good way to check whether the rpm target works, _and_ 
cogito can have something to build against.

They rpm's are at

	http://www.kernel.org/pub/software/scm/git/

or will be once mirrored.

		Linus
