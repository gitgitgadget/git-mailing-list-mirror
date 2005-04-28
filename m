From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on ia64 linux tree
Date: Wed, 27 Apr 2005 17:21:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271719380.18901@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035B31D9@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0504271525520.18901@ppc970.osdl.org> <20050427225821.GI22956@pasky.ji.cz>
 <Pine.LNX.4.58.0504271632060.18901@ppc970.osdl.org> <20050428000729.GT22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:14:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQwff-00077y-E2
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVD1ATl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVD1AT2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:19:28 -0400
Received: from fire.osdl.org ([65.172.181.4]:6848 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262119AbVD1ATX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 20:19:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3S0JKs4003030
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 17:19:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3S0JJ6l020196;
	Wed, 27 Apr 2005 17:19:20 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050428000729.GT22956@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Petr Baudis wrote:
> 
> Hmm, doesn't the three-way read-tree -m take care of that? Then it
> should hit

Yes, you're right, I didn't think about the fact that the helper script 
actually does the checkout for the clashing files it merges.

(Which is not really nice, because it means that some files get updated 
and others don't, depending on how they were merged, but whatever..)

			Linus
