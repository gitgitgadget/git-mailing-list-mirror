From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: git-gui 0.7.3
Date: Mon, 11 Jun 2007 02:26:21 -0400
Message-ID: <20070611062621.GE6073@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 08:26:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxdMJ-0002xt-8A
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 08:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbXFKG00 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 02:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbXFKG00
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 02:26:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57236 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbXFKG0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 02:26:25 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1HxdM6-0006PK-4T; Mon, 11 Jun 2007 02:26:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7F50620FBAE; Mon, 11 Jun 2007 02:26:21 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49822>

Linus recently pointed out that the blame viewer in git-gui 0.7.2
is useless, and the one parked seemingly indefinately in my pu
branch was much better, and couldn't do any worse than 0.7.2's.  

So here's git-gui 0.7.3, available in my maint branch:

  git://repo.or.cz/git-gui.git maint

for merging into the next public Git release.


Features since 0.7.2:

* New selection indication and softer colors.  This change is
  due to the efforts of Matthijs Melchior, and makes the main
  interface window slightly more pleasing to read.

* Vastly improved internal blame viewer.  The new viewer was
  incrementally improved, but in the end it amounted to a total
  rewrite by the time we reached the 0.7.3 release.

* Blame viewer now shows two blame passes side-by-side on the
  same file, giving the user fast access to original author and
  relocation author, for any line of the file.

* Mouse tooltips appear in the blame viewer when you mouse over
  a line of interest.

* Hyperlinks to original location are offered for both the original
  commit and the relocation commit in the blame viewer.

Bug fixes since 0.7.2:

* Allow creating a branch when none exists.  Previously we crashed
  if the repository had no local branches, but had a valid HEAD.

* Better handle internal Tk destroy messages sent to widgets;
  we used to terminate the entire git-gui process when any widget
  was destroyed.

* Minor font corrections, where git-gui was not honoring the user's
  configured preferences.

-- 
Shawn.
