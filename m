From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 11:36:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
References: <20050414002902.GU25711@pasky.ji.cz> <20050413212546.GA17236@64m.dyndns.org>
 <20050414004504.GW25711@pasky.ji.cz> <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
 <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz>
 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 20:33:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM98b-0007oX-6t
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 20:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVDNSfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 14:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVDNSfT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 14:35:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:12752 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261396AbVDNSfI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 14:35:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3EIYws4028534
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Apr 2005 11:34:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3EIYsC3011670;
	Thu, 14 Apr 2005 11:34:56 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 14 Apr 2005, Junio C Hamano wrote:
> 
> Sorry, I have not seen what you have been doing since pasky 0.3,
> and I have not even started to understand the mental model of
> the world your tool is building.  That said, my gut feeling is
> that telling this script about git-pasky's world model might be
> a mistake.  I'd rather see you consider the script as mere "part
> of the plumbing". 

I agree. Having separate abstraction layers is good.  I'm actually very 
happy with Pasky's cleaned-up-tree, exactly because unlike the first one, 
Pasky did a great job of maintaining the abstraction between "plumbing" 
and user interfaces.

The plumbing should take user interface needs into account, but the more
conceptually separate it is ("does it makes sense on its own?") the better
off we'll be. And "merge these two trees" (which works on a _tree_ level)
or "find the common commit" (which works on a _commit_ level) look like 
plumbing to me - the kind of things I should have written, if I weren't 
such a lazy slob.

		Linus
