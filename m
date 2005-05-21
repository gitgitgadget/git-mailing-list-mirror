From: Junio C Hamano <junkio@cox.net>
Subject: updated design for the diff-raw format.
Date: Sat, 21 May 2005 16:12:57 -0700
Message-ID: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 01:12:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZd8T-0003o8-9a
	for gcvg-git@gmane.org; Sun, 22 May 2005 01:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVEUXNA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 19:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVEUXNA
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 19:13:00 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:24000 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261272AbVEUXM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 19:12:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521231257.GXWQ12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 19:12:57 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

After the introduction of the diff-core infrastructure, Linus
and I had a couple more back-and-forth, but by accident these
exchanges happened off the list.  I'll be replaying a couple of
messages to let people know about these because this change will
affect all the Porcalain implementations.


