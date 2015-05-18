From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 2/2] Documentation/log: clarify sha1 non-abbreviation in log --raw
Date: Mon, 18 May 2015 19:55:58 +0200
Message-ID: <1431971758-979-2-git-send-email-Matthieu.Moy@imag.fr>
References: <xmqqtwvdhhb2.fsf@gitster.dls.corp.google.com>
 <1431971758-979-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 18 19:56:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuPGw-0005vv-37
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 19:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbbERR4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 13:56:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56845 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900AbbERR4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 13:56:05 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4IHtxBl010118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 May 2015 19:55:59 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4IHu1hn001204;
	Mon, 18 May 2015 19:56:01 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1YuPGi-0000KN-Sm; Mon, 18 May 2015 19:56:00 +0200
X-Mailer: git-send-email 2.3.5.2.ge515092.dirty
In-Reply-To: <1431971758-979-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 18 May 2015 19:55:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4IHtxBl010118
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1432576559.22687@f12aHitr2AyFRpGj15igkQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269286>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This patch is new.

 Documentation/pretty-formats.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index dcf7429..c434ecc 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -79,7 +79,10 @@ stored in the commit object.  Notably, the SHA-1s are
 displayed in full, regardless of whether --abbrev or
 --no-abbrev are used, and 'parents' information show the
 true parent commits, without taking grafts or history
-simplification into account.
+simplification into account. Note that this format affects the way
+commits are displayed, but not the way the diff is shown e.g. with
+`git log --raw`. To get unabbreviated commits in a raw diff format,
+use `--no-abbrev`.
 
 * 'format:<string>'
 +
-- 
2.3.5.2.ge515092.dirty
