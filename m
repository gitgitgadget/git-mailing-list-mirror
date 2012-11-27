From: Max Horn <max@quendi.de>
Subject: [PATCH 3/6] Fix grammar
Date: Tue, 27 Nov 2012 18:44:36 +0100
Message-ID: <1354038279-76475-4-git-send-email-max@quendi.de>
References: <1354038279-76475-1-git-send-email-max@quendi.de>
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 18:45:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdPE1-0003a2-Kv
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756685Ab2K0RpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:45:04 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:45265 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756639Ab2K0RpC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 12:45:02 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=localhost.localdomain); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1TdPDO-00080S-Ny; Tue, 27 Nov 2012 18:44:58 +0100
X-Mailer: git-send-email 1.8.0.393.gcc9701d
In-Reply-To: <1354038279-76475-1-git-send-email-max@quendi.de>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354038302;a61156d0;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210575>


Signed-off-by: Max Horn <max@quendi.de>
---
 Documentation/git-remote-helpers.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index db63541..7eb43d7 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -235,9 +235,9 @@ Commands are given by the caller on the helper's standard input, one per line.
 'capabilities'::
 	Lists the capabilities of the helper, one per line, ending
 	with a blank line. Each capability may be preceded with '*',
-	which marks them mandatory for git version using the remote
-	helper to understand (unknown mandatory capability is fatal
-	error).
+	which marks them mandatory for git versions using the remote
+	helper to understand. Any unknown mandatory capability is a
+	fatal error.
 
 'list'::
 	Lists the refs, one per line, in the format "<value> <name>
-- 
1.8.0.393.gcc9701d
