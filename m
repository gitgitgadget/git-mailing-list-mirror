From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -z HEAD | git-diff-helper -z fails for me
Date: Mon, 23 May 2005 11:44:59 -0700
Message-ID: <7vpsvh3hp0.fsf@assigned-by-dhcp.cox.net>
References: <20050523090206.GJ23388@cip.informatik.uni-erlangen.de>
	<7vwtpp6goy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231119570.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 20:45:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaHty-0008Re-FE
	for gcvg-git@gmane.org; Mon, 23 May 2005 20:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVEWSpG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 14:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVEWSpG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 14:45:06 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46560 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261926AbVEWSpB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 14:45:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523184501.VFWZ26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 14:45:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505231119570.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 23 May 2005 11:21:59 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> How about instead making sure that any "extra" text be NUL-terminated and
LT> never start with ':' after a NUL (which will automatically be true, since
LT> it's either "diff-tree " + ascii for the verbose case, or just the tree
LT> name).

Makes much more sense although it has certain amount of Yuck
factor ;-).


