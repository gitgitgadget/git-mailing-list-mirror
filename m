From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] fork optional branch point normazilation
Date: Sun, 17 Apr 2005 18:07:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171806230.7211@ppc970.osdl.org>
References: <Pine.LNX.4.44.0504171614150.2625-100000@bellevue.puremagic.com>
 <Pine.LNX.4.58.0504171636590.7211@ppc970.osdl.org> <20050418002326.GC1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brad Roberts <braddr@puremagic.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 03:02:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKeA-0003e4-Tj
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 03:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVDRBFd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 21:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbVDRBFd
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 21:05:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:37834 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261394AbVDRBF3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 21:05:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3I15Ls4001969
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 18:05:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3I15KGh016036;
	Sun, 17 Apr 2005 18:05:20 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418002326.GC1461@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Petr Baudis wrote:
> 
> Am I just slow or does the first dst-- make it miss the last trailing
> /[,;.]/?

Hopefully not. It _should_ make it miss the last '\0', but hey, it got my
usual amount of testing (ie none). I'm sure Brad can tell us whether it
makes any difference..

		Linus
