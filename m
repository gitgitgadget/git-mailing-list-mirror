Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5589C20248
	for <e@80x24.org>; Mon, 25 Feb 2019 20:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfBYUDQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 15:03:16 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37062 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBYUDP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 15:03:15 -0500
Received: by mail-lf1-f67.google.com with SMTP id z196so7154426lff.4
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 12:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lm3VpTi4rV0BJJp9W7KdITBxIGnT6raINZ5B1Q+EoOQ=;
        b=HkVHLGfpSDhrC9W69zeDkZd+hmUAA5qNmv1V4Lu6ushYivoot3ccdCSM5TbM9l1eGH
         Ui2a2BPK9TmPhf6UxIKsqk0Jer0q0K6R86E0XwqpFCB9jjAJodVsp6XYkuG++TCoB0F0
         8nHGWVwWN86oLgXgJpRDz1WfF5mCOxXNoHF2t0/BkYbx2n9Q8qIcqMLNhytAiKF7A0Cd
         0Gwp6koj/PCJ7E2xNPcvEoK65FwgVpzgNj2wFoOAu1LYv9gk77+zG2EMMFBL3qYd0FG4
         csDtF6094NPsznlWthkgBjGyocTbmE9cvbsRhkU2vGT8eZcO+E5uB0A5zYnGaMMR/ewI
         xJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lm3VpTi4rV0BJJp9W7KdITBxIGnT6raINZ5B1Q+EoOQ=;
        b=GHT/uhYOsUGpnKtnag/fPQvXllo3eBCol4/5MqXym374te04jLwXapbKl5Yenq1jEm
         C1Nj1DIgxjtjT2O8xOExdJiU8jyn9T6E5Ttn/6p9wQYCnHlACvXw+hVc+qAIsoF256nY
         oJGhgQ5s+i/Cy5zoiQFXaQY/nbnpgGokG/durKIIZ3ay8PAx7cTuUujCME8rRk6nzbRl
         cqW50oUWJG5EnwIdfestDdxmzGB8BeiNFO4Ny975lAOPIj5yg4djV+1vqiJH78oO3yW2
         zVNWq6TYZyDdNkF3iekEobwEqfoShWgoNmEH8S6IeX7eWonIbMQfeqgWUZr2xxfd/fO1
         wGAg==
X-Gm-Message-State: AHQUAuYkv4IR2lxpvLvW9+6ACaHkmVchiIEK62lqaPC+voyMLrHq5gEg
        6ImeMPL19G0ToSwXyqNz/F8vdtJZ
X-Google-Smtp-Source: AHgI3Ibh2xuN2zvnrIDAC7TskhMZzwHcbMxyHmTMxKSkAsO2ilR9tG/2bSjZDfNlRBEoLOzwAHYUjQ==
X-Received: by 2002:ac2:514d:: with SMTP id q13mr11130737lfd.30.1551124993337;
        Mon, 25 Feb 2019 12:03:13 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c22sm2977168lfi.27.2019.02.25.12.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 12:03:12 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 3/3] asciidoctor-extensions: fix spurious space after linkgit
Date:   Mon, 25 Feb 2019 21:02:40 +0100
Message-Id: <41d9ea21c37a634b2310b5b2f68935bcd612665c.1551123979.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1551123979.git.martin.agren@gmail.com>
References: <cover.1551123979.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we render, e.g., "linkgit:gitglossary[7]." with Asciidoctor, we get
"gitglossary(7) ." with a space between the linkgit macro expansion and
the punctuation. We can fix this by dropping the trailing newline after
we've turned `linkgit:foo[bar]` into `<citerefentry>..</citerefentry>`.

The diff produced by `USE_ASCIIDOCTOR=Yes ./doc-diff HEAD^ HEAD` is
almost 6000 lines large and shows how this fixes "git-foo(x) ,", "(see
git-bar(y) )" and so on. One might wonder whether this also turns, e.g.,
"see linkgit:foo[1] for more" into "see foo(1)for more", but no. We get
"...</citerefentry> for more" in the XML, see, e.g., git-am.xml, so the
space ends up in git-am.1 just fine.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index ec83b4959e..f7a5982f8b 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -16,7 +16,7 @@ module Git
           "<citerefentry>\n" \
             "<refentrytitle>#{target}</refentrytitle>" \
             "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-          "</citerefentry>\n"
+          "</citerefentry>"
         end
       end
     end
-- 
2.21.0

