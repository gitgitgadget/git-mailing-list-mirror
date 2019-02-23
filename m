Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F2020248
	for <e@80x24.org>; Sat, 23 Feb 2019 06:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfBWGdw (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 01:33:52 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43751 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfBWGdw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 01:33:52 -0500
Received: by mail-qk1-f195.google.com with SMTP id f196so2483029qke.10
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 22:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0/1gpZYwIlYIUrhUbOlNabHPRAxyohEpg3ZZtpYgajY=;
        b=RR6j3QoN1ttVZESwCF8cevzZBe2SmJr3NRVCjMNaMyYwyQpuyd9ChezeP5qG0VRVhu
         IUiNgfQPjZ55R7V1pLMJoE2Py8UYE2E2Q1ybjCyXdU0bajTL59m3ZiTFJuSJSlUtFB2V
         oClGSUnjXsKs+OfJWBNkc+rZmEiqdePYZJXcg7bn0Srv9tSCuMdgqqXgAMdEyW41mlZn
         3wuYS2AwRZ1BoxFshWl21LnUyG1DGVnqn1uvmxKZzGUMi57fG9dk3exUB+TCvsZoMxRE
         f4tCkrzetM6uEH2dAEHaIhSh+Dmqtb7lGaXAmZetzauEGL58ZjQ5lzADs82dzHNyh/kp
         SRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0/1gpZYwIlYIUrhUbOlNabHPRAxyohEpg3ZZtpYgajY=;
        b=jJJvghmaCaBbbvjhqaHJjI0k4I8h5yC7sFX25SCOQb73ItE+1yY9cvvcbXuyh3MNDU
         9+VF7U8Qr4F8PGQRiIUgzSKAsSdjbibJh47hj8eNPh2zcAI9bZk0MQo7q6k3dptOnbnM
         qlBVdkyHL9wubZKiuqyVOurBJ3haxU0wZxVK90bGrfqsCcS1DiI2MJWqDKO6f7se2YEx
         q7OqYOCX6f8+4xzVyEP5U7+E5mAt2SVIbAfMJgX4zX2I7bhUqB/bDwfELPoZVo3XMNZm
         k/P5U4b2aLgDwbQq/aXXKSBtJv5Hy06SJ5dKKQfMIXSJyJ9Wm1mIeWx+ERk2RcRYXS+t
         EhpQ==
X-Gm-Message-State: AHQUAuaXxdKfv5QoHNgtrNvhwsbtxjzlm/Hczbl1l2KN2W65kG27e8iV
        bMKL0lQSYk4TpigzIake285A8krn7KceKZ97d6xePugK
X-Google-Smtp-Source: AHgI3IZJhdOuT98TTijTOHoibCE2RHMq9WLaUDxdiThBqo+JH1erTqRrdQmvwHNepdEBUioYR8gCohmw4VrKYvHkas4=
X-Received: by 2002:ae9:ddc3:: with SMTP id r186mr5755859qkf.163.1550903631040;
 Fri, 22 Feb 2019 22:33:51 -0800 (PST)
MIME-Version: 1.0
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Sat, 23 Feb 2019 15:33:40 +0900
Message-ID: <CAF5D8-tHxFyFD-ZvdYRauT_Egz8RWzF_TDL487SmuwTVO-oyhQ@mail.gmail.com>
Subject: [PATCH] Fix the quotation mark in the explanation of "git checkout -".
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
---
 Documentation/git-checkout.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 801de2f764..55eb39a897 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -285,7 +285,7 @@ section of linkgit:git-add[1] to learn how to
operate the `--patch` mode.
 +
 You can use the `"@{-N}"` syntax to refer to the N-th last
 branch/commit checked out using "git checkout" operation. You may
-also specify `-` which is synonymous to `"@{-1}`.
+also specify `-` which is synonymous to `"@{-1}"`.
 +
 As a special case, you may use `"A...B"` as a shortcut for the
 merge base of `A` and `B` if there is exactly one merge base. You can
-- 
2.19.1
