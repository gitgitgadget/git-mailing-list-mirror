From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] RelNotes/1.8.5: direct script writers to "git status --porcelain"
Date: Thu, 26 Sep 2013 20:33:40 +0200
Message-ID: <1380220420-27064-1-git-send-email-Matthieu.Moy@imag.fr>
References: <loom.20130926T201754-563@post.gmane.org>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 27 10:25:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPTN1-0001ND-Fv
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 10:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409Ab3I0IZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 04:25:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39751 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813Ab3I0IZq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 04:25:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r8R8Pd5f016806
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 27 Sep 2013 10:25:39 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1VPTMp-0004M7-Vv; Fri, 27 Sep 2013 10:25:40 +0200
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1VPTMp-0007p8-M1; Fri, 27 Sep 2013 10:25:39 +0200
X-Mailer: git-send-email 1.8.4.474.g128a96c
In-Reply-To: <loom.20130926T201754-563@post.gmane.org>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 27 Sep 2013 10:25:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r8R8Pd5f016806
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1380875141.11064@0MGzjw22p05jv5zOo7UZvg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235445>

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Jakub Narebski <jnareb@gmail.com> writes:

> Perhaps "to use instead ..." would be easier to understand than
> proposed "to use ..., instead." (with "..." being one line long).

Actually, I had the version below staged, but forgot to "commit
--amend" before sending. Should be clear enough.

 Documentation/RelNotes/1.8.5.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/RelNotes/1.8.5.txt b/Documentation/RelNotes/1.8.5.txt
index ac5c3fa..e295266 100644
--- a/Documentation/RelNotes/1.8.5.txt
+++ b/Documentation/RelNotes/1.8.5.txt
@@ -96,6 +96,9 @@ UI, Workflows & Features
 
  * "git status" now omits the prefix to make its output a comment in a
    commit log editor, which is not necessary for human consumption.
+   Scripts that parse the output of "git status" are advised to use
+   "git status --porcelain" instead. Its format is both easier to
+   parse and stable.
 
  * Make "foo^{tag}" to peel a tag to itself, i.e. no-op., and fail if
    "foo" is not a tag.  "git rev-parse --verify v1.0^{tag}" would be
-- 
1.8.4.474.g128a96c
