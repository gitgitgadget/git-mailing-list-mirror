From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] completion: complete diff --word-diff
Date: Wed, 19 Jun 2013 00:54:05 +0530
Message-ID: <1371583445-11706-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 18 21:27:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up1Yn-0001FX-6k
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 21:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932982Ab3FRT1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 15:27:17 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:63939 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596Ab3FRT1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 15:27:16 -0400
Received: by mail-pd0-f175.google.com with SMTP id 4so4200925pdd.6
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 12:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=AcM4BgIXPFWcQuMquseYYeJK+Hvrp1a3T+RExCocLxM=;
        b=Z+HepfSPE04k8DHVI+UG3HoT0oTPSVgsBMbrk3g/EN0pUZ4Pl3CG2aHshgnlaqd/vz
         4hN00T9mXHQOpz866ePTJAHu/9skjgFEDfP6RdnH91WRuFY37TXFysQGVnztweMUKPPw
         BzNZyip7GZqbb2GlQq5Yudht11RkctYQ3fqjL5bYEGw2AiNLBbstDoIpy4/bk9zpOgKW
         /6e3hdVrYt8Czw2mPamJ0a3921Cp49JNgIEATopTZgEkDMqVWnpow1KhuhPXMhlfvx9U
         cCEEMSlPjDwH7W0Fx8XcroAlKN1X8EyTsAmBaO8oxtAeZ0q8MHkVyiOilSH/loiF0OAK
         1QoA==
X-Received: by 10.68.13.168 with SMTP id i8mr18447350pbc.86.1371583633769;
        Tue, 18 Jun 2013 12:27:13 -0700 (PDT)
Received: from localhost.localdomain ([122.164.211.22])
        by mx.google.com with ESMTPSA id ib9sm19486220pbc.43.2013.06.18.12.27.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 12:27:13 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.455.g5932b31
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228305>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index fd9a1d5..6c3bafe 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1163,7 +1163,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--no-prefix --src-prefix= --dst-prefix=
 			--inter-hunk-context=
 			--patience --histogram --minimal
-			--raw
+			--raw --word-diff
 			--dirstat --dirstat= --dirstat-by-file
 			--dirstat-by-file= --cumulative
 			--diff-algorithm=
-- 
1.8.3.1.455.g5932b31
