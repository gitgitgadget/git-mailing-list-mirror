From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sat, 02 Jun 2007 14:09:46 -0700
Message-ID: <7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 02 23:10:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuarJ-0006CK-10
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 23:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671AbXFBVJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 2 Jun 2007 17:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756924AbXFBVJz
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 17:09:55 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:61683 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756671AbXFBVJy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2007 17:09:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070602210953.CXUQ22318.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 2 Jun 2007 17:09:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6l9n1X0041kojtg0000000; Sat, 02 Jun 2007 17:09:52 -0400
X-maint-at: 996e2d6ea2626f55a59e70ac7305a02ce0171814
X-master-at: 4bc708347e2b94564d9ec5e0e3a2ab0e3d6b2fd9
In-Reply-To: <7vejl0546b.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 29 May 2007 03:12:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48954>

I will do a v1.5.2.1 with 'maint' and push it out this weekend.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

 Frank Lichtenheld (2):
  git-config: Various small fixes to asciidoc documentation
  git-config: Improve documentation of git-config file handling

 Jeff King (1):
  Documentation: robustify asciidoc GIT_VERSION replacement

 Jerald Fitzjerald (1):
  decode_85(): fix missing return.

 Josh Triplett (1):
  Create a new manpage for the gitignore format, and reference it elsew=
here

 Kristian H=C3=B8gsberg (1):
  Use =3D20 when rfc2047 encoding spaces.

 Linus Torvalds (1):
  fix signed range problems with hex conversions


* The 'master' branch has these since the last announcement
  in addition to the above.

 James Bowes (1):
  rev-parse: Identify short sha1 sums correctly.

 Jonas Fonseca (2):
  Fix git-am(1) synopsis formatting
  git-rebase: suggest to use git-add instead of git-update-index

 Julian Phillips (1):
  Makefile: Use generic rule to build test programs

 Junio C Hamano (1):
  Add DLH to .mailmap

 Martin Koegler (4):
  builtin-pack-objects: don't fail, if delta is not possible
  git-pack-objects: cache small deltas between big objects
  builtin-pack-object: cache small deltas
  diff-delta: use realloc instead of xrealloc

 Nicolas Pitre (2):
  fix repack with --max-pack-size
  always start looking up objects in the last used pack first

 Shawn O. Pearce (7):
  Lazily open pack index files on demand
  Micro-optimize prepare_alt_odb
  Attempt to delay prepare_alt_odb during get_sha1
  Test for recent rev-parse $abbrev_sha1 regression
  Simplify index access condition in count-objects, pack-redundant
  Ensure the pack index is opened before access
  Style nit - don't put space after function names

 Theodore Ts'o (1):
  Fix minor grammatical typos in the git-gc man page
