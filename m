From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] diff-cache buglet
Date: Tue, 26 Apr 2005 12:09:14 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261207380.18901@ppc970.osdl.org>
References: <7v7jippjky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504261005360.18901@ppc970.osdl.org> <7vy8b5o211.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504261103550.18901@ppc970.osdl.org> <7vsm1do0t4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504261137350.18901@ppc970.osdl.org> <7vk6mpnz96.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 21:03:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQVK8-0005xJ-G5
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 21:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVDZTH0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 15:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVDZTH0
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 15:07:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:51096 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261745AbVDZTHU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 15:07:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QJ7Fs4015021
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 12:07:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QJ7EGb001857;
	Tue, 26 Apr 2005 12:07:15 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6mpnz96.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Junio C Hamano wrote:
> 
> We should just fix "remove-merge-entries" and call that
> unconditionally before the read-tree is called.  Once it is
> fixed, we need to think about how to show this stage
> information but that should be a separate discussion.

I already applied that part of your fix and pushed it out, there as no 
question about that one.

I just thought that _if_ you wanted the unmerged parts to show up, then 
the "1//filename.c" thing might be acceptable. Personally, I just think 
diff-cache is pretty nonsensical with unmerged files,

		Linus
