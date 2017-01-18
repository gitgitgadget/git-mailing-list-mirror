Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487D120756
	for <e@80x24.org>; Wed, 18 Jan 2017 03:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751461AbdARDxF (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jan 2017 22:53:05 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33470 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751115AbdARDxE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2017 22:53:04 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so140984pfg.0
        for <git@vger.kernel.org>; Tue, 17 Jan 2017 19:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PfOt78L/11AYZf1f9VVUPFDa6z6RHTN0ZK0nSsJ4wz0=;
        b=VWrSzJ0zgXZ9xeMa/BrGZYYn7DJSHxMslKg3p6Zw0rW32H4P80XVc8qv0yjyc5npwe
         RHCiuET8maIFlTpRPFXMy4rdAPWgXTV0zklSE53YKilwu1mP7XvK09dvbTOzIiV1qEmj
         CeiI/pqGhg3vEGzSp3rcT4waaRF2Xq97z9FYXd498Sc4FLmBZF6SYqlFO2Dsl4fZXO5g
         GizxA+JVB/yG8Q5t796STT87+Ml9N0kyRAuKGs1ARSCmbkyFq91WAC8EjyElgfyEgDVG
         ZHFaOUR8sZ4COWsh2ZvB71gW7CXRyN3V0E55TFGZwk4/UDXvdVV2a4g/B85zuC3qcPd4
         FU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PfOt78L/11AYZf1f9VVUPFDa6z6RHTN0ZK0nSsJ4wz0=;
        b=RTOER2E+Xj7Ca00MZCZvqlmN/V5Ro9eoQ89i8PBjmXt/pKwU7nB2+Oh77/Mfa7DcqF
         94tcNgwzCnR/ICIOXltO2TfckfsHF4CFOSRQcY2oqfx9kUvOzmUuzY4qKiroUMC5z2+n
         qXED+d8Y0IIasjzq+B8e07QR3irxnEKimfKtvJ/dL9h7lw6Y2nnu8oysVOwP4WaCXg/5
         pPi4Nhy7QXOhRHOVdnZ2hf1MJRwmAxAzizwxBbsSV8WoZ5A9EmrILcdbLTEfdHeopA+X
         WAGHPQuoH+W5UQDnW5+8Ypn02zcc7rcBzBRWDRJKJd6cIQvksHMgFFKSGDdZgGuDOW1X
         CTpA==
X-Gm-Message-State: AIkVDXLKPPkr2JDAYVwm0iJ96AOO9oT1MpSlFZfyou+0SpCDZ5alFD8o83hk5AVUmYVayw==
X-Received: by 10.99.62.73 with SMTP id l70mr1420917pga.97.1484711569999;
        Tue, 17 Jan 2017 19:52:49 -0800 (PST)
Received: from localhost.localdomain (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id b69sm49872243pfd.90.2017.01.17.19.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jan 2017 19:52:48 -0800 (PST)
From:   David Aguilar <davvid@gmail.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] gitk: remove translated message from comments
Date:   Tue, 17 Jan 2017 19:52:45 -0800
Message-Id: <20170118035245.1757-1-davvid@gmail.com>
X-Mailer: git-send-email 2.11.0.536.gaf746e49c2
In-Reply-To: <xmqq4m0xpmbz.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m0xpmbz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"make update-po" fails because a previously untranslated string
has now been translated:

	Updating po/sv.po
	po/sv.po:1388: duplicate message definition...
	po/sv.po:380: ...this is the location of the first definition

Remove the duplicate message definition.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 po/sv.po | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/po/sv.po b/po/sv.po
index 32fc752..2a06fe5 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -1385,21 +1385,6 @@ msgstr "Felaktiga argument till gitk:"
 #~ msgid "mc"
 #~ msgstr "mc"
 
-#~ msgid ""
-#~ "\n"
-#~ "Gitk - a commit viewer for git\n"
-#~ "\n"
-#~ "Copyright © 2005-2016 Paul Mackerras\n"
-#~ "\n"
-#~ "Use and redistribute under the terms of the GNU General Public License"
-#~ msgstr ""
-#~ "\n"
-#~ "Gitk - en incheckningsvisare för git\n"
-#~ "\n"
-#~ "Copyright © 2005-2016 Paul Mackerras\n"
-#~ "\n"
-#~ "Använd och vidareförmedla enligt villkoren i GNU General Public License"
-
 #~ msgid "next"
 #~ msgstr "nästa"
 
-- 
2.11.0.536.gaf746e49c2

