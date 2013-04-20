From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/5] git-shortlog.txt: remove (-h|--help) from OPTIONS
Date: Sat, 20 Apr 2013 17:15:09 +0530
Message-ID: <1366458313-7186-2-git-send-email-artagnon@gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 20 13:45:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTWEn-0000g4-Lq
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 13:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115Ab3DTLpf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 07:45:35 -0400
Received: from mail-da0-f45.google.com ([209.85.210.45]:46653 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755032Ab3DTLpY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 07:45:24 -0400
Received: by mail-da0-f45.google.com with SMTP id v40so2353341dad.4
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jLqx15Zjn+LzLtUt68bLt5ecGQWfU9JAHaWYDe/WpTw=;
        b=FaCqYU1jbbQRbX2z2oBz8a8LauQRXCLsn5tskQ7o4gF4stXj3eVrKreUR6MNTXoZIt
         vg6YAtKRbpSFW4y99ki0R5/P4CIgiPBgzuKsYaRmhynEXYxqxUqdQT+oUkihIEs8pF8x
         1XFxn0Ksaiy7+VRvE81/eHZmX0jv3UJOBY6Rmf5DSxxFHoWznEg62M6DyAr0boxDUhYb
         MjvCMMSHmdBcPq5UI8rhuv557Ml/ff3Mcwfsb4gKciGDdo58vuL3wVK40p9tEiWY8h8S
         Rq6nIJa8ke9m1cs9GwNiVIMWCpsYjXxyLjHeOcZ+TSv0ejvPXTvhXpuNh93kBRQ5DgQ9
         pIXA==
X-Received: by 10.68.103.131 with SMTP id fw3mr23135578pbb.112.1366458323652;
        Sat, 20 Apr 2013 04:45:23 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.136])
        by mx.google.com with ESMTPS id ag4sm629048pbc.20.2013.04.20.04.45.21
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 04:45:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.506.gbce9ff0
In-Reply-To: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221849>

To be consistent with the documentation of all the other commands,
remove (-h|--help) from the OPTIONS section.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-shortlog.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c308e91..c7f7f51 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -26,10 +26,6 @@ reference to the current repository.
 OPTIONS
 -------
 
--h::
---help::
-	Print a short usage message and exit.
-
 -n::
 --numbered::
 	Sort output according to the number of commits per author instead
-- 
1.8.2.1.506.gbce9ff0
