From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] xdiff/xemit.c (xdl_find_func): Elide trailing white
 space in a context header.
Date: Mon, 23 Oct 2006 14:10:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610231409430.3962@g5.osdl.org>
References: <87y7r63hq6.fsf@rho.meyering.net> <Pine.LNX.4.64.0610231347490.3962@g5.osdl.org>
 <20061023210327.GT20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 23:11:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc74d-0000Bh-UA
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 23:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbWJWVLE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 17:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWJWVLD
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 17:11:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46555 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751753AbWJWVLB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 17:11:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NLAqaX007298
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 14:10:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NLAoWM006487;
	Mon, 23 Oct 2006 14:10:51 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061023210327.GT20017@pasky.or.cz>
X-Spam-Status: No, hits=-2.478 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29884>



On Mon, 23 Oct 2006, Petr Baudis wrote:
> 
> Not really - mind you, this is only about the diff headers. Actually, it
> is only about the hunk headers, specifically when we append the function
> name to the hunk header.

Ahh. I totally misunderstood, looking at just the diff, and not the bigger 
context of it.

Removing whitespace from the "comment" in the hunk header is obviously 
fine.

Sorry for the noise.

		Linus
