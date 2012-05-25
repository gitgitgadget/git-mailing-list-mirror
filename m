From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.10.3
Date: Fri, 25 May 2012 13:54:39 -0700
Message-ID: <7vhav4q8vk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 22:55:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY1XH-0004N3-WB
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 22:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290Ab2EYUyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 16:54:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758812Ab2EYUyl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 16:54:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7237688EC;
	Fri, 25 May 2012 16:54:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=SvsZyWyb3BzMxCp+nUtUcNbt5
	9c=; b=Cvh6z8N3rPBsL402fvk+ExPI017tScV/2aHvWQbeRoi1DYEeEEqTJ4s6l
	pw9Nr/7HYtQR+BxbZtz+GXrmUGxBW2cxXPCn0zrpcyVjFzRoz0qZy2KVwX/oDyUd
	avQ4sABgR8cGU9LGiRPl6ctXF23yghJth3Rtr/D3/s6MmbDbiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ybnQP8Jq6ezOqjnEaRP
	Q5VFTELyo6Ui0VdlfL2GlVF3yyW1C5NLFXsxkzviUTmzDVEKERrpKxZzTY6JAXdb
	2ZBjdWscDsEri/V7OtUWtYDgkMgmg5pzpvS1FtbJ6MbvoqGn35UedZW9qStsOZFd
	j2Q0y8A0/CLhKWbzhowFjH60=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 685C988EB;
	Fri, 25 May 2012 16:54:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BB28988E9; Fri, 25 May 2012
 16:54:40 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8FACE6E-A6AB-11E1-BB0E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198525>

The latest maintenance release Git 1.7.10.3 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

172c6ad5a55276213c5e40b83a4c270f6f931b3e  git-1.7.10.3.tar.gz
c75f9dd4e5157b0c0cb53d67a599b1b038b9c708  git-htmldocs-1.7.10.3.tar.gz
4ae4f9f0f0dc42ad5cb2de309049c953841bc413  git-manpages-1.7.10.3.tar.gz

Also the following public repositories all have a copy of the v1.7.10.3
tag and the maint branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git


Git v1.7.10.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

=46ixes since v1.7.10.2
---------------------

 * The message file for German translation has been updated a bit.

 * Running "git checkout" on an unborn branch used to corrupt HEAD.

 * When checking out another commit from an already detached state, we
   used to report all commits that are not reachable from any of the
   refs as lossage, but some of them might be reachable from the new
   HEAD, and there is no need to warn about them.

 * Some time ago, "git clone" lost the progress output for its
   "checkout" phase; when run without any "--quiet" option, it should
   give progress to the lengthy operation.

 * The directory path used in "git diff --no-index", when it recurses
   down, was broken with a recent update after v1.7.10.1 release.

 * "log -z --pretty=3Dtformat:..." did not terminate each record with
   NUL.  The fix is not entirely correct when the output also asks for
   --patch and/or --stat, though.

 * The DWIM behaviour for "log --pretty=3Dformat:%gd -g" was somewhat
   broken and gave undue precedence to configured log.date, causing
   "git stash list" to show "stash@{time stamp string}".

 * "git status --porcelain" ignored "--branch" option by mistake.  The
   output for "git status --branch -z" was also incorrect and did not
   terminate the record for the current branch name with NUL as asked.

 * When a submodule repository uses alternate object store mechanism,
   some commands that were started from the superproject did not
   notice it and failed with "No such object" errors.  The subcommands
   of "git submodule" command that recursed into the submodule in a
   separate process were OK; only the ones that cheated and peeked
   directly into the submodule's repository from the primary process
   were affected.

Also contains minor fixes and documentation updates.


----------------------------------------------------------------

Changes since v1.7.10.2 are as follows:

Bobby Powers (2):
      diff --no-index: reset temporary buffer lengths on directory iter=
ation
      diff --no-index: don't leak buffers in queue_diff

Carlos Mart=C3=ADn Nieto (1):
      pack-protocol: fix first-want separator in the examples

Erik Faye-Lund (2):
      clone: fix progress-regression
      checkout: do not corrupt HEAD on empty repo

Heiko Voigt (2):
      link to gitmodules page at the beginning of git-submodule documen=
tation
      teach add_submodule_odb() to look for alternates

Jan Kr=C3=BCger (1):
      log-tree: use custom line terminator in line termination mode

Jeff King (10):
      docs: stop using asciidoc no-inline-literal
      t1411: add more selector index/date tests
      log: respect date_mode_explicit with --format:%gd
      reflog-walk: clean up "flag" field of commit_reflog struct
      reflog-walk: always make HEAD@{0} show indexed selectors
      commit: refactor option parsing
      status: refactor null_termination option
      status: fix null termination with "-b"
      status: respect "-b" for porcelain format
      osxkeychain: pull make config from top-level directory

Jens Lehmann (1):
      Consistently use "superproject" instead of "supermodule"

Jiang Xin (4):
      l10n: Update git.pot (1 new messages)
      l10n: zh_CN.po: translate 1 new message
      l10n: Update git.pot (3 new, 2 removed messages)
      l10n: zh_CN.po: translate 3 new messages

Johannes Sixt (3):
      t2020-checkout-detach: check for the number of orphaned commits
      checkout (detached): truncate list of orphaned commits at the new=
 HEAD
      t3404: begin "exchange commits with -p" test with correct precond=
itions

Jonathan Nieder (1):
      config doc: remove confusion about relative GIT_DIR from FILES se=
ction

Junio C Hamano (5):
      log-tree: the previous one is still not quite right
      reflog-walk: tell explicit --date=3Ddefault from not having --dat=
e at all
      Start preparing for 1.7.10.3
      Update draft release notes to 1.7.10.3
      Git 1.7.10.3

Linus Torvalds (1):
      fmt-merge-message: add empty line between tag and signature verif=
ication

Ralf Thielow (7):
      l10n: add new members to German translation team
      l10n: de.po: translate "track" as "beobachten"
      l10n: de.po: translate "remote" as "extern"
      l10n: de.po: collection of improvements
      l10n: de.po: unify translation of "ahead" and "behind"
      l10n: de.po: translate one new message
      l10n: de.po: translate 3 new messages

Thomas Rast (4):
      l10n: de.po: translate "bare" as "blo=C3=9F"
      l10n: de.po: hopefully uncontroversial fixes
      l10n: de.po: translate "bad" as "ung=C3=BCltig" ("invalid")
      l10n: de.po: collection of suggestions
