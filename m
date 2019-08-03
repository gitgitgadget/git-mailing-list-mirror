Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B32601F732
	for <e@80x24.org>; Sat,  3 Aug 2019 23:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfHCXwO (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 19:52:14 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40966 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbfHCXwO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 19:52:14 -0400
Received: by mail-wr1-f44.google.com with SMTP id c2so77593889wrm.8
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oLHoOjhyHR5nFgKHVvG9aKxuhtHWHsLyf5G0Hu5vux8=;
        b=JBOnIHaZ4J3IDaoqjF6RAC+e/ug1Hlq4dgkVVNhmZ5QgGMm7mGYIEfP/Rm10J/WOnw
         ZwOjkLBstZ6mzWcrhOkqHxYgjwjYOJo/IWWSHIssSCN07659wydodG7woqGYv4UIc9e+
         YPwO9jYHeIAecsTJQTv3svpcFn+FrgpKKO1qPtliEIaOJgdymhh2ILX1OPMUf8nQ4Rqn
         ujjPgHbOTwwgJuu1pgAQISKNq5llrGOyhvkDbqv5Sh45dBmNDzm+rxVgqTQVDcGtOfZq
         SMVG2ZAbK2N1OgvPkrdSa4fzRo5L5SMPZRxOu/Db7jZlk8SA5djECukeYjeVxxGX40/o
         yKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oLHoOjhyHR5nFgKHVvG9aKxuhtHWHsLyf5G0Hu5vux8=;
        b=LSPd7Z41JvuAIyNG4vQiNsMTfoyM3pJqrf7jukG2p++CMGYrSzC3kT+preuRJYYG3M
         FPloZ+8s6bMdNavuasU4Zs0olHnVuOq776bTujaohe6L1reiISzuFoHKH6U6/77vO3Zl
         93nfIK+SK/34AaFPVtJkgJAIoWQ7DuTskzwdyqUZnPsDciSVrjy9EpZDsS7Q8175pKPa
         mTj7wNYJlb+jdx5euQVqmnUyM/66nk6ONgjR6sVWksr4/GX1MeZ15FO0mS3HRFsYamSO
         IicQ9TgwuLsOTbZWBBr+bdjqj2y7PSYEjbAG8TxxMAWfDLMM7qrI3C6Rg2oZpHmTKPK2
         jtZQ==
X-Gm-Message-State: APjAAAU/KTj61jZrX8SzhNbHFcOCK75uiCK+CHcmOSfbLQARLul2tjIQ
        LUOO9xxsINO2aPJQR2xtxHsct84K
X-Google-Smtp-Source: APXvYqxhwqChtWvD23+0RawrElujArjI+xiwBdM4CJs2b0AroU/i4WfpPtha0LeUp3qX4rR/5i3Kgg==
X-Received: by 2002:adf:f84f:: with SMTP id d15mr151422643wrq.53.1564876332392;
        Sat, 03 Aug 2019 16:52:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v65sm92640688wme.31.2019.08.03.16.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 16:52:12 -0700 (PDT)
Date:   Sat, 03 Aug 2019 16:52:12 -0700 (PDT)
X-Google-Original-Date: Sat, 03 Aug 2019 23:52:05 GMT
Message-Id: <d25bcb43e1d8fe68717c6df57063427ab5a142f4.1564876327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.305.git.gitgitgadget@gmail.com>
References: <pull.305.git.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/6] Port generate-cmdline.sh to rc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, lufia <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lufia <lufia@lufia.org>

Signed-off-by: lufia <lufia@lufia.org>
---
 generate-cmdlist.rc | 102 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100755 generate-cmdlist.rc

diff --git a/generate-cmdlist.rc b/generate-cmdlist.rc
new file mode 100755
index 0000000000..18699ea9c4
--- /dev/null
+++ b/generate-cmdlist.rc
@@ -0,0 +1,102 @@
+#!/bin/rc
+
+rfork e
+
+fn die {
+	echo $* >[1=2]
+	exit die
+}
+
+fn command_list {
+	grep -v '^#' $1
+}
+
+fn get_categories {
+	tr ' ' '\x0a'|
+	grep -v '^$' |
+	sort |
+	uniq
+}
+
+fn category_list {
+	command_list $1 |
+	awk '{ print substr($0, 40) }' |
+	get_categories
+}
+
+fn get_synopsis {
+	sed -n '
+		/^NAME/,/'$1'/h
+		${
+			x
+			s/.*'$1' - (.*)/N_\("\1"\)/
+			p
+		}' Documentation/$1.txt
+}
+
+fn define_categories {
+	echo
+	echo '/* Command categories */'
+	bit=0
+	category_list $1 |
+	while(cat=`{read}){
+		echo '#define CAT_'$"cat' (1UL << '$bit')'
+		bit=`{hoc -e $bit' + 1'}
+	}
+	test $bit -gt 32 && die 'Urgh.. too many categories?'
+}
+
+fn define_category_names {
+	echo
+	echo '/* Category names */'
+	echo 'static const char *category_names[] = {'
+	bit=0
+	category_list $1 |
+	while(cat=`{read}){
+		echo '	"'$"cat'", /* (1UL << '$bit') */'
+		bit=`{hoc -e $bit' + 1'}
+	}
+	echo '	NULL,'
+	echo '};'
+}
+
+fn print_command_list {
+	echo 'static struct cmdname_help command_list[] = {'
+
+	command_list $1 |
+	while(a=`{read}){
+		s=`{get_synopsis $a(1)}
+		q=`{seq 2 $#a}
+		echo -n '	{ "'^$a(1)^'", '$"s', 0'
+		for(cat in `{echo $a($q) | get_categories})
+			echo -n ' | CAT_'^$cat
+		echo ' },'
+	}
+	echo '};'
+}
+
+fn print_config_list {
+	echo 'static const char *config_name_list[] = {'
+	grep -h '^[a-zA-Z].*\..*::$' Documentation/*config.txt Documentation/config/*.txt |
+	sed '/deprecated/d; s/::$//; s/,  */\n/g' |
+	sort |
+	while(line=`{read})
+		echo '	"'$"line'",'
+	echo '	NULL'
+	echo '};'
+}
+
+echo '/* Automatically generated by generate-cmdlist.sh */
+struct cmdname_help {
+	const char *name;
+	const char *help;
+	uint32_t category;
+};
+'
+define_categories $1
+echo
+define_category_names $1
+echo
+print_command_list $1
+echo
+print_config_list
-- 
gitgitgadget

