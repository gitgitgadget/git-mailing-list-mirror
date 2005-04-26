From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] check for malloc
Date: Tue, 26 Apr 2005 11:25:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261125220.18901@ppc970.osdl.org>
References: <20050426151217.GA5344@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:19:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUeA-0007qo-1l
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVDZSYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVDZSYF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:24:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:56715 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261608AbVDZSYB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 14:24:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QINxs4011714
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 11:24:00 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QINwTr031904;
	Tue, 26 Apr 2005 11:23:59 -0700
To: Christopher Li <chrislgit@chrisli.org>
In-Reply-To: <20050426151217.GA5344@64m.dyndns.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Christopher Li wrote:
>
> Add check for NULL return from malloc and realloc

I'd prefer xmalloc()/xrealloc() instead, and just do it in one place.

		Linus
