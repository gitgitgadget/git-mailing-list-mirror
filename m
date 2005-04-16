From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Add "clone" support to lntree
Date: Fri, 15 Apr 2005 20:16:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504152014330.7211@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504152142360.30848-100000@iabervon.org>
 <20050416024755.GX7417@pasky.ji.cz> <20050416025844.GY7417@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 05:10:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMdhp-0007NI-4f
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 05:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVDPDOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 23:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262607AbVDPDOW
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 23:14:22 -0400
Received: from fire.osdl.org ([65.172.181.4]:34225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262599AbVDPDOT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 23:14:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3G3EEs4001804
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 20:14:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3G3EDIj031184;
	Fri, 15 Apr 2005 20:14:14 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050416025844.GY7417@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, Petr Baudis wrote:
> 
> I'm wondering, whether each tree should be fixed to a certain branch.

I'm wondering why you talk about "branches" at all.

No such thing should exist. There are no branches. There are just 
repositories. You can track somebody elses repository, but you should 
track it by location, not by any "branch name".

And you track it by just merging it.

Yeah, we don't have really usable merges yet, but..

		Linus
