From: Junio C Hamano <gitster@pobox.com>
Subject: Recent issues
Date: Sat, 07 Jul 2007 00:31:50 -0700
Message-ID: <7v7ipcbrfd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com, pasky@suse.cz, ltuikov@yahoo.com,
	paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 09:32:00 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I74lp-0001Qs-PO
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 09:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbXGGHbx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 03:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753657AbXGGHbx
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 03:31:53 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60632 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753513AbXGGHbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 03:31:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070707073151.ERRJ22777.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Jul 2007 03:31:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LXXq1X00g1kojtg0000000; Sat, 07 Jul 2007 03:31:51 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51806>

Here is a list of recent issues on the list that I am aware of,
but not much have been done on.

To use the Message-ID, you can use:

    http://mid.gmane.org/$message_id

where $message_id is the Message-ID without surrounding <>.

* gitweb patches (bunch of them)

  From: Matt McCutchen <hashproduct@gmail.com>
  Subject: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
  Message-ID: <1183053733.6108.0.camel@mattlaptop2>

  From: Matt McCutchen <hashproduct@gmail.com>
  Subject: [PATCH] gitweb: make search form generate pathinfo-style URLs
  Message-ID: <1183057027.6108.4.camel@mattlaptop2>

  From: Matt McCutchen <hashproduct@gmail.com>
  Subject: [PATCH] gitweb: make "No commits" in project list gray, not bold green
  Message-ID: <1183068922.6108.8.camel@mattlaptop2>

  From: Miklos Vajna <vmiklos@frugalware.org>
  Subject: [PATCH] gitweb: prefer git_get_project_owner() over get_file_owner()
  Message-ID: <20070703221122.GI32766@genesis.frugalware.org>

  From: Michael Hendricks <michael@ndrix.org>
  Subject: [PATCH] gitweb: configurable width for the projects list Description column
  Message-ID: <11835958082458-git-send-email-michael@ndrix.org>

Haven't heard any from gitweb folks about these; I'd take a look
at them if I find time this weekend.

* gitk --left-right

  From: Linus Torvalds <torvalds@linux-foundation.org>
  Message-ID: <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
  From: Junio C Hamano <junkio@cox.net>
  Message-ID: <7vabwifl23.fsf@assigned-by-dhcp.cox.net>

Paulus?

* gitk tree view fix

  From: Brian Downing <bdowning@lavos.net>
  Subject: [PATCH] gitk: Fix for tree view ending in nested directories
  Message-ID: <20070704212643.GR4087@lavos.net>

Paulus?

* switching branches when b changes between symlink and directory in a/b/c

  From: Pierre Habouzit <madcoder@debian.org>
  Subject: [BUG (or misfeature?)] git checkout and symlinks
  Message-ID: <20070704203541.GA13286@artemis.corp>

Will take a look.

* cherry-pick unexpected conflicts

  From: Gerrit Pape <pape@smarden.org>
  Subject: Re: unexpected git-cherry-pick conflict
  Message-ID: <20070613134336.13661.qmail@c61f4fed932273.315fe32.mid.smarden.org>

* git-apply -R --whitespace=warn

  From: Daniel Barkalow <barkalow@iabervon.org>
  Message-ID: <Pine.LNX.4.64.0707062155170.6977@iabervon.org>
  Subject: Minor bug in git-apply's patch-cleaning

* Use gitattributes for more things.

 - Customized "diff -p" markers per path.

  From: Linus Torvalds <torvalds@linux-foundation.org>
  Subject: Re: [PATCH] Per-path attribute based hunk header selection.
  Message-ID: <alpine.LFD.0.98.0707061051020.9434@woody.linux-foundation.org>

Will take a look and try to finish this before 1.5.3-rc1.
