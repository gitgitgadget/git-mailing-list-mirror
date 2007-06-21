From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Thu, 21 Jun 2007 00:21:33 -0700
Message-ID: <7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
	<7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 09:21:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Gz2-0007oJ-RW
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 09:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756272AbXFUHVf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Jun 2007 03:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756244AbXFUHVf
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 03:21:35 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:57909 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbXFUHVf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2007 03:21:35 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621072135.UBXT1594.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Jun 2007 03:21:35 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id E7Ma1X0041kojtg0000000; Thu, 21 Jun 2007 03:21:34 -0400
X-maint-at: c7c84859ad586ae5670224e1abc4f846f7c3a9ae
X-master-at: 45fd8bd32dd68ce6b14a406d0abbd6f56490131c
In-Reply-To: <7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com> (Junio C. Hamano's
	message of "Wed, 13 Jun 2007 13:11:10 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50605>

* The 'maint' branch has these fixes since the last announcement.

 Alex Riesen (1):
  Add a local implementation of hstrerror for the system which do not h=
ave it

 Jakub Narebski (1):
  Generated spec file to be ignored is named git.spec and not git-core.=
spec

 Johannes Schindelin (2):
  Move buffer_is_binary() to xdiff-interface.h
  merge-recursive: refuse to merge binary files

 Junio C Hamano (5):
  $EMAIL is a last resort fallback, as it's system-wide.
  git-branch --track: fix tracking branch computation.
  Avoid diff cost on "git log -z"
  Documentation: adjust to AsciiDoc 8
  GIT 1.5.2.2


* The 'master' branch has these since the last announcement
  in addition to the above.

 Alex Riesen (2):
  Do not use h_errno after connect(2): the function does not set it
  cvsserver: Actually implement --export-all

 Daniel Barkalow (1):
  Fix pushing to a pattern with no dst

 Frank Lichtenheld (3):
  cvsserver: Add some useful commandline options
  cvsserver: Let --base-path and pserver get along just fine
  cvsserver: Actually implement --export-all

 Gerrit Pape (1):
  git-branch: cleanup config file when deleting branches

 Ismail D=C3=B6nmez (1):
  Change default man page path to /usr/share/man

 Jakub Narebski (8):
  Document git rev-list --full-history
  Document git read-tree --trivial
  Document git rev-parse --is-inside-git-dir
  Document git reflog --stale-fix
  Document git rev-list --timestamp
  Use tabs for indenting definition list for options in git-log.txt
  Document git log --abbrev-commit, as a kind of pretty option
  Document git log --full-diff

 Junio C Hamano (8):
  remote.c: refactor match_explicit_refs()
  remote.c: refactor creation of new dst ref
  remote.c: minor clean-up of match_explicit()
  remote.c: fix "git push" weak match disambiguation
  remote.c: "git-push frotz" should update what matches at the source.
  git-push: Update description of refspecs and add examples
  Documentation: update "stale" links for 1.5.2.2
  INSTALL: explain how to build documentation

 Lars Hjemli (6):
  t7400: barf if git-submodule removes or replaces a file
  git-submodule: remember to checkout after clone
  Rename sections from "module" to "submodule" in .gitmodules
  git-submodule: give submodules proper names
  Add gitmodules(5)
  gitmodules(5): remove leading period from synopsis

 Sam Vilain (1):
  git-svn: avoid string eval for defining functions
