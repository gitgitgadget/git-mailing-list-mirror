From: Linus Torvalds <torvalds@osdl.org>
Subject: Tree tags again..
Date: Thu, 4 Aug 2005 17:03:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508041702180.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 05 02:04:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0pgV-0006r5-3v
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 02:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVHEAD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 20:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbVHEADZ
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 20:03:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49850 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262758AbVHEADW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2005 20:03:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7503HjA008379
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 4 Aug 2005 17:03:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7503GCD017151;
	Thu, 4 Aug 2005 17:03:17 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Junio, maybe there should be some test-case for this:

	error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit
	error: remote ref 'refs/tags/v2.6.11' is not a strict subset of local ref 'refs/tags/v2.6.11'.
	error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit
	error: remote ref 'refs/tags/v2.6.11-tree' is not a strict subset of local ref 'refs/tags/v2.6.11-tree'.

Hmm?

		Linus
