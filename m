From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Under NO_OPENSSL -lssl should not be used
Date: Sat, 30 Jul 2005 09:09:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507300908450.29650@g5.osdl.org>
References: <20050729085819.GL24895@pasky.ji.cz> <20050729155051.GJ21909@pasky.ji.cz>
 <Pine.LNX.4.58.0507292038160.29650@g5.osdl.org> <7vek9g6g4f.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Jon Seymour <jon.seymour@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 18:09:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DytuH-0005C1-GC
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 18:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbVG3QJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 12:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbVG3QJp
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 12:09:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262996AbVG3QJo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2005 12:09:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6UG9TjA021868
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Jul 2005 09:09:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6UG9SX4000589;
	Sat, 30 Jul 2005 09:09:29 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek9g6g4f.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Jul 2005, Junio C Hamano wrote:
> 
> Would this be OK?  I think it is ugly but it gets the job done.

Looks ok. I'd suggest having some option to turn of "curl" too - I have 
one machine that doesn't have curl installed, and I just turn the things 
that depend on it off by hand by editing the makefile right now..

		Linus
