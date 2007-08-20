From: linux@horizon.com
Subject: How to do a reverse rebase?
Date: 20 Aug 2007 01:32:37 -0400
Message-ID: <20070820053237.9349.qmail@science.horizon.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 07:40:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN00C-0008N6-Iy
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 07:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbXHTFkA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 01:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbXHTFkA
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 01:40:00 -0400
Received: from science.horizon.com ([192.35.100.1]:14452 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750877AbXHTFj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 01:39:59 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Aug 2007 01:39:59 EDT
Received: (qmail 9350 invoked by uid 1000); 20 Aug 2007 01:32:37 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56170>

Okay, this is picayune whining, but when you've fixed all the big
bugs...

I don't want to rebase HEAD on *that*, but rather rebase *that*
on top of the current HEAD.

Sometimes I have a little debug hack on a branch by itself, and I
discover that I need it again, so I want to rebase it on top of
current development.

But there's been a LOT of development in the meantime.  And if I do

git-rebase HEAD debug_hack

git first checks out debug_hack.  This takes a while and, more
importantly, every file modified in HEAD...debug_hack has its timestamp
touched and make(1) insists on recompiling it.

I want to only modify the three files that are touched on the debug_hack
branch, so my recompile times aren't too long.

Currently, when I remember, I'll use git-cherry-pick and manually
rename branches.

Is there an easier way?  Or should I just learn StGit?
