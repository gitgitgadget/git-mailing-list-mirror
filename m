From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.1.4
Date: Wed, 09 May 2007 00:10:43 -0700
Message-ID: <7vhcqmxyj0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 09:10:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlgK3-0004GD-HB
	for gcvg-git@gmane.org; Wed, 09 May 2007 09:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967970AbXEIHKr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 9 May 2007 03:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968348AbXEIHKq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 03:10:46 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:35927 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967970AbXEIHKp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2007 03:10:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070509071045.DUBK24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 03:10:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wvAk1W0031kojtg0000000; Wed, 09 May 2007 03:10:44 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46673>

To: git@vger.kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] GIT 1.5.1.4

The latest maintenance release GIT 1.5.1.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.1.4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.1.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.1.4.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.1.4-1.$arch.rpm	(RPM)

GIT v1.5.1.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.5.1.3
--------------------

* Bugfixes

  - "git-http-fetch" did not work around a bug in libcurl
    earlier than 7.16 (curl_multi_remove_handle() was broken).

  - "git cvsserver" handles a file that was once removed and
    then added again correctly.

  - import-tars script (in contrib/) handles GNU tar archives
    that contain pathnames longer than 100 bytes (long-link
    extension) correctly.

  - xdelta test program did not build correctly.

  - gitweb sometimes tried incorrectly to apply function to
    decode utf8 twice, resulting in corrupt output.

  - "git blame -C" mishandled text at the end of a group of
    lines.

  - "git log/rev-list --boundary" did not produce output
    correctly without --left-right option.

  - Many documentation updates.


----------------------------------------------------------------

Changes since v1.5.1.3 are as follows:

Alex Riesen (1):
      Small correction in reading of commit headers

Alexandre Julliard (1):
      http-fetch: Disable use of curl multi support for libcurl < 7.16.

Amos Waterland (1):
      wcwidth redeclaration

Arjen Laarhoven (1):
      Document 'opendiff' value in config.txt and git-mergetool.txt

Bryan Larsen (2):
      Allow PERL_PATH=3D"/usr/bin/env perl"
      posix compatibility for t4200

Carl Worth (1):
      Mention version 1.5.1 in tutorial and user-manual

Daniel Barkalow (1):
      Make xstrndup common

=46rank Lichtenheld (1):
      cvsserver: Handle re-added files correctly

Ismail D=C3=B6nmez (1):
      gitweb: use decode_utf8 directly

J. Bruce Fields (7):
      user-manual: more discussion of detached heads, fix typos
      user-manual: add section ID's
      user-manual: clean up fast-forward and dangling-objects sections
      user-manual: fix .gitconfig editing examples
      user-manual: miscellaneous editing
      user-manual: stop deprecating the manual
      user-manual: fix clone and fetch typos

Jakub Narebski (1):
      diff format documentation: describe raw combined diff format

James Bowes (1):
      Documentation: fix typo in git-remote.txt

Jeff King (1):
      Documentation: don't reference non-existent 'git-cvsapplycommit'

Johannes Schindelin (1):
      Teach import-tars about GNU tar's @LongLink extension.

Junio C Hamano (5):
      diff.c: fix "size cache" handling.
      blame: Notice a wholesale incorporation of an existing file.
      blame: -C -C -C
      Add test for blame corner cases.
      GIT v1.5.1.4

Karl Hasselstr=C3=B6m (2):
      Fix markup in git-svn man page
      Add --no-rebase option to git-svn dcommit

Linus Torvalds (1):
      Fix --boundary output

Martin Koegler (1):
      Fix compilation of test-delta

Paul Mackerras (1):
      gitk: Allow user to choose whether to see the diff, old file, or =
new file

Quy Tonthat (1):
      Add howto files to rpm packages.

Shawn O. Pearce (1):
      git-gui: Allow spaces in path to 'wish'
