From: Junio C Hamano <junkio@cox.net>
Subject: Status of git.git repository
Date: Fri, 29 Jul 2005 19:11:48 -0700
Message-ID: <7vhded6o0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 30 04:19:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dygw5-0001zz-Hc
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 04:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262928AbVG3CSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 22:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVG3CNg
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 22:13:36 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:3547 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S262933AbVG3CLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 22:11:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730021150.QHKT7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 22:11:50 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've been trying to streamline my workflow since I took it over
from Linus, and I think I am getting used to it.  So here is a
short summary of what I am doing in the git.git repository.

Right now, there are two branches on kernel.org git.git
repository.  I would not rewind "master" so if I find out any
screwups and need to do an emergency fix, that fix would go on
top of the tip of "master" (I just did one today X-< due to lack
of testing).

On the other hand, "pu" is rebased every time "master" advances.
They are queued patches I receive in e-mails, and they hopefully
will graduate to be part of "master" when I feel they look OK,
and I feel that objections from the list were non-issues.  Of
course some may drop out without graduating.  Please consider
seeing your patch in "pu" branch an ACK from me, but seeing it
sitting in "pu" for a long time is a sign of trouble.

By the way, do people mind my posting my own patches to the
list?  I keep the same in the "pu" (proposed updates) branch, so
if the list readers think I am just adding noise to the list
traffic, I would stop doing so, and instead just invite
interested people to browse the "pu" branch.
