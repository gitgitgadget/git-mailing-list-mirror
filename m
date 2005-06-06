From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile for 1.0
Date: Sun, 05 Jun 2005 23:35:26 -0700
Message-ID: <7vpsv0uh5d.fsf@assigned-by-dhcp.cox.net>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org>
	<7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
	<20050606054356.GB3669@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 08:32:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfB9a-0005to-TH
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 08:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVFFGfe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 02:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVFFGfe
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 02:35:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18933 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261194AbVFFGf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2005 02:35:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050606063526.SNGJ7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Jun 2005 02:35:26 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 5 Jun 2005 23:13:11 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> And the "git-merge-one-file-script" thing needs to be updated to keep the
LT> tree updated as it merges things by hand, since it can't depend on the
LT> git-checkout-cache fixing things up any more. Anybody?

I'd love to bite.  One problem I have been having for the last
30 minutes or so is that t1000 test (merge from h*ll) does not
show that read-tree resolving even the trivial ones anymore, and
I do not know if you want make it that the responsibility of
git-merge-one-file-script, or if it is just an oversight.

I might have leave that to Europeans, though, due to timezone
differences ;-).

