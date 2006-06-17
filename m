From: Junio C Hamano <junkio@cox.net>
Subject: Post 1.4.0 merge status
Date: Sat, 17 Jun 2006 14:38:59 -0700
Message-ID: <7virmz798s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jun 17 23:39:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FriVV-0001hc-CX
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 23:39:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbWFQVjB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 17:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWFQVjB
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 17:39:01 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:47055 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750947AbWFQVjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 17:39:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060617213900.MOMQ23482.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Jun 2006 17:39:00 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22034>

I thank everybody who submitted patches while I was away.  

I'm trying to catch up with you and have merged the following so
far to "master".  Will push them out shortly after I review them
for the last time, hopefully sometime today:

 - pulled git-svn updates from Eric Wong (I first applied the
   patches from the list to a test branch, and compared it with
   the result of the pull onto the master -- they match, so I
   decided to take the pull result).

 - pulled gitk from Paul to fix "Re-read references".

 - git whatchanged to show full-history from Linus.

 - Portability of t4101 test for diff implementations that do
   not do "\No newline..." from Dennis Stosberg.

 - mailinfo fix from Eric W Biederman not to confuse "From: "
   lines in the middle of log message as an in-body header.

 - gitweb 'blame' that can be switched on/off from Florian
   Foster.

 - gitweb README update from Jakub.

 - git-blame updates to add -time from Fredrik.

 - three patches to cvsimport from Martin.

 - strlcpy from Peter Eriksen.

 - a p4import update from Sean.

 - cvsexportcommit typofix  from Sven Verdoolaege.


I'll be looking at these after the above;

 - 2 patches to diff (color and -b/w) from Johannes.

 - avoiding "make prefix=A ; make prefix=B install" confusion
   from Yakov.

I've queued the following to look at in the next round;

 - format-patch -s fix from Eric W Biederman;

 - 7+1 patches to make am and commands required for it built-in
   from Lukas.

 - raw-blob output from gitweb by Jakub.

 - big "SHA1"->"SHA-1" and other documentation updates from
   Horst; I was hoping to merge this while flying over Pacific,
   but I seemed to have duplicates and was too tired and fell
   asleep.
