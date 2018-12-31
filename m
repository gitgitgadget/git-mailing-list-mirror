Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3E741F770
	for <e@80x24.org>; Mon, 31 Dec 2018 23:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbeLaX5o (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Dec 2018 18:57:44 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43323 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbeLaX5o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Dec 2018 18:57:44 -0500
Received: by mail-qk1-f196.google.com with SMTP id z18so254937qkj.10
        for <git@vger.kernel.org>; Mon, 31 Dec 2018 15:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RL1uwPlunUKzqzcVH3t1UuAKhg6ho8l0SGCvLnJeTNE=;
        b=fnQLe5q7qAL/VdI0GcyySj2tveCYPlKzRJder+cayXmtgI6Xtuz+mVEeLrueOjFm2h
         rMkYC34wBZCDk3l9NeRLUH2Y2RpqzyKWpO/Lc5KD441dtKL42h59hC2PWAnv6duw/AH2
         bYQZAW/+HlBYKVbHuUNIB2lKNaapIFZeU1Mi8MXuP1O/xEWDDG9PHr0J7Suc07+30Vy4
         XL9YVstNzsjtldcj95a9NC+DMSUuQXC/5B8cZdnjd5TqxjBnyOBpw7O64SqjlYg6eRlE
         ItW5cXJUSxbMU4NiUr3N/0BFWgG+rw4J/y8dtsPZONKbSh8T6+Al5RuQ2/Bo3/xQ60lt
         VpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RL1uwPlunUKzqzcVH3t1UuAKhg6ho8l0SGCvLnJeTNE=;
        b=gpdZJEdHUX4w0+eIdUj75NRhMS5Dmp7VQ/K2+3Xt29sXM65BCptVVhVdwpdj488XIh
         M++OdBCZZUe4G3lShbIAn62/MH4HOsz1+zbwcFPy+Os0j3rcnjf2bTZAZ4ikxJUxUFl/
         bD+xPPI6k8d35SEdQdvnP5BUyi5+/+xASENZtDauogfGR+BZU+OC1j1Xmw1CBov9kE7W
         2aU042MkPtOLxIQaN/0IzRi2/Bz9/dgb6UMqqK/zdlp2dtQGsQlHxtx4LyMltFBvj4cz
         +VseOogq2Z6HoR3GxW/8B8FZbqOswg821o6MJgQ8kxvSx7EMn3QBDoF97aw+r6fCW8tI
         tpOw==
X-Gm-Message-State: AJcUuke28lI3xfiM59xl1UGPRJ0Sdw7wUcEXSn+dr2HcNEYR0aViZquK
        O1ClfHigl2W5RNrwXDhSL2Oy4WI1
X-Google-Smtp-Source: ALg8bN70ywvwCnRYSQ917yj7+eqguib6oz1AF33ky+axBCzb4APDlcmXZ02venjPulX67TSyH5gPFQ==
X-Received: by 2002:a37:7d85:: with SMTP id y127mr36981744qkc.302.1546300663065;
        Mon, 31 Dec 2018 15:57:43 -0800 (PST)
Received: from Alberts-MBP.home (ool-18e4c9f9.dyn.optonline.net. [24.228.201.249])
        by smtp.gmail.com with ESMTPSA id m6sm4091258qkm.30.2018.12.31.15.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Dec 2018 15:57:42 -0800 (PST)
From:   Albert Burt <aburthinds@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stefanbeller@gmail.com,
        Albert Burt <aburthinds@gmail.com>
Subject: [PATCH] doc: remove unneeded TODO for release_commit_memory
Date:   Mon, 31 Dec 2018 18:57:13 -0500
Message-Id: <20181231235713.76200-1-aburthinds@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code that was merged with commit 1102405 left in an TODO that
is no longer relevant. It seems as if we can remove this todo.
util seems to not be a field of the struct commit,
definition of struct commit --> commit.c:27
The commit list also, does not contain a field for util.

____
By making a contribution to this project, I certify that:

a. The contribution was created in whole or in part by me and I
   have the right to submit it under the open source license
   indicated in the file; or

b. The contribution is based upon previous work that, to the best
   of my knowledge, is covered under an appropriate open source
   license and I have the right under that license to submit that
   work with modifications, whether created in whole or in part
   by me, under the same open source license (unless I am
   permitted to submit under a different license), as indicated
   in the file; or

c. The contribution was provided directly to me by some other
   person who certified (a), (b) or (c) and I have not modified
   it.

d. I understand and agree that this project and the contribution
   are public and that a record of the contribution (including all
   personal information I submit with it, including my sign-off) is
   maintained indefinitely and may be redistributed consistent with
   this project or the open source license(s) involved.
____

Signed-off-by: Albert Burt <aburthinds@gmail.com>
---
 commit.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/commit.c b/commit.c
index 2d94e0b199..2ff6dca0bc 100644
--- a/commit.c
+++ b/commit.c
@@ -357,8 +357,6 @@ void release_commit_memory(struct commit *c)
 	c->index = 0;
 	free_commit_buffer(c);
 	free_commit_list(c->parents);
-	/* TODO: what about commit->util? */
-
 	c->object.parsed = 0;
 }
 
-- 
2.17.2 (Apple Git-113)

