From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] Selective diff-tree
Date: Sun, 24 Apr 2005 10:15:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504241013110.15879@ppc970.osdl.org>
References: <1113400651.20848.135.camel@hades.cambridge.redhat.com> 
 <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
 <1114323914.3419.70.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 19:08:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPkbF-0007kQ-Gq
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 19:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVDXRNo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 13:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVDXRNo
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 13:13:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:32488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261793AbVDXRNn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 13:13:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3OHDcs4001760
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 24 Apr 2005 10:13:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3OHDbDY012992;
	Sun, 24 Apr 2005 10:13:37 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1114323914.3419.70.camel@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 24 Apr 2005, David Woodhouse wrote:
> 
> On the other hand, my gitfilelog.sh is fairly fundamentally flawed and
> probably needs rewriting in C based on rev-tree.

Yeah, I think I'll make the "tree-diff" functions be available to others,
since they are actually _very_ cheap, and it's a bit sad to have to
execute a whole new process just to get a tree-diff. Then writing some
rev-list thing that just does tree-diff between different versions should
be trivial and quite efficient for finding things like "when did this set
of files/subdirectory last change".

Which definitely is very useful information.

		Linus
