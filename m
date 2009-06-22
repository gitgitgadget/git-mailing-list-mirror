From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Jun 2009, #02; Mon, 22)
Date: Mon, 22 Jun 2009 00:57:05 -0700
Message-ID: <7vvdmoem5q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 09:57:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIeOy-0008CL-TV
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 09:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243AbZFVH5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 03:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753980AbZFVH5G
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 03:57:06 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48652 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbZFVH5F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 03:57:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090622075705.YRGD17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jun 2009 03:57:05 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6vx61c0014aMwMQ04vx6Y0; Mon, 22 Jun 2009 03:57:06 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=FNH49bf8C_0A:10 a=D7S3u2PffX5rOpQXkhEA:9
 a=Z_4ur6Kcb2xAtJu9X--i7m0XozkA:4
X-CM-Score: 0.00
X-maint-at: 1ab012cf811abba5745fa0da70db963decd65f21
X-master-at: 916e1373fb86db9d7019de4e7e74e39c9474a153
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122017>

The 'maint' branch gave birth to v1.6.3.3 tonight.  There are still
a handful of fixes that are already in 'master' but have not been
backmerged for v1.6.3.X series; hopefully we can flush them all and mak=
e
v1.6.3.4 the final one before 'master' starts the rc freeze for v1.6.4.

* The 'maint' branch has these fixes since v1.6.3.3.

Johannes Sixt (1):
  t3700-add: add a POSIXPERM prerequisite to a new test

Stephen Boyd (1):
  add: allow configurations to be overriden by command line


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Benn=C3=A9e (1):
  Add -k option to cvsexportcommit to revert expanded CVS keywords in C=
VS
    working tree before applying commit patch

Christian Stimming (1):
  gitk: Update German translation.

Dirk S=C3=BCsserott (1):
  gitk: Add option 'Simple history' to the options menu

Elijah Newren (1):
  gitk: Make more options easily accessible from Edit View dialog

Jim Meyering (1):
  avoid NULL dereference on failed malloc

Johan Herland (1):
  git-submodule: add support for --merge.

Johannes Sixt (1):
  gitk: Use --textconv to generate diff text

Junio C Hamano (5):
  write-tree --ignore-cache-tree
  cache-tree.c::cache_tree_find(): simplify internal API
  t4007: modernize the style
  Optimize "diff-index --cached" using cache-tree
  Avoid "diff-index --cached" optimization under --find-copies-harder

Linus Torvalds (1):
  Fix various sparse warnings in the git source code

Markus Heidelberg (1):
  gitk: Allow diff view without context lines

Michael J Gruber (5):
  Allow push and fetch urls to be different
  t5516: Check pushurl config setting
  technical/api-remote: Describe new struct remote member pushurl
  builtin-remote: Show push urls as well
  builtin-remote: Make "remote -v" display push urls

Michele Ballabio (1):
  gitk: Add another string to translation

Paolo Bonzini (1):
  Test cccmd in t9001-send-email.sh and fix some bugs

Pat Thoyts (1):
  gitk: Handle msysGit version during version comparisons

Paul Mackerras (1):
  gitk: Check git version before using --textconv flag

Santi B=C3=A9jar (3):
  parse-remote: function to get the tracking branch to be merge
  parse-remote: support default reflist in get_remote_merge_branch
  parse-remote: remove unused functions

Stephen Boyd (2):
  parse-options: make OPT_INTEGER's argh explicit
  parse-options: simplify usage argh handling
