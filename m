From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Suggest applicants to participate in review of other peoples' patches
Date: Fri,  6 Mar 2015 12:53:57 +0100
Message-ID: <1425642837-31651-1-git-send-email-Matthieu.Moy@imag.fr>
References: <CAPc5daV7Dv8K8itmQhdf1CG-opMVw7DYyheHdcdL0r_9zFQR-Q@mail.gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 06 12:54:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTqpi-00009Z-IJ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 12:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbbCFLyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 06:54:17 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55771 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbbCFLyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 06:54:16 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t26BrxjA023025
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Mar 2015 12:53:59 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t26Bs1rq021349;
	Fri, 6 Mar 2015 12:54:01 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YTqpN-0008I1-4k; Fri, 06 Mar 2015 12:54:01 +0100
X-Mailer: git-send-email 2.3.0.157.g79e124b
In-Reply-To: <CAPc5daV7Dv8K8itmQhdf1CG-opMVw7DYyheHdcdL0r_9zFQR-Q@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 Mar 2015 12:54:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t26BrxjA023025
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1426247641.87053@n8WlyIkTzznbzQC2qUyjZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264916>

Idea and most of the wording comes from Junio's message on the list. I
added a hint to include links to review in the application (which makes
the suggestion a bit stronger since it implies that it will be taken into
account in the selection).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> What do mentors and others think?

Very good idea indeed.

 SoC-2015-Ideas.md | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/SoC-2015-Ideas.md b/SoC-2015-Ideas.md
index 0ccbcdc..ba8b25e 100644
--- a/SoC-2015-Ideas.md
+++ b/SoC-2015-Ideas.md
@@ -16,9 +16,22 @@ way for us to get experience with applicants, but it will also help
 applicants become familiar with Git's development and submission
 process.
 
+Also, working in Git project is not only about writing your own
+patches. Constructively critiquing design and implementation of
+patches by other people is also an important skill you need to learn
+in order to effectively collaborate with others. So, if you have time
+and inclination, it would be beneficial to read and understand other
+applicants' patches (or any other patch submitted to the mailing-list),
+think if you agree that the problem they are trying to solve is worth
+solving, the approach they are taking is the best way (or if you think
+of a better way to solve it), etc., and respond to their patches with
+the result of your thinking as a review.
+
 Please, include link(s) to the mailing-list discussion(s) related to
 your microproject in your application (e.g. linking to
-[gmane](http://news.gmane.org/gmane.comp.version-control.git)).
+[gmane](http://news.gmane.org/gmane.comp.version-control.git)). If you
+participate in the review of other patches, then you may also include
+links to discussions that would support your application.
 
 ## Note about the number of slots
 
-- 
2.3.0.157.g79e124b
