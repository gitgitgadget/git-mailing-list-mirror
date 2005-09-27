From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 15:11:29 -0700
Message-ID: <7vll1iyxda.fsf@assigned-by-dhcp.cox.net>
References: <7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<7v3bnra20z.fsf@assigned-by-dhcp.cox.net> <43348086.2040006@zytor.com>
	<20050924011833.GJ10255@pasky.or.cz>
	<20050926212536.GF26340@pasky.or.cz>
	<7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<20050926222944.GG26340@pasky.or.cz>
	<7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net>
	<8764snyufn.fsf@ualberta.net>
	<7v4q875bbj.fsf@assigned-by-dhcp.cox.net>
	<20050927094029.GA30889@pasky.or.cz>
	<7v64sm30dh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509271020530.3308@g5.osdl.org>
	<7v64sm1hp3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509271414000.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Tom Prince <tom.prince@ualberta.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 00:13:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKNfm-00062g-Jm
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 00:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbVI0WLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 18:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965207AbVI0WLc
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 18:11:32 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:56524 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965204AbVI0WLb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 18:11:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927221128.BMRA2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 18:11:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509271414000.3308@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 27 Sep 2005 14:16:12 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9417>

Linus Torvalds <torvalds@osdl.org> writes:

> Yes, it would work, but I really think that there's no downside to just 
> having a
>
> 	git fetch --tags <dest>
>
> since that's just a few lines of trivial code, with no special cases.

I do not oppose that idea.  I was just trying to point out that
'git fetch --tags' does not solve what Pasky wants to do -- in
his ideal world, people track branches, and tags that refer to
objects that are on those tracked branches are automatically
fetched; at the same time tags irrelevant to the tracked
branches are not fetched at all.  'git fetch --tags' would
require the user to slurp in objects on branches she is not
interested in.
