From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-cache/tree compatible output for show-diff (take
 2).
Date: Tue, 26 Apr 2005 17:20:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504261719230.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org>
 <7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org>
 <7vy8b5mawy.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504261534590.18901@ppc970.osdl.org>
 <7vd5shm94l.fsf@assigned-by-dhcp.cox.net> <7vy8b5ksqi.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 02:14:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQaBh-0005lz-Ef
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 02:13:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVD0ATE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVD0ATE
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 20:19:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:2450 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261865AbVD0ASx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 20:18:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3R0Ils4009042
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 17:18:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3R0IjaW019799;
	Tue, 26 Apr 2005 17:18:47 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy8b5ksqi.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, Junio C Hamano wrote:
>
> This patch changes the output format of the show-diff command to
> match that of the diff-cache/tree commands.  One type of record
> it can produce that diff-cache/tree do not is of this form:

Dang, I already did this in my tree. I pushed mine out, and I don't want 
to see the "-p" flag until the others also do it (ie diff-tree and 
diff-cache ;).

Btw, diff-cache definitely _can_ output this form, so we probably should 
make diff-cache do so too, to match, no?

		Linus
