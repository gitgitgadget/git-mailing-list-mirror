From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Mon, 06 Aug 2007 23:22:32 -0700
Message-ID: <7vtzrb9847.fsf@assigned-by-dhcp.cox.net>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
	<7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
	<7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
	<7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
	<7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
	<7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 07 08:22:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIISk-0003v8-87
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 08:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbXHGGWe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 7 Aug 2007 02:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXHGGWe
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 02:22:34 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64529 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbXHGGWd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Aug 2007 02:22:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070807062233.SNLA14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 7 Aug 2007 02:22:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YuNY1X00W1kojtg0000000; Tue, 07 Aug 2007 02:22:33 -0400
X-maint-at: 93969438dca50c7f0039fcf35e7ab82776d4122f
X-master-at: 5b56aaa29e9d7c0371b6d47bd8a6b12a0c4292dd
In-Reply-To: <7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 28 Jul 2007 01:47:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55221>

* The 'maint' branch has these fixes since the last
  announcement, which are all included in 'master' as well.
  Because 1.5.3 is just around the corner, I think it is
  pointless to do 1.5.2.5 from here, though.

Christian Couder (1):
  rev-list --bisect: fix allocation of "int*" instead of "int".

Junio C Hamano (1):
  setup.c:verify_non_filename(): don't die unnecessarily while
      disambiguating

Linus Torvalds (1):
  apply: remove directory that becomes empty by renaming the last
      file away

* The 'master' branch has these since 1.5.3-rc4.

Adam Roben (1):
  Documentation/git-svn: how to clone a git-svn-created repository

Gerrit Pape (1):
  git-am: initialize variable $resume on startup

J. Bruce Fields (4):
  user-manual: update for new default --track behavior
  user-manual: mention git-gui
  documentation: use the word "index" in the git-add manual page
  documentation: use the word "index" in the git-commit man page

Jakub Narebski (1):
  gitweb: Fix handling of $file_name in feed generation

Johannes Schindelin (1):
  checkout-index needs a working tree

Junio C Hamano (8):
  git-completion: add "git stash"
  INSTALL: add warning on docbook-xsl 1.72 and 1.73
  unpack-trees.c: assume submodules are clean during check-out
  Fix install-doc-quick target
  user-manual: mention git stash
  setup.c:verify_non_filename(): don't die unnecessarily while
      disambiguating
  pager: find out pager setting from configuration
  Fix "make GZ=3D1 quick-install-doc"

Jyotirmoy Bhattacharya (1):
  Fixed git-push manpage

Linus Torvalds (1):
  apply: remove directory that becomes empty by renaming the last
      file away

Randal L. Schwartz (1):
  add "test-absolute-path" to .gitignore

Shawn O. Pearce (1):
  Document GIT_SSH environment variable alongside other variables

Uwe Kleine-K=C3=B6nig (1):
  send-email: teach sanitize_address to do rfc2047 quoting
