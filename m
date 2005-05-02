From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Mon, 2 May 2005 10:32:38 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505021031070.3594@ppc970.osdl.org>
References: <20050430025211.GP17379@opteron.random> <42764C0C.8030604@tmr.com>
 <Pine.LNX.4.58.0505020921080.3594@ppc970.osdl.org> <20050502171802.GA28045@nevyn.them.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Davidsen <davidsen@tmr.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 19:32:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSeke-0004Bj-Ps
	for gcvg-git@gmane.org; Mon, 02 May 2005 19:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVEBRdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 13:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVEBRbg
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 13:31:36 -0400
Received: from fire.osdl.org ([65.172.181.4]:47762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261366AbVEBRbF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 13:31:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j42HUcs4021330
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 2 May 2005 10:30:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j42HUam2007462;
	Mon, 2 May 2005 10:30:37 -0700
To: Daniel Jacobowitz <dan@debian.org>
In-Reply-To: <20050502171802.GA28045@nevyn.them.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 2 May 2005, Daniel Jacobowitz wrote:
> 
> Do you know any vaguely Unix-like system where #!/usr/bin/env does not
> work?  I don't; I've used it on Solaris, HP-UX, OSF/1...

I've used unixes where "#!" didn't work.

Things like bash still have support for such unixes, I think - you can
tell them to parse the #! line themselves, to make it appear to do the 
right thing.

Are these common? Hell no. But they definitely existed.

		Linus
