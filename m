From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCHv2 3/8] Doc: Improve shallow depth wording
Date: Wed, 19 Sep 2012 00:25:29 +0100
Message-ID: <1348010734-664-4-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:25:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE7A3-0005Bj-K3
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 01:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594Ab2IRXYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 19:24:49 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:24050 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752043Ab2IRXYq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 19:24:46 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgUFAMwBWVBZ8rU+/2dsb2JhbABFhSC3IYEJgn07gQIkE4gEmQmhTpILA6YEgmc
X-IronPort-AV: E=Sophos;i="4.80,445,1344207600"; 
   d="scan'208";a="47757874"
Received: from host-89-242-181-62.as13285.net (HELO localhost) ([89.242.181.62])
  by out1.ip07ir2.opaltelecom.net with ESMTP; 19 Sep 2012 00:24:44 +0100
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205891>

Avoid confusion in compound sentence about the start of the commit set
and the depth measure. Use two sentences.

Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 49cdc57..d51e20f 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -259,8 +259,10 @@ a positive depth, this step is skipped.
 ----
 
 If the client has requested a positive depth, the server will compute
-the set of commits which are no deeper than the desired depth, starting
-at the client's wants. The server writes 'shallow' lines for each
+the set of commits which are no deeper than the desired depth. The set
+of commits start at the client's wants.
+
+The server writes 'shallow' lines for each
 commit whose parents will not be sent as a result. The server writes
 an 'unshallow' line for each commit which the client has indicated is
 shallow, but is no longer shallow at the currently requested depth
-- 
1.7.8.msysgit.0
