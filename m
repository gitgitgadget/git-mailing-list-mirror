From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.3.3
Date: Mon, 22 Jun 2009 00:49:49 -0700
Message-ID: <7vzlc0emhu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 09:50:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIeIQ-0004LU-4P
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 09:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263AbZFVHtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Jun 2009 03:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbZFVHts
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jun 2009 03:49:48 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48575 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbZFVHtr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2009 03:49:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090622074951.DXZN18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jun 2009 03:49:51 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6vpp1c0074aMwMQ04vppvH; Mon, 22 Jun 2009 03:49:50 -0400
X-VR-Score: 20.00
X-Authority-Analysis: v=1.0 c=1 a=VwQbUJbxAAAA:8 a=IzREjsFMYBAGxtjCVs0A:9
 a=WlHCVC5kzJDzdhl5l-cA:7 a=PJkv-vc8Ds409IVfBPYyxhixPGYA:4
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122016>

The latest maintenance release, GIT 1.6.3.3, is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.3.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.3.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.3.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.3.3-1.fc9.$arch.rpm	(RPM)

GIT v1.6.3.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.3.2
--------------------

 * "git archive" running on Cygwin can get stuck in an infinite loop.

 * "git daemon" did not correctly parse the initial line that carries
   virtual host request information.

 * "git diff --textconv" leaked memory badly when the textconv filter
   errored out.

 * The built-in regular expressions to pick function names to put on
   hunk header lines for java and objc were very inefficiently written.

 * in certain error situations git-fetch (and git-clone) on Windows did=
n't
   detect connection abort and ended up waiting indefinitely.

 * import-tars script (in contrib) did not import symbolic links correc=
tly.

 * http.c used CURLOPT_SSLKEY even on libcURL version 7.9.2, even thoug=
h
   it was only available starting 7.9.3.

 * low-level filelevel merge driver used return value from strdup()
   without checking if we ran out of memory.

 * "git rebase -i" left stray closing parenthesis in its reflog message=
=2E

 * "git remote show" did not show all the URLs associated with the name=
d
   remote, even though "git remote -v" did.  Made them consistent by
   making the former show all URLs.

 * "whitespace" attribute that is set was meant to detect all errors kn=
own
   to git, but it told git to ignore trailing carriage-returns.

Includes other documentation fixes.

----------------------------------------------------------------

Changes since v1.6.3.2 are as follows:

Anders Kaseorg (1):
      for-each-ref: Do not lookup objects when they will not be used

Clemens Buchacher (1):
      refuse to merge during a merge

Jim Meyering (1):
      use xstrdup, not strdup in ll-merge.c

Johannes Schindelin (1):
      import-tars: support symlinks

Johannes Sixt (2):
      fetch-pack: close output channel after sideband demultiplexer ter=
minates
      diff.c: plug a memory leak in an error path

Junio C Hamano (3):
      t3505: fix abuse of test_expect_code
      attribute: whitespace set to true detects all errors known to git
      GIT 1.6.3.3

Linus Torvalds (1):
      Fix big left-shifts of unsigned char

Marco Nelissen (1):
      fix handling of iconv configuration options

Mark Lodato (1):
      http.c: fix compiling with libcurl 7.9.2

Michael J Gruber (1):
      builtin-remote: Make "remote show" display all urls

Miklos Vajna (1):
      git-svn documentation: fix typo in 'rebase vs. pull/merge' sectio=
n

Nanako Shiraishi (1):
      .gitattributes: CR at the end of the line is an error

Paolo Bonzini (2):
      Documentation: git-send-mail can take rev-list arg to drive forma=
t-patch
      avoid exponential regex match for java and objc function names

Ren=C3=A9 Scharfe (1):
      upload-archive: fix infinite loop on Cygwin

Shawn O. Pearce (1):
      daemon: Strictly parse the "extra arg" part of the command

Stephen Boyd (3):
      git-rerere.txt: grammatical fixups and cleanups
      pull, rebase: simplify to use die()
      git-show-ref.txt: remove word and make consistent
v
Tay Ray Chuan (1):
      http*: cleanup slot->local after fclose

Thomas Rast (1):
      Documentation: refer to gitworkflows(7) from tutorial and git(1)

Uwe Kleine-K=C3=B6nig (1):
      rebase--interactive: remote stray closing parenthesis
