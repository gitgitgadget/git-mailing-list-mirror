From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/9] Documentation/git-commit.txt: describe --dry-run
Date: Sat, 15 Aug 2009 15:39:49 -0700
Message-ID: <1250375997-10657-2-git-send-email-gitster@pobox.com>
References: <1250375997-10657-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 00:40:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McRv3-0003Yf-Ra
	for gcvg-git-2@gmane.org; Sun, 16 Aug 2009 00:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbZHOWkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 18:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZHOWkF
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 18:40:05 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48743 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbZHOWkD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 18:40:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C415F2AA84
	for <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 40E7E2AA83 for
 <git@vger.kernel.org>; Sat, 15 Aug 2009 18:40:02 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.227.g1d720
In-Reply-To: <1250375997-10657-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 92E5656C-89EC-11DE-9724-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126034>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Unchanged since the last round.

 Documentation/git-commit.txt |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d01ff5a..64f94cf 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dry-run]
-	   [(-c | -C) <commit>] [-F <file> | -m <msg>]
+	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--dry-run]
 	   [--allow-empty] [--no-verify] [-e] [--author=<author>]
 	   [--cleanup=<mode>] [--] [[-i | -o ]<file>...]
 
@@ -42,10 +42,9 @@ The content to be added can be specified in several ways:
    by one which files should be part of the commit, before finalizing the
    operation.  Currently, this is done by invoking 'git-add --interactive'.
 
-The 'git-status' command can be used to obtain a
+The `--dry-run` option can be used to obtain a
 summary of what is included by any of the above for the next
-commit by giving the same set of parameters you would give to
-this command.
+commit by giving the same set of parameters (options and paths).
 
 If you make a commit and then find a mistake immediately after
 that, you can recover from it with 'git-reset'.
@@ -70,6 +69,12 @@ OPTIONS
 	Like '-C', but with '-c' the editor is invoked, so that
 	the user can further edit the commit message.
 
+--dry-run::
+	Do not actually make a commit, but show the list of paths
+	with updates in the index, paths with changes in the work tree,
+	and paths that are untracked, similar to the one that is given
+	in the commit log editor.
+
 -F <file>::
 --file=<file>::
 	Take the commit message from the given file.  Use '-' to
-- 
1.6.4.224.g3be84
