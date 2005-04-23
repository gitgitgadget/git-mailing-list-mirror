From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] git-pasky-0.6.3 && request for testing
Date: Fri, 22 Apr 2005 17:18:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504221717350.2344@ppc970.osdl.org>
References: <20050422030931.GA14565@pasky.ji.cz> <20050422064936.GA10854@kroah.com>
 <20050422230551.GI21204@pasky.ji.cz> <Pine.LNX.4.58.0504221621280.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Greg KH <greg@kroah.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 02:13:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP8H7-0001dn-HD
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 02:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVDWAQy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 20:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVDWAQy
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 20:16:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:59786 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261392AbVDWAQH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 20:16:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3N0G4s4019363
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Apr 2005 17:16:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3N0G3cV020590;
	Fri, 22 Apr 2005 17:16:03 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <Pine.LNX.4.58.0504221621280.2344@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 22 Apr 2005, Linus Torvalds wrote:
> 
> I'm not even going to debug this bug. I'm just going to rewrite diff-cache 
> to do what I should have done originally, ie use the power of the 
> in-memory cache.

Done, and pushed out. It should hopefully work now.

		Linus

