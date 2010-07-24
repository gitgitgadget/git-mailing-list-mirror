From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] Document receive.denyDeleteCurrent
Date: Sat, 24 Jul 2010 18:03:14 +0200
Message-ID: <ab7b73ce593846b083bf0f4c4c7de08fb6008a5e.1279986834.git.trast@student.ethz.ch>
References: <20100724011752.GA3333@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, bill lam <cbill.lam@gmail.com>,
	<Eric@cybersprocket.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 24 18:03:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OchCR-0006AY-9u
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 18:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755082Ab0GXQDh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 12:03:37 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:7318 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754594Ab0GXQDh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 12:03:37 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 24 Jul
 2010 18:03:35 +0200
Received: from localhost.localdomain (217.162.250.31) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Sat, 24 Jul
 2010 18:03:14 +0200
X-Mailer: git-send-email 1.7.2.278.g76edd.dirty
In-Reply-To: <20100724011752.GA3333@debian.b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151658>

This option was introduced by 747ca24 (receive-pack:
receive.denyDeleteCurrent, 2009-02-08) but never documented.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
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
+	If set to true, git-receive,pack will deny a ref update that
+	deletes the currently checked out branch of a non-bare repository.
+
 receive.denyCurrentBranch::
 	If set to true or "refuse", git-receive-pack will deny a ref update
 	to the currently checked out branch of a non-bare repository.
-- 
1.7.2.278.g76edd.dirty
