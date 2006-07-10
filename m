From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix some doubled word typos
Date: Sun, 09 Jul 2006 17:50:38 -0700
Message-ID: <7vodvye10h.fsf@assigned-by-dhcp.cox.net>
References: <11524377844177-git-send-email-alp@atoker.com>
	<44B1A01F.5090408@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 02:50:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzjzA-0003Ov-Vv
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 02:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbWGJAuk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 20:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWGJAuk
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 20:50:40 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:10944 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964880AbWGJAuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 20:50:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710005039.GYUG985.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Jul 2006 20:50:39 -0400
To: Alp Toker <alp@atoker.com>
In-Reply-To: <44B1A01F.5090408@atoker.com> (Alp Toker's message of "Mon, 10
	Jul 2006 01:32:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23580>

Alp Toker <alp@atoker.com> writes:

> My patch was made against the 'next' branch, where the file had
> recently been moved to Documentation/git-svn.txt, but it was applied
> to the 'master' branch where the file still exists at
> contrib/git-svn/git-svn.txt as it has not yet been moved.

Actually, I am a bit more careful than that ;-).

I have split your patch into two, and applied the part that
applicable to "master" first.  The tip of ew/svn topic branch (I
do not publish topic branch tips) have two patches that are
still not in even "pu", and one of these two patches is your
Documentation/git-svn.txt patch.  These two will appear in
"next" hopefully soon -- I just haven't gotten around to them.
