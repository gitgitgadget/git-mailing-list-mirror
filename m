From: Ryan Biesemeyer <ryan@yaauie.com>
Subject: [PATCH v2 1/4] t7505: add missing &&
Date: Thu,  9 Jan 2014 00:45:41 +0000
Message-ID: <1389228344-38813-2-git-send-email-ryan@yaauie.com>
References: <6B177FFA-1797-45FE-9EF1-2C9E6EE8A234@yaauie.com>
 <1389228344-38813-1-git-send-email-ryan@yaauie.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ryan Biesemeyer <ryan@yaauie.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 09 01:47:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W13mS-0006uA-8W
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 01:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757438AbaAIArZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 19:47:25 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:48280 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757097AbaAIArY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 19:47:24 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so260424pab.30
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 16:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PG8JU6hjdUZPP+j2UcAWJtDNz+Mwfh3lEyTP6ExgJ2U=;
        b=BPlDKfQS43ET3fuLTfZyET9o+/iaYo1jyR0VcxuufwJnxuZsscki5Gu0aN9KZ0P07V
         P0AzYLhU6ZQuNVZIlpcznW0FxGrdImUGGvGrGUjng1ZMvhpRqNhsD0evl3ei9RckqTFL
         Hh9yj0FXnc70aPHnsEhSNXqbnhQeGLoL0tQVIz0w0X3XcMseNOLEe8qKsEJLYS+XxUwF
         QS5dgxHRmYisCSDjaP8IugN0y5X4wQUnFqF0PzCLG5yx7cFNhvStl+yHDP4Adtl+HYN5
         Cbtxg+DzRDmQGpZlJpqueCTHMBkou1yGl4Yhp1pJU1WOoFNAZnhI04/bVj+dU7jLgL5u
         Nsag==
X-Gm-Message-State: ALoCoQmmLbh6aYOFWVRALIEoSniSthyzna31AqEn3xKLKdVf7490Jw7SLcO3cqWoP5HbBXC9ndh9
X-Received: by 10.68.143.231 with SMTP id sh7mr180779pbb.7.1389228443721;
        Wed, 08 Jan 2014 16:47:23 -0800 (PST)
Received: from beorn.local.com ([69.164.175.238])
        by mx.google.com with ESMTPSA id xs1sm6854477pac.7.2014.01.08.16.46.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jan 2014 16:47:06 -0800 (PST)
X-Mailer: git-send-email 1.8.5
In-Reply-To: <1389228344-38813-1-git-send-email-ryan@yaauie.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240235>

From: Matthieu Moy <Matthieu.Moy@imag.fr>

Signed-off-by: Ryan Biesemeyer <ryan@yaauie.com>
---
 t/t7505-prepare-commit-msg-hook.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
index 3573751..1c95652 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -174,7 +174,7 @@ test_expect_success 'with failing hook (merge)' '
 	git add file &&
 	rm -f "$HOOK" &&
 	git commit -m other &&
-	write_script "$HOOK" <<-EOF
+	write_script "$HOOK" <<-EOF &&
 	exit 1
 	EOF
 	git checkout - &&
-- 
1.8.5
