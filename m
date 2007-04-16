From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sun, 15 Apr 2007 18:27:42 -0700
Message-ID: <7vfy71yupd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 03:27:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdG0R-00078a-5e
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 03:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235AbXDPB1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 15 Apr 2007 21:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754268AbXDPB1o
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 21:27:44 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42984 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbXDPB1n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2007 21:27:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416012744.LXLV1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 21:27:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ndTi1W00l1kojtg0000000; Sun, 15 Apr 2007 21:27:43 -0400
X-maint-at: 5f2e1df5c9fa7856e5d7dda7d6c618ed08822b82
X-master-at: 7a1593972c19df26aee7d14c7d7c8c4fce24fb26
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44560>

Perhaps we would need 1.5.1.2 to push out a few accumulated
small fixes on 'maint'.

----------------------------------------------------------------

* The 'maint' branch has these fixes since v1.5.1.1.

 Alex Riesen (2):
  Use rev-list --reverse in git-rebase.sh
  Document -g (--walk-reflogs) option of git-log

 Eygene Ryabinkin (2):
  Teach gitk to use the user-defined UI font everywhere.
  Improve look-and-feel of the gitk tool.

 Frank Lichtenheld (4):
  config.txt: Document gitcvs.allbinary
  config.txt: Document core.autocrlf
  config.txt: Change pserver to server in description of gitcvs.*
  config.txt: Fix grammatical error in description of http.noEPSV

 Jim Meyering (1):
  sscanf/strtoul: parse integers robustly

 Junio C Hamano (1):
  Do not default to --no-index when given two directories.

 Linus Torvalds (1):
  git-quiltimport complaining yet still working

 Matthias Lederhofer (1):
  handle_options in git wrapper miscounts the options it handled.

 Michael Spang (1):
  git-blame: Fix overrun in fake_working_tree_commit()


* The 'master' branch has these since the last announcement
  in addition to the above.

 Frank Lichtenheld (2):
  gitweb: Allow forks with project list file
  gitweb: Allow configuring the default projects order and add order 'n=
one'

 Jim Meyering (1):
  sscanf/strtoul: parse integers robustly

 Junio C Hamano (5):
  Add %m to '--pretty=3Dformat:'
  Refactor patch-id filtering out of git-cherry and git-format-patch.
  git-log --cherry-pick A...B
  Documentation: --cherry-pick
  Fix git {log,show,...} --pretty=3Demail

 Luiz Fernando N. Capitulino (2):
  ident.c: Use const qualifier for 'struct passwd' parameters
  ident.c: Use size_t (instead of int) to store sizes

 Ren=C3=A9 Scharfe (1):
  git-archive: make tar the default format

 Robin H. Johnson (2):
  Add custom subject prefix support to format-patch (take 3)
  Add testcase for format-patch --subject-prefix (take 3)

 Shawn O. Pearce (1):
  Don't yap about merge-subtree during make
