From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Mon, 15 Aug 2005 15:37:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508151535130.3553@g5.osdl.org>
References: <20050815080931.64F0D352633@atlas.denx.de> 
 <Pine.LNX.4.58.0508150930020.3553@g5.osdl.org> <46a038f90508151309269ffc04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Wolfgang Denk <wd@denx.de>, GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 16 00:38:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4na2-0003zB-Vi
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 00:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965021AbVHOWhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 18:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVHOWhP
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 18:37:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965021AbVHOWhO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 18:37:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7FMb8jA000435
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 Aug 2005 15:37:08 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7FMb6aE018211;
	Mon, 15 Aug 2005 15:37:07 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90508151309269ffc04@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 16 Aug 2005, Martin Langhoff wrote:
> 
> If I find the time, I'll add some sort of pattern-match parameters to
> be tried against the commitmsg to extract likely head/branch names
> where we are merging from. My problem right now is that the only cvs
> repo with interesting branches and merges I have is huge, and takes an
> hour to import. That puts a damper on things, unfortunately.

I was seriously considering just breaking the "remote cvs" support
entirely (you can always just use cvsup or something to download it to
make it local), and just taking the RCS parsing code from GNU rcs/cvs and
making a C language CVS importer. That would speed things up by an order
of magnitude or more, as far as I can tell.

			Linus
