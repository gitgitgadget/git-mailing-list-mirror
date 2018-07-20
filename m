Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E4981F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbeGTWoD (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:44:03 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:35268 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbeGTWoD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:44:03 -0400
Received: by mail-yw0-f202.google.com with SMTP id t189-v6so7116925ywg.2
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 14:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=fpqcQ2p/x0VN7nbouLHtV6pqz9WZ8mi4IA2tdA7n3qI=;
        b=AF4LyXoXoSRQ4a/kdVoDTtXA4nlmQNruWypAiMK8qye7kdF8OglrhX9R8MJLlptLwo
         SpsCVY09/RpvZ46sHAVJA0GuiAjdffarSsWQxpTqovCO0DvomrTRT/ZTdZ1E+XZ9quC4
         FdwTNGMtTP8DuXPXpuZ/JDYOluowiEjpM89a1l4JVacPPAnzoe3TqzkFeuQ77Bl+Lw+h
         x6BNUu8c2IPOhfSJfTiPNLi1VXobp5fX1UL8F8oYYVaZXNz5vGfQ0zjRE5W5pDbF752Y
         yWC0qFrkQGgYLtwVW8R7sOkeRPJ2oDu01dAEC7RuW8oIJmmH5Jd1DNjcifjYPsvB74LK
         EPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=fpqcQ2p/x0VN7nbouLHtV6pqz9WZ8mi4IA2tdA7n3qI=;
        b=b87nKrDduWUDrSnT2+L9KSLGmvcSP9fwCxjdU2PhZahMLGcH4kQ+Ey6EKEuGEP83sS
         pBoKLbmK9WlwfhZL4UBpvSdJEDnzxxNiDzhzPlUZEEpVzbDPcUi0fOgn501Olelyi6I1
         elgfdhdbSkxoPrutJSrFi7y9yjNt1zPleYJu/wjByx4RsflvqAfpzXVyqy9pOzNX5cG+
         KnTFmmZ8cizhEjT2NqJdi0nfDqw33Ljm7ufpyxhKxjnDtBpZN4FB2sgMtSv+0Fkea1mg
         RJ9IphwcrIs16w1oJBT0uvkJuwBKTcjrmyFbX6YTCiyleaq64VwUutz0rXQyiVFkxSCa
         cKzg==
X-Gm-Message-State: AOUpUlEX9yA0ombcGBDBOJtOLYclnsJq8dditwn6PVWsYJX4eoawoBO9
        WaV/MV+iwIdgcNN+whduwv6hwgfkEQFw/iPd66cn3VwzOFQsZ7ShqnsVaqNMA+xVsYW6xwrk2kl
        3uq9EYM+HT9Jwdv4c5TfAPrnGC4HhnovxRlcLT1KnXS8iZrGmHQ2bY7tKPOWi
X-Google-Smtp-Source: AAOMgpdnpVjtGlbBiWdzdt+x6Z2GSUZLEfDQYPlBi+DzauIKnQyFEWjdGYrYwXf7rWrCeHGeIMGLJS3Z8Ha6
MIME-Version: 1.0
X-Received: by 2002:a81:1786:: with SMTP id 128-v6mr1114855ywx.176.1532123633175;
 Fri, 20 Jul 2018 14:53:53 -0700 (PDT)
Date:   Fri, 20 Jul 2018 14:53:49 -0700
Message-Id: <20180720215349.179542-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH] Documentation/git-interpret-trailers: explain possible values
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Maybe we rather want to refer to the options that are described further
down in the document?

 Documentation/git-interpret-trailers.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 9111c47a1bf..b8fafb1e8bd 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -88,7 +88,8 @@ OPTIONS
 	Specify where all new trailers will be added.  A setting
 	provided with '--where' overrides all configuration variables
 	and applies to all '--trailer' options until the next occurrence of
-	'--where' or '--no-where'.
+	'--where' or '--no-where'. Possible values are `after`, `before`,
+	`end` or `start`.
 
 --if-exists <action>::
 --no-if-exists::
@@ -96,7 +97,8 @@ OPTIONS
 	least one trailer with the same <token> in the message.  A setting
 	provided with '--if-exists' overrides all configuration variables
 	and applies to all '--trailer' options until the next occurrence of
-	'--if-exists' or '--no-if-exists'.
+	'--if-exists' or '--no-if-exists'. Possible actions are `addIfDifferent`,
+	`addIfDifferentNeighbor`, `add`, `replace` and `doNothing`.
 
 --if-missing <action>::
 --no-if-missing::
@@ -104,7 +106,8 @@ OPTIONS
 	trailer with the same <token> in the message.  A setting
 	provided with '--if-missing' overrides all configuration variables
 	and applies to all '--trailer' options until the next occurrence of
-	'--if-missing' or '--no-if-missing'.
+	'--if-missing' or '--no-if-missing'. Possible actions are `doNothing`
+	or `add`.
 
 --only-trailers::
 	Output only the trailers, not any other parts of the input.
-- 
2.18.0.233.g985f88cf7e-goog

