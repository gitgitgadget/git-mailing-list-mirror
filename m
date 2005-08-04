From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (preview) Renaming push.
Date: Wed, 03 Aug 2005 17:05:49 -0700
Message-ID: <7v3bpq8t2a.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508030109210.21304@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508030944210.3258@g5.osdl.org>
	<Pine.LNX.4.63.0508031849270.24318@wgmdd8.biozentrum.uni-wuerzburg.de>
	<200508031908.22562.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.58.0508031102590.3258@g5.osdl.org>
	<7vek9a8uy9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508031641270.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 02:06:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0TFL-0005lY-Vt
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 02:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVHDAFx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 20:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVHDAFx
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 20:05:53 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:3829 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261655AbVHDAFv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 20:05:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050804000548.CNAN16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 Aug 2005 20:05:48 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508031641270.3258@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 3 Aug 2005 16:48:13 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> 	git-send-pack parent $(git-rev-parse HEAD^):master
>
> and there's no real reason why that syntax shouldn't just work: it's 
> entirely logical to say "I want to push out the parent of my HEAD as 
> 'master' on the other end", and that's _exactly_ what the above says.

Yes I think allowing get_sha()-able thing on the left hand side
makes things, well, interesting.  I need to think about it a bit.

When I do something like your example, I create a temporary
lightweight tag and push it.  Snapshots in JIT are just a bunch
of lightweight tags so..
