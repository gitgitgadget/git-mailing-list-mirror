From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Short-circuit git-clone-pack while cloning locally.
Date: Wed, 06 Jul 2005 11:00:09 -0700
Message-ID: <7vy88jx1au.fsf@assigned-by-dhcp.cox.net>
References: <20050704.125744.59481768.davem@davemloft.net>
	<Pine.LNX.4.58.0507041327580.3570@g5.osdl.org>
	<Pine.LNX.4.58.0507051721450.3570@g5.osdl.org>
	<7v8y0kxsfq.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507060911510.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David S. Miller" <davem@davemloft.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 20:01:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqECL-0000z9-1q
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 20:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVGFSAR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 14:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVGFSAR
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 14:00:17 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:11964 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261847AbVGFSAK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 14:00:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050706180009.QGQN12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 6 Jul 2005 14:00:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507060911510.3570@g5.osdl.org> (Linus Torvalds's message of "Wed, 6 Jul 2005 09:13:12 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> It would seem that you don't do anything at all for the non-local case.

Oops.
