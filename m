From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] Documentation/git-clean: fix description for range
Date: Wed, 24 Jul 2013 06:22:43 +0800
Message-ID: <8d333586a314b8c108a01dbf9b76764b51f0a5a5.1374618147.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 00:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1l8t-0004MD-8E
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 00:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935019Ab3GWWdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 18:33:07 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:49553 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934882Ab3GWWdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 18:33:04 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so8662591pdj.17
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=vyijrwlQzBtOtAnpOpu0n7TfdXsvrQWZAkQEV4IZD2A=;
        b=vl4cPXTyHCTSJEC+gk0FRTtuuXiv7/HA9mTdUbH5q/pReMi/dUIt89r7f7RGJp0wtM
         RwCWZid0xNOhAYqQ90gbo+CxcPIEEdT1wjYGCIqXL1PFYi09DbVzB9kfAmOBdjzrRtgZ
         7EmHQnh4fFkWPVyYbg2AyTdHaVFwY+h+7SVl98Z/HOoRbWFGp47AKucqMMjPZ6Bv9AlG
         CqsBE/bHZIxruAnnrVQqSLu8A5iLsr5eMbexclQc3AODb9dWJMQlIaaWbqijdZcXrx3J
         Ot/U/3oNYGdgihfisGaWmOSP1CcnPGOmrfibZvKkFkzYtXL94d8go4YeQ+5LosaDpi7j
         ePPA==
X-Received: by 10.68.242.105 with SMTP id wp9mr38823208pbc.153.1374618784125;
        Tue, 23 Jul 2013 15:33:04 -0700 (PDT)
Received: from localhost.localdomain ([114.246.130.173])
        by mx.google.com with ESMTPSA id e7sm30734131pbc.11.2013.07.23.15.33.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 15:33:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.1052.g3a6d627
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231067>

The descriptions of "select by numbers" section for interactive
git-clean are borrowed from git-add, and one sentence should be
replaced.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 Documentation/git-clean.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 75fb543..8997922 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -111,7 +111,7 @@ select by numbers::
    '>>' like this, you can make more than one selection, concatenated
    with whitespace or comma.  Also you can say ranges.  E.g. "2-5 7,9"
    to choose 2,3,4,5,7,9 from the list.  If the second number in a
-   range is omitted, all remaining patches are taken.  E.g. "7-" to
+   range is omitted, all remaining items are selected.  E.g. "7-" to
    choose 7,8,9 from the list.  You can say '*' to choose everything.
    Also when you are satisfied with the filtered result, press ENTER
    (empty) back to the main menu.
-- 
1.8.3.2.1052.g3a6d627
