From: Junio C Hamano <junkio@cox.net>
Subject: Re: What is in git.git
Date: Sun, 22 Jan 2006 12:41:53 -0800
Message-ID: <7vbqy4c7vy.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net>
	<200601211636.02340.lan@ac-sw.com>
	<7vek31mkyg.fsf@assigned-by-dhcp.cox.net>
	<200601220033.26321.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 22 21:42:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0m2A-000415-K2
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 21:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWAVUl4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 15:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWAVUlz
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 15:41:55 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:7423 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751349AbWAVUlz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jan 2006 15:41:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122204032.IRHV20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 22 Jan 2006 15:40:32 -0500
To: git@vger.kernel.org
In-Reply-To: <200601220033.26321.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Sun, 22 Jan 2006 00:33:25 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15062>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> I understand that "moving binding point of X from X/ to lib/X/" is not
> representable within the index as a simple change. Is this the main issue
> for your "against the whole git philosophy"?

No.  I meant an exposure of local branch names by recording them
in the commit object, and nothing else, by that comment.

Instead of using an extra $GIT_DIR/bind file extending what we
record in the index file is OK.  $GIT_INDEX_FILE, $GIT_DIR/HEAD,
and $GIT_DIR/bind pretty much go hand-in-hand anyway and they
_are_ local to the repository, just like branch names are, so I
do not have any problem with using local branch names in these
places, but not in a commit object (or gitlink object for that
matter).
