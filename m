From: Petr Baudis <pasky@suse.cz>
Subject: rsync access method deprecated in latest Cogito
Date: Sun, 3 Jul 2005 13:17:17 +0200
Message-ID: <20050703111717.GA22672@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 03 13:17:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp2Tf-0004NL-PT
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 13:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVGCLRZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 07:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVGCLRZ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 07:17:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12693 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261308AbVGCLRT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 07:17:19 -0400
Received: (qmail 23865 invoked by uid 2001); 3 Jul 2005 11:17:17 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hi,

  just a heads-up, I deprecated the rsync access method in the latest
Cogito. For all kernel.org trees, just using HTTP instead should do,
and most of the other GIT repository URLs I noticed use HTTP as well.
rsync is evil and with packs likely doubly so for general GIT access.

  I will probably remove rsync access support altogether after another
one or two Cogito releases to give this some transition time; in the
meantime, cg-pull (cg-update, subsequently) will shout a warning.

  The only big advantage of rsync is that it is probably (I didn't
measure it, but it feels so) faster especially for smaller repositories,
larger updates and higher latency links. Hopefully we (I hope Daniel
gets to it, but I will do it in foreseeable future if he doesn't)
improve this too.

  Does anyone have anything on mind what rsync can do and the git-*-pull
tools can't (or can but a lot worse)?

  Have a nice localtime.timeofday,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
