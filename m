Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC3C20951
	for <e@80x24.org>; Fri, 17 Mar 2017 22:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbdCQWWQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 18:22:16 -0400
Received: from mout.web.de ([212.227.15.4]:57668 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbdCQWWP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 18:22:15 -0400
Received: from [192.168.178.36] ([79.213.126.222]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXYTG-1cjzeF3wRS-00WVZM; Fri, 17
 Mar 2017 23:15:26 +0100
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] revision: remove declaration of path_name()
Message-ID: <476be7e2-4b7a-6707-a162-439ef1f4530e@web.de>
Date:   Fri, 17 Mar 2017 23:15:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:0KA93xStCBRXboQtdeuWUk2XiS1CEW2V6T2pp8TyTDT2KYkDjxw
 Fy1uWZymTKmX1AbedFhVdQeSBzrBSFrtHyp2V7yEeevNqtSVIJVPK4bd8wfE87igqEeCgog
 TmxAs/S7KpNvj6E7f8Omapj65whzsKQ2Q6CHOUoUbNgVDN/QhvwY9T9s2Y8Frzu+9/wSVlU
 pS71YalWs/gbbidXg8RIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oCrArKGFBT4=:Hn8t8OvOpW4PP909LqPCMJ
 8yxKBQdc2j7ptLGPyPwrSfSTSag7AL5QAJZZQrraR/GM49eUlWi78E4UX8T5UfzgzPwUuP1FY
 fBWXyI4umS9qeoXKAL4oPVv7mlO9/xZNuAq7kZarrdjfq4FM7GlcK8yj5RVLLxZi498EAyn0n
 45sU73wDDXt1habBnQEbpxUUFAaARPyrUPWWvL/77yFGTrHqQ8I1WIA3PZYE/10aC3Z2OgDgE
 njpG3OlX3OllRsiPZSWnJgD213s/M2FGmAsjYhy93Ig7TEKMkiw87SugiKiqh5hBafHsTgH4h
 90GUH6Gcq9Zm5rX+YP9FBD/KZR6YLHQHGVT6RE5hjELoW9LKWpXnKuxjGEklPN4J2DulZTPIk
 C91sCh6eVG8aCZr1qGbkSz9wlGEBLCDu/nU6MMrkvfFumYNChvZWhzCxrb/7wL37FI4pfLxTf
 qEDDilB0HM7xg7gEMnavY/fY7x4J1m/cnOAeCkghXunPXAfPYWMPHxD5nF1srLNI0HiBx5ao0
 I24yHxwtlwU3a7jZKZOjZnaPmD1jbsoFMqJW9TQWcuWDVa4m/i3Hbqev7ydsuqc4sxKg97oBY
 3mvpNRiBzYz7bG3ya6AZilkntg/m4cb1haCnIdYbVEo0kBwWFRjuCCQcZvXPyEtGLKxYZQuP5
 7/vQP5vGUHj9UM86FORaFN3Cb10NiA81bk9R4Kplcnx5nDnCccIk+JkeMWbFqJqDepqaKPXFB
 L/sGFRfCXAGDljSbRVXB0kSP2bVaxQ9ID0EZHA+0gh8EaerhxZrgTdQQFfGXBVI2+DG5ik4em
 eGlydCd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The definition of path_name() was removed by 2824e1841 (list-objects:
pass full pathname to callbacks); remove its declaration as well.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 revision.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/revision.h b/revision.h
index 9fac1a607d..14886ec92b 100644
--- a/revision.h
+++ b/revision.h
@@ -259,8 +259,6 @@ extern void put_revision_mark(const struct rev_info *revs,
 extern void mark_parents_uninteresting(struct commit *commit);
 extern void mark_tree_uninteresting(struct tree *tree);
 
-char *path_name(struct strbuf *path, const char *name);
-
 extern void show_object_with_name(FILE *, struct object *, const char *);
 
 extern void add_pending_object(struct rev_info *revs,
-- 
2.12.0

