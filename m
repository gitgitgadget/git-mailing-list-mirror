From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make -s flag to show-diff a no-op.
Date: Wed, 27 Apr 2005 16:11:16 -0700
Message-ID: <7vwtqnddd7.fsf@assigned-by-dhcp.cox.net>
References: <7vfyxbeuwt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504271520150.18901@ppc970.osdl.org>
	<7v64y7etko.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504271600280.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 01:06:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQvbS-0000mM-0H
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVD0XLU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVD0XLU
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:11:20 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:38342 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262087AbVD0XLS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 19:11:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427231115.LAVH19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 19:11:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504271600280.18901@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 27 Apr 2005 16:05:02 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Well, if you give pathnames, it's always going to limit recursion to only 
LT> those subdirectories that match one of them. 

If that is the case then -p should imply -r.  Will fix it up.

