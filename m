From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/17] fixup! pack v4: move packv4-create.c to libgit.a
Date: Sat, 21 Sep 2013 20:57:52 +0700
Message-ID: <1379771883-10278-7-git-send-email-pclouds@gmail.com>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 21 15:55:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNNeg-0000Pe-Kk
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 15:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391Ab3IUNzV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Sep 2013 09:55:21 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:64895 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329Ab3IUNzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 09:55:17 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so1821467pab.15
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xTxoUz/nddp2YrDXnkqYb9CuR45MLy9BUbI6ABx7iJo=;
        b=NWOSCpt8HiqANzInYqFEmfeViQcYBk/TGV+8tVrTxt+P/mTIJD+Jvx0V/vBsRug8W3
         As6K+UYS78cTvIpy+QFUgqG5qM6jSPdvFJcEyWsN+GpbRB+2BFuGh5Ets32zl3KKuO9X
         HcqOwjHwPfDtj7fZA+qjmOhHVSZgHZcKU7HcJ9tP+Ac3yMG0Ddp4ixNCTHKvTCQBJEbG
         Z7A+JVx9SGVbIQGt7JiC6S2tl+3o6MbHC7cZWWETqTpIVvoGed3H0hrPsiyU9wf7ajac
         aB/eG9vIW+mlUiKOP7VleP+Nz81YEA1nhm/E/dTfASxpqWrcpo5V36WZCYathTJzEvAk
         fOXw==
X-Received: by 10.66.234.193 with SMTP id ug1mr14627199pac.92.1379771716788;
        Sat, 21 Sep 2013 06:55:16 -0700 (PDT)
Received: from lanh ([115.73.252.65])
        by mx.google.com with ESMTPSA id hx1sm22149628pbb.35.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 21 Sep 2013 06:55:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 21 Sep 2013 20:58:39 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235107>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 6b1fd1b..2e2ae2b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -190,6 +190,7 @@
 /test-match-trees
 /test-mergesort
 /test-mktemp
+/test-packv4
 /test-parse-options
 /test-path-utils
 /test-prio-queue
--=20
1.8.2.83.gc99314b
