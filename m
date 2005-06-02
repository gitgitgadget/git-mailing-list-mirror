From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] cogito-0.11
Date: Fri, 3 Jun 2005 00:23:29 +0200
Message-ID: <20050602222329.GJ32189@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jun 03 00:22:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddy3R-00034A-5t
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 00:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVFBWXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 18:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVFBWXm
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 18:23:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3545 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261332AbVFBWXb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 18:23:31 -0400
Received: (qmail 26905 invoked by uid 2001); 2 Jun 2005 22:23:29 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  Hello,

  so I'm happy to finally announce cogito-0.11, a SCMish interface to
Linus' git storage system. (It's actually 0.11.1 because I forgot to do
some stuff before the release.) Get it at

	kernel.org/pub/software/scm/cogito/

or just pull it if you have your Cogito tree Cogito-tracked.

  There's probably too many things which have changed since cg-0.10.
There were plenty of bugfixes, the diff format changed, the git side of
stuff made a giant leap forward, etc. It's just better. :-) (Hopefully.)

  Note that I tried to take all the seemingly-important bugfixes I've
noticed, but my feature patches queue is just huge so if your patch is
not inside (it probably isn't unless I notified you over email), don't
panic. If you think it's an important bugfix which should go in now,
please resend it. And if it's a feature patch but older than a week or
two, resend it too. I will try to process my queue as fast as I will be
able to.

  This release wasn't extensively tested and there were some last-minute
changes. So handle it with a little bit of care and expect cogito-0.11.2
possibly following soon with some more bugfixes (if there are any
problems found).

  Another thing to note if you are pulling - there are might be some
obsolete or (in case of the git-pb tree) completely nonsensical tags
in your tree, and they will slow down cg-pull/cg-update a lot now - it
will complain about them and if they don't get fetched ("different
tree" message is provided instead of "retrieved"), just rm the tags for
good.

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
