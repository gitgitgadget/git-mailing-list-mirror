From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Restore expected list order for --merge-order switch
Date: Tue, 5 Jul 2005 16:43:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507051642490.3570@g5.osdl.org>
References: <20050705010619.13581.qmail@blackcubes.dyndns.org>
 <2cfc403205070516216b911160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 06 01:44:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpx5M-0000UC-DU
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 01:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVGEXoG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 19:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVGEXoG
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 19:44:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38866 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262017AbVGEXoC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 19:44:02 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j65NhsjA004060
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 5 Jul 2005 16:43:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j65NhlKQ032119;
	Tue, 5 Jul 2005 16:43:50 -0700
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc403205070516216b911160@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 6 Jul 2005, Jon Seymour wrote:
> 
> Is there some reason why this didn't get applied?

I think it's horribly horribly ugly. 

I really don't see the point of argument ordering mattering, and I think 
the test is broken. Convince me otherwise.

		Linus
