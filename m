From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Careful object writing..
Date: Tue, 3 May 2005 12:56:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505031254550.26698@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
 <20050503192753.GA6435@taniwha.stupidest.org> <Pine.LNX.4.58.0505031242330.26698@ppc970.osdl.org>
 <20050503194739.GA7082@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 21:49:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3NG-0008DY-AJ
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVECTyT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVECTyT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:54:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:24202 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261650AbVECTyP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 15:54:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j43JsDs4013542
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 May 2005 12:54:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j43JsCZX012316;
	Tue, 3 May 2005 12:54:12 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20050503194739.GA7082@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 3 May 2005, Chris Wedgwood wrote:
>
> On Tue, May 03, 2005 at 12:47:36PM -0700, Linus Torvalds wrote:
> 
> > Me, I refuse to slow down my habits for old filesystems. You can
> > either fsck, or use a logging filesystem.
> 
> ok, so you're saying everyone use linux ext3 or similar more or
> less...

No. I'm saying
 - you can use git-fsck-cache
 - or you can use a logging filesystem.

I happen to use both.

> how about we drop all the objects in one directory then?

I don't even have directory hashing on, and as mentioned, the logging 
filesystem is _not_ a requirement. It's just a reality for most of us.

		Linus
