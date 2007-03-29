From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable) and announcing GIT 1.5.1-rc3
Date: Wed, 28 Mar 2007 18:13:16 -0700
Message-ID: <7vk5x0c0nn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 29 03:13:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWjCi-0005b5-As
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 03:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934296AbXC2BNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 21:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934288AbXC2BNS
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 21:13:18 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58167 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934296AbXC2BNR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 21:13:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329011317.GZAF27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 28 Mar 2007 21:13:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gRDG1W0031kojtg0000000; Wed, 28 Mar 2007 21:13:16 -0400
X-maint-at: 9529a2524a29c15107905f2f8f0b310a40880dc7
X-master-at: 7685227e973fce34340d3766b1775263751afa56
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43400>

The 'maint' branch has just produced the 1.5.0.6 maintenance
release.

On the 'master' front, the tip of the 'master' branch has been
tagged as -rc3.  I missed the last few --pretty=format: fixes
from Jeff King, and I suspect there might be a few more breakage
in that area of the code to fix, but there are hopefully no more
major surprises.  Hopefully we can do a real release on April
4th.

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to what's already in 1.5.0.6.

Alexandre Julliard (1):
      git.el: Display some information about the HEAD commit.

Christian Couder (2):
      Bisect: Use "git-show-ref --verify" when reseting.
      Bisect: add checks at the beginning of "git bisect run".

Gerrit Pape (3):
      Makefile: remove test-chmtime program in target clean.
      http-fetch: don't use double-slash as directory separator in URLs
      http-fetch: remove path_len from struct alt_base, it was computed but never used

H. Peter Anvin (1):
      git-upload-pack: make sure we close unused pipe ends

Jakub Narebski (2):
      gitweb: Add example of config file and how to generate projects list to gitweb/INSTALL
      gitweb: Cleanup and uniquify die_error calls

James Bowes (2):
      read-tree: use xcalloc
      use xrealloc in help.c

Jeff King (5):
      git-rm: don't remove newly added file without -f
      --pretty=format: fix broken %ct and %at interpolation
      Add some basic tests of rev-list --pretty=format
      Fix "--pretty=format:" encoding item
      t/t6006: add tests for a slightly more complex commit messages

Jim Meyering (1):
      sha1_file.c (write_sha1_from_fd): Detect close failure.

Junio C Hamano (5):
      Document git-log --first-parent
      sha1_file.c (write_sha1_file): Detect close failure
      Fix "--pretty=format:" for parent related items.
      Update main git.html page to point at 1.5.0.6 documentation
      GIT 1.5.1-rc3

Linus Torvalds (1):
      Fix "getaddrinfo()" buglet
