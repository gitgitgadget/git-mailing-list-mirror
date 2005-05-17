From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] uml: remove elf.h
Date: Tue, 17 May 2005 14:42:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505171440470.18337@ppc970.osdl.org>
References: <200505171704.j4HH4Ne8002532@hera.kernel.org>
 <20050517142113.59097a3d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
X-From: git-owner@vger.kernel.org Tue May 17 23:42:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY9oA-0003kU-Bv
	for gcvg-git@gmane.org; Tue, 17 May 2005 23:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVEQVlE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 17:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVEQVlD
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 17:41:03 -0400
Received: from fire.osdl.org ([65.172.181.4]:9645 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbVEQVkp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 17:40:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4HLeeU3001918
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 May 2005 14:40:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4HLedo8024847;
	Tue, 17 May 2005 14:40:40 -0700
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050517142113.59097a3d.akpm@osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 17 May 2005, Andrew Morton wrote:
> 
> And I bet that when Linus releases patch-2.6.12-rc5.gz and patch-2.6.12.gz,
> they will have the same construct.  AFAICT, the patch-based people will
> need to download a full new tarball to get rid of this dang file.

Or just run "make distclean" once.

> It all wouldn't really matter much, except apparently the mere presence of
> this file breaks the UML build.
> 
> Frazzle.  Paolo, I'm almost wondering if we should change that test to also
> check for a zero-length file.

How many people are affected? The file _is_ gone in the git archives, and 
in fact I wonder if it was ever there, but I didn't bother to check.

		Linus
