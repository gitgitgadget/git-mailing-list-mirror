From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: emit base before delta.
Date: Thu, 30 Jun 2005 23:18:02 -0700
Message-ID: <7v64vvxd5x.fsf@assigned-by-dhcp.cox.net>
References: <7vbr5nxe38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 08:11:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DoEje-0000v7-FY
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 08:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263231AbVGAGSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jul 2005 02:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263235AbVGAGSL
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jul 2005 02:18:11 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:6081 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S263231AbVGAGSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2005 02:18:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050701061804.VSHD18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 1 Jul 2005 02:18:04 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vbr5nxe38.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 30 Jun 2005 22:58:03 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> This micro-optimizes the order of objects in a pack.  By
JCH> emitting base objects before deltified ones, unpack-objects do
JCH> not keep items on delta_list.

Oops; "does not have to keep items" is what I meant.
