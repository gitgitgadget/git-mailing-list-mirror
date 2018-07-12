Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3C11F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbeGLT7E (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:59:04 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:40102 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732229AbeGLT7E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:59:04 -0400
Received: by mail-qt0-f201.google.com with SMTP id 13-v6so30675238qtt.7
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=yR1Me+YQdH0CK5oOejY/0TUDyC+mof0NYmEK0WF/Wu8=;
        b=DFqdCLJGdR8YmRNApkRo3uXN/FKYDCLd+DSYzCgE+jjKoTT01UMVgeaWozzRk1VE+g
         8JIc2ywyHFxmYdzO06WpCIib/0WTEJBtEdyF5qgFgnpAUlBehs4EoHUFiVD+s9rMPdCJ
         yYKthZvCXjzHbf2YX30tw/mhG2wWJWJtvxlplnYpoWlWCwgaYAi9Ij+AZgfvHVnZ4mIk
         vxGD6U8ulJZl2gDmJhSWU5Rod0ZjrUYgMTrNZvH6ysoWHeMbaiibjGZ02Gd9DaYB0UQT
         5rC7H4v48kkLNoYalyy96ES998jHsP8XEJCXIhAOwJUi8wSM2FRabruhzp3Xfl7H54eo
         Mvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=yR1Me+YQdH0CK5oOejY/0TUDyC+mof0NYmEK0WF/Wu8=;
        b=br+DYm55QveloL7je+mVzviE9anm3nc44FYqay5Ahew5/+ajhpfasLuFRjSobGZ1cg
         v49v+i0zeRaKP5U77g9eTnkDSo8AXpo2cRwf+jm0c2sOTb5AtxrsJB5wyD4HTxHkKkJP
         wg/Gs3W9q4MDdngayt1crakAPUibEhsIcuZqLVKMWASYUfIzmegMQPWp0mq9z2gfd5Af
         vStjXW63/M4je12Mr17MiCFqtO7xsG1bnGzw3e3zyCbVceb11DOi2AwDx1smhcz+UqJU
         YJhRFOVrF1xYY9YqRbHA2ed8osvqiT1Ex51ntU5VI9NN3QRwXxOLJlmOdUHGNeApHNJE
         CTGA==
X-Gm-Message-State: AOUpUlGA2XryEFMOSKNZPCTaQhhgzsNRo+FSnUSxZnqNlIVNZbsKYTYi
        iCVE2qbw0M6URQi80ulaxgGYf4Tn+y8llSehm216VXfX3cGx+oTtBJ2fAJE4Bwb/ijQjtDwfLzM
        O23TFR6gKTaI86JHV5bspDyC8D2XGG+16C6CxdL9c/Cv8pE39QG/1kMFZe39H
X-Google-Smtp-Source: AAOMgpejw3KuuEnyUxIVk/e2brOyV4OnL7AJnd157E5f7Ac/YNM6AdTENEBaN929DOrnUNmY3GhW+DUVDcp9
MIME-Version: 1.0
X-Received: by 2002:a37:c24d:: with SMTP id j13-v6mr1943260qkm.15.1531424882605;
 Thu, 12 Jul 2018 12:48:02 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:47:50 -0700
In-Reply-To: <20180712194754.71979-1-sbeller@google.com>
Message-Id: <20180712194754.71979-3-sbeller@google.com>
References: <20180712194754.71979-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 2/6] git-submodule.sh: rename unused variables
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'mode' variable is not used in cmd_update for its original purpose,
rename it to 'dummy' as it only serves the purpose to abort quickly
documenting this knowledge.

The variable 'stage' is also not used any more in cmd_update, so remove it.

This went unnoticed as first each function used the commonly used
submodule listing, which was converted in 74703a1e4df (submodule: rewrite
`module_list` shell function in C, 2015-09-02). When cmd_update was
using its own function starting in 48308681b07 (git submodule update:
have a dedicated helper for cloning, 2016-02-29), its removal was missed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 5 ++---
 git-submodule.sh            | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 20ae9191ca3..ebcfe85bfa9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1571,9 +1571,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	needs_cloning = !file_exists(sb.buf);
 
 	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
-			oid_to_hex(&ce->oid), ce_stage(ce),
-			needs_cloning, ce->name);
+	strbuf_addf(&sb, "dummy %s %d\t%s\n",
+		    oid_to_hex(&ce->oid), needs_cloning, ce->name);
 	string_list_append(&suc->projectlines, sb.buf);
 
 	if (!needs_cloning)
diff --git a/git-submodule.sh b/git-submodule.sh
index 8a611865397..56588aa304d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -531,9 +531,9 @@ cmd_update()
 		"$@" || echo "#unmatched" $?
 	} | {
 	err=
-	while read -r mode sha1 stage just_cloned sm_path
+	while read -r quickabort sha1 just_cloned sm_path
 	do
-		die_if_unmatched "$mode" "$sha1"
+		die_if_unmatched "$quickabort" "$sha1"
 
 		name=$(git submodule--helper name "$sm_path") || exit
 		if ! test -z "$update"
-- 
2.18.0.203.gfac676dfb9-goog

