From: Jeff King <peff@peff.net>
Subject: [RFH] hackday and GSoC topic suggestions
Date: Wed, 5 Feb 2014 17:57:02 -0500
Message-ID: <20140205225702.GA12589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 23:57:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBBP6-0005JS-Ha
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 23:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbaBEW5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 17:57:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:45373 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751085AbaBEW5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 17:57:05 -0500
Received: (qmail 26000 invoked by uid 102); 5 Feb 2014 22:57:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Feb 2014 16:57:04 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Feb 2014 17:57:02 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241671>

This Saturday I'm going to be attending a Git hackday held by Bloomberg
in New York. The participants will be eager C coders who have experience
using git, but not contributing to it. As somebody who has read The
Mythical Man Month, I don't expect huge productivity, but I'm hoping to
do some bug triage and fixes, and maybe get some people involved who
might join the community. I'm hoping some of the folks will have
features _they_ want to work on, and I can help get them started. But
I'd like to have a list of potential projects to direct people towards
as a backup.

On a similar note, the GSoC application deadline is Feb 14th. I am
happy to be admin again and put together the application, but we will
need an idea page. I'll set up a page to collect them, but in the
meantime, please dump any ideas/discussion in this thread.

Below is a list of features / bugs that I am taking to the hackday. The
bug list was collected by grepping the mailing list for items without
responses. They haven't been triaged at all, so I'm sure some of them
are "not a bug" or "won't fix".  But the triage process is part of what
we'll be doing on Saturday.

I don't think the list below and the potential GSoC list really have any
overlap, as the project scales are completely different. But I'd be
happy to take suggestions for either.

---
features:

 - negative refspecs
   http://thread.gmane.org/gmane.comp.version-control.git/240997/focus=241019

 - optionally remove tempfiles on failed pack-objects (especially when
   we get ENOSPC)
   http://article.gmane.org/gmane.comp.version-control.git/241466

 - previewing "git pull"
   http://article.gmane.org/gmane.comp.version-control.git/236732

bugs:

 - branch.*.merge interpreted too strictly by tracking logic
   http://article.gmane.org/gmane.comp.version-control.git/241582

 - relative core.worktree is resolved from symlink and not its target
   http://article.gmane.org/gmane.comp.version-control.git/241519

 - Branch rename breaks local downstream branches
   http://article.gmane.org/gmane.comp.version-control.git/241228

 - git clone on out-of-space device causes incorrect errors
   http://article.gmane.org/gmane.comp.version-control.git/241206

 - commit-msg hook and merges
   http://article.gmane.org/gmane.comp.version-control.git/241203

 - inconsistent include behaviour for core.sharedRepository
   http://article.gmane.org/gmane.comp.version-control.git/241277

 - Rebase options '--whitespace=fix' and '--keep-empty' are incompatible
   http://article.gmane.org/gmane.comp.version-control.git/238055

 - git stash doesn't use --index as default
   http://article.gmane.org/gmane.comp.version-control.git/235892

 - git describe --contains --abbrev=0 <sha1> doesn't work as expected
   http://article.gmane.org/gmane.comp.version-control.git/236707

 - using git commit-tree with "-F -" adds trailing newlines
   http://article.gmane.org/gmane.comp.version-control.git/236583

 - Pull and fetch don't honor `--progress` flag
   http://thread.gmane.org/gmane.comp.version-control.git/236257/focus=236262

 - Unexpected outputs of git pull on stdout v.s. stderr
   http://article.gmane.org/gmane.comp.version-control.git/235716

 - MERGE_HEAD lost with git checkout master
   http://article.gmane.org/gmane.comp.version-control.git/233806

 - git stash doesn't always save work dir as-is: bug?
   http://article.gmane.org/gmane.comp.version-control.git/234153

 - Well-past commit dates unsupported
   http://article.gmane.org/gmane.comp.version-control.git/236827

 - we do not handle integer overflow in commit/author timestamps
   [no reference, but something I have noticed; we should probably
   return a sentinel "0" rather than a random overflow value, and
   we should probably detect and warn in git-fsck]

 - git stash does not work when directory is replaced by a symlink to itself
   http://article.gmane.org/gmane.comp.version-control.git/236798

 - rebase not recovering gracefully from repack error
   http://article.gmane.org/gmane.comp.version-control.git/234261

 - (broken ?) output of "git diff --color-word"
   http://article.gmane.org/gmane.comp.version-control.git/237370

 - git filter-branch does not make tree replacements permanent
   http://article.gmane.org/gmane.comp.version-control.git/220931

 - 'git show' gives duplicate errors for ambiguous args
   http://article.gmane.org/gmane.comp.version-control.git/205023

 - (git commit --patch --message $MESSAGE) disallows hunk editing
   http://article.gmane.org/gmane.comp.version-control.git/208213

 - filter-branch --parent-filter in bare repository
   http://article.gmane.org/gmane.comp.version-control.git/203619

insanely hard bugs:

 - shallow clones over http
   http://article.gmane.org/gmane.comp.version-control.git/223682
