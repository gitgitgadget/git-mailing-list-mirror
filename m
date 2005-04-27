From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Add -r flag to show-diff for diff-cache/diff-tree like
 output.
Date: Tue, 26 Apr 2005 17:22:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261721550.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
 <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
 <7vy8b5mawy.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504261534590.18901@ppc970.osdl.org>
 <7vd5shm94l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504261639420.18901@ppc970.osdl.org>
 <7vd5shkrs5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 02:15:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQaDA-0005uj-35
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 02:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVD0AUj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 20:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261864AbVD0AUj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 20:20:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:26514 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261862AbVD0AUf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 20:20:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3R0KVs4009359
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 17:20:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3R0KTqQ019916;
	Tue, 26 Apr 2005 17:20:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5shkrs5.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Junio C Hamano wrote:
> 
> By the way, how about renaming show-diff to diff-file?
> 
>     diff-tree  : compares two trees.
>     diff-cache : compares a tree and the cache, or a tree and files.
>     diff-file  : compares the cache and files.

Yes. Except I think that the "big renaming" is coming up, and we should 
just rename them to have a "git-" prefix too.

		Linus
