From: Junio C Hamano <junkio@cox.net>
Subject: Re: Necessity of "evil" merge and topic branches
Date: Wed, 17 May 2006 23:44:15 -0700
Message-ID: <7vu07n6dds.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605172120160.10823@g5.osdl.org>
	<7vy7wz6e8c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 08:44:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgcF9-0003gs-OE
	for gcvg-git@gmane.org; Thu, 18 May 2006 08:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWERGoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 02:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWERGoR
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 02:44:17 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17116 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751258AbWERGoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 02:44:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518064416.BZTD24290.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 02:44:16 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vy7wz6e8c.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 17 May 2006 23:25:55 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20266>

Junio C Hamano <junkio@cox.net> writes:

> Now, unlike "pu", I never rewind "next", so once I did this
> "evil merge", I do not have to worry about this anymore while
> the topic is still on "next".

Side note.  If an evil merge or other hand resolution needs to
be done on a path that results in automerge conflicts, rerere
often helps.  I really should start advertising it a bit more.

Unfortunatly, rerere does not even kick in in this case.
