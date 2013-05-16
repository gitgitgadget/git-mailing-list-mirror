From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v4 07/15] Documentation: avoid "uninteresting"
Date: Thu, 16 May 2013 18:32:33 +0300
Message-ID: <1368718361-27859-8-git-send-email-kevin@bracey.fi>
References: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 16 17:40:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0Hn-00012I-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab3EPPjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:39:49 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:50322 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752775Ab3EPPjk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:39:40 -0400
Received: from mail92.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 6986910540DE
	for <git@vger.kernel.org>; Thu, 16 May 2013 17:33:10 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 May 2013 17:33:10 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 16 May 2013 17:33:07 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368718361-27859-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18172587447881142501
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -58
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.500072/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -58
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrkeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224586>

The documentation of --boundary uses the term "uninteresting", which is
not used or defined anywhere else in the documentation. This is
unhelpful and confusing to anyone who hasn't seen the UNINTERESTING
flag in the source code.

Change to use "excluded", as per revisions.txt.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 Documentation/rev-list-options.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 50bbff7..55ddf33 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -271,8 +271,8 @@ See also linkgit:git-reflog[1].
 
 --boundary::
 
-	Output uninteresting commits at the boundary, which are usually
-	not shown.
+	Output excluded boundary commits. Boundary commits are
+	prefixed with `-`.
 
 --
 
-- 
1.8.3.rc0.28.g4b02ef5
