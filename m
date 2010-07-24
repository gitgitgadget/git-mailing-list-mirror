From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v1.1 1/2] Document receive.denyDeleteCurrent
Date: Sat, 24 Jul 2010 18:07:53 +0200
Message-ID: <ab7b73ce593846b083bf0f4c4c7de08fb6008a5e.1279987608.git.trast@student.ethz.ch>
References: <ab7b73ce593846b083bf0f4c4c7de08fb6008a5e.1279986834.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, bill lam <cbill.lam@gmail.com>,
	<Eric@cybersprocket.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 24 18:08:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OchGZ-0000Jb-It
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 18:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779Ab0GXQHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 12:07:54 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:47562 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755391Ab0GXQHx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 12:07:53 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 24 Jul
 2010 18:07:52 +0200
Received: from localhost.localdomain (217.162.250.31) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sat, 24 Jul
 2010 18:07:52 +0200
X-Mailer: git-send-email 1.7.2.278.g76edd.dirty
In-Reply-To: <ab7b73ce593846b083bf0f4c4c7de08fb6008a5e.1279986834.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151660>

This option was introduced by 747ca24 (receive-pack:
receive.denyDeleteCurrent, 2009-02-08) but never documented.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Argh, there was a typo ("receive,pack") in the first version.  Why do
I only notice them on the 4th reading.  Sorry for the noise.

 Documentation/config.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e75434b..fdb90c0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1558,6 +1558,10 @@ receive.denyDeletes::
 	If set to true, git-receive-pack will deny a ref update that deletes
 	the ref. Use this to prevent such a ref deletion via a push.
 
+receive.denyDeleteCurrent::
+	If set to true, git-receive-pack will deny a ref update that
+	deletes the currently checked out branch of a non-bare repository.
+
 receive.denyCurrentBranch::
 	If set to true or "refuse", git-receive-pack will deny a ref update
 	to the currently checked out branch of a non-bare repository.
-- 
1.7.2.278.g76edd.dirty
