From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation: quote braces in {upstream} notation
Date: Wed, 10 Feb 2010 17:30:29 +0100
Message-ID: <a91746a91d0ad0b38a4e49f1f79a056a2d3eac69.1265819421.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 17:31:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfFSt-0005m7-JT
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 17:31:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423Ab0BJQay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 11:30:54 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:28989 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754806Ab0BJQax (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 11:30:53 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Feb
 2010 17:30:51 +0100
Received: from localhost.localdomain (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 10 Feb
 2010 17:30:29 +0100
X-Mailer: git-send-email 1.7.0.rc2.178.g109e1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139515>

The lack of quoting made the entire line disappear.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rev-parse.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index fc73152..d677c72 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -244,7 +244,7 @@ when you run 'git merge'.
 * The special construct '@\{-<n>\}' means the <n>th branch checked out
   before the current one.
 
-* The suffix '@{upstream}' to a ref (short form 'ref@{u}') refers to
+* The suffix '@\{upstream\}' to a ref (short form 'ref@\{u\}') refers to
   the branch the ref is set to build on top of.  Missing ref defaults
   to the current branch.
 
-- 
1.7.0.rc2.178.g109e1
