From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 12:53:42 -0700
Message-ID: <7vk6lvyou1.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
	<7vy8abys5a.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505191148470.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 21:56:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYr4g-0002DP-Cn
	for gcvg-git@gmane.org; Thu, 19 May 2005 21:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVESTxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 15:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVESTxp
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 15:53:45 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:57048 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261237AbVESTxo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 15:53:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519195341.RHGR19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 15:53:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505191148470.2322@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 19 May 2005 11:55:52 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> IOW, you're screwed. "execvp()" really should take an argument of type
LT> "const char * const *", but it doesn't for historical reasons.

That's what I suspected.

