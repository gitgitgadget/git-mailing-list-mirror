From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] Public Gitweb Hosting Service
Date: Wed, 20 Sep 2006 02:48:28 +0200
Message-ID: <20060920004828.GI8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Sep 20 02:49:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPqGP-0004T7-U0
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 02:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbWITAsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 20:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWITAsb
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 20:48:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10218 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750768AbWITAsa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 20:48:30 -0400
Received: (qmail 5012 invoked by uid 2001); 20 Sep 2006 02:48:28 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27321>

  Hi,

  there are various tiny repositories scatterred over the web that are
on crappy broken webhostings, don't have lifetime long enough and most
importantly have no gitweb interface for peeking inside - even e.g.
the StGIT repository suffers from that.

  To fix that problem, I've decided to quickly set up a public gitweb
hosting service. The deal is basically that you tell the system your
repository URL (designed only for reasonably small repositories; if you
have big repository, you ought to have the resources to host it) and it
will mirror the repository and provide gitweb interface for it, as well
as publish the mirror for cloning.

  It's running at

	http://repo.or.cz/

with latest Git and Gitweb from #next and few custom patches (I've
posted the interesting ones), all features enabled. If I get some
time, I will hopefully further improve the Gitweb interface (blame is
almost unusable, pickaxe is top secret functionality, etc.) and I will
generally try to track #next gitweb version closely (at least for the
start).

  This is still very experimental - I will watch how much interest, load
and traffic it generates; if it becomes unbearable, I will disable the
public mirror service and keep just the gitweb interface. Also, the web
interface is rather crude and you can currently use it only to register
new projects - if you want to make any adjustments to them, please drop
me a mail. Also please do if you have some cool ideas, or want to do a
nice design for the registration web interface. ;-)


  Note that there is also a glibc CVS import available at that address,
entirely coincidentally. That one is an exception and is not synced from
any other Git repository. It took git-cvsimport two days to chew through
on a decent machine (but over the network), the resulting size of 107M
is pretty nice. I hope to set it up to automatically track glibc CVS
further (and possibly other popular non-Git projects later).  There's
insane amount of tags which means the gitweb summary page takes "a bit"
long to load, I wonder if using packed refs would improve that.

  Have fun,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
