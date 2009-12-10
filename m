From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.6.6.rc2
Date: Wed, 09 Dec 2009 17:44:02 -0800
Message-ID: <7vocm7li1p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 10 02:44:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIY4y-0001UN-S3
	for gcvg-git-2@lo.gmane.org; Thu, 10 Dec 2009 02:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759401AbZLJBoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Dec 2009 20:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759392AbZLJBoN
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 20:44:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759396AbZLJBoK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Dec 2009 20:44:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D315A86120;
	Wed,  9 Dec 2009 20:44:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=aaLVSTzWX1kHc/7lqkUgF79tg
	mA=; b=JlHs487P+ya9WHDUHC+DEJdqBp7Ji0VxJRAZDh6IGcTtBqlYvWVkQ+zPc
	MZHNzLn1Crs8nUPruexH3p7doPLVtsH+0JoIDD+Zlc+Om5AJjyM1vjOL13rNgIZS
	TjKRJ6xvPm6IYPR2GeGv8PEQDlQvwpMTx8k4ekKD+La9LXRcKY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=TAGVY2r9VGXbzYhIVeq
	Niusbd07qR73x2kUrVpwTNyYaKzLHWB0MU6klRYQNWNiVCABR8I4cORP2s+kuoqh
	tKDEFAdSY/lcAbxtdJ29wh9/5a5bfXKP4vGH5TtXJjYC2nwv+UPMTm/khIX0Bd9K
	b4na7s3dWkNXFhS2eocDsC9U=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 551238611D;
	Wed,  9 Dec 2009 20:44:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CB0986115; Wed,  9 Dec
 2009 20:44:03 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83145E30-E52D-11DE-A5E1-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135008>

A release candidate Git 1.6.6.rc2 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.6.rc2.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.6.rc2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.6.rc2.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.6.6.rc2-1.fc11.$arch.rpm	(RPM)

The changes since rc1 are mostly updates to the subsystems.

The regression to "git pull" that made the command give annoying warnin=
g
message when there is no local commit has been fixed; it appeared in rc=
1.

----------------------------------------------------------------

Changes since v1.6.6-rc1 are as follows:

Alex Vandiver (3):
      git-svn: sort svk merge tickets to account for minimal parents
      git-svn: Set svn.authorsfile to an absolute path when cloning
      git-svn: set svn.authorsfile earlier when cloning

Alexander Gavrilov (1):
      git-gui: Increase blame viewer usability on MacOS.

Bernt Hansen (1):
      gitk: Skip translation of "wrong Tcl version" message

Brandon Casey (2):
      t4201: use ISO8859-1 rather than ISO-8859-1
      t9001: use older Getopt::Long boolean prefix '--no' rather than '=
--no-'

Clemens Buchacher (1):
      git-gui: search 4 directories to improve statistic of gc hint

Eric Wong (1):
      git svn: log removals of empty directories

Greg Price (1):
      git svn: Don't create empty directories whose parents were delete=
d

Guillermo S. Romero (1):
      gitk: Add configuration for UI colour scheme

Heiko Voigt (1):
      git gui: make current branch default in "remote delete branch" me=
rge check

Jakub Narebski (1):
      gitweb: Describe (possible) gitweb.js minification in gitweb/READ=
ME

Jan Kr=C3=BCger (1):
      pull: clarify advice for the unconfigured error case

Jeff King (3):
      rerere: don't segfault on failure to open rr-cache
      reset: improve worktree safety valves
      add-interactive: fix deletion of non-empty files

Jens Lehmann (2):
      gitk: Fix diffing committed -> staged (typo in diffcmd)
      gitk: Use the --submodule option for displaying diffs when availa=
ble

Jindrich Makovicka (1):
      git-gui: suppress RenderBadPicture X error caused by Tk bug

Johan Herland (1):
      Fix crasher on encountering SHA1-like non-note in notes tree

Junio C Hamano (9):
      Documentation/Makefile: allow man.base.url.for.relative.link to b=
e set from Make
      Unconditionally set man.base.url.for.relative.links
      Git 1.6.5.4
      Documentation: xmlto 0.0.18 does not know --stringparam
      Prepare for 1.6.5.5
      Git 1.6.5.5
      Revert recent "git merge <msg> HEAD <commit>..." deprecation
      Update draft release notes to 1.6.6 before -rc2
      Git 1.6.6-rc2

Linus Torvalds (1):
      Fix diff -B/--dirstat miscounting of newly added contents

Markus Heidelberg (1):
      gitk: Fix "git gui blame" invocation when called from top-level d=
irectory

Mizar (2):
      gitk: Add Japanese translation
      gitk: Update Japanese translation

Pat Thoyts (4):
      gitk: Use themed tk widgets
      gitk: Fix errors in the theme patch
      gitk: Default to the system colours on Windows
      gitk: Fix selection of tags

Paul Mackerras (5):
      gitk: Restore scrolling position of diff pane on back/forward in =
history
      gitk: Add a user preference to enable/disable use of themed widge=
ts
      gitk: Show diff of commits at end of compare-commits output
      gitk: Don't compare fake children when comparing commits
      gitk: Improve appearance of radiobuttons and checkbuttons

Ren=C3=A9 Scharfe (1):
      archive: clarify description of path parameter

SZEDER G=C3=A1bor (1):
      bash: update 'git commit' completion

Sitaram Chamarty (1):
      gitk: Disable checkout of remote branches

Todd Zullinger (1):
      Documentation: Avoid use of xmlto --stringparam
