From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re-done kernel archive - real one?
Date: Sun, 17 Apr 2005 13:26:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171324340.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org>
 <20050417162448.A13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504170926410.7211@ppc970.osdl.org>
 <20050417195742.D13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171226530.7211@ppc970.osdl.org>
 <20050417205149.E13233@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171306360.7211@ppc970.osdl.org>
 <20050417211116.F13233@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 17 22:25:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNGKp-0008L9-9Z
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 22:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVDQU2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 16:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVDQU1W
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 16:27:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:38292 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261507AbVDQUYh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 16:24:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HKOTs4016451
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 13:24:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HKOSCm003305;
	Sun, 17 Apr 2005 13:24:29 -0700
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050417211116.F13233@flint.arm.linux.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Russell King wrote:
> 
> It's trivial to change - it's either sort -n or sort -nr !

Yes.

Btw, it might make sense to do the "grep" before the sort, since the sort 
doesn't scale as nicely with lots of output. On the other hand, then the 
grep pattern needs to be a bit more complex (so that it doesn't pick up on 
things that have _parents_ with ":1"). I think the rev-tree output is 
obvious enough that it's pretty trivial to grep for..

		Linus
