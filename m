From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/5] ls-remote: fix synopsis
Date: Mon, 18 Jan 2016 17:57:16 +0100
Message-ID: <1453136238-19448-4-git-send-email-t.gummerer@gmail.com>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Cc: peff@peff.net, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 17:57:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLD7M-0003S4-T2
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 17:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973AbcARQ5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 11:57:21 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35194 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793AbcARQ5N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 11:57:13 -0500
Received: by mail-wm0-f66.google.com with SMTP id 123so10521393wmz.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 08:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rSZ2CHWKv/A4EFwchzRLB5czyCg/AsXeqnubH2J3afU=;
        b=APchDoaLWWH/wAhDZdtnUB0xjG4nOZyynV2MDzXK3z6h05nOcMP/BaU1sHBo2eqTKa
         V9LJZ0vS5wlpB23cklGHMBwyDywv0ox6VPVpa+OTHZtw0xFkDlG9qFNGO3FFYZQgWM19
         bIBUJRlpy7LBq00ZD/CQ2kq6elU8394MrGoWX/fiBVywtCqD9taqnEd84T3zl9Ubq2Zd
         7XJCfXBeTl6A79rooEyidCyu2y+91bBeDegbKlkEV9zPIpYxmDqcprLDVIVFdX0MEPSK
         gd9x9+WyAXQryjzzeaUex9mQ+3l0x7+dy84Wv4Ykr23i209pUitXh90moFaGRVmbR+SQ
         0guw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rSZ2CHWKv/A4EFwchzRLB5czyCg/AsXeqnubH2J3afU=;
        b=GEkWNBKqIdsbj0opsqmEDsvaJMl9/itYbZcTobmCHVsytcC/D9QWfMfcFBUNN6ViPm
         cRf2cGSMjEarsZlV9qoF0vEUAOvCLiZw14fWAvGA+qxMnNrm+Ci0IBR5ey4vB9CrL3kx
         mdgIXdpBF6FFm3X5KUdbm+kGG3EZjnp3GwmXA1PZJ+RU/ZvTXflqPvnsAgj6zvsnwCeS
         RF6LrZB3l13MOwcztJBf0sP+S8rDnbAdK9/K8P9ZuYmctjkHYU9PmOUZFpdL2y1T80Zc
         7PYEL82orOBaiuLITSNKa1ke3nSedJP1in+fywTfPBff1Z1Qu6ijeoQXFS6rZgR44Xa6
         taeg==
X-Gm-Message-State: ALoCoQl9r7w5ZcsRYx9fewCN71J3H1bDjFD9vPBOsKNJdy+F+IiUWkMjwaDzNlqtkeDYVwQMxzH92xWd6tIEDs9qjcAn8PRiOQ==
X-Received: by 10.194.115.129 with SMTP id jo1mr25647564wjb.28.1453136232675;
        Mon, 18 Jan 2016 08:57:12 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id s129sm16483184wmf.18.2016.01.18.08.57.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 08:57:11 -0800 (PST)
X-Mailer: git-send-email 2.7.0.30.gd0a78e9.dirty
In-Reply-To: <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284296>

git ls-remote takes an optional get-url argument, and specifying the
repository is optional.  Fix the synopsis in the documentation to
reflect this.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-ls-remote.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 5cd47c0..f7d1091 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
-	      [-q | --quiet] [--exit-code] <repository> [<refs>...]
+	      [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]
 
 DESCRIPTION
 -----------
-- 
2.7.0.30.gd0a78e9.dirty
