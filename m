Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28C3C4332F
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1E760E8C
	for <git@archiver.kernel.org>; Sat, 30 Oct 2021 21:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhJ3VfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Oct 2021 17:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhJ3Vev (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Oct 2021 17:34:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBCFC061764;
        Sat, 30 Oct 2021 14:32:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so9273847wmz.2;
        Sat, 30 Oct 2021 14:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vIipCw0Wwh0ul3qOK8pfzpX53VDY8ae6yE9OoL4XkhA=;
        b=K1YxRX29wbof4MNWEo+Oeoy60CB+AqY0I0Y+ydetPtIynelx49kYsWezGnOPQnydrb
         u4jz/IS/ZtnpUhMUqhq9BoVm+XsZS+8fDwUCNoMm+4D1G9k5KONiMla4itvF+4FLE3WU
         SxCdyD6a2B+2GMYBGWnKxuSXXgKcU1TwTYkSh+S20RZfEvF1NKDTGFgfbkRxT3Rhz8NR
         1TgV21uwutys4s6I7eyk3N+1PNRtXouZ+dJLvNT9wF0ZeONoFVS0nzZme9qm5waLO3J/
         NPBVKCQ8eC17IgkCBCOlhlQYppuk0WGbGUaLmm2FKnjv9JOqRgJZ/bmMp8UDTYbYNQea
         zcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vIipCw0Wwh0ul3qOK8pfzpX53VDY8ae6yE9OoL4XkhA=;
        b=vpk1blPwPex82R4YBPMGF5W/JtPckg7I7/InAhMwu4/D4hmeJdYKLbguew7T1puY1w
         F+qtmOfTRlERL3vXpNvMKP92yT9JRaMryFsw11nUWhF3zlB/XThfDB/NnzAvbCoj3vNz
         Pg8/Df6DZM7UijC6ExSVlhPbGyJJxFIXPo7lreIU4ZKMMsoVEdAdHxUcgVv1XdWTOWDd
         kpO6UMtRO8h3c0OBcKcTZYDJ4qYzsPb7TSrsh7IsZa1fWAh8aC7BduGatxCDz3zRvUok
         Jk/s77LxJsqQZvgPtJMbBjhGb5msVGNcYe/BHJJOkwNTzghMsaFxbF66ZzhdjXo6lF2E
         wA/A==
X-Gm-Message-State: AOAM53087m97Q70FzuZXHc6i+a3FxkQTIAwHUM2SeMSms+t2DDQpvX7s
        HUOXKEiPT8I8VMjoSFLTmFQ=
X-Google-Smtp-Source: ABdhPJxxNRbTf+TOVo661xTbsBw2b0kZ8hdlOLzuuDlBFYKjQpV7d5X0u2VflXyzBH4vaQoBbn7CTg==
X-Received: by 2002:a1c:2b85:: with SMTP id r127mr28738093wmr.134.1635629535489;
        Sat, 30 Oct 2021 14:32:15 -0700 (PDT)
Received: from sqli.sqli.com ([195.53.121.100])
        by smtp.googlemail.com with ESMTPSA id c79sm2948689wme.43.2021.10.30.14.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 14:32:15 -0700 (PDT)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     mtk.manpages@gmail.com, linux-man@vger.kernel.org
Cc:     git@vger.kernel.org, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: [PATCH 21/22] sysfs.2: SYNOPSIS: Mark as [[deprecated]]
Date:   Sat, 30 Oct 2021 23:31:31 +0200
Message-Id: <20211030213131.140429-22-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211030213131.140429-1-alx.manpages@gmail.com>
References: <20211030213131.140429-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use proc(5) instead.

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 man2/sysfs.2 | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/man2/sysfs.2 b/man2/sysfs.2
index 0bf2a60c0..10a4f0d43 100644
--- a/man2/sysfs.2
+++ b/man2/sysfs.2
@@ -29,9 +29,9 @@
 sysfs \- get filesystem type information
 .SH SYNOPSIS
 .nf
-.BI "int sysfs(int " option ", const char *" fsname );
-.BI "int sysfs(int " option ", unsigned int " fs_index ", char *" buf );
-.BI "int sysfs(int " option );
+.BI "[[deprecated]] int sysfs(int " option ", const char *" fsname );
+.BI "[[deprecated]] int sysfs(int " option ", unsigned int " fs_index ", char *" buf );
+.BI "[[deprecated]] int sysfs(int " option );
 .fi
 .SH DESCRIPTION
 .BR "Note" :
-- 
2.33.1

