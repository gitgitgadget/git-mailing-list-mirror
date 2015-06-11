From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 03/12] for-each-ref: change comment in ref_sort
Date: Thu, 11 Jun 2015 21:39:54 +0530
Message-ID: <1434039003-10928-3-git-send-email-karthik.188@gmail.com>
References: <5579B253.4020804@gmail.com>
 <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 11 18:10:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z353h-0006IG-Ny
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 18:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754372AbbFKQKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 12:10:20 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32821 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbbFKQKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 12:10:19 -0400
Received: by pablj1 with SMTP id lj1so2427058pab.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 09:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i9hCPlwoK6bTYjUbXS8GNQzNpsUyMiPu+Y30bQt4Igk=;
        b=VPyU6mGpilNvpPclvKnlisduFQkJD2vUDE50qWTzZJpQQQjDIW2l2VgVX5HMCJkbfQ
         AsDLZ77olOVFBIlWhHDDxgkVCoNCVS5QSypW/EPX7ra8V2CpHY+zGSl+F7FGJLUea+v8
         zHlgMITnMnJHN9W4pt3GChlkYsd90qvq8a6sCLZTZ5YgFAquhsA0F89K/J3/WhvRIyJO
         HHnugD0AooZ5JJe3rk+WTjfwzZro5hXHv2R0jvPAEoB93GypThdRuERf8mpWo4OsLjED
         AT21ZlLKF/kpHvxvIF/JaWfU12Vhq/WIya4bmjy1uLM0PfcEoLD2l3RylFphBBnp4wxE
         qP9Q==
X-Received: by 10.70.29.164 with SMTP id l4mr15912006pdh.32.1434039018881;
        Thu, 11 Jun 2015 09:10:18 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id f4sm1132981pdc.95.2015.06.11.09.10.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Jun 2015 09:10:18 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1434039003-10928-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271425>

The comment in 'ref_sort' hasn't been changed 9f613dd.
Change the comment to reflect changes made in the code since
9f613dd.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 0dd2df2..bfad03f 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -27,7 +27,7 @@ struct atom_value {
 
 struct ref_sort {
 	struct ref_sort *next;
-	int atom; /* index into used_atom array */
+	int atom; /* index into 'struct atom_value *' array */
 	unsigned reverse : 1;
 };
 
-- 
2.4.2
