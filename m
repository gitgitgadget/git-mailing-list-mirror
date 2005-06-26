From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-relink-script to fix up missing hardlinks
Date: Sun, 26 Jun 2005 12:31:59 -0700
Message-ID: <7vy88wq5hs.fsf@assigned-by-dhcp.cox.net>
References: <20050626181516.GC20369@mythryan2.michonline.com>
	<7v7jghq6lt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 26 21:25:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmcko-00040G-F7
	for gcvg-git@gmane.org; Sun, 26 Jun 2005 21:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVFZTcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 15:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVFZTcF
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 15:32:05 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:31139 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261578AbVFZTcC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2005 15:32:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050626193201.EVRM16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Jun 2005 15:32:01 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <7v7jghq6lt.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 26 Jun 2005 12:07:58 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> Your latest version has an option not to die which is very
JCH> good, but in a very narrow corner case, without comparing
JCH> the file contents, I think the code would still do a wrong
JCH> thing.

Having said that, the corner case is narrow enough (and
hopefully to be gone soon) that I think the current version is
perfectly acceptable for inclusion.

Linus, please apply.  What it does is useful to encourage the
"one topic, one tree" use pattern, the officially recommended
way IIUC.

I am a bit puzzled, though, why Jeff was the original requestor
for this feature --- I thought he handles 50 heads in one
repository which means there is no multiple repositories to
relink across.
