From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Date: Sat, 21 May 2005 11:34:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505211128570.2206@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
 <7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
 <7vzmuoh2ma.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:31:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZYkc-0005R1-3v
	for gcvg-git@gmane.org; Sat, 21 May 2005 20:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVEUScF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 14:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVEUScF
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 14:32:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:59050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261762AbVEUScC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 14:32:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4LIVvjA009862
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 May 2005 11:31:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4LIVuPx008580;
	Sat, 21 May 2005 11:31:57 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0505211124440.2206@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 21 May 2005, Linus Torvalds wrote:
> 
> Now, all of the actual test-cases I looked at were actually parts of
> patches where the source file _had_ been modified, so I didn't see a case
> where it selected any of the random 17,000 files that were _not_ modified,
> and I didn't double-check further than your commit message saying that it 
> really does that, so..

Oh, I decided to double-check, and no, it doesn't actually do a full copy 
check for diff-tree. Only for diff-cache and diff-files.

Which is a sensible default, and I note that you sent a separate email for 
testing the extreme case. I'll try that out too, just for fun,

		Linus
