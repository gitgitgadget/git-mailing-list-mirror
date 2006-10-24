From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.4.3.2
Date: Mon, 23 Oct 2006 23:27:07 -0700
Message-ID: <7vd58irzyc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 08:27:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcFko-00006A-PX
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 08:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbWJXG1K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Oct 2006 02:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbWJXG1K
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 02:27:10 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49071 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752075AbWJXG1I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Oct 2006 02:27:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024062708.RYNF16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Oct 2006 02:27:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id e6TB1V00a1kojtg0000000
	Tue, 24 Oct 2006 02:27:12 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29931>

The latest maintenance release GIT 1.4.3.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.4.3.2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.4.3.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.4.3.2.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.4.3.2-1.$arch.rpm	(RPM)

This is primarily to fix two rather embarrasing breakage
discovered post 1.4.3.1 release.

 - The pager change to default to LESS=3DFRS exposed problem with less
   that switches to alternate screen, shows its output and then switche=
s
   back immediately from the alternate screen afterwards -- which means
   the user would not have a chance to see _anything_.

 - Older upload-pack protocol clients did not pass host=3D and recent
   git-daemon change to support virtual hosting did not handle this
   correctly (although it attempted to do so, the check was borked).

----------------------------------------------------------------

Changes since v1.4.3.1 are as follows:

Alexandre Julliard (1):
      prune-packed: Fix uninitialized variable.

J. Bruce Fields (1):
      Make prune also run prune-packed

Jakub Narebski (2):
      gitweb: Whitespace cleanup - tabs are for indent, spaces are for =
align (2)
      gitweb: Do not esc_html $basedir argument to git_print_tree_entry

Jim Meyering (2):
      git-clone: honor --quiet
      xdiff/xemit.c (xdl_find_func): Elide trailing white space in a co=
ntext header.

Junio C Hamano (2):
      pager: default to LESS=3DFRSX not LESS=3DFRS
      daemon: do not die on older clients.

Karl Hasselstr=F8m (1):
      git-vc: better installation instructions

Lars Hjemli (1):
      Fix usagestring for git-branch

Petr Baudis (1):
      gitweb: Fix setting $/ in parse_commit()

Rene Scharfe (1):
      git-merge: show usage if run without arguments

Santi B=E9jar (1):
      Documentation for the [remote] config
