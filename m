From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: A note from the interim Git maintainer
Date: Tue, 16 Oct 2007 01:54:48 -0400
Message-ID: <20071016055448.GA13801@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 07:55:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhfOT-0007fd-0e
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 07:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760226AbXJPFyy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 01:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759937AbXJPFyy
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 01:54:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59038 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758775AbXJPFyx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 01:54:53 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhfOE-0000fg-7P; Tue, 16 Oct 2007 01:54:50 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 57E4720FBAE; Tue, 16 Oct 2007 01:54:49 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61079>

As most folks are probably now well aware, Junio has been offline
for about 11 days and may still be offline for a little while more.
Before he dropped offline Junio shared why he left on such a short
notice with both Dscho and myself, as it meant cancelling the
"git together" we were planning to have last weekend in San Jose.

I'm not going to get into the specific details as it is Junio's
business and not mine.  But I can say that my thoughts and prayers
to $DEITY are with him and his family at this time, and I don't
expect him to be rushing back to git work tomorrow.  However I'm
quite certain that Junio will return when he can.


Lars Hjemli has done a terrific job of stacking up patches from the
mailing list in his "q/*" branches, available for fetching directly
from his tree at [*1*].  I really want to thank Lars for stepping
up and doing this, as I think it has helped the community.

Unfortunately there were quite a few q/* branches, some of which
were not trivial to merge against the other topics that were already
pending in Junio's next.  Someone really needed to go through the
branches and merge them together into suitable maint, master and
next branches.


I've decided to step up and try to fill Junio's shoes.  To that end
I am publishing a maint, master, next (and soon) pu branch from a
new fork on repo.or.cz:

  gitweb:  http://repo.or.cz/w/git/spearce.git
  git:     git://repo.or.cz/git/spearce.git
           http://repo.or.cz/r/git/spearce.git

Traditional "What's in" messages will be sent in a minute.  I'm
going to try to apply the exact same policies that Junio applies
to these, so maint/master/next won't rewind, but pu may.

I based my branches on top of the last items published by Junio,
and am hoping that he will be open to pulling directly from these
before he starts working again.  Junio obviously has the option
not to pull from me, but if I do my job of interim maintainer well
I can probably talk him into it.  :)

I won't be publishing a tagged release from maint or master anytime
soon.  Primarily because I don't think its time to do that, and also
because I don't have a kernel.org account to upload the tarballs to.
If a month goes by without Junio, well, lets just see what happens.


I probably don't need to say this for the git regulars, but you
can start to track my published branches yourself with git-remote
if you are interested in testing and/or using these versions:

  $ git remote add -f spearce git://repo.or.cz/git/spearce.git
  $ git pull spearce master  ; # or next



*1* git://hjemli.net/pub/git/git

-- 
Shawn.
