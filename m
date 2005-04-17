From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] update-cache --refresh cache entry leak
Date: Sat, 16 Apr 2005 21:44:46 -0700
Message-ID: <7vbr8e2erl.fsf@assigned-by-dhcp.cox.net>
References: <7v8y3i5o8t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504162033250.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 06:41:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN1ai-0004rq-9T
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 06:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVDQEot (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 00:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVDQEot
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 00:44:49 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28916 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261252AbVDQEos (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 00:44:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417044446.CJDG1497.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 00:44:46 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504162033250.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Sat, 16 Apr 2005 20:35:07 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> I've seen this patch now three times, and it's been wrong every single 
LT> time. Maybe we should add a comment?

I found out the previous two just after I sent it out.  Sorry
about that.


