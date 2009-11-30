From: "Bernhard R. Link" <brlink@debian.org>
Subject: [PATCH 3/7] format-patch defaults to --first-equal-tree-only
Date: Mon, 30 Nov 2009 15:44:34 +0100
Message-ID: <42502278366cca0d87980e538fa2e1a587d7e525.1259524136.git.brlink@debian.org>
References: <cover.1259524136.git.brlink@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 15:44:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF7UW-00077E-OQ
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 15:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641AbZK3Oo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 09:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbZK3Oo3
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 09:44:29 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:33531
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752542AbZK3Oo2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 09:44:28 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7UR-00011j-18
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:44:35 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1NF7UQ-0000r0-VZ
	for git@vger.kernel.org; Mon, 30 Nov 2009 15:44:34 +0100
Content-Disposition: inline
In-Reply-To: <cover.1259524136.git.brlink@debian.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134106>

TODO: manpage update to hint to --all-equal-trees?
---
 builtin-log.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 33fa6ea..a3a2d3f 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -960,6 +960,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
+	rev.first_equal_tree_only = 1;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
