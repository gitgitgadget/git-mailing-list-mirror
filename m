From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix up diffcore-rename scoring
Date: Mon, 13 Mar 2006 16:55:16 -0800
Message-ID: <7virqhq1zf.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org>
	<7vmzfusuyq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603122256550.3618@g5.osdl.org>
	<Pine.LNX.4.64.0603122316160.3618@g5.osdl.org>
	<7vzmjupqv0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603130727350.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 14 01:55:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIxou-00067L-1g
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 01:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWCNAzV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 19:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWCNAzV
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 19:55:21 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:5003 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932521AbWCNAzS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Mar 2006 19:55:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060314005354.UGPH15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Mar 2006 19:53:54 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603130727350.3618@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 13 Mar 2006 07:38:53 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17582>

Linus Torvalds <torvalds@osdl.org> writes:

> There's a pretty natural terminating character that works well for 
> sources: '\n'.

Good to know that great minds think alike ;-).  There is a
version that did this line-oriented hashing, buried in the next
branch.  I'll see how well it performs within the context of the
current somewhat restructured code.
