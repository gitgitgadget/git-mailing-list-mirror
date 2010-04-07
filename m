From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.1.rc0
Date: Wed, 07 Apr 2010 08:05:51 -0700
Message-ID: <7vmxxfe20g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 07 17:06:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWpf-0001G0-EL
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 17:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748Ab0DGPGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 11:06:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642Ab0DGPGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 11:06:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F14CA81A8;
	Wed,  7 Apr 2010 11:06:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=Gsj2
	+volCPEo/C9R03qmUu0bU9Q=; b=ChSI2T22bUqeFQmVvnbF6nWAE0n+xpKxJfXq
	0lkKo/og5U1+gbBaKpM0yH1DNLEvK557S91k6RSdSGJRTS7/G+Slj6HBgw4Exjah
	i0aYtlX/J5Gx6WxMVp+CtKBnnC9Wi6za30UMR5CPOVi/S7XB1ulBMRZg2VYCYtHf
	LoDgV6s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=tsC
	LrT0gUNy4lQgoNk0l2+wXHqt//y1V06axjI/p9NUlLkLrUY1P2hgZc5mFE9dl4r5
	70eaGKHWFFb68HYGRDu3CWvlcmOIflYD3ZDs/DAm1CxRFIwMfKFAQOFVjYs//yoi
	5KvDHQEfzvMgAMPujgBb8/BJNsys77y8degWRDt8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1ED9A81A4;
	Wed,  7 Apr 2010 11:05:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10046A81A0; Wed,  7 Apr
 2010 11:05:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 119F0E4E-4257-11DF-B788-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144232>

A release candidate Git 1.7.1.rc0 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.1.rc0.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.1.rc0.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.1.rc0.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.7.1.rc0-1.fc11.$arch.rpm	(RPM)

----------------------------------------------------------------

Git v1.7.1 Release Notes (draft)
================================

Updates since v1.7.0
--------------------

 * Eric Raymond is the maintainer of updated CIAbot scripts, in contrib/.

 * Some commands (e.g. svn and http interfaces) that interactively ask
   password can be told to use an external program given via GIT_ASKPASS.

 * Conflict markers that lead the common ancestor in diff3-style output
   now has a label, which hopefully would help third-party tools that
   expect one.

 * Comes with an updated bash-completion script.

 * "git am" learned "--keep-cr" option to handle inputs that are
   mixture of changes to files with and without CRLF line endings.

 * "git cvsimport" learned -R option to leave revision mapping between
   CVS revisions and resulting git commits.

 * "git diff --submodule" notices and descries dirty submodules.

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

 * "git merge-file" learned to use custom conflict marker size and also use
   the "union merge" behaviour.

 * "git notes" command has been rewritten in C and learned quite a
   many commands and features to help you carry notes forward across
   rebases and amends.

 * "git request-pull" identifies the commit the request is relative to in
   a more readable way.

 * "git reset" learned "--keep" option that lets you discard commits
   near the tip while preserving your local changes in a way similar
   to how "git checkout branch" does.

 * "git status" notices and descries dirty submodules.

 * "git svn" should work better when interacting with repositories
   with CRLF line endings.

 * "git imap-send" learned to support CRAM-MD5 authentication.

Fixes since v1.7.0
------------------

All of the fixes in v1.7.0.X maintenance series are included in this
release, unless otherwise noted.

 * "git add frotz/nitfol" did not complain when the entire frotz/ directory
   was ignored.

 * "git rev-list --pretty=oneline" didn't terminate a record with LF for
   commits without any message.

 * "git rev-list --abbrev-commit" defaulted to 40-byte abbreviations, unlike
   newer tools in the git toolset.
