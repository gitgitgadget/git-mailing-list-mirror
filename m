From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] test-lib.sh: unfilter GIT_PERF_*
Date: Wed, 16 Jan 2013 17:23:53 +0700
Message-ID: <1358331833-8289-1-git-send-email-pclouds@gmail.com>
References: <1358257856-3274-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 11:24:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvQA6-0003cr-NN
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 11:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758868Ab3APKXj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2013 05:23:39 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:44795 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758812Ab3APKXh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 05:23:37 -0500
Received: by mail-pb0-f49.google.com with SMTP id un15so652768pbc.36
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 02:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=3oeaI2qppQazEeNyzUZVhjAV9ew/e7c+pgdIsVPVlz4=;
        b=PnWb/5OKqgFAnVQ2o2t6+fxUlC0CGKEhoM4HyJyS+L3Nd4K6SwmHDYawvB+xCkbmt3
         wkgHPemq1nuxanEH1j/q6jPygcUyCNGoMu5x5PP9na/PqVaIntajXS9K5KJL3B/e/FHG
         4iI2qSw+TRyHkcW5kv5Y6x7cI9GK3jC7ggm2WOl5qTRjjcpnlRjqn0LzJhFm2Le5zuSO
         xZsu+U8LBHXNMLzQ/KA/qk4RcHTn2GTbwbcjfZgeg7pVLg/LVLI/nIwmte2uptjp4SsH
         /wymLpryk2Kaq7c/60ZnuOtkC4IB+fXjUZXLnu4R48Zqq145w06zgf5G1pWzZ55djttY
         4lHA==
X-Received: by 10.68.243.105 with SMTP id wx9mr1427140pbc.74.1358331817194;
        Wed, 16 Jan 2013 02:23:37 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id im5sm10968740pbc.55.2013.01.16.02.23.33
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jan 2013 02:23:36 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 16 Jan 2013 17:23:54 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358257856-3274-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213743>

These variables are user parameters to control how to run the perf
tests. Allow users to do so.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 PERF -> PERF_

 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f50f834..bf4cf71 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -85,7 +85,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e=
 '
 		.*_TEST
 		PROVE
 		VALGRIND
-		PERF_AGGREGATING_LATER
+		PERF_
 	));
 	my @vars =3D grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
--=20
1.8.0.rc2.23.g1fb49df
