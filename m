From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.16.3
Date: Mon, 16 Jan 2006 02:51:41 +0100
Message-ID: <20060116015141.GG28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932157AbWAPBuo@vger.kernel.org Mon Jan 16 02:51:07 2006
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932157AbWAPBuo@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyJWP-0005qK-0w
	for glk-linux-kernel-3@gmane.org; Mon, 16 Jan 2006 02:51:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWAPBuo (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 15 Jan 2006 20:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWAPBuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 20:50:44 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32686 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932157AbWAPBuo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 20:50:44 -0500
Received: (qmail 5724 invoked by uid 2001); 16 Jan 2006 02:51:41 +0100
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14719>

  Hello,

  this is Cogito version 0.16.3, the next stable release of the
human-friendly version control UI for the Linus' GIT tool. Share
and enjoy at:

	http://www.kernel.org/pub/software/scm/cogito/

  All the fixes are of minor to normal severity. Pretty boring, and
that's what I love on the release the most - it seems that we are in a
quite stable state now. However, I am probably going to disrupt that
state with the v0.17 release, hopefully very soon - I got so used to it
that I wouldn't realize all the v0.16 users were deprived of the goodies
like cg-switch.

Michael Richardson:
      Mark that gawk (not mawk) is required for cg-diff -c
      Only show the fetch progress bar on terminals

Paolo 'Blaisorblade' Giarrusso:
      Fix unconditional early exit of cg-fetch over rsync, v2

Petr Baudis:
      Fix cg-push not always defaulting to 'master' remotely
      Make it possible to push out new branches
      Fix cg-clone -l of specific branch
      Make cg-fetch return false if fetch_tags fails.
      cogito-0.16.3

  Happy hacking,

-- 
				Petr "Pasky the Broken Hand" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
