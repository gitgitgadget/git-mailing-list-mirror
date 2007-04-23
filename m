From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Mon, 23 Apr 2007 00:04:03 -0700
Message-ID: <7v7is3inbw.fsf@assigned-by-dhcp.cox.net>
References: <7vfy71yupd.fsf@assigned-by-dhcp.cox.net>
	<7virbtck12.fsf@assigned-by-dhcp.cox.net>
	<7vlkglq664.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 23 09:04:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfsb5-0003o8-3h
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 09:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753413AbXDWHEG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 03:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbXDWHEG
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 03:04:06 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:57668 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbXDWHEE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 03:04:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423070404.VTNC1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 23 Apr 2007 03:04:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qX431W0081kojtg0000000; Mon, 23 Apr 2007 03:04:03 -0400
X-maint-at: 97317061c6799765c7f2f83d8e3f4f74df469793
X-master-at: 4280cde95fa4e3fb012eb6d0c239a7777baaf60c
In-Reply-To: <7vlkglq664.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 21 Apr 2007 23:22:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45300>

Together with fixes to pack-objects mode bits gotcha that caused
quite a traffic on the list this morning, and crlf conversion
bug from Alex, I've fast-tracked a few topics to 'master' tonight:

 - Nico's progress meter clean-up.
 - My custom diff driver in gitattributes series.

By "fast-track", I mean there might still be bugs in the code
but there do not seem to be anything contentious in the design,
and I trust the people who can fix possible breakages are
responsive.  I think "ident" attribute to expand "$ident$" in
blobs is probably less controversial as it is a stateless
transformation, but I left it out for now.

The tip of 'master' tonight is v1.5.2-rc0.  I am reasonably sure
that I have missed a few topics that we saw/reviewed patches for
the past several days.  Please do not get discouraged as I have
not necessarily rejected them; I was just busy whipping v1.5.1.2
and the 'master' branch into shape tonight.  Please discuss the
patches that are missing from tonight's 'master' for possible
inclusion in the coming few days, and then let's declare feature
freeze by the end of the week with v1.5.2-rc1.  After that, the
usual rules for stabilization period applies (no new features,
only fixes including documentation updates).

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.

 Alex Riesen (2):
  Fix a typo in crlf conversion code
  Fix crash in t0020 (crlf conversion)

 Junio C Hamano (8):
  Update documentation links to point at v1.5.1.2
  Documentation/Makefile: fix section (5) installation
  Update draft release notes for v1.5.2
  pack-objects: quickfix for permission modes.
  Fix 'quickfix' on pack-objects.
  Update tests not to assume that generated packfiles are writable.
  pack-objects: make generated packfile read-only
  Support 'diff=pgm' attribute

 Martin Koegler (1):
  gitweb: Show "no difference" message for empty diff

 Nicolas Pitre (4):
  common progress display support
  make progress "title" part of the common progress interface
  provide a facility for "delayed" progress reporting
  delay progress display when checking out files

 Shawn O. Pearce (1):
  Cleanup variables in cat-file
