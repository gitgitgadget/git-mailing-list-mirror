From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 26/28] git-clone.txt: remove shallow clone limitations
Date: Mon, 25 Nov 2013 10:55:52 +0700
Message-ID: <1385351754-9954-27-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:54:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknFV-0002Ps-Di
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab3KYDyE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:54:04 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:41239 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab3KYDyC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:54:02 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so4838240pbb.28
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3K99sbrFi0x4Ns2z21364k96COwym+cW6V0eHmGo26Y=;
        b=rVw9wtZirVR6cjXNdLz0KbvrfDkFM4V7G7LfiNkxV3txFiJP5lTA/Odz9aqp0+QOzX
         KFfTbqupE3qMM7KEokjjaw8o2y8/iqib4XRqxYWcQitaML54gQhmR7zZtDPQgdyvdNPq
         jQ/i4Wf5T8D+yDqZNW2rmM45dm6p7SXX5wZ2qOtPWou9hDtbUOlcRpD3qbQCtBoZQ1SL
         eB9sMJwKXhfliQjr/D3a/NR6ep/43iTIQnFbDZ/BONmVsrtISboxrrY7Ktyabi5LpFU2
         s2xQS5em/BquxY8cyt3c3yPC/EOJgiD4MtzsOUtsJ6ylPTXnl5h8l1udOizNJpGv7cE+
         vZiQ==
X-Received: by 10.68.6.66 with SMTP id y2mr15847895pby.60.1385351641621;
        Sun, 24 Nov 2013 19:54:01 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id xv2sm69704963pbb.39.2013.11.24.19.53.58
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:54:00 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:58:34 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238298>

Now that git supports push/pull from/to a shallow clone, these
limitations are not true anymore.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 450f158..4987857 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -181,12 +181,7 @@ objects from the source repository into a pack in =
the cloned repository.
=20
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-	specified number of revisions.  A shallow repository has a
-	number of limitations (you cannot clone or fetch from
-	it, nor push from nor into it), but is adequate if you
-	are only interested in the recent history of a large project
-	with a long history, and would want to send in fixes
-	as patches.
+	specified number of revisions.
=20
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
--=20
1.8.2.83.gc99314b
