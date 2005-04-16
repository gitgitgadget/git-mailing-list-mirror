From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/2] merge-trees script for Linus git
Date: Fri, 15 Apr 2005 18:02:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz>
 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <20050414193507.GA22699@pasky.ji.cz>
 <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz>
 <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net> <20050414223039.GB28082@64m.dyndns.org>
 <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net> <20050415062807.GA29841@64m.dyndns.org>
 <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net> <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org> <7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
 <7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net> <7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 02:57:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMbcN-0006uc-49
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 02:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVDPBAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 21:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVDPBAU
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 21:00:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:5520 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262499AbVDPBAP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 21:00:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3G109s4020511
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 18:00:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3G108pi026119;
	Fri, 15 Apr 2005 18:00:09 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, Junio C Hamano wrote:
> 
>     the merge-trees I sent you earlier was expecting the old
> diff-tree behaviour, and I did not realize that I need an
> explicit -z flag now.

You didn't need one - I just didn't want to merge your "ls-tree" change
without making things be consistent. Once we started using the "-z" flag 
for ls-tree, it just didn't make any sense not to do the same thing for 
diff-tree.

Just a heads-up - I'd really want to do the same thing to "merge-tree.c" 
too, but since you said that you were working on extending that to do 
recursion etc, I decided to hold off. So if you're working on it, maybe 
you can add the "-z" flag there too? 

I'm actually holding off merging the perl version exactly because you 
seemed to be working on the C version. I don't mind perl per se, but if 
there's a real solution coming down the line..

		Linus
