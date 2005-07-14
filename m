From: Junio C Hamano <junkio@cox.net>
Subject: Why O_EXCL would make this difference?  I am puzzled..
Date: Thu, 14 Jul 2005 01:17:41 -0700
Message-ID: <7v8y09g5sq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Thu Jul 14 10:18:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dsyum-0003V2-12
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 10:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVGNIRr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 04:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbVGNIRr
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 04:17:47 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:48552 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262958AbVGNIRn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 04:17:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714081740.FUZD8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Jul 2005 04:17:40 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The bisect search found that the commit

	Make "git-checkout" create files with O_EXCL

makes the test t1005 fail.  But it is getting late so I give up
to figuire this out tonight.
