From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.3.2
Date: Thu, 21 Oct 2010 21:13:29 -0700
Message-ID: <7vwrparhjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri Oct 22 06:14:01 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1P990x-0006nJ-9I
	for glk-linux-kernel-3@lo.gmane.org; Fri, 22 Oct 2010 06:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab0JVENl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 22 Oct 2010 00:13:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667Ab0JVENj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2010 00:13:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21729E0922;
	Fri, 22 Oct 2010 00:13:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=nzw7eoOtTfsvxi+SutsvGzD2J
	Nk=; b=I0vmFLrVE603MyQpxIWigOIS/Y/ZfpIhEP8MVQy+zltl+ckvC9O2oZD3X
	/ga1LGOAlkK2GEg+zf0U9pZi9WLBZXfJ+LP++3a54S/yaO++xyMyLdF2sajfwMGY
	mCTFg1NEz8eFcYQhdBLGE1FWHeDVJoApzaceMsO42E9+xKpeuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=sdep8dCnPN/y3fsMWGT
	qVLPpboUL/JkmRPnr1WtjRkH4pdaD+eWBk36CWKwnTW05sGT0V/AF/JcsfM+yDAF
	mcmSHWekDHsDJP1TonIwInmIEuOOO+I4Aw0Hm9vxR/tF/CeEOZE13WQ7bKV4/v2A
	DfZnIvM97/Ii0bujnmi+EKhA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE1D7E0921;
	Fri, 22 Oct 2010 00:13:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC27FE0920; Fri, 22 Oct
 2010 00:13:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BCE90300-DD92-11DF-837C-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159637>

The latest maintenance release Git 1.7.3.2 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.3.2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.3.2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.3.2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.3.2-1.fc11.$arch.rpm	(RPM)

This is primarily to push out many documentation fixes accumulated sinc=
e
the 1.7.3.1 release.

----------------------------------------------------------------

Changes since v1.7.3.1 are as follows:

Andreas Gruenbacher (1):
      Clarify and extend the "git diff" format documentation

Antonio Ospite (1):
      t/t9001-send-email.sh: fix stderr redirection in 'Invalid In-Repl=
y-To'

Bert Wesarg (1):
      Documentation: update-index: -z applies also to --index-info

Brandon Casey (1):
      diffcore-pickaxe.c: remove unnecessary curly braces

Cliff Frey (1):
      documentation: git-config minor cleanups

Elijah Newren (1):
      t3020 (ls-files-error-unmatch): remove stray '1' from end of file

Eric Wong (1):
      Documentation/git-svn: discourage "noMetadata"

Erik Faye-Lund (1):
      do not depend on signed integer overflow

Johannes Schindelin (2):
      Make sure that git_getpass() never returns NULL
      Fix typo in pack-objects' usage

Jon Seymour (1):
      stash: simplify parsing fixes

Jonathan Nieder (10):
      t0004 (unwritable files): simplify error handling
      environment.c: remove unused variable
      setup: make sure git dir path is in a permanent buffer
      init: plug tiny one-time memory leak
      xdiff: cast arguments for ctype functions to unsigned char
      Documentation: No argument of ALLOC_GROW should have side-effects
      Documentation: gitrevisions is in section 7
      Documentation: diff can compare blobs
      Documentation: expand 'git diff' SEE ALSO section
      Documentation: update implicit "--no-index" behavior in "git diff=
"

Junio C Hamano (4):
      MinGW: avoid collisions between "tags" and "TAGS"
      CodingGuidelines: reword parameter expansion section
      shell portability: no "export VAR=3DVAL"
      Git 1.7.3.2

Kevin Ballard (1):
      Update test script annotate-tests.sh to handle missing/extra auth=
ors

Kirill Smelkov (1):
      user-manual: be consistent in illustrations to 'git rebase'

Mathias Lafeldt (1):
      git-svn: fix processing of decorated commit hashes

Matthieu Moy (1):
      diff: trivial fix for --output file error message

Michael J Gruber (4):
      remote-helpers: build in platform independent directory
      user-manual: fix anchor name Finding-comments-With-given-Content
      rev-list-options: clarify --parents and --children
      git-show-ref.txt: clarify the pattern matching

Ramkumar Ramachandra (1):
      SubmittingPatches: Document some extra tags used in commit messag=
es

Ren=C3=A9 Scharfe (1):
      work around buggy S_ISxxx(m) implementations

Steven Walter (1):
      git-svn: check_cherry_pick should exclude commits already in our =
history

Tony Luck (1):
      Better advice on using topic branches for kernel development

Uwe Kleine-K=C3=B6nig (1):
      Documentation/git-clone: describe --mirror more verbosely

Yann Dirson (1):
      t/t3415: use && where applicable.

=C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec (6):
      Use angles for placeholders consistently
      Fix odd markup in --diff-filter documentation
      Use parentheses and `...' where appropriate
      Remove stray quotes in --pretty and --format documentation
      Put a space between `<' and argument in pack-objects usage string
      Fix {update,checkout}-index usage strings
