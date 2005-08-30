From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix bisection terminating condition
Date: Tue, 30 Aug 2005 11:56:42 -0700
Message-ID: <7vy86ji785.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508301026450.4293@g5.osdl.org>
	<Pine.LNX.4.58.0508301038340.4426@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 30 21:07:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EABIc-0005Yd-TK
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 20:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbVH3S4o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Aug 2005 14:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVH3S4o
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Aug 2005 14:56:44 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:23507 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932264AbVH3S4o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2005 14:56:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050830185644.KFHX2438.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 Aug 2005 14:56:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508301038340.4426@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 30 Aug 2005 11:04:39 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7962>

Linus Torvalds <torvalds@osdl.org> writes:

> When testing bisection and using gitk to visualize the result, it was 
> obvious that the termination condition was broken.

Thanks.
