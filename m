From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 18:50:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505231847260.2307@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505231758350.2307@ppc970.osdl.org>
 <Pine.LNX.4.62.0505231827430.4200@qynat.qvtvafvgr.pbz>
 <211e617258d9d993810f3c88bace255e.IBX@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Lang <david.lang@digitalinsight.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 03:49:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaOW4-00073R-Bc
	for gcvg-git@gmane.org; Tue, 24 May 2005 03:47:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVEXBs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 21:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVEXBs7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 21:48:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:53157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261286AbVEXBsy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 21:48:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4O1mljA006460
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 18:48:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4O1mkTq000672;
	Mon, 23 May 2005 18:48:47 -0700
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <211e617258d9d993810f3c88bace255e.IBX@taniwha.stupidest.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Chris Wedgwood wrote:
> 
> diff doesn't do this, so i'm not sure it's useful:

Indeed.

A few weeks ago (for the previous round of "what should the diff format 
be" discussions) I looked at what "diffstat" does to figure out what the 
name should be, and it's quite disgusting.

The sad part is that if it wasn't for the date that GNU diff puts out, 
we'd be ok (since only GNU diff historically did unified diffs). Then we'd 
just know that the filename ends at the newline, and screw people who use 
newlines in filenames.

Now, we can fix this for git-diffs, and make sure that we don't make that 
mistake, but that just covers git users.

		Linus
