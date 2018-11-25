Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04AF81F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 11:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeKYV5z (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 16:57:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38929 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYV5z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 16:57:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so6212589pld.6
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 03:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xTCgJhNPG3jt8WciFeVHgP+5jh6bQ/kizlZ5+tCvfeg=;
        b=I3IlaFNCG40Hg6P9pubGK65UeFgtxlhl+6yHZANYZKh7D+FKF5YkprsImHxLfT7+cg
         WeKbGFt5IwvziQaPKeUXaAlhnM60ZOTeoW0mmt4dT6O5/LP0cSZD5gumv5FnwY1KjhfM
         nwU0VXXMbyDx0khP5g9KxVB40rCDgKpTnfPzM9A5VwcKt/h3NvnxCZS9lQT1+WsCT5BB
         78dKLJIdjARcDGu/Kh3/uFFVnZ4d9HlguAo0XqdYQThn6KM9KU8VNlgQfA4rS3B8mcik
         09yw+q+AStAhbd5nVJncF/k99kwxDTWIA344iu5/TSiDrzxSSMvVMxB/iMFKEGCuhGiA
         opCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xTCgJhNPG3jt8WciFeVHgP+5jh6bQ/kizlZ5+tCvfeg=;
        b=Onfx4cpWMCMHhf4iB6PWQi2BVt8io0Ebtnuv6yUaWYJ7GTuH/oyqO+0j7pRiyCph0S
         svpKmqv9eIS3YeL+iw0P9jTd6qXJtbd27tfs0xe2cQPUf3yv0eH2cx5kgapAGuuLr+r5
         p1pqPzXms8oAq8sK2YciLeFlukjq8nJIpA+InLndFl85tG5KOjziKpVy/Y1uiJoc4YrS
         28FThy8disbqG1zff85bZsk/lKl7w/Bd9IOjlS27IHj5uspa+fxQdMZSZsZ6ibinNSuX
         H4CttG1bPh7Pp6tBfy+jqM2wutSkGUoLjZKW1TKQgc1AxIoXSWUrpcFrj5XF7VAWaOjr
         Xu5w==
X-Gm-Message-State: AA+aEWb/2pT1QTQkIWDBXUH8M17GIjDh9+S+EyUS3+UV+ND7Q6eH5nsi
        Uf5YXN/wgcPt58S0ldLX3RxW4HKp
X-Google-Smtp-Source: AFSGD/VJMow1Gf8KvG3dSvkwFxmATSaDLoVA/CGLa9JT7U0eOCy39dNEqbzSAMmgi5dTSXq9JutR5w==
X-Received: by 2002:a17:902:2a66:: with SMTP id i93mr22686447plb.113.1543144024981;
        Sun, 25 Nov 2018 03:07:04 -0800 (PST)
Received: from localhost.localdomain ([136.179.21.64])
        by smtp.gmail.com with ESMTPSA id h15sm21154301pgl.43.2018.11.25.03.07.04
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Nov 2018 03:07:04 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 1/7] Documentation: update INSTALL for NetBSD
Date:   Sun, 25 Nov 2018 03:06:44 -0800
Message-Id: <91d5d8cf6c3013f6c309d3666d8626ef546b18df.1543143503.git.carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <cover.1543143503.git.carenas@gmail.com>
References: <cover.1543143503.git.carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

NetBSD added a BSD licensed reimplementation of GNU libintl to
its base at least since release 4.0 (mid 2012) and git can be
configured to build with it.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 INSTALL | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/INSTALL b/INSTALL
index c39006e8e7..100718989f 100644
--- a/INSTALL
+++ b/INSTALL
@@ -154,11 +154,11 @@ Issues of note:
 	  git-gui, you can use NO_TCLTK.
 
 	- A gettext library is used by default for localizing Git. The
-	  primary target is GNU libintl, but the Solaris gettext
-	  implementation also works.
+	  primary target is GNU libintl, but the Solaris and NetBSD gettext
+	  implementations also work.
 
 	  We need a gettext.h on the system for C code, gettext.sh (or
-	  Solaris gettext(1)) for shell scripts, and libintl-perl for Perl
+	  gettext(1) utility) for shell scripts, and libintl-perl for Perl
 	  programs.
 
 	  Set NO_GETTEXT to disable localization support and make Git only
-- 
2.20.0.rc1

