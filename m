From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] test: rename http fetch and push test files
Date: Thu,  6 Feb 2014 22:10:34 +0700
Message-ID: <1391699439-22781-2-git-send-email-pclouds@gmail.com>
References: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 16:11:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBQc3-0005Pk-1m
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 16:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752929AbaBFPL2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Feb 2014 10:11:28 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:45549 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbaBFPL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 10:11:27 -0500
Received: by mail-pd0-f178.google.com with SMTP id y13so1812520pdi.9
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 07:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=s8Lv9X39et7U095DkpUuStOJZSa+gPUNOTsaKMfqzrE=;
        b=D9wtOQuQNCKtG3YPu76hWwYX5NqESF212wtIIApYTQa68kjORHzAIXfFp6vzWNh5tx
         WGX+NMnpTWp1vTWyN3uLiZ/6KG0IIN/pBC5OS1n2cIzl3UjrRciLftAuTIflI0r6x7qv
         jQCvEg4Aj9iNi2T2mRjQ+Ra4u+hPr9PP1Z05jhMEDPne2gdGb1RTI+SNyqfVHZAP0HHW
         fqeuzRzoKnRmtuvQulBQ0ibHUouoAli/rn0UR0KbkWs5qg3bgTImxnkp+QIJbJetAlyc
         mi/GCuXeYNK38IZQj2ZldXKlCsPRhaPVQRk04M2yFobGm+RHE9ZhZyWrJF4oVAD4afH6
         1kDw==
X-Received: by 10.68.143.34 with SMTP id sb2mr12921717pbb.135.1391699487403;
        Thu, 06 Feb 2014 07:11:27 -0800 (PST)
Received: from lanh ([115.73.207.183])
        by mx.google.com with ESMTPSA id ix5sm4327956pbd.36.2014.02.06.07.11.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 06 Feb 2014 07:11:26 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 06 Feb 2014 22:11:27 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391699439-22781-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241695>

Make clear which one is for dumb protocol, which one is for smart from
their file name.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/{t5540-http-push.sh =3D> t5540-http-push-webdav.sh}  | 0
 t/{t5541-http-push.sh =3D> t5541-http-push-smart.sh}   | 0
 t/{t5550-http-fetch.sh =3D> t5550-http-fetch-dumb.sh}  | 0
 t/{t5551-http-fetch.sh =3D> t5551-http-fetch-smart.sh} | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t5540-http-push.sh =3D> t5540-http-push-webdav.sh} (100%)
 rename t/{t5541-http-push.sh =3D> t5541-http-push-smart.sh} (100%)
 rename t/{t5550-http-fetch.sh =3D> t5550-http-fetch-dumb.sh} (100%)
 rename t/{t5551-http-fetch.sh =3D> t5551-http-fetch-smart.sh} (100%)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push-webdav.sh
similarity index 100%
rename from t/t5540-http-push.sh
rename to t/t5540-http-push-webdav.sh
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push-smart.sh
similarity index 100%
rename from t/t5541-http-push.sh
rename to t/t5541-http-push-smart.sh
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch-dumb.sh
similarity index 100%
rename from t/t5550-http-fetch.sh
rename to t/t5550-http-fetch-dumb.sh
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch-smart.sh
similarity index 100%
rename from t/t5551-http-fetch.sh
rename to t/t5551-http-fetch-smart.sh
--=20
1.8.5.2.240.g8478abd
