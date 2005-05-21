From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Date: Sat, 21 May 2005 11:27:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
 <7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
 <7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:25:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZYeL-0004oo-D0
	for gcvg-git@gmane.org; Sat, 21 May 2005 20:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVEUSZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 14:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVEUSZ2
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 14:25:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:13994 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261762AbVEUSZW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 14:25:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4LIPHjA009559
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 May 2005 11:25:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4LIPGpg008378;
	Sat, 21 May 2005 11:25:17 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 21 May 2005, Junio C Hamano wrote:
> 
> LT> I'm also somewhat surprised by the fact that it even seems
> LT> to be usable on the kernel tree:
> 
> Surprised?  Correctness-wise and/or performance-wise?

Performance-wise. It seems to be quite usable, even doing just a plain
"git-whatchanged -C" on the kernel with no limits on what it does.

Now, all of the actual test-cases I looked at were actually parts of
patches where the source file _had_ been modified, so I didn't see a case
where it selected any of the random 17,000 files that were _not_ modified,
and I didn't double-check further than your commit message saying that it 
really does that, so..

		Linus
