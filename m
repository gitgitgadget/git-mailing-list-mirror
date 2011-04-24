From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.5
Date: Sun, 24 Apr 2011 13:31:26 -0700
Message-ID: <7v39l7mlwh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:32:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE5yS-0005oa-Uo
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 22:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757689Ab1DXUbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 16:31:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50674 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757666Ab1DXUbg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 16:31:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5DBF943CB;
	Sun, 24 Apr 2011 16:33:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=y
	K2miabEM0sVlwPIgl19X2Re+4A=; b=wygUtsK3d5a7CMpNGvJpV1pGmA+GwJmF2
	+TWq0tIWvGo5leoEa4tOQFMLr/ZdcEfa2yYWcTOi6MjxBbHho9e9eTCQVJZml/dr
	gN1LzfSsdyj0gtLxf39w78/jkTAVWfgk1jlIaDPQkcc+7Gubw6AT/XMYE8JKXGyX
	1f7AE2qbaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=xqEyS7HOV2WivnGqEQzOf2RARDe61BwpNemK+FA3YJA9xHGoXfYlyedn
	v5U+DhQwL8FO+sxL/mD0nROtQKS7dVjbY4btWSGpxppKmH84f3h70f86sqx9gJ99
	7/AIa71L0My6Sh8SHe8DFOpHOBnS9QTNOYWTIriAYKCDN6SOZ0U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38CDE43CA;
	Sun, 24 Apr 2011 16:33:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EBCA443C9; Sun, 24 Apr 2011
 16:33:30 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2004B0D2-6EB2-11E0-BA99-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171996>

The latest feature release Git 1.7.5 is available at the usual
places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.7.5.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.7.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.7.5.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.7.5-1.fc13.$arch.rpm	(RPM)

This release has 500+ changes from 70+ contributors; thanks for everybody
who contributed.

----------------------------------------------------------------

Git v1.7.5 Release Notes
========================

Updates since v1.7.4
--------------------

 * Various MinGW portability fixes.

 * Various git-p4 enhancements (in contrib).

 * Various vcs-svn, git-svn and gitk enhancements and fixes.

 * Various git-gui updates (0.14.0).

 * Update to more modern HP-UX port.

 * The codebase is getting prepared for i18n/l10n; no translated
   strings nor translation mechanism in the code yet, but the strings
   are being marked for l10n.

 * The bash completion script can now complete symmetric difference
   for "git diff" command, e.g. "git diff ...bra<TAB>".

 * The default minimum length of abbreviated and unique object names
   can now be configured by setting the core.abbrev configuration
   variable.

 * "git apply -v" reports offset lines when the patch does not apply at
   the exact location recorded in the diff output.

 * "git config" used to be also known as "git repo-config", but the old
   name is now officially deprecated.

 * "git checkout --detach <commit>" is a more user friendly synonym for
   "git checkout <commit>^0".

 * "git checkout" performed on detached HEAD gives a warning and
   advice when the commit being left behind will become unreachable from
   any branch or tag.

 * "git cherry-pick" and "git revert" can be told to use a custom merge
   strategy, similar to "git rebase".

 * "git cherry-pick" remembers which commit failed to apply when it is
   stopped by conflicts, making it unnecessary to use "commit -c $commit"
   to conclude it.

 * "git cvsimport" bails out immediately when the cvs server cannot be
   reached, without spewing unnecessary error messages that complain about
   the server response it never got.

 * "git fetch" vs "git upload-pack" transfer learned 'no-done'
   protocol extension to save one round-trip after the content
   negotiation is done. This saves one HTTP RPC, reducing the overall
   latency for a trivial fetch.

 * "git fetch" can be told to recursively fetch submodules on-demand.

 * "git grep -f <filename>" learned to treat "-" as "read from the
   standard input stream".

 * "git grep --no-index" did not honor pathspecs correctly, returning
   paths outside the specified area.

 * "git init" learned the --separate-git-dir option to allow the git
   directory for a new repository created elsewhere and linked via the
   gitdir mechanism. This is primarily to help submodule support later
   to switch between a branch of superproject that has the submodule
   and another that does not.

 * "git log" type commands now understand globbing pathspecs.  You
   can say "git log -- '*.txt'" for example.

 * "git log" family of commands learned --cherry and --cherry-mark
   options that can be used to view two diverged branches while omitting
   or highlighting equivalent changes that appear on both sides of a
   symmetric difference (e.g. "log --cherry A...B").

 * A lazy "git merge" that didn't say what to merge used to be an error.
   When run on a branch that has an upstream defined, however, the command
   now merges from the configured upstream.

 * "git mergetool" learned how to drive "beyond compare 3" as well.

 * "git rerere forget" without pathspec used to forget all the saved
   conflicts that relate to the current merge; it now requires you to
   give it pathspecs.

 * "git rev-list --objects $revs -- $pathspec" now limits the objects listed
   in its output properly with the pathspec, in preparation for narrow
   clones.

 * "git push" with no parameters gives better advice messages when
   "tracking" is used as the push.default semantics or there is no remote
   configured yet.

 * A possible value to the "push.default" configuration variable,
   'tracking', gained a synonym that more naturally describes what it
   does, 'upstream'.

 * "git rerere" learned a new subcommand "remaining" that is similar to
   "status" and lists the paths that had conflicts which are known to
   rerere, but excludes the paths that have already been marked as
   resolved in the index from its output.  "git mergetool" has been
   updated to use this facility.

Also contains various documentation updates.


Fixes since v1.7.4
------------------

All of the fixes in the v1.7.4.X maintenance series are included in this
release, unless otherwise noted.

 * "git fetch" from a client that is mostly following the remote
   needlessly told all of its refs to the server for both sides to
   compute the set of objects that need to be transferred efficiently,
   instead of stopping when the server heard enough. In a project with
   many tags, this turns out to be extremely wasteful, especially over
   the smart HTTP transport (sp/maint-{upload,fetch}-pack-stop-early~1).

 * "git fetch" run from a repository that uses the same repository as
   its alternate object store as the repository it is fetching from
   did not tell the server that it already has access to objects
   reachable from the refs in their common alternate object store,
   causing it to fetch unnecessary objects (jc/maint-fetch-alt).

 * "git remote add --mirror" created a configuration that is suitable for
   doing both a mirror fetch and a mirror push at the same time, which
   made little sense.  We now warn and require the command line to specify
   either --mirror=fetch or --mirror=push.
