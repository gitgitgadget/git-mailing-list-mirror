From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/22] wrapper.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:42:13 +0700
Message-ID: <1456555333-5853-23-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:44:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYc3-00044q-RZ
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129AbcB0GoU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:44:20 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33895 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105AbcB0GoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:44:19 -0500
Received: by mail-pf0-f173.google.com with SMTP id x65so63901014pfb.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMxpQLE/Q8eLWFYEIx0sWiitilaUgWUmsU2BeyKsaYc=;
        b=V63ueqXMQciKslo0REzKAS1FLwN+t+c48QQzjPsXhWJkh3+h+BLSa2eLbMPSHnzorr
         q3Xpgz/A8BZAb+iA5l8DYWf6WtPtsiWAJYfo2jYEC/Kt3+l7XswddqUtEsn+HBiCu9RV
         GM1uzz7w4Fvqu5D+sOLnUOEuOXupDLqnarvsh1Xf2V28SP6mudDHeCYDSBUoytVV1Vzj
         X+yJe5jU2I4pYNWLApRNdpVq5RfwZbiTz288W8BuhLezHJ55jz+bZaa372qdi+iEYv0Y
         o48Ms60LMtHLKxVbJMQalsaWaXQpCuv39Mn21EpSINq0+MARlT/pAwCioAZ8wmG6fyTL
         OYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMxpQLE/Q8eLWFYEIx0sWiitilaUgWUmsU2BeyKsaYc=;
        b=Zm0J8xbnoWFbp+12efOtZHl5/fxXI0X4f3oYZH1kKINlnRZagaXSUw6d1SK5Gpd8zK
         Mj6LMUIX20s4N+1+nkEKvtQc2D1P2yU81coPVCl3DUc3yuwYMiYl8e57lkhk7crihunO
         ljisVDq7m0+e75qhHXhAMdTdwY4UEckwQGLEu4I8DC4hU4cKkpoZoCKyIeX4tYkvOr+X
         oSHuBdWjxLcGuVm6w11Y0ame81oHKHOLiEv5HC+o+7HNrNEnmXue7Uus44GXYSQd4Cus
         gKMhnQuc/MEiHg6f3D5kyhhHAMzjK7xIZsg9E/Mm1ivzww6f7GzBaBHYhbxJ+qKHr+xB
         +Azw==
X-Gm-Message-State: AD7BkJKJdLP4I99yBEVGy0FRB2xFCBRtdyzWZt6l5Y+pTa2HjPcdnnLNPqEJT+1wRwIYuw==
X-Received: by 10.98.80.80 with SMTP id e77mr7641112pfb.126.1456555459152;
        Fri, 26 Feb 2016 22:44:19 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id xm10sm23550840pab.12.2016.02.26.22.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:44:17 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:44:51 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287683>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wrapper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 9afc1a0..d2e3068 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -91,10 +91,10 @@ static void *do_xmallocz(size_t size, int gentle)
 	void *ret;
 	if (unsigned_add_overflows(size, 1)) {
 		if (gentle) {
-			error("Data too large to fit into virtual memory space.");
+			error(_("Data too large to fit into virtual memory space."));
 			return NULL;
 		} else
-			die("Data too large to fit into virtual memory space.");
+			die(_("Data too large to fit into virtual memory space."));
 	}
 	ret =3D do_xmalloc(size + 1, gentle);
 	if (ret)
--=20
2.8.0.rc0.205.g7ec8cf1
