From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list: proper lazy reachability
Date: Sat, 04 Jun 2005 12:30:50 -0700
Message-ID: <7v7jh9hqc5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
	<17052.21846.816147.370354@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0505310735260.1876@ppc970.osdl.org>
	<Pine.LNX.4.58.0505310813540.1876@ppc970.osdl.org>
	<7vekbigo8q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506040837190.1876@ppc970.osdl.org>
	<Pine.LNX.4.58.0506040847170.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 21:27:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeeJ5-0000nv-Pm
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 21:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVFDTbC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 15:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFDTbC
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 15:31:02 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:52637 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261202AbVFDTa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2005 15:30:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050604193051.PTQV1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Jun 2005 15:30:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506040847170.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 4 Jun 2005 08:51:13 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Sat, 4 Jun 2005, Linus Torvalds wrote:

>> Does this fix it for you (untested, of course)?

Will check later.

LT> Would people prefer to have "git-rev-list" take arguments like
LT> 	git-rev-list a b ^c ^d
LT> the way git-rev-tree does?

I do not expect myself to maintain many heads like Jeff, I
cannot comment on how well that "many heads" feature would work
in practice, but I would vote "a ^b" syntax to match
git-rev-tree.





