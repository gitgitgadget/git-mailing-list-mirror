From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/2] git-rev-list.txt: make ascii markup uniform with other pages.
Date: Tue,  7 Apr 2009 19:24:33 +0200
Message-ID: <1239125073-4422-2-git-send-email-Matthieu.Moy@imag.fr>
References: <vpqvdpg8knl.fsf@bauges.imag.fr>
 <1239125073-4422-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 19:31:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrF8S-0008O2-Jl
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 19:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759138AbZDGR3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 13:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759189AbZDGR3Y
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 13:29:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:55745 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759001AbZDGR3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 13:29:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n37HOpt7010597
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 7 Apr 2009 19:24:51 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LrF2X-0007DR-UE; Tue, 07 Apr 2009 19:24:49 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LrF2X-00019w-Rt; Tue, 07 Apr 2009 19:24:49 +0200
X-Mailer: git-send-email 1.6.2.2.449.g92961.dirty
In-Reply-To: <1239125073-4422-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 07 Apr 2009 19:24:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115968>

Other pages use --option=<argument>, not --option='argument', do the
same here.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/rev-list-options.txt |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 7dd237c..11eec94 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -140,38 +140,38 @@ limiting may be applied.
 --
 
 -n 'number'::
---max-count='number'::
+--max-count=<number>::
 
 	Limit the number of commits output.
 
---skip='number'::
+--skip=<number>::
 
 	Skip 'number' commits before starting to show the commit output.
 
---since='date'::
---after='date'::
+--since=<date>::
+--after=<date>::
 
 	Show commits more recent than a specific date.
 
---until='date'::
---before='date'::
+--until=<date>::
+--before=<date>::
 
 	Show commits older than a specific date.
 
 ifdef::git-rev-list[]
---max-age='timestamp'::
---min-age='timestamp'::
+--max-age=<timestamp>::
+--min-age=<timestamp>::
 
 	Limit the commits output to specified time range.
 endif::git-rev-list[]
 
---author='pattern'::
---committer='pattern'::
+--author=<pattern>::
+--committer=<pattern>::
 
 	Limit the commits output to ones with author/committer
 	header lines that match the specified pattern (regular expression).
 
---grep='pattern'::
+--grep=<pattern>::
 
 	Limit the commits output to ones with log message that
 	matches the specified pattern (regular expression).
-- 
1.6.2.2.449.g92961.dirty
