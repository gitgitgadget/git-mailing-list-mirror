From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Cogito-0.15
Date: Mon, 19 Sep 2005 03:14:28 +0200
Message-ID: <20050919011428.GF22391@pasky.or.cz>
References: <7vr7c02zgg.fsf@assigned-by-dhcp.cox.net> <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 03:15:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHAEz-0003C4-Hu
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 03:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVISBOb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 21:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVISBOb
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 21:14:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29844 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932284AbVISBOa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 21:14:30 -0400
Received: (qmail 30204 invoked by uid 2001); 19 Sep 2005 03:14:28 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtleyml5.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8825>

  Hello,

  this is the release of Cogito-0.15. It fixes several minor bugs, and
adds a feature or two. The most important thing though is that this
depends on Git-core-0.99.7 and uses the new command names. Everyone is
encouraged to upgrade at least to this Cogito version in the next few
days, since the older Cogito versions likely won't work with the future
Git-core releases.

  To stay in sync with the Git terminology, Cogito also renames its
cg-pull to cg-fetch. Since this is a major naming change (I'm not too
happy about it, personally), cg-pull will stay aliased to cg-fetch for
at least one (likely two) next major Cogito releases (it also produces a
warning when invoked as cg-pull). In the more distant future, cg-pull
will slowly become the new name of cg-update, to make it confusing.

  While at it, we also renamed the *-id scriptlets to cg-*-id. Other
notable stuff is cg-init respecting the ignore rules, and better UI for
cg-add wrt. directories (including cg-add -r support).

  Now let's see what the usual bug-right-after-release (major release,
so a major bug?) will be this time.

  Happy hacking,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
