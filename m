From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 17:30:21 -0700
Message-ID: <7vd5rgtaea.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505201604460.2206@ppc970.osdl.org>
	<428E745C.30304@zytor.com>
	<Pine.LNX.4.58.0505201702170.2206@ppc970.osdl.org>
	<4292A08A.5050108@cobite.com>
	<Pine.LNX.4.58.0505232048190.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org>
	<20050524161745.GA9537@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
	<20050524184612.GA23637@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241212190.2307@ppc970.osdl.org>
	<20050525003917.40700d19.froese@gmx.de>
	<Pine.LNX.4.58.0505241602330.2307@ppc970.osdl.org>
	<7vk6lotbil.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505241711590.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Edgar Toernig <froese@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 02:29:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dajll-0003XA-K9
	for gcvg-git@gmane.org; Wed, 25 May 2005 02:29:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVEYAae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 20:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVEYAae
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 20:30:34 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14792 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S262178AbVEYAaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 20:30:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525003021.TEMY20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 24 May 2005 20:30:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505241711590.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 24 May 2005 17:17:37 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> The sad part is that I don't even have an excuse like "I use
LT> perl all the time". No, shell is my _forte_ when it comes to
LT> scripting.

You are allowed to suck at scripting when you are so good at C
;-).

By the by, are you still having problem with "whatchanged -s"?
I see a few of my patches still not in your tree, and I do not
care too much about the last one (rename/copy similarity
estimator update) after you made it clear that -M and -C are of
lower priority, I would like to know if the "diff-tree -s" fix I
sent you was missing the point, and if so how.  Also the test
scripts to verify your fix to the "checkout-cache --prefix
pointing at some directory via symlink" along with your fix is
something I feel ready to go.

Hoping it would be easy to look for a message by message-ID,
here they are.  The first one is the proposed "diff-tree -s"
fix.

Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half...
Message-ID: <7vr7fxuh8b.fsf@assigned-by-dhcp.cox.net>

Subject: Squelch compiler warning
Message-ID: <7vis18v4ea.fsf_-_@assigned-by-dhcp.cox.net>

Subject: [PATCH] Allow symlinks in the leading path in checkout-cache --prefix=
Message-ID: <7vacmlvwfk.fsf_-_@assigned-by-dhcp.cox.net>

Subject: [PATCH] Update rename/copy similarity estimator.
Message-ID: <7vbr70v3tf.fsf@assigned-by-dhcp.cox.net>

