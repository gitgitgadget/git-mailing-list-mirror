From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ORIG_HEAD
Date: Tue, 21 Jun 2005 14:06:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506211404320.2268@ppc970.osdl.org>
References: <20050620.221055.71088925.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 21 23:16:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dkq4u-0007Yn-B5
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 23:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVFUVQa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Jun 2005 17:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVFUVGx
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jun 2005 17:06:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262342AbVFUVEP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jun 2005 17:04:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5LL43jA014575
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 21 Jun 2005 14:04:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5LL42LG028366;
	Tue, 21 Jun 2005 14:04:03 -0700
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050620.221055.71088925.davem@davemloft.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 20 Jun 2005, David S. Miller wrote:
> 
> Is there a really good reason why git-pull-script runs are deleting
> that file now?

No. I've cleaned it up a bit, and codified the stuff we leave around.

I also changed "git fetch" to write FETCH_HEAD instead of MERGE_HEAD, 
because that's obviously what it is (it's perfectly fine to fetch things 
for other reasons, like just checking what somebody else has, and you 
might not ever intend to merge it anyway).

		Linus
