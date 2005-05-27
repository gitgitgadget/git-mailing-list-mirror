From: Junio C Hamano <junkio@cox.net>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 12:52:35 -0700
Message-ID: <7vhdgoxx8c.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
	<20050527192941.GE7068@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 21:51:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbkqq-0007g7-4L
	for gcvg-git@gmane.org; Fri, 27 May 2005 21:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVE0Twj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 15:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVE0Twj
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 15:52:39 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:45782 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261900AbVE0Twh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 15:52:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050527195237.WFCQ23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 May 2005 15:52:37 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050527192941.GE7068@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Fri, 27 May 2005 21:29:41 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

TG> talking about octopus-merges ... I don't understand how they work. What
TG> happens if one file is touched in every of the 8 trees. How can that be
TG> handled?

You merge by hand and resolve if they have conflicts, just like
what you already do in two head merge case.

Octopus is only about how you record the results.  Instead of
making 7 consecutive "merge from A" "merge from B" to record two
head merges, you just say "I merged these 8 heads" in a single
commit.

