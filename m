From: Junio C Hamano <junkio@cox.net>
Subject: Re: Delitifier broken (Re: diff-core segfault)
Date: Mon, 12 Dec 2005 17:41:21 -0800
Message-ID: <7vhd9ddb9a.fsf@assigned-by-dhcp.cox.net>
References: <1134404990.5928.4.camel@localhost.localdomain>
	<7vmzj6i206.fsf@assigned-by-dhcp.cox.net>
	<7virtui1kj.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512121620380.26663@localhost.localdomain>
	<7vek4igevq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512121529200.15597@g5.osdl.org>
	<7vlkypdcsb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512121720150.15597@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 02:42:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElzAT-0005fM-PG
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 02:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbVLMBlX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 20:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbVLMBlX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 20:41:23 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:47804 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751185AbVLMBlW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 20:41:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213014033.VKKY6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 20:40:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512121720150.15597@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 12 Dec 2005 17:34:28 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13560>

Linus Torvalds <torvalds@osdl.org> writes:

> So I think your diffcore-break.c patch is much more appropriate: it also 
> fixes the bug, but it fixes it by virtue of realizing that the delta 
> cannot matter and thus should never even be computed.

Agreed, redone and pushed out.
