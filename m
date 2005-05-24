From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 14:13:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org>
References: <4292A08A.5050108@cobite.com> <Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
 <20050524161745.GA9537@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
 <20050524184612.GA23637@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
 <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
 <20050524202846.GC25606@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 23:11:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DagfM-0006nR-6h
	for gcvg-git@gmane.org; Tue, 24 May 2005 23:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVEXVLl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 17:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbVEXVLl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 17:11:41 -0400
Received: from fire.osdl.org ([65.172.181.4]:13282 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262183AbVEXVLb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2005 17:11:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4OLBMjA023850
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 24 May 2005 14:11:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4OLBKhd017560;
	Tue, 24 May 2005 14:11:21 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050524202846.GC25606@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 24 May 2005, Thomas Glanzmann wrote:
> 
> btw:
> 
> For the mutt tree there are a few 'empty commits' eg were the
> parent tree is the same as the current. This is because git ignores
> .cvsignore and they commited some .cvsignore files without any other
> deltas. I don't know if you want to handle this. Just a note.

I don't like source repositories with dot-files, and I thought it was a
good idea to disallow them, but on the other hand I'd like it even less if
some CVS-weenie goes and says "I can't convert my project to git without
potentially losing information".

So in the name of furthering humanity through allowing people to migrate
away from CVS, I'm considering making the git dot-file check be more
specific to "." ".." and ".git". After all, project-specific rules might
have their own porcelain-related ignore-files that cause dot-files to
never appear..

Hmm.

		Linus
