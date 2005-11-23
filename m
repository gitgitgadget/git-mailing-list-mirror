From: Junio C Hamano <junkio@cox.net>
Subject: gitweb on kernel.org and UTF-8
Date: Tue, 22 Nov 2005 16:03:11 -0800
Message-ID: <7vzmnw9qo0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 23 01:08:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeiAL-0008Bl-DH
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 01:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVKWAHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 19:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbVKWAHJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 19:07:09 -0500
Received: from fed1rmmtai13.cox.net ([68.230.241.46]:61158 "EHLO
	fed1rmmtai13.cox.net") by vger.kernel.org with ESMTP
	id S1030268AbVKWAHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 19:07:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123000237.DVCR20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 19:02:37 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12590>

Is it possible that the UTF-8 check in gitweb running on
kernel.org machine is somehow too strict?

The following two commits in git.git repository are not showing
properly.

I have a track record of getting peoples' names wrong, so I
double checked my commit objects, and as far as I can tell, all
of them are encoded in UTF-8 properly (or at least I can view
what I expect if I throw raw bytes from the commit objects at my
Firefox):

        c3df8568424684bbcc7df7722eb3ec34bdae8b2d

        This is from Yoshifuji-san; the third character in
        author name field is mangled.

	bb931cf9d73d94d9940b6d0ee56b6c13ad42f1a0

	This is from Lukas Sandstr*m; o with Umlaut on top is
	showing a ?.  Incidentally, the blob that records recent
	version of Documentation/git-pack-redundant.txt has his
	name in it, which has the same ? problem, but "plain"
	option shows his name correctly in UTF-8.

Interestingly enough, my name spelled in Japanese
(Documentatino/git-lost-found.txt) is intact.  Am I getting a
VIP treatment somehow?
