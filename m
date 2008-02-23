From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.4.3
Date: Sat, 23 Feb 2008 13:07:24 -0800
Message-ID: <7vr6f31iwj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 22:08:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT1bU-0005Qp-WC
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 22:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760573AbYBWVHl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Feb 2008 16:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757614AbYBWVHk
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 16:07:40 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283AbYBWVHj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Feb 2008 16:07:39 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DCA1617A9;
	Sat, 23 Feb 2008 16:07:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C5E3C17A8; Sat, 23 Feb 2008 16:07:31 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74851>

The latest maintenance release GIT 1.5.4.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.4.3.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.4.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.4.3.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.4.3-1.$arch.rpm	(RPM)

Largest user visible change in this is RPM packaging updates by
Kristian H=C3=B8gsberg.  'git-core' will only be pure git without
pulling foreign SCM packages in as its dependencies anymore when
you do "yum install git-core".

----------------------------------------------------------------

GIT v1.5.4.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.5.4.2
--------------------

 * RPM spec used to pull in everything with 'git'.  This has been
   changed so that 'git' package contains just the core parts,
   and we now supply 'git-all' metapackage to slurp in everything.
   This should match end user's expectation better.

 * When some refs failed to update, git-push reported "failure"
   which was unclear if some other refs were updated or all of
   them failed atomically (the answer is the former).  Reworded
   the message to clarify this.

 * "git clone" from a repository whose HEAD was misconfigured
   did not set up the remote properly.  Now it tries to do
   better.

 * Updated git-push documentation to clarify what "matching"
   means, in order to reduce user confusion.

 * Updated git-add documentation to clarify "add -u" operates in
   the current subdirectory you are in, just like other commands.

 * git-gui updates to work on OSX and Windows better.

----------------------------------------------------------------

Changes since v1.5.4.2 are as follows:

Gerrit Pape (1):
      git-clone.sh: properly configure remote even if remote's head is =
dangling

Jay Soffian (2):
      git-gui: support Git Gui.app under OS X 10.5
      send-email: squelch warning due to comparing undefined $_ to ""

Jeff King (4):
      push: indicate partialness of error message
      Documentation/push: clarify matching refspec behavior
      push: document the status output
      hash: fix lookup_hash semantics

Junio C Hamano (1):
      GIT 1.5.4.3

Kristian H=E6=B7=A1gsberg (1):
      Rename git-core rpm to just git and rename the meta-pacakge to gi=
t-all.

Miklos Vajna (1):
      Documentation/git-stash: document options for git stash list

Pekka Kaitaniemi (1):
      Clarified the meaning of git-add -u in the documentation

Shawn O. Pearce (5):
      git-gui: Ensure error dialogs always appear over all other window=
s
      git-gui: Paper bag fix error dialogs opening over the main window
      git-gui: Default TCL_PATH to same location as TCLTK_PATH
      git-gui: Avoid hardcoded Windows paths in Cygwin package files
      git-gui: Focus insertion point at end of strings in repository ch=
ooser

Wincent Colaiuta (1):
      git-gui: relax "dirty" version detection
