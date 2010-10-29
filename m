From: Seth Robertson <in-gitvger@baka.org>
Subject: ANNOUNCE gitslave-1.1.1 and git-what-branch-0.2.4
Date: Fri, 29 Oct 2010 16:41:10 -0400
Message-ID: <201010292041.o9TKfAPL004629@no.baka.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 22:41:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBvlJ-00026l-Nl
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 22:41:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904Ab0J2UlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 16:41:15 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:34132 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932894Ab0J2UlN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 16:41:13 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id o9TKfC2u022651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 29 Oct 2010 16:41:12 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id o9TKfAPL004629
	for <git@vger.kernel.org>; Fri, 29 Oct 2010 16:41:11 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160362>


gitslave http://gitslave.sf.net is a superproject multi-repository
management tool. It creates a group of related repositories--a
superproject repository and a number of slave repositories--all of
which are concurrently developed on and on which all git operations
should normally operate; so when you branch, each repository in the
project is branched in turn. Similarly when you commit, push, pull,
merge, tag, checkout, status, log, etc; each git command will run on
the superproject and all slave repositories in turn.

git-what-branch http://github.com/SethRobertson/git-what-branch
determines if a commit was made directly on any named
branch/reference, or what the earliest merge path was to a named
branch/reference.


Gitslave release notes:
----------------------------------------------------------------------
Add support for `gits remote add` to add new remotes for all slaves
with the correct relative remote URLs.

Add support for `gits archive` to generate a unified tarball with
slave-relative paths.

Full (and documented) support for command substitution to allow
gits-archive, gits-exec, gits-bundle and friends to have output files
contain repository specific tokens.

Deduplicate output summarizing code.  Provide standard mechanism to
suppress (and show) empty command output.
----------------------------------------------------------------------


Git-what-branch release notes:
----------------------------------------------------------------------
Add --first-parent and --first-parent-simple options to allow more
easy programmatic detection of failure if a commit was not made
directly on any named branch and programmatic parse of output.

Exit with errors if things go wrong or at least not as the user
probably desired (e.g. commit has not merged with a named branch, etc)

Bugfix: Prevent duplicate refs from being researched multiple times.
Prevent first-parent outputs from being discussed again during
merge-path output if --all is used.

Bugfix: If multiple commits are listed for research, do not have
subsequent commits inherit bad or duplicate information from previous
commits.

Bugfix: Do not fail if user is not on a branch.
----------------------------------------------------------------------
