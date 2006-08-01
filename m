From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-ls-files prefix superset problem
Date: Mon, 31 Jul 2006 22:18:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607312217420.4168@g5.osdl.org>
References: <20060731.221327.26966465.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 07:19:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7mex-0004ff-9u
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 07:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbWHAFTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 01:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWHAFTM
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 01:19:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1424 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161054AbWHAFTK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 01:19:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k715IlnW031912
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 31 Jul 2006 22:18:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k715Il0K002034;
	Mon, 31 Jul 2006 22:18:47 -0700
To: David Miller <davem@davemloft.net>
In-Reply-To: <20060731.221327.26966465.davem@davemloft.net>
X-Spam-Status: No, hits=-0.486 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.141 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24575>



On Mon, 31 Jul 2006, David Miller wrote:
> 
> I had been previously using git-1.1.3 on my local repositories
> and I upgraded to the current git head:
> 
> b63fafdfd844c2037fba53b9944431c1378b4135
> 
> git commit stopped working, specifically it dies on
> git-ls-files:
> 
> davem@sunset:~/src/GIT/net-2.6$ ../git/git-ls-files -- net/ipv4/tcp.c
> fatal: git-ls-files: internal error - cache entry not superset of prefix

It should be fixed by the recent commit

	Fix up some fallout from "setup_git_directory()" cleanup

that Junio already merged.

So just update your git again, and everything should be happy.

		Linus
