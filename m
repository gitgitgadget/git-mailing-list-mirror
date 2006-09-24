From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.18rc2
Date: Mon, 25 Sep 2006 00:46:42 +0200
Message-ID: <20060924224642.GD20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 00:47:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRckK-0003fQ-C5
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 00:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWIXWqp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 18:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWIXWqp
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 18:46:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7638 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932089AbWIXWqo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 18:46:44 -0400
Received: (qmail 1841 invoked by uid 2001); 25 Sep 2006 00:46:42 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27709>

  Hello,

  I've just released cogito-0.18rc2 for your fun'n'profit, it should
appear at kernel.org shortly.

  This is mostly random bugfixing of 0.18rc1 (check out its announcement if
you don't know about the cool new features yet), with few minor new
features.  I originally wanted to have cg-clone -a support in 0.18 but it
has so many goodies that I will release it ASAP and hopefully 0.19 will not
take so long anymore (summer is over). If no big bugs show up until Wednesday
or so, I will release 0.18 so that this finally gets its way to wider audience.

  It contains all the bugfixes from 0.17.4, some more master-specific
bugfixes (if you are using 0.18rc1, upgrade), and most notably:

  * INCOMPATIBLE: cg-log now by default hides merges, -M behaviour is
    reversed
  * All kinds of very stale command aliases that were deprecated for eons
    were removed
  * .git/author is deprecated (use .git/config to set it up)
  * We now officially depend on 1.4.2 (we use git-*-fetch --stdin which makes
    fetching tags _MUCH_ faster)

  * cg-clone -l now sets up an alternate instead of symlinking the object db
  * Support for cg-clone --reference
  * cg-admin-setuprepo supports setting up repositories over SSH
  * Support fetching over FTP

  * Start of some work on making Cogito compatible with POSIX sh (didn't
    get much far for now) and depends less on Perl for now (didn't get
    much far either ;)
  * Start of an effort to document Cogito hooks


  P.S.: See us at #git @ FreeNode.

  P.P.S.: And _please_, if you like/dislike it, send me some feedback. Lately
I'm wondering if anyone still actually uses Cogito at all or if all the gang's
already moved to core Git and I should better quit, get used to Git's interface
and do something useful for a change.

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
