From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull-script hates me
Date: Wed, 06 Jul 2005 14:23:11 -0700
Message-ID: <7v64vnwrwg.fsf@assigned-by-dhcp.cox.net>
References: <20050706203139.GA19198@kroah.com>
	<Pine.LNX.4.58.0507061335100.4159@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jul 06 23:49:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqHlO-0001Zx-Q4
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 23:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262541AbVGFVji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 17:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262516AbVGFVXZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 17:23:25 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:28840 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262540AbVGFVXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 17:23:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050706212309.UBSR550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 6 Jul 2005 17:23:09 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0507061335100.4159@g5.osdl.org> (Linus Torvalds's message of "Wed, 6 Jul 2005 13:37:55 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> But yeah, it's being a bit too anal. Just look at connect.c: shell_safe(),
LT> and add both '_' and '@' to the safe list (and any other safe characters),
LT> and off you go.

LT> And if somebody wants to add code to do proper escaping of the non-safe 
LT> ones, we can do that too. I was just lazy and added the characters I ever 
LT> use ;)

Anybody who is interested in doing this can just move
sq_expand() from diff.c to some public library and expose it in
cache.h.

I am not going to do it myself immediately so there is no worry
to race against me ;-).
