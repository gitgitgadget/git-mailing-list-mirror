From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.1.1
Date: Sun, 25 Jan 2009 17:19:16 -0800
Message-ID: <7vfxj6dfu3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 02:20:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRG9j-00054t-5x
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 02:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbZAZBT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 20:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbZAZBT0
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 20:19:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbZAZBT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 20:19:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A16BE93625;
	Sun, 25 Jan 2009 20:19:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B751893620; Sun,
 25 Jan 2009 20:19:19 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5E317BD8-EB47-11DD-9F20-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107153>

The latest maintenance release GIT 1.6.1.1 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.1.1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.1.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.1.1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  RPMS/$arch/git-*-1.6.1.1-1.fc9.$arch.rpm	(RPM)

----------------------------------------------------------------
GIT v1.6.1.1 Release Notes
==========================

Fixes since v1.6.1
------------------

* "git add frotz/nitfol" when "frotz" is a submodule should have errored
  out, but it didn't.

* "git apply" took file modes from the patch text and updated the mode
  bits of the target tree even when the patch was not about mode changes.

* "git bisect view" on Cygwin did not launch gitk

* "git checkout $tree" did not trigger an error.

* "git commit" tried to remove COMMIT_EDITMSG from the work tree by mistake.

* "git describe --all" complained when a commit is described with a tag,
  which was nonsense.

* "git diff --no-index --" did not trigger no-index (aka "use git-diff as
  a replacement of diff on untracked files") behaviour.

* "git format-patch -1 HEAD" on a root commit failed to produce patch
  text.

* "git fsck branch" did not work as advertised; instead it behaved the same
  way as "git fsck".

* "git log --pretty=format:%s" did not handle a multi-line subject the
  same way as built-in log listers (i.e. shortlog, --pretty=oneline, etc.)

* "git daemon", and "git merge-file" are more careful when freopen fails
  and barf, instead of going on and writing to unopened filehandle.

* "git http-push" did not like some RFC 4918 compliant DAV server
  responses.

* "git merge -s recursive" mistakenly overwritten an untracked file in the
  work tree upon delete/modify conflict.

* "git merge -s recursive" didn't leave the index unmerged for entries with
  rename/delete conflictd.

* "git merge -s recursive" clobbered untracked files in the work tree.

* "git mv -k" with more than one errorneous paths misbehaved.

* "git read-tree -m -u" hence branch switching incorrectly lost a
  subdirectory in rare cases.

* "git rebase -i" issued an unnecessary error message upon a user error of
  marking the first commit to be "squash"ed.

* "git shortlog" did not format a commit message with multi-line
  subject correctly.

Comes with many documentation updates.
