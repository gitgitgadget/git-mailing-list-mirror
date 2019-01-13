Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD42211B5
	for <e@80x24.org>; Sun, 13 Jan 2019 21:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfAMVAF (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Jan 2019 16:00:05 -0500
Received: from avasout04.plus.net ([212.159.14.19]:58381 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfAMVAE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jan 2019 16:00:04 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id imrSgA1U3AOoyimrTg5e8p; Sun, 13 Jan 2019 21:00:04 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Rdm+9Wlv c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=VylQL-m3XBZ-qWfzXXcA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     alban.gruin@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] rebase-interactive.h: fix hdr-check warnings
Message-ID: <d414e1a2-e5a1-ce15-96b5-cf294c7f3c92@ramsayjones.plus.com>
Date:   Sun, 13 Jan 2019 21:00:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGjeTC1VRzQaV1582D8HcAVptkdGpRfWTGnW0DLWlMuMsfCigufnTqopR74ND2mYGIyEAkHY4nVVsVj5tYp24YTK/SSuoFVYaIJ0GeUetf+HNc+htlnp
 /UQTbD9tacY4RfwuAbeCzlpC+sYVPMYmD+wOSg2hZkbJJu4WwE5PxmGZsePkMiby8AFEderI3se0iQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Alban,

If you need to re-roll your 'ag/sequencer-reduce-rewriting-todo' branch,
could you please squash this into the relevant patch [commit c27b32f0ec4
("sequencer: refactor check_todo_list() to work on a todo_list",
2018-12-29)].

[Both commit e5b1c9d9299 and c27b32f0ec4 add function declarations
that cause the hdr-check target to complain about the lack of a
declaration for 'struct todo_list'. However, c27b32f0ec4 is earlier
in the branch ...].

Thanks!

ATB,
Ramsay Jones

 rebase-interactive.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rebase-interactive.h b/rebase-interactive.h
index 42cc3f865d..44dbb06311 100644
--- a/rebase-interactive.h
+++ b/rebase-interactive.h
@@ -3,6 +3,7 @@
 
 struct strbuf;
 struct repository;
+struct todo_list;
 
 void append_todo_help(unsigned keep_empty, int command_count,
 		      const char *shortrevisions, const char *shortonto,
-- 
2.20.0
