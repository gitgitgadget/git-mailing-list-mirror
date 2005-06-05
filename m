From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-shortlog script
Date: Sat, 4 Jun 2005 17:16:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506041715170.1876@ppc970.osdl.org>
References: <42A22C20.10002@pobox.com> <Pine.LNX.4.58.0506041642530.1876@ppc970.osdl.org>
 <42A24274.7040906@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 05 02:11:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Deije-0000mQ-Sg
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 02:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVFEAOr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 20:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVFEAOr
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 20:14:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:21160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261443AbVFEAOp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 20:14:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j550EgjA020194
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 4 Jun 2005 17:14:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j550EfaR011266;
	Sat, 4 Jun 2005 17:14:42 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42A24274.7040906@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 4 Jun 2005, Jeff Garzik wrote:
> 
> I'm surprised git doesn't fall back to GIT_COMMITTER_NAME if 
> GIT_AUTHOR_NAME doesn't exist, though.

GIT_AUTHOR_NAME existed first ;)

Btw, what does your /etc/passwd look like, and I'll try to hack it up to 
just get that case right by default too..

		Linus
