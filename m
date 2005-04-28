From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on ia64 linux tree
Date: Wed, 27 Apr 2005 18:08:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504271805550.18901@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035B31D9@scsmsx401.amr.corp.intel.com>
 <Pine.LNX.4.58.0504271525520.18901@ppc970.osdl.org> <20050427225821.GI22956@pasky.ji.cz>
 <Pine.LNX.4.58.0504271632060.18901@ppc970.osdl.org> <20050428000729.GT22956@pasky.ji.cz>
 <Pine.LNX.4.58.0504271719380.18901@ppc970.osdl.org> <20050428003342.GW22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 03:01:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQxOv-0002wC-Ar
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 03:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVD1BGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVD1BGf
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:06:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262142AbVD1BGd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 21:06:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3S16Us4006365
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 18:06:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3S16TZU022116;
	Wed, 27 Apr 2005 18:06:29 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050428003342.GW22956@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Petr Baudis wrote:
>
> > (Which is not really nice, because it means that some files get updated 
> > and others don't, depending on how they were merged, but whatever..)
> 
> We always do checkout-cache -f -a after we do merge-cache, so it should
> end up in a consistent state.

I agree that for the common case it doesn't really matter, since we'll 
always update the working directory regardless.

It was more of a conceptual complaint. We do everything else purely in the
index, so it's a bit confusing that in that intermediate stage _some_
files end up being up-to-date, and others end up not.

		Linus
