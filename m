From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 1/3] Documentation: use 'keyid' consistantly, not 'key-id'
Date: Fri, 18 Sep 2015 17:01:48 +0200
Message-ID: <1442588510-7379-2-git-send-email-Matthieu.Moy@imag.fr>
References: <20150917174306.GA29171@sigill.intra.peff.net>
 <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Alastair McGowan-Douglas <altreus@altre.us>,
	Jeff King <peff@peff.net>, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 18 17:16:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcxOO-00042L-18
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 17:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530AbbIRPPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 11:15:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36098 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754731AbbIRPCD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 11:02:03 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8IF1qDp031167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 18 Sep 2015 17:01:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8IF1sk2014910;
	Fri, 18 Sep 2015 17:01:54 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZcxAg-00023Q-Q4; Fri, 18 Sep 2015 17:01:54 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
In-Reply-To: <1442588510-7379-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 18 Sep 2015 17:01:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8IF1qDp031167
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1443193314.18006@CQcQxrsxNnqNwYhCAe9DQA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278200>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-cherry-pick.txt | 4 ++--
 Documentation/git-revert.txt      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 1147c71..83b3cc2 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -101,8 +101,8 @@ effect to your index in a row.
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
 
--S[<key-id>]::
---gpg-sign[=<key-id>]::
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
 	GPG-sign commits.
 
 --ff::
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index cceb5f2..6388089 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -80,8 +80,8 @@ more details.
 This is useful when reverting more than one commits'
 effect to your index in a row.
 
--S[<key-id>]::
---gpg-sign[=<key-id>]::
+-S[<keyid>]::
+--gpg-sign[=<keyid>]::
 	GPG-sign commits.
 
 -s::
-- 
2.5.0.402.g8854c44
