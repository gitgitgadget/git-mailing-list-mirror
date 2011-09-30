From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.7
Date: Fri, 30 Sep 2011 15:33:59 -0700
Message-ID: <7vbou1oe20.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 00:34:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9ler-000145-FQ
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 00:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758610Ab1I3WeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 18:34:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59196 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758452Ab1I3WeC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 18:34:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D45C6719;
	Fri, 30 Sep 2011 18:34:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type; s=sasl;
	 bh=nlGn6QgkkNXsMT2urAHMTaJKjko=; b=SpwiaGlOfGRzjFneVnV6mGvugfZS
	5oNYH2MNfs2rcNMqVEuw5S1bV8OwfaVPg2iPdzrr992rUOxUW4qKRzeTVOGffpNI
	2b47R4OWtvv/MmZv9KoHeprEBsKgPqr3tHBNVSXsE8NMiwFY4nxJCGcNftH4ZQmn
	0o8Dtzi6pdYRNyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	LQJPEtsTohxzncGNDJJ8hD4VEl9nseVwBjxTNw/yVgGsSp1bR+4uzHhZn33tL8Sw
	vKCvFZ1LHkIlhXKZIh4MySjuyHKh+23moTWxkC7Xie1END3w5j9B87CvusfQA7Gj
	nzjovVuRSGzynF90D0o54fH0QpO36QoBPyNO7QbjiFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0E396718;
	Fri, 30 Sep 2011 18:34:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E92016717; Fri, 30 Sep 2011
 18:34:00 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B372332-EBB4-11E0-8F93-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182519>

The latest feature release Git 1.7.7 is available.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

bbf85bd767ca6b7e9caa1489bb4ba7ec64e0ab35  git-1.7.7.tar.gz
33183db94fd25e001bd8a9fd6696b992f61e28d8  git-htmldocs-1.7.7.tar.gz
75d3cceb46f7a46eeb825033dff76af5eb5ea3d9  git-manpages-1.7.7.tar.gz

Also the following public repositories all have a copy of the v1.7.7
tag and the master branch that the tag points at:

  url = git://repo.or.cz/alt-git.git
  url = https://code.google.com/p/git-core/
  url = git://git.sourceforge.jp/gitroot/git-core/git.git
  url = git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url = https://github.com/gitster/git


The release tag and the tarballs can be verified with my GPG key if
anybody is so inclined. To get my public key:

  $ git fetch git://repo.or.cz/alt-git.git refs/tags/junio-gpg-pub
  $ git rev-parse FETCH_HEAD
  680865b90b18efbc9402ea979adf0302c6dfe72e
  $ git cat-file blob FETCH_HEAD | gpg --import
  
and then make sure that you got my key by checking the output from
"gpg --fingerprint", which should contain these lines:

  pub   1024D/F3119B9A 2004-01-28
        Key fingerprint = 3565 2A26 2040 E066 C9A7  4A7D C0C6 D9A4 F311 9B9A
  uid                  Junio C Hamano <gitster@pobox.com>


Git v1.7.7 Release Notes
========================

Updates since v1.7.6
--------------------

 * The scripting part of the codebase is getting prepared for i18n/l10n.

 * Interix, Cygwin and Minix ports got updated.

 * Various updates to git-p4 (in contrib/), fast-import, and git-svn.

 * Gitweb learned to read from /etc/gitweb-common.conf when it exists,
   before reading from gitweb_config.perl or from /etc/gitweb.conf
   (this last one is read only when per-repository gitweb_config.perl
   does not exist).

 * Various codepaths that invoked zlib deflate/inflate assumed that these
   functions can compress or uncompress more than 4GB data in one call on
   platforms with 64-bit long, which has been corrected.

 * Git now recognizes loose objects written by other implementations that
   use a non-standard window size for zlib deflation (e.g. Agit running on
   Android with 4kb window). We used to reject anything that was not
   deflated with 32kb window.

 * Interaction between the use of pager and coloring of the output has
   been improved, especially when a command that is not built-in was
   involved.

 * "git am" learned to pass the "--exclude=<path>" option through to underlying
   "git apply".

 * You can now feed many empty lines before feeding an mbox file to
   "git am".

 * "git archive" can be told to pass the output to gzip compression and
   produce "archive.tar.gz".

 * "git bisect" can be used in a bare repository (provided that the test
   you perform per each iteration does not need a working tree, of
   course).

 * The length of abbreviated object names in "git branch -v" output
   now honors the core.abbrev configuration variable.

 * "git check-attr" can take relative paths from the command line.

 * "git check-attr" learned an "--all" option to list the attributes for a
   given path.

 * "git checkout" (both the code to update the files upon checking out a
   different branch and the code to checkout a specific set of files) learned
   to stream the data from object store when possible, without having to
   read the entire contents of a file into memory first. An earlier round
   of this code that is not in any released version had a large leak but
   now it has been plugged.

 * "git clone" can now take a "--config key=value" option to set the
   repository configuration options that affect the initial checkout.

 * "git commit <paths>..." now lets you feed relative pathspecs that
   refer to outside your current subdirectory.

 * "git diff --stat" learned a --stat-count option to limit the output of
   a diffstat report.

 * "git diff" learned a "--histogram" option to use a different diff
   generation machinery stolen from jgit, which might give better
   performance.

 * "git diff" had a weird worst case behaviour that can be triggered
   when comparing files with potentially many places that could match.

 * "git fetch", "git push" and friends no longer show connection
   errors for addresses that couldn't be connected to when at least one
   address succeeds (this is arguably a regression but a deliberate
   one).

 * "git grep" learned "--break" and "--heading" options, to let users mimic
   the output format of "ack".

 * "git grep" learned a "-W" option that shows wider context using the same
   logic used by "git diff" to determine the hunk header.

 * Invoking the low-level "git http-fetch" without "-a" option (which
   git itself never did---normal users should not have to worry about
   this) is now deprecated.

 * The "--decorate" option to "git log" and its family learned to
   highlight grafted and replaced commits.

 * "git rebase master topci" no longer spews usage hints after giving
   the "fatal: no such branch: topci" error message.

 * The recursive merge strategy implementation got a fairly large
   fix for many corner cases that may rarely happen in real world
   projects (it has been verified that none of the 16000+ merges in
   the Linux kernel history back to v2.6.12 is affected with the
   corner case bugs this update fixes).

 * "git stash" learned an "--include-untracked option".

 * "git submodule update" used to stop at the first error updating a
   submodule; it now goes on to update other submodules that can be
   updated, and reports the ones with errors at the end.

 * "git push" can be told with the "--recurse-submodules=check" option to
   refuse pushing of the supermodule, if any of its submodules'
   commits hasn't been pushed out to their remotes.

 * "git upload-pack" and "git receive-pack" learned to pretend that only a
   subset of the refs exist in a repository. This may help a site to
   put many tiny repositories into one repository (this would not be
   useful for larger repositories as repacking would be problematic).

 * "git verify-pack" has been rewritten to use the "index-pack" machinery
   that is more efficient in reading objects in packfiles.

 * test scripts for gitweb tried to run even when CGI-related perl modules
   are not installed; they now exit early when the latter are unavailable.

Also contains various documentation updates and minor miscellaneous
changes.


Fixes since v1.7.6
------------------

Unless otherwise noted, all fixes in the 1.7.6.X maintenance track are
included in this release.

 * "git branch -m" and "git checkout -b" incorrectly allowed the tip
   of the branch that is currently checked out updated.
