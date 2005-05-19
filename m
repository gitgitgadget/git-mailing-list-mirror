From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 16:32:57 -0700
Message-ID: <7vhdgyyeom.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191426000.20274@localhost.localdomain>
	<7vsm0jyryf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191456040.20274@localhost.localdomain>
	<7vy8abx8ay.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191643030.20274@localhost.localdomain>
	<7vll6ayjok.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505191516350.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 20 01:54:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYuoC-0007Gh-NQ
	for gcvg-git@gmane.org; Fri, 20 May 2005 01:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVESXjC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 19:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVESXeb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 19:34:31 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:60390 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261349AbVESXdA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 19:33:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519233259.HPTP7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 19:32:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505191516350.2322@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 19 May 2005 15:26:39 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Not quite a related topic, but unless we start to support the
copy detection you recommended against, my understanding is that
-M does not do anything useful for git-diff-files.  Is there a
good use case for it?  I am not advocating for its removal so
please leave the command line option there.


