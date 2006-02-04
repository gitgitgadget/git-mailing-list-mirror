From: Michael Fischer <michael@visv.net>
Subject: 2 questions/nits about commit and config
Date: Sat, 4 Feb 2006 16:23:37 -0500
Message-ID: <20060204212337.GA8612@blinkenlights.visv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Feb 04 22:23:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5Usm-0003W2-RZ
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 22:23:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbWBDVXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 16:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWBDVXl
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 16:23:41 -0500
Received: from www.visv.net ([64.81.194.132]:24987 "EHLO visv.net")
	by vger.kernel.org with ESMTP id S932574AbWBDVXk (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 16:23:40 -0500
Received: by visv.net (Postfix, from userid 1000)
	id 19AAC645B4; Sat,  4 Feb 2006 16:23:38 -0500 (EST)
To: git@vger.kernel.org
Mail-Followup-To: Michael Fischer <michael@visv.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15602>


Hi.

Well, I went ahead and put my current project under git. So far so good.

Two nits: (yeah, I'm a "recovering" CVS user)

1) git commit -m"this is a commit message"  doesn't work. 
   It has to have a space between -m and the first '"'. 
   I *think* this is due to git-commit.sh and how it parses
   the args, but I'm not quite sure of how to try to patch
   that without mucking up the whole works. Very odd
   and hard to figure out what was "wrong" for a CVS user.

2) I can descend into subdirectories in my project, and 
   git diff, git status both work fine, but git commit
   gets annoyed and says "fatal: Not a git repository: '.git'".
   Irksome to say the least, and not a little suprising.
   Is that something which can be fixed, or is there a 
   magic incantation (perhaps in .git/config) to make
   git commit work anywhere in the source tree?

Incidentally, I groped around my git mailbox, and google,
looking for some definitive list/examples of what can
go in the .git/config file. Seems there must be more
than what is listed in the manpage...

Thanks for all the cool work.


Michael
-- 
Michael Fischer                         Happiness is a config option.
michael@visv.net                        Recompile and be happy. 
