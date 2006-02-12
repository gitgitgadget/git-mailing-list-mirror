From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix object re-hashing
Date: Sun, 12 Feb 2006 10:18:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602121017290.3691@g5.osdl.org>
References: <Pine.LNX.4.64.0602120956130.3691@g5.osdl.org>
 <Pine.LNX.4.64.0602121015020.3691@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Feb 12 19:19:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8LoT-0002We-NA
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 19:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWBLSSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 13:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbWBLSSy
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 13:18:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36586 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750748AbWBLSSx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 13:18:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k1CIImDZ015696
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Feb 2006 10:18:48 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k1CIIlAQ014769;
	Sun, 12 Feb 2006 10:18:47 -0800
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.64.0602121015020.3691@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16007>



On Sun, 12 Feb 2006, Linus Torvalds wrote:
> 
> That's what I get for editing the patch in-place to remove the optimized 
> version that I felt wasn't worth worrying about due to being subtle. So 
> instead I sent out a patch that was not-so-subtly obvious crap!

Btw: the reason I edited out the optimization is that it doesn't actually 
matter. Re-hashing the whole thing is a trivial thing, and has basically 
zero overhead in my testing. The costs are all elsewhere now.

		Linus
