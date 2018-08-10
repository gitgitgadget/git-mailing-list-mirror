Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB311F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeHKAqg (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35976 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbeHKAqf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so5128811pfo.3
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mNPuVOLfAv83qJ58LyUwgbNxGqHRWthH+tV7Ychlzyk=;
        b=WPaq2UeEtK4at4XRwMbL2kuzKR2WCt0muq1wLkwVvuPdOyanSvhpF4M62ZKN+eyRkd
         nZeaYkX1gMir7X1lC7rEqDV6djesp5K3blvy4PvuiVPmQ3EVVrJR7340yHj6lnBF4Yte
         sgMX9zgq/FOwJToJHqKqNxd9wjlsvthbnK9AMtf05rwhwZM81sQMs8WwB+Iq8eCXwHE8
         J34jmrKDUg3vcounGvpJ7M6v4E5bNURhPX2EseNrMEWpHmvam7q93V1sC1Es1irym/pi
         /Jw3DSkObWUegeeELY+MaLP77oQkNJ9H3YlQYLhhwqb0r+l3YCgVURsOiYQ/MNaS1RJT
         QD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mNPuVOLfAv83qJ58LyUwgbNxGqHRWthH+tV7Ychlzyk=;
        b=sF/G26VOO9MolvIPrmreeoTcOglHCOQER8owf7BexRANECPQFaWgOuBWblj1KTXyvB
         5tecpELzvwC8p6YBVK4k1drTuGskBBd5Zq8gtiqLW7SK/6j7Gr1by9JjH5uqC6nPjboJ
         mpmn0oUPwoRXchbwMcPFSdieyrhPNMz9iEhtWc0EOp9nxviZTUzM+9LbU5CMfjWKe/L3
         ZWVs+Mbn0DgiqIDqE56JxRe/SIdQFeib9FZqsbQclW/bvnIyT5dlwmkaZQXgK8CvUZQW
         pn0XMXU66H4RlOEAoD55pQW/PEfFBBk9LUgOKSprzXyajyfo+vyii0Uwka8VzkSYcdhN
         NXbA==
X-Gm-Message-State: AOUpUlHPc8fpH87z9GMRTz8cfHbc5DgfnZS8n3jbHdJr2MykX3bHuA+j
        /HgjfK33uQ6vD3J+HZ9AE0iHMd0L
X-Google-Smtp-Source: AA+uWPzDQxd3U6l6O5XtKR21F4liCLT5eNMf05SpLqn8TtsEN6Yexc+NyaIWYncfTIQj5oyjo0Oy4A==
X-Received: by 2002:a63:b349:: with SMTP id x9-v6mr8039675pgt.337.1533939289884;
        Fri, 10 Aug 2018 15:14:49 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id v71-v6sm13836324pgd.56.2018.08.10.15.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:49 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:49 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:18 GMT
Message-Id: <05947781f94a351b84dd189905b665d41df7b442.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 16/21] range-diff --dual-color: skip white-space warnings
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When displaying a diff of diffs, it is possible that there is an outer
`+` before a context line. That happens when the context changed between
old and new commit. When that context line starts with a tab (after the
space that marks it as context line), our diff machinery spits out a
white-space error (space before tab), but in this case, that is
incorrect.

Rather than adding a specific whitespace flag that specifically ignores
the first space in the output (and might miss other problems with the
white-space warnings), let's just skip handling white-space errors in
dual color mode to begin with.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff.c b/diff.c
index e6c857abf..ea8ecae04 100644
--- a/diff.c
+++ b/diff.c
@@ -1299,6 +1299,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_FRAGINFO);
 			else if (c != '+')
 				set = diff_get_color_opt(o, DIFF_CONTEXT);
+			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
 		}
 		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
-- 
gitgitgadget

