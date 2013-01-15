From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2] test-lib.sh: unfilter GIT_PERF_*
Date: Tue, 15 Jan 2013 20:50:56 +0700
Message-ID: <1358257856-3274-1-git-send-email-pclouds@gmail.com>
References: <1358254409-15187-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 15 14:51:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv6v1-0003lt-IW
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 14:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785Ab3AONur convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 08:50:47 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:47172 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756332Ab3AONuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 08:50:46 -0500
Received: by mail-pb0-f50.google.com with SMTP id wz7so53828pbc.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 05:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=lULqg8cXSaQmsAPamIfPW7+H3v9Vp8XWCR6wgtnyTZY=;
        b=ktiyvKo8p9IquQ6LQA8oFrKyWQYEf4e11ia46t+75eWhiX5BlISUc0NudzNyGHKtmH
         CWwXoWFZB1C7GvbU4EsTN77NRtOy4WPDJwr+klZnVlFIPrFdSDMMp8pzPJVBQu2ZAZxU
         eBYLr+t7UQDk0uTym7MnbjapZDU7C9kGVq/Uk2C55aqGCvNAwCk7yPxb1CzpErXVdVal
         93SbxDlfyPF6iaDHXPBqOngfx7qSTfvnJMKl0D6kMlh3fhyZTcSZWolpdplTPy+gHlW0
         AVPaAl148kpCjn37HWGeJIfltN0qOjLd5IevBFRUOeSjvxGERU4N0SanQMZQ5JmQg38x
         MxLg==
X-Received: by 10.68.209.230 with SMTP id mp6mr262679545pbc.8.1358257845796;
        Tue, 15 Jan 2013 05:50:45 -0800 (PST)
Received: from lanh ([115.74.52.72])
        by mx.google.com with ESMTPS id vk5sm10255568pbc.34.2013.01.15.05.50.40
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 05:50:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 15 Jan 2013 20:50:58 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
In-Reply-To: <1358254409-15187-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213637>

These variables are user parameters to control how to run the perf
tests. Allow users to do so.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f50f834..e1c8c85 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -85,7 +85,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" -e=
 '
 		.*_TEST
 		PROVE
 		VALGRIND
-		PERF_AGGREGATING_LATER
+		PERF
 	));
 	my @vars =3D grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
--=20
1.8.0.rc2.23.g1fb49df
