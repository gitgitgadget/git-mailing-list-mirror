From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge conflicts as .rej .orig files
Date: Thu, 18 Aug 2005 21:29:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508182125490.3412@g5.osdl.org>
References: <46a038f9050818200625d64a12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 06:30:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5yWf-0001lW-8M
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 06:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVHSE3y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 00:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVHSE3y
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 00:29:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932539AbVHSE3x (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Aug 2005 00:29:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7J4TnjA007152
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 18 Aug 2005 21:29:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7J4Tm8F027962;
	Thu, 18 Aug 2005 21:29:48 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f9050818200625d64a12@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 19 Aug 2005, Martin Langhoff wrote:
> 
> Is there a way to convince cogito/git to leave reject files around?

Nope.

Git just doesn't deal in patches. There's never any patch rejects: there 
are just two source files that get merged.

The ".orig" and ".rej" things are signs of patch-based systems. 

I'm sure you could fake it, but I'm also sure that there's an emacs mode 
for the "merge" style diffs. It is, after all, what CVS and RCS have used, 
so I'd expect that there be tons of support for making it look nice and 
help merges.

		Linus
