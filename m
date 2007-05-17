From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Wed, 16 May 2007 17:21:01 -0700
Message-ID: <7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 02:21:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoTkY-0003P0-Jo
	for gcvg-git@gmane.org; Thu, 17 May 2007 02:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760655AbXEQAVG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 20:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761380AbXEQAVF
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 20:21:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:55852 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728AbXEQAVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 20:21:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070517002102.SCIJ6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 16 May 2007 20:21:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 00M11X00T1kojtg0000000; Wed, 16 May 2007 20:21:02 -0400
X-maint-at: 0ab564be6e59c66c7aa4fc44997f3fc62ebcd0d9
X-master-at: d26c4264e584a1a8cbadbc161fa52cf947f5230a
In-Reply-To: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 13 May 2007 15:30:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47471>

It probably would be more interesting to look at the earlier
"What's not in 1.5.2" messages, but here is the current status
of my tree on the 'stable' front.

I'd expect to have 1.5.1.5 from 'maint' perhaps on Saturday, and
1.5.2 from 'master' hopefully on Sunday if everything goes well.

----------------------------------------------------------------
* The 'maint' branch has these fixes since the last announcement.

 Andy Whitcroft (1):
  git name-rev writes beyond the end of malloc() with large generations

 Frank Lichtenheld (3):
  builtin-log.c: Fix typo in comment
  Documentation: format-patch has no --mbox option
  git-am: Clean up the asciidoc documentation

 Jakub Narebski (1):
  gitweb: Add a few comments about %feature hash

 Jeff King (1):
  format-patch: add MIME-Version header when we add content-type.

 Johannes Schindelin (1):
  import-tars: Use the "Link indicator" to identify directories

 Junio C Hamano (2):
  Fix git-clone buglet for remote case.
  Prepare for 1.5.1.5 Release Notes

 Quy Tonthat (1):
  Documentation/branch: fix small typo in -D example

 Steffen Prohaska (1):
  Fixed link in user-manual


* The 'master' branch has these since the last announcement
  in addition to the above.

 Andy Parkins (1):
  Use $Id$ as the ident attribute keyword rather than $ident$ to be consistent with other VCSs

 Frank Lichtenheld (1):
  cvsserver: Don't send mixed messages to clients

 Jakub Narebski (5):
  gitweb: Fix "Use of unitialized value" warnings in empty repository
  Documentation: Split description of pretty formats of commit log
  gitweb: Do not use absolute font sizes
  gitweb: Separate search regexp from search text
  gitweb: Empty patch for merge means trivial merge, not no differences

 Jeff King (1):
  Documentation/git-add: clarify -u with path limiting

 Johan Herland (2):
  Fix signedness on return value from xread()
  Ensure return value from xread() is always stored into an ssize_t
