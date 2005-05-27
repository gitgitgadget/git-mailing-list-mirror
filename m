From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix ptrdiff_t vs. int
Date: Fri, 27 May 2005 10:18:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505271013260.17402@ppc970.osdl.org>
References: <42971EB4.2050403@oberhumer.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 19:16:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbiQ8-0001Mx-4B
	for gcvg-git@gmane.org; Fri, 27 May 2005 19:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbVE0RQp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 13:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVE0RQo
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 13:16:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:41645 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262514AbVE0RQe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 May 2005 13:16:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4RHGTjA022207
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 27 May 2005 10:16:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4RHGSVI030939;
	Fri, 27 May 2005 10:16:28 -0700
To: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
In-Reply-To: <42971EB4.2050403@oberhumer.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 27 May 2005, Markus F.X.J. Oberhumer wrote:
>
> This trivial patch fixes an obvious ptrdiff_t vs. int mismatch. Which
> makes we wonder why Linus isn't hitting this on his ppc64 - maybe it's
> time to start using -Werror...

My _kernel_ is 64-bit, but my user-space is all 32-bit because (a) I don't
care about user-space and (b) I'm lazy and (c)  all the distributions
contain just 32-bit programs and a ppc64 kernel has no trouble running
32-bit programs.

I can compile a kernel with "-m64", but since I don't have any 64-bit
libraries installed, user space doesn't work that well ;)

		Linus
