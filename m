From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list: proper lazy reachability
Date: Sat, 04 Jun 2005 12:41:17 -0700
Message-ID: <7v1x7hhpuq.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
	<17052.21846.816147.370354@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0505310735260.1876@ppc970.osdl.org>
	<Pine.LNX.4.58.0505310813540.1876@ppc970.osdl.org>
	<7vekbigo8q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506040837190.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 21:39:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeeTB-0001WP-4b
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 21:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVFDTlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 15:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVFDTlV
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 15:41:21 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:18074 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261232AbVFDTlT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2005 15:41:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050604194118.QSBH26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Jun 2005 15:41:18 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506040837190.1876@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 4 Jun 2005 08:42:46 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Yes. The whole thing is written to literally expect to see the "stop here" 
LT> thing, and that's when it starts poisoning the well.

LT> Does this fix it for you (untested, of course)?

Yes, it does.


