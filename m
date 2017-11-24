Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC9D32036D
	for <e@80x24.org>; Fri, 24 Nov 2017 23:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753887AbdKXXzG (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 18:55:06 -0500
Received: from mout.gmx.net ([212.227.17.21]:59947 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753880AbdKXXzE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 18:55:04 -0500
Received: from bedhanger.strangled.net ([188.193.86.106]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MgpmG-1eVdMA1txo-00M09c; Sat, 25 Nov 2017 00:54:26 +0100
From:   Ann T Ropea <bedhanger@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>,
        Ann T Ropea <bedhanger@gmx.de>
Subject: Re: [PATCH v4 5/6] Documentation: git: document GIT_PRINT_SHA1_ELLIPSIS
Date:   Sat, 25 Nov 2017 00:53:29 +0100
Message-Id: <20171124235330.15157-5-bedhanger@gmx.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171124235330.15157-1-bedhanger@gmx.de>
References: <20171124235330.15157-1-bedhanger@gmx.de>
References: <20171119184113.16630-1-bedhanger@gmx.de> <20171113223654.27732-1-bedhanger@gmx.de> <83D263E58ABD46188756D41FE311E469@PhilipOakley> <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com> <20171113223654.27732-3-bedhanger@gmx.de> <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com> <20171119184113.16630-5-bedhanger@gmx.de> <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com> <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley> <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com> <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley> <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com> <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
In-Reply-To: <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:38GNPwnMNj6ChlVFr32KR9cOf2ekgDGyF6gJfYfS6Gt5eAz+Voj
 SAqoxODStHNoXmgd20GNjRWq63m1yu2a6PbiEPxhzROey4JdyN/smuQC6rbCMozHNrJ9Dh6
 WNJ1EriG0hucb39l6o/b8JEsEEtpUALODmux5NMUaajf2eG/ihoz3DMcw73T8Iuf7TKir1L
 ZOJmY4ByKs8Q2L6Ylxukg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WbFWHyOy8u8=:vhpq6868T8GeCceo0OtkBM
 kXKVfRWdYCMI3rWm7VmpTyrDwZ65VvsD2R0hHcoq9ROjduV33VIMSgJd8EwXvPSzBZXTRr6u1
 iuMcRciTLe0o/wgmtuKXOJms5TiZ4ProYGhTxFINpVpj6SB5XwUn4c+A4yG5rq1QmV3hgMHHo
 2hzBoGhO3q9vUOglGv3kFxKRUdAHR06Vzh77pb4DbuOYDcOx+auqGxe7D10U/xnzqqUOz2umK
 uMiaBbYFMP58KN6hCFJdH2MYcklOqqKQk6CxxTV2pCpPbpANoRNyCMZFigC28gPoAN159SOu5
 ZXtRaW6Py4eN3AiD7Hwmo8uw+MBZbEFujQWmTVboTeUR1bizFKblCiGcxxtqb89ijKqsOR9A/
 0yrG75v2/06RSQJjMHq+LtqsgNuP55+GeOtH+AuYhltc2ul4lTZO1+Y5L/WxNuyL+shll7Bf8
 kR/xPne7m2jJkwzHXhZvVBK04GE2f8nSbyHAZl7EOFSNaBlE7tg7sCHgM2BH7E/7X9Y+B5+Q/
 XRcf+k6q8MFN/7RC1rIkoEksyIUXrDGY8OD8MORI86ktCq5IVzhCulmoeHhksMWcW09YhHwhq
 Bn4wo92y/He6PQlOTs37KJHhS6dj4+MFpSdIkoV2bCuI1UquNK3Uyjq8OIfBQkCZScPYkTeb0
 W8iPufK8REBAYLMtsMFV3oaYMgH5GeFyhV4egpCaqO77Vkw/BtWdJZwr3QhXtGRynKKJ5ByF1
 EA2xtywE7r5Obh1MFezGtcisqXGw5GK9qElNXj2PsAqodR2MQJ6e6mMSLh3AHXACEZIeeovR+
 ej44qUNurxmZ6hXIrhej8Alb9rCcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ann T Ropea <bedhanger@gmx.de>
---
v2: rename patch series & focus on removal of ellipses
v3: env var instead of config option, use one-line comments where appropriate, preserve indent level
v4: improve env var handling (rename, helper func to query, docu)
 Documentation/git.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 483a1f35475e..395c88c8a31f 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -731,6 +731,15 @@ corresponding standard handle, and if `GIT_REDIRECT_STDERR` is
 `2>&1`, standard error will be redirected to the same handle as
 standard output.
 
+`GIT_PRINT_SHA1_ELLIPSIS` (deprecated)::
+	If set to `yes`, print an ellipsis following an
+	(abbreviated) SHA-1 value.  This affects indications of
+	detached HEADs (linkgit:git-checkout[1]) and the raw
+	diff output (linkgit:git-diff[1]).  Printing an
+	ellipsis in the cases mentioned is no longer considered
+	adequate and support for it is likely to be removed in the
+	foreseeable future (along with the variable).
+
 Discussion[[Discussion]]
 ------------------------
 
-- 
2.13.6

