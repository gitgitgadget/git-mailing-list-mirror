From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.1
Date: Fri, 23 Apr 2010 20:47:19 -0700
Message-ID: <7vtyr1qzp4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Sat Apr 24 05:47:51 2010
connect(): No such file or directory
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1O5WLN-0006x9-SD
	for glk-linux-kernel-3@lo.gmane.org; Sat, 24 Apr 2010 05:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163Ab0DXDrc (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 23 Apr 2010 23:47:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab0DXDr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2010 23:47:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3816BAD401;
	Fri, 23 Apr 2010 23:47:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=gf0k
	BB3i+MGfQsCZTTksRaNrs54=; b=OwclBGV/iJ8B7Ba6zbBc3RKpSbyc1Dfa3Z6F
	ey1tm9C17id9hHACXX3tuYisHWuCuV6je1v2wIboBMW3OIzNCGuR8B6cG5gnId4O
	CG8CB+kMOCHjIsxeZo+QTNRm2mkwhXgkcnpd3SdVDQaN/SBERdhPab6SrzKygQou
	LocrZFw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Jeu
	/R0b1JidfbcdLzPTe7BMZgvcWNrbZHLU3GYstaAwxtbrnS/XCtfNvL2Sq5x27xUE
	dMfTgndUmTtxLA4onFxxyw+ax9KeCZ4SQ3ocyOHfPZjh/Vh52/1L0SM49ZMpEOA1
	JOtSfSI/YS0IlhJnQwHcjwQDCvySoL89urynxMGE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04F42AD400;
	Fri, 23 Apr 2010 23:47:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2457AAD3FF; Fri, 23 Apr
 2010 23:47:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 186AE586-4F54-11DF-942F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145654>

The latest feature release Git 1.7.1 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.1.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.1.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.1.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.1-1.fc11.$arch.rpm	(RPM)


Git v1.7.1 Release Notes
========================

Updates since v1.7.0
--------------------

 * Eric Raymond is the maintainer of updated CIAbot scripts, in contrib/.

 * gitk updates.

 * Some commands (e.g. svn and http interfaces) that interactively ask
   for a password can be told to use an external program given via
   GIT_ASKPASS.

 * Conflict markers that lead the common ancestor in diff3-style output
   now have a label, which hopefully would help third-party tools that
   expect one.

 * Comes with an updated bash-completion script.

 * "git am" learned "--keep-cr" option to handle inputs that are
   a mixture of changes to files with and without CRLF line endings.

 * "git cvsimport" learned -R option to leave revision mapping between
   CVS revisions and resulting git commits.

 * "git diff --submodule" notices and describes dirty submodules.

 * "git for-each-ref" learned %(symref), %(symref:short) and %(flag)
   tokens.

 * "git hash-object --stdin-paths" can take "--no-filters" option now.

 * "git init" can be told to look at init.templatedir configuration
   variable (obviously that has to come from either /etc/gitconfig or
   $HOME/.gitconfig).

 * "git grep" learned "--no-index" option, to search inside contents that
   are not managed by git.

 * "git grep" learned --color=auto/always/never.

 * "git grep" learned to paint filename and line-number in colors.

 * "git log -p --first-parent -m" shows one-parent diff for merge
   commits, instead of showing combined diff.

 * "git merge-file" learned to use custom conflict marker size and also
   to use the "union merge" behaviour.

 * "git notes" command has been rewritten in C and learned many commands
   and features to help you carry notes forward across rebases and amends.

 * "git request-pull" identifies the commit the request is relative to in
   a more readable way.

 * "git reset" learned "--keep" option that lets you discard commits
   near the tip while preserving your local changes in a way similar
   to how "git checkout branch" does.

 * "git status" notices and describes dirty submodules.

 * "git svn" should work better when interacting with repositories
   with CRLF line endings.

 * "git imap-send" learned to support CRAM-MD5 authentication.

 * "gitweb" installation procedure can use "minified" js/css files
   better.

 * Various documentation updates.

Fixes since v1.7.0
------------------

All of the fixes in v1.7.0.X maintenance series are included in this
release, unless otherwise noted.

 * "git add frotz/nitfol" did not complain when the entire frotz/ directory
   was ignored.

 * "git diff --stat" used "int" to count the size of differences,
   which could result in overflowing.

 * "git rev-list --pretty=oneline" didn't terminate a record with LF for
   commits without any message.

 * "git rev-list --abbrev-commit" defaulted to 40-byte abbreviations, unlike
   newer tools in the git toolset.
