From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add SubmittingPatches
Date: Mon, 15 Aug 2005 17:37:48 -0700
Message-ID: <7vbr3ysomb.fsf@assigned-by-dhcp.cox.net>
References: <7vslxep5jq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508160147560.26580@wgmdd8.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.58.0508151715520.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 02:38:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4pSo-0001Jq-UM
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 02:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbVHPAhu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 20:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVHPAhu
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 20:37:50 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:11680 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964907AbVHPAht (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 20:37:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816003747.GJDM8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 Aug 2005 20:37:47 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508151715520.3553@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 15 Aug 2005 17:24:56 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> And 4.58 needs at least this

> diff-tree 8326dd8350be64ac7fc805f6563a1d61ad10d32c (from e886a61f76edf5410573e92e38ce22974f9c40f1)
> Author: Linus Torvalds <torvalds@g5.osdl.org>
> Date:   Mon Aug 15 17:23:51 2005 -0700
>
>     Fix pine whitespace-corruption bug
>     
>     There's no excuse for unconditionally removing whitespace from
>     the pico buffers on close.

Wow.

This is a _terrible_ one.  Isn't pico code also supposed to be a
standalone editor of some sort?  I wonder how anybody could
tolerate this kind of "dictatorship ;-)".

At least the changelog entry seems to say that 4.60 removed this
"feature".
