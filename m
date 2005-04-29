From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] GIT: Create tar archives of tree on the fly
Date: Fri, 29 Apr 2005 15:26:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291522250.18901@ppc970.osdl.org>
References: <20050426144222.GA12035@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 00:19:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdon-0002Yc-Nl
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 00:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263032AbVD2WYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 18:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbVD2WYW
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 18:24:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:51651 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263032AbVD2WYT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 18:24:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3TMOFs4017591
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 15:24:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3TMOEPT008841;
	Fri, 29 Apr 2005 15:24:15 -0700
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <20050426144222.GA12035@lsrfire.ath.cx>
X-Spam-Status: No, hits=0.16 required=5 tests=HTML_MESSAGE
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



Having just done the git-0.7.tar.gz file with git-tar-tree, I started 
wondering if there is some nice way to encode the commit version that got 
tarred up into the tar archive itself.

There are various obvious ways, like creating a fake zero-sized file 
called <base>/.git-version-<commit-id>, and maybe that's the right thing 
to do. But maybe the tar archive format (and no, I don't even want to know 
details) has some nice way to hide off a keyname even _without_ having to 
create a file.

Would people like to have such a file for later? Obviously there would be 
a need to suppress it with a command line flag if you don't want it (or 
have a cmd line flag to enable it in the first place), what do people 
think? Rene?

		Linus
