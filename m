From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add -O<orderfile> option to diff-* brothers.
Date: Sun, 29 May 2005 13:32:09 -0700
Message-ID: <7vll5xkc3a.fsf@assigned-by-dhcp.cox.net>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291154030.10545@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 22:37:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcUPy-0002B4-KG
	for gcvg-git@gmane.org; Sun, 29 May 2005 22:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVE2UcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 16:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVE2UcP
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 16:32:15 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:45803 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261433AbVE2UcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 16:32:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050529203211.GQTW16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 29 May 2005 16:32:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505291154030.10545@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 29 May 2005 11:56:10 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> This smells to me like a "cool feature, because we can"
LT> rather than a "this is useful because of xxx".

You could even do the rename/copy detection outside with a
standalone diff-raw filter, just like your "sort-filenames" pipe
example.  Rename/copy is not done that way primarily for the
performance reasons.  Pickaxe is not done that way because we
wanted to conditionally suppress diff-tree headers, and it is
easier to implement the suppression inside rather than as a
"sort-filename" like filter.

This diffcore-order is more like "cool feature, because we can,
_and_ it is simpler to do it inside rather than outside, now we
already have the infrastructure inside to do this kind of thing
for other purposes anyway".




