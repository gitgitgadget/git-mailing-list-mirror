From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: using git directory cache code in darcs?
Date: Sun, 17 Apr 2005 20:06:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504172005450.7211@ppc970.osdl.org>
References: <20050416132231.GJ2551@abridgegame.org>
	<Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org>
	<20050417121712.GA22772@abridgegame.org>
	<Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>
	<20050417195600.6894e576.pj@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, droundy@abridgegame.org, darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Mon Apr 18 05:01:28 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNMVs-00048k-6k
	for gcvdd-darcs-devel@m.gmane.org; Mon, 18 Apr 2005 05:01:28 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DNMZS-0006ZE-LJ; Sun, 17 Apr 2005 23:05:10 -0400
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by abridgegame.org with esmtp (Exim 4.50) id 1DNMZN-0006Wc-0w
	for darcs-devel@darcs.net; Sun, 17 Apr 2005 23:05:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3I352s4010464
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 20:05:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3I351OO021595;
	Sun, 17 Apr 2005 20:05:01 -0700
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050417195600.6894e576.pj@sgi.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net



On Sun, 17 Apr 2005, Paul Jackson wrote:
> 
> I'd encourage you to invite someone to provide a libgit.

Not until all the data structures are really really stable.

That's the thing - we can keep the _program_ interfaces somewhat stable. 
But internally we may change stuff wildly, and anybody who depends on a 
library interface would be screwed.

Ergo: no library interfaces yet. Wait for it to stabilize. Start trying to 
just script the programs.

		Linus
