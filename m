From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsimport: document -S and -L options
Date: Mon,  8 Jan 2007 19:53:03 +1300
Message-ID: <11682391832099-git-send-email-martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Jan 08 07:53:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3oNQ-0004il-SS
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 07:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbXAHGw6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 01:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbXAHGw6
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 01:52:58 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:42803 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbXAHGw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 01:52:57 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1H3oNM-0007tV-LN; Mon, 08 Jan 2007 19:52:56 +1300
Received: from martin by mltest with local (Exim 3.36 #1 (Debian))
	id 1H3oNT-00064s-00; Mon, 08 Jan 2007 19:53:03 +1300
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: git-send-email 1.5.0.rc0.g4017-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36239>


Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>
---
I was surprised to find that I seem to have added those myself.
So, correct the bad manners of not documenting them earlier.

---
 Documentation/git-cvsimport.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 6deee94..7c0e6b9 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -104,6 +104,14 @@ If you need to pass multiple options, separate them with a comma.
 -a::
 	Import all commits, including recent ones. cvsimport by default
 	skips commits that have a timestamp less than 10 minutes ago.
+
+-S <regex>::
+	Skip paths matching the regex.
+
+-L <limit>::
+	Limit the number of commits imported. Workaround for cases where
+	cvsimport leaks memory. 
+
 +
 ---------
 	exon=Andreas Ericsson <ae@op5.se>
-- 
1.5.0.rc0.g4017-dirty
