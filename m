From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] Documentation/SubmittingPatches: unify whitespace/tabs for the DCO
Date: Wed, 17 Dec 2014 17:08:15 -0800
Message-ID: <1418864895-18583-3-git-send-email-sbeller@google.com>
References: <xmqq1tnx961q.fsf@gitster.dls.corp.google.com>
 <1418864895-18583-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 02:08:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1Pa8-0003pd-5t
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 02:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbaLRBIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 20:08:36 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:51559 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201AbaLRBIa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 20:08:30 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so82619iga.9
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 17:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K7qCnLo6/Yhz1ba5VrPb4Lcyk+sDEd2YhbhODDptaL8=;
        b=Pq8meinuonQnSMISXEMKBhbbiNEelzyTg9QV2CjOrn3fra5nnI+KoAq5Xip7m7RoY/
         tlR6jgv2yOkb71lH08ppNvrizCoo0KXgMKYD5cVYTwYFB3lmTEsmSreKXho6cWBKlgv8
         1ofz5wLmTjLz6nn/ISPBpqYqEaRhIJ8sW6ryOCrKdoyJ2G9uOPYI5//8r2J3KiIU+0aN
         ZlJ3BL38IE+7miywGF5KQRD0lQoRWyFtzGHdQBNDwyHqiudD9R6SQ1JS8aP6PCQO8c3Y
         lYaKVDUxxuGSGM7VuAnBewDEHB1XF7YqahnC28S6nkLhQaUIglk28E8LmzQQYbkhvjVX
         M/Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K7qCnLo6/Yhz1ba5VrPb4Lcyk+sDEd2YhbhODDptaL8=;
        b=GIstWaNtEiQAWX9k3D1DYSOCht98nZTiTSsMUVZpTpXoKxaI0wVikWghl6XRZG2SQv
         ZTiuxyQIbVPV2Ih42HrsnQIyhAfD786TUSWsw1MRXYt6uNfYCtXvMMnO9G6JQReKBZll
         Ps5RwSuehWWH396I8MtqMBSSecQVUeK/RieHyxF6q60ULyr1tqYErSwgIYw8weiNVmhS
         8wMB37F8tZNuc7CsvptbFi3LEQrY2ZiQ26wwt7LZ0ivIw3pfRi9pqK+7NDou2ysCTPz0
         hiZFe3pOZ4LuTMvLRhgAuqrLJm5xFQYE8qid6eCnemic9k8c5lbBq56Y5WBPW02OP/Ne
         MJGw==
X-Gm-Message-State: ALoCoQmCbvkdJXYrI6dXo/uMhCBT/P6sRGzNQ6ajBHAbtG9dKzXqFE5+KLQzVNiz7G2VxJZ100up
X-Received: by 10.107.33.21 with SMTP id h21mr4166083ioh.37.1418864910223;
        Wed, 17 Dec 2014 17:08:30 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9f5:d31a:4ba2:b65d])
        by mx.google.com with ESMTPSA id g5sm2549299iod.25.2014.12.17.17.08.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Dec 2014 17:08:29 -0800 (PST)
X-Mailer: git-send-email 2.2.0.31.gad78000.dirty
In-Reply-To: <1418864895-18583-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261515>

The Developers Certificate of Origin has a mixture of tabs and white
spaces which is annoying to view if your editor explicitly views white
space characters.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    I'll also try to send it upstream to linux.

 Documentation/SubmittingPatches | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 16b5d65..6124f34 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -258,15 +258,15 @@ pretty simple: if you can certify the below:
             person who certified (a), (b) or (c) and I have not modified
             it.
 
-	(d) I understand and agree that this project and the contribution
-	    are public and that a record of the contribution (including all
-	    personal information I submit with it, including my sign-off) is
-	    maintained indefinitely and may be redistributed consistent with
-	    this project or the open source license(s) involved.
+        (d) I understand and agree that this project and the contribution
+            are public and that a record of the contribution (including all
+            personal information I submit with it, including my sign-off) is
+            maintained indefinitely and may be redistributed consistent with
+            this project or the open source license(s) involved.
 
 then you just add a line saying
 
-	Signed-off-by: Random J Developer <random@developer.example.org>
+        Signed-off-by: Random J Developer <random@developer.example.org>
 
 This line can be automatically added by Git if you run the git-commit
 command with the -s option.
-- 
2.2.0.31.gad78000.dirty
