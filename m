From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.0.4
Date: Sun, 09 Nov 2008 10:07:29 -0800
Message-ID: <7v8wrsbwny.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 19:09:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzEif-0001JV-R3
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 19:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755550AbYKISHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 13:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbYKISHq
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 13:07:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbYKISHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 13:07:45 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A50495492;
	Sun,  9 Nov 2008 13:07:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 38BB895491; Sun, 
 9 Nov 2008 13:07:31 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4D92E528-AE89-11DD-A3C5-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100458>

The latest maintenance release GIT 1.6.0.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.0.4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.0.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.0.4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  RPMS/$arch/git-*-1.6.0.4-1.fc9.$arch.rpm	(RPM)

Fixes since v1.6.0.3
--------------------

* 'git add -p' said "No changes" when only binary files were changed.

* 'git archive' did not work correctly in bare repositories.

* 'git checkout -t -b newbranch' when you are on detached HEAD was broken.

* when we refuse to detect renames because there are too many new or
  deleted files, 'git diff' did not say how many there are.

* 'git push --mirror' tried and failed to push the stash; there is no
  point in sending it to begin with.

* 'git push' did not update the remote tracking reference if the corresponding
  ref on the remote end happened to be already up to date.

* 'git pull $there $branch:$current_branch' did not work when you were on
  a branch yet to be born.

* when giving up resolving a conflicted merge, 'git reset --hard' failed
  to remove new paths from the working tree.

* 'git send-email' had a small fd leak while scanning directory.

* 'git status' incorrectly reported a submodule directory as an untracked
  directory.

* 'git svn' used deprecated 'git-foo' form of subcommand invocaition.

* 'git update-ref -d' to remove a reference did not honor --no-deref option.

* Plugged small memleaks here and there.

* Also contains many documentation updates.
