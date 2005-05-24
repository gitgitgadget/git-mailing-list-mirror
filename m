From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -z HEAD | git-diff-helper -z fails for me
Date: Mon, 23 May 2005 17:15:38 -0700
Message-ID: <7vll651nth.fsf@assigned-by-dhcp.cox.net>
References: <20050523090206.GJ23388@cip.informatik.uni-erlangen.de>
	<7vwtpp6goy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231119570.2307@ppc970.osdl.org>
	<7vpsvh3hp0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231644560.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 02:20:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaN98-0006tB-KX
	for gcvg-git@gmane.org; Tue, 24 May 2005 02:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVEXAQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 20:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEXAQH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 20:16:07 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:53381 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261281AbVEXAPq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 20:15:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050524001538.LOQL23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 20:15:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505231644560.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 23 May 2005 16:47:02 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Actually, your solution is the yucky one.

Nod.

By the way, there seems to be a big
screwup in the pruning code and currently -C does not work at
all.  Just to let you know that I am already looking into it.

