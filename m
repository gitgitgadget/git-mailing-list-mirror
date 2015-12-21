From: Alan Mackenzie <acm@muc.de>
Subject: "git stash pop" is doing an unwanted "git add" when there are
	conflicts.
Date: Mon, 21 Dec 2015 14:29:54 +0000
Message-ID: <20151221142953.GA12764@acm.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 15:34:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB1Xf-0001C1-0H
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 15:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbbLUOeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 09:34:23 -0500
Received: from mail.muc.de ([193.149.48.3]:21114 "EHLO mail.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbbLUOeW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 09:34:22 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Dec 2015 09:34:21 EST
Received: (qmail 3492 invoked by uid 3782); 21 Dec 2015 14:27:39 -0000
Received: from acm.muc.de (p548A50F8.dip0.t-ipconnect.de [84.138.80.248]) by
	colin.muc.de (tmda-ofmipd) with ESMTP;
	Mon, 21 Dec 2015 15:27:38 +0100
Received: (qmail 12827 invoked by uid 1000); 21 Dec 2015 14:29:54 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
X-Primary-Address: acm@muc.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282794>

Hello, git project.

Last night, whilst clearing out a stale "stash stack", I did "git stash
pop".  There were conflicts in two files.

However, all the popped files became staged.  This doesn't normally happen.
It was intensely irritating, and required me to do "git reset HEAD" on
each of the files, none of which I wanted to commit.

I searched the git-stash man page for this scenario, but found nothing
about it.

Surely staging all the files is a bug?

-- 
Alan Mackenzie (Nuremberg, Germany).
