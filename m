From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: stgit "unknown user details" bug?
Date: Tue, 13 Feb 2007 12:34:48 +0800
Message-ID: <200702130434.l1D4YmrA010122@freya.yggdrasil.com>
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 13 05:48:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGpay-0000oC-2P
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 05:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbXBMEsl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 23:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbXBMEsl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 23:48:41 -0500
Received: from [61.51.204.93] ([61.51.204.93]:54356 "EHLO freya.yggdrasil.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161015AbXBMEsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 23:48:41 -0500
X-Greylist: delayed 929 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Feb 2007 23:48:39 EST
Received: from freya.yggdrasil.com (localhost [127.0.0.1])
	by freya.yggdrasil.com (8.13.8/8.13.8) with ESMTP id l1D4Yq2e010123;
	Tue, 13 Feb 2007 12:35:14 +0800
Received: (from adam@localhost)
	by freya.yggdrasil.com (8.13.8/8.13.8/Submit) id l1D4YmrA010122;
	Tue, 13 Feb 2007 12:34:48 +0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39488>

	First of all, I apologize in advance for cc'ing the busy git
mailing list with problems about stgit.  The stgit web page at
http://www.procode.org/stgit/ says "Please report bugs to Catalin
Marinas and copy the GIT mailing list."  I would feel less guilty
about whose time I was spending on reports like this if there were a
separate stgit-users list.

	Anyhow, here is my bug reporting, which likely is some mistake
on my part.

	I have a git tree with snapshots of linux kernel tar files, no
branches and no local modifications.  By the way, this tree is not a
pull from the kernel.org git repository (although it will likely be
replaced with one in the future).  Rather, this git tree one of a
collection git trees that correspond to tar files released on various
ftp and web repositories (i.e., there is one for gcc, one for
binutils, etc.).

	I also have an stgit tree of the kernel.  This one has the
local modifications in stgit.  I just upgraded from stgit 0.11 to
0.12, upgraded the git kernel tree from 2.6.20 to 2.6.20-git7, and
tried to pull from the updated git tree to the stgit tree, using the
new stgit 0.12.  stgit refused to apply the first local patch,
complaining "stg pull: unknown user details."

	I did the "stg pull" as root, did not set any of the
GIT_AUTHOR_* environment variables and did not create any kind of git
or stg configuration file.  No doubt I could work around this by
setting up some kind of configuration file, but I should not be
required to do so, especially just to do a "pull".

	I don't mind that a version control system might log user ID
and email addresses somewhere, but it should still work if I do not
wish to provide that information.

Adam Richter
