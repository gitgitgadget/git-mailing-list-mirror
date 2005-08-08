From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git revert" (Re: pci_update_resource() getting called on sparc64)
Date: Mon, 8 Aug 2005 13:59:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508081357020.3258@g5.osdl.org>
References: <20050808.103304.55507512.davem@davemloft.net>
 <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org> <20050808160846.GA7710@kroah.com>
 <20050808.123209.59463259.davem@davemloft.net> <20050808194249.GA6729@kroah.com>
 <Pine.LNX.4.58.0508081249110.3258@g5.osdl.org> <Pine.LNX.4.58.0508081257190.3258@g5.osdl.org>
 <7vd5oo40mq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 08 23:00:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2EiZ-0008Vn-V5
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 22:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVHHU73 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 16:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbVHHU73
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 16:59:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932224AbVHHU72 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 16:59:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j78KxJjA009882
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 8 Aug 2005 13:59:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j78KxI0b025389;
	Mon, 8 Aug 2005 13:59:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5oo40mq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 8 Aug 2005, Junio C Hamano wrote:
> 
> Totally untested.  I acquired your habit of coding in my e-mail
> client ;-).

Looks good. Although I also have this advanced testing habit of just 
reading the email and if it looks sane it tested out ok ;)

But it strikes me that we could use the "-M" flag to git-diff-tree, which
makes it a lot more likely that we can revert renames, even if the file
has been slightly changed afterwards.

			Linus
