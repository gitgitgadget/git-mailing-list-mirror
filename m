From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fix bug in read-cache.c which loses files when merging
 a tree
Date: Mon, 18 Apr 2005 15:09:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504181508040.15725@ppc970.osdl.org>
References: <1113848239.4998.45.camel@mulgrave> <Pine.LNX.4.58.0504181219480.15725@ppc970.osdl.org>
 <1113854941.4998.61.camel@mulgrave> <Pine.LNX.4.58.0504181330450.15725@ppc970.osdl.org>
 <20050418215819.GH5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 00:04:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNeLY-0006q4-JN
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVDRWHu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVDRWHu
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:07:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:7839 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261186AbVDRWHq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 18:07:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3IM7Xs4002419
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 18 Apr 2005 15:07:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3IM7Wp8007142;
	Mon, 18 Apr 2005 15:07:33 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418215819.GH5554@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 18 Apr 2005, Petr Baudis wrote:
> 
> So, I'm confused. Why did you introduce unpack-file instead of doing
> just this?

It was code that I already had (ie the old code from "merge-cache" just
moved over), and thanks to that, I don't have to worry about broken
"mktemp" crap in user space...

		Linus
