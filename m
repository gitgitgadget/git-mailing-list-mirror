From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] diff-cache buglet
Date: Tue, 26 Apr 2005 11:38:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261137350.18901@ppc970.osdl.org>
References: <7v7jippjky.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504261005360.18901@ppc970.osdl.org> <7vy8b5o211.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504261103550.18901@ppc970.osdl.org> <7vsm1do0t4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:32:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUqO-0001Q7-2a
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261648AbVDZSgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVDZSgr
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:36:47 -0400
Received: from fire.osdl.org ([65.172.181.4]:64911 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261648AbVDZSgo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 14:36:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QIacs4012587
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 11:36:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3QIab7Y032655;
	Tue, 26 Apr 2005 11:36:37 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsm1do0t4.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Junio C Hamano wrote:
> 
> Well, I somehow thought these things are in fixed column format;
> mode, ->, sha, stage, and filename are all seperated with either
> ' ' or '\t'.  So if I copy MN to "1 MN", presumably you would
> see this:
> 
>     100644 a716d58de4a570e0038f5c307bd8db34daea021f 0 MN
>     100644 a716d58de4a570e0038f5c307bd8db34daea021f 0 1 MN
> 
> So while I agree that // would also work, I fail to see why you
> would even need that.

Because I'd rather _not_ have the 0 in there at all for the normal case.

Yes, it's there for "show-files --stages", but it's certainly _not_ there 
in "diff-tree" output right now.

		Linus
