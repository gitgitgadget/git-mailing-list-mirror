From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Tracking few files among many
Date: Sun, 30 Oct 2005 14:00:02 +0100
Message-ID: <20051030130001.GA26652@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 30 14:19:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWD4E-0007Fr-3h
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 14:17:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVJ3NQc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Oct 2005 08:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVJ3NQc
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Oct 2005 08:16:32 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:8609 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1751258AbVJ3NQb
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Oct 2005 08:16:31 -0500
Received: (qmail 26859 invoked by uid 5842); 30 Oct 2005 13:00:02 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10818>

Hello,

There's something I can't figure out.  I'm tracking a few
configuration files in $HOME, but some operations are really
slow.  Let's take git-status as example: 

~ > git-status >laaangsom.txt
~ > wc -l laaangsom.txt
25875 laaangsom.txt
~ > cat laaangsom.txt
#
# Changed but not updated:
#   (use git-update-index to mark for commit)
#
#       modified: .gaim/blist.xml
#       modified: .gaim/prefs.xml
#       modified: .mozilla/firefox/s4q22693.default/prefs.js
#
#
# Untracked files:
#   (use "git add" to add to commit)
#
#   [ A lot of untracked files. See the line count above. ]

What is going on?  This really doesn't seem like the wanted
behavior.  Have I missed something?  I'm using
46774a81f9d6ca4d230d33757afe9dd07bfe398b  (GIT 0.99.9).

Regards,

Peter
