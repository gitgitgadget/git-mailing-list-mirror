From: Petr Baudis <pasky@ucw.cz>
Subject: Recent git pull troubles
Date: Sun, 17 Apr 2005 00:55:24 +0200
Message-ID: <20050416225524.GM19099@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 17 00:52:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMw8n-0001Iy-7M
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVDPWzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVDPWzc
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:55:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40582 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261179AbVDPWz0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 18:55:26 -0400
Received: (qmail 10993 invoked by uid 2001); 16 Apr 2005 22:55:24 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  just thought that I should drop a line here about it. I recently
changed the .git/HEAD to be a symlink, and old git pull could not cope
with that. So you would get a small error and no updates.

  So far I fixed it by just making it a hardlink in my tree for now;
don't do that at home though, since git update will happily trash your
branch information in that case.

  BTW, tomorrow will by my bugfix merging day (I will have a look
especially on Ingo Molnar's fixes), I will fix the bugs in git pull and
git update I mentioned in my night mail, and finally expand the docs;
sorry for the lack of activity on my side today. Then I will release 0.5
(getting 0.4 and doing git pull is not very smooth now), and after that
I will rewrite git merge to use Linus' merging stuff - can't wait to do
that. :-)

  I'd still like you to constructively complain about my current branch
model. ;-)

  Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
