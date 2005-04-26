From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] diff-cache buglet
Date: Tue, 26 Apr 2005 10:11:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261005360.18901@ppc970.osdl.org>
References: <7v7jippjky.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 19:05:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQTUZ-0001dt-5Q
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 19:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVDZRJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 13:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVDZRJx
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 13:09:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:51165 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261498AbVDZRJ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 13:09:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QH9Ks4004348
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 10:09:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QH9JBO027144;
	Tue, 26 Apr 2005 10:09:20 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jippjky.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Junio C Hamano wrote:
> 
> The patch lets you have it in both ways by adding --unmerged
> flag.  Without it, unmerged entries are culled at the beginning;
> with it, you will see diffs for all unmerged stages.

I'm ok with that, but if so I think it should show the stage somehow, and
make it clear that it's unmerged. Maybe by appending something to the name
(maybe just a ':' and stage number, but I'd almost prefer the stage number
to be translated into something human-readable, so maybe we could have
something like

	filename.c^orig
	filename.c^first
	filename.c^second

for stages 1-3 respectively)?

I'll apply your fix right now.

		Linus
