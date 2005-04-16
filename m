From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/2] merge-trees script for Linus git
Date: Fri, 15 Apr 2005 22:02:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz>
 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz>
 <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz>
 <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net> <20050414223039.GB28082@64m.dyndns.org>
 <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net> <20050415062807.GA29841@64m.dyndns.org>
 <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net> <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org> <7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
 <7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net> <7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org> <7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 06:57:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMfN3-0005hD-IV
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 06:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVDPFAt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 01:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262635AbVDPFAt
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 01:00:49 -0400
Received: from fire.osdl.org ([65.172.181.4]:56260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261697AbVDPFAo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 01:00:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3G50ds4012450
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 22:00:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3G50cCQ001650;
	Fri, 15 Apr 2005 22:00:38 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, Junio C Hamano wrote:
> 
> I'd take the hint, but I would say the current Perl version
> would be far more usable than the C version I would come up with
> by the end of this weekend because:

Actually, it turns out that I have a cunning plan.

I'm full of cunning plans, in fact. It turns out that I can do merges even
more simply, if I just allow the notion of "state" into an index entry,
and allow multiple index entries with the same name as long as they differ
in "state".

And that means that I can do all the merging in the regular index tree, 
using very simple rules.

Let's see how that works out. I'm writing the code now.

		Linus
