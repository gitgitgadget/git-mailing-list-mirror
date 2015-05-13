From: Jeff King <peff@peff.net>
Subject: [PATCH 1/8] doc: fix misrendering due to `single quote'
Date: Wed, 13 May 2015 00:57:54 -0400
Message-ID: <20150513045754.GA6821@peff.net>
References: <20150513045650.GA6070@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 06:58:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOk5-0007P1-GN
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 06:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbbEME55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 00:57:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:57595 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751733AbbEME54 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 00:57:56 -0400
Received: (qmail 1794 invoked by uid 102); 13 May 2015 04:57:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 12 May 2015 23:57:57 -0500
Received: (qmail 6884 invoked by uid 107); 13 May 2015 04:57:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 May 2015 00:57:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 May 2015 00:57:54 -0400
Content-Disposition: inline
In-Reply-To: <20150513045650.GA6070@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268927>

AsciiDoc misparses some text that contains a `literal`
word followed by a fancy `single quote' word, and treats
everything from the start of the literal to the end of the
quote as a single-quoted phrase.

We can work around this by switching the latter to be a
literal, as well. In the first case, this is perhaps what
was intended anyway, as it makes us consistent with the the
earlier literals in the same paragraph. In the second, the
output is arguably better, as we will format our commit
references as <code> blocks.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/diff-generate-patch.txt | 2 +-
 Documentation/git-rebase.txt          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 843a20b..bcf54da 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -77,7 +77,7 @@ combined diff format
 Any diff-generating command can take the `-c` or `--cc` option to
 produce a 'combined diff' when showing a merge. This is the default
 format when showing merges with linkgit:git-diff[1] or
-linkgit:git-show[1]. Note also that you can give the `-m' option to any
+linkgit:git-show[1]. Note also that you can give the `-m` option to any
 of these commands to force generation of diffs with individual parents
 of a merge.
 
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 47984e8..1d01baa 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -80,7 +80,7 @@ remain the checked-out branch.
 If the upstream branch already contains a change you have made (e.g.,
 because you mailed a patch which was applied upstream), then that commit
 will be skipped. For example, running `git rebase master` on the
-following history (in which A' and A introduce the same set of changes,
+following history (in which `A'` and `A` introduce the same set of changes,
 but have different committer information):
 
 ------------
-- 
2.4.0.192.g5f8138b
