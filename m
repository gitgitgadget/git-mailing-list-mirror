From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on ia64 linux tree
Date: Wed, 27 Apr 2005 16:36:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271632060.18901@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035B31D9@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0504271525520.18901@ppc970.osdl.org> <20050427225821.GI22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 01:29:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQvyB-0002ut-LO
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVD0Xel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVD0Xec
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:34:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:40116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262100AbVD0XeX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 19:34:23 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RNYKs4031561
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 16:34:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RNYJ2Z017670;
	Wed, 27 Apr 2005 16:34:20 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050427225821.GI22956@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Petr Baudis wrote:
> 
> Fixed and pushed out.

It looks like you only did the fix for the pure "just update to the 
version at the other end" case. 

So if you actually end up doing a merge, it still leaves all the old files
(that the merge may have removed from the tree) around. Or did I miss 
something?

		Linus
