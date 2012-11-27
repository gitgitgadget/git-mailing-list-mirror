From: Max Horn <max@quendi.de>
Subject: [PATCH v2 3/6] git-remote-helpers.txt: minor grammar fix
Date: Wed, 28 Nov 2012 00:03:23 +0100
Message-ID: <1354057407-83151-4-git-send-email-max@quendi.de>
References: <1354057407-83151-1-git-send-email-max@quendi.de>
Cc: Max Horn <max@quendi.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 28 00:04:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdUCU-0005AE-PA
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 00:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856Ab2K0XEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 18:04:00 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53666 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755696Ab2K0XDt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 18:03:49 -0500
Received: from ip-178-200-227-112.unitymediagroup.de ([178.200.227.112] helo=localhost.localdomain); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1TdUBt-0001yU-7L; Wed, 28 Nov 2012 00:03:45 +0100
X-Mailer: git-send-email 1.8.0.393.gcc9701d
In-Reply-To: <1354057407-83151-1-git-send-email-max@quendi.de>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1354057429;b7b0017e;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210618>


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
