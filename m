Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187451F405
	for <e@80x24.org>; Wed,  8 Aug 2018 19:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeHHWLn (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 18:11:43 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:33871 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbeHHWLm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 18:11:42 -0400
Received: by mail-yw1-f73.google.com with SMTP id p127-v6so3870920ywg.1
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 12:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LqPDRAWNqjmFLtaE7hsAjLpc+yojn05FfUpGyo0fT+Q=;
        b=tsyMtJZwrgWIVE0c9xCi5/e9AuuUkHkXUhJovGi7LUmsah6QsO/UOqpOze4pFdA8Dh
         z3CE6nCJLgi0HNRqURbuUhUV6rKtFHxiqNe4ArB1D4GsK7jlIxVn5PjXDLJCoT3gViNP
         +XYPmdf3U1j2A4jsXq8vCRB1WGNoZpLT9oOiPeJuGCKF3evwJY6WFot26KKA7CIVGYCM
         O5aEy5khivNdG16z4+CPMGOgCWMDr/RX4gj4XCa2lxKUpp8T5aJ/zhZ9MRmw9QgiPWt5
         wHwVziZ9q6e462seHuW60zAX6i5hVd7DOHiZI7lXDx9s/YauYtlwlFgwQ8misiqhM0Oe
         365g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LqPDRAWNqjmFLtaE7hsAjLpc+yojn05FfUpGyo0fT+Q=;
        b=hSFq3DJysBNwW/76b6iyd0iMrzw+fzDk905OKK3BEI2ubby5E6ePlhVfjmxVA/DCoU
         IOXNsrVja/uITv5nAMFeLV7KRIi+qXykcxVKDXgCXWfmgykHjyNLPS7FkGaU23tGbOxF
         nvggikhOeGDvVEWBWkAcSu7iNqJMP/2f8VCZpk0xZoc7LxbiWx0bzHePKjwLOJi2Faw8
         Fxe3NRYiFfG6JE9sBr1rFI82bwFRqjHOD0d5n64rRkHG5FPvPu4xTOLfh+HI6OWfuDi/
         axK8HrTc/urpvWknF+IMPUmAmc7p6B9Oq+eOwSFSjhSaEwiX0DhZoaCj4hJ4s+XIJgr0
         vQhg==
X-Gm-Message-State: AOUpUlHTT4gcj16tl/ZqG3QnZKJlVVWiSOivDHZu/PAwJHlyfZTO62Ul
        GvZdS+uOd1tSkx18TmWw7b9ip3akhJmA
X-Google-Smtp-Source: AA+uWPzqoW1aYP+1OJhRKppxIacIRBGit7zJ/aDQjTGv7ugh1aaYuaEt2vgR5X9bLQv58JViFsG9eVG94Q2/
X-Received: by 2002:a25:8489:: with SMTP id v9-v6mr1101327ybk.60.1533757830387;
 Wed, 08 Aug 2018 12:50:30 -0700 (PDT)
Date:   Wed,  8 Aug 2018 12:50:17 -0700
Message-Id: <20180808195020.37374-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 0/3] Resending sb/config-write-fix
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a resend of sb/config-write-fix, with a slightly
better commit message and a renamed variable.

Thanks,
Stefan


Stefan Beller (3):
  t1300: document current behavior of setting options
  config: fix case sensitive subsection names on writing
  git-config: document accidental multi-line setting in deprecated
    syntax

 Documentation/git-config.txt | 21 +++++++++
 config.c                     | 12 ++++-
 t/t1300-config.sh            | 87 ++++++++++++++++++++++++++++++++++++
 3 files changed, 119 insertions(+), 1 deletion(-)

./git-range-diff origin/sb/config-write-fix...HEAD >>0000-cover-letter.patch 
2.18.0.597.ga71716f1ad-goog

1:  999d9026272 ! 1:  e40f57f3da1 t1300: document current behavior of setting options
    @@ -7,7 +7,6 @@
         for the follow up that will fix some issues with the current behavior.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/t/t1300-config.sh b/t/t1300-config.sh
      --- a/t/t1300-config.sh
2:  c667e555066 ! 2:  f01cb1d9dae config: fix case sensitive subsection names on writing
    @@ -2,8 +2,8 @@
     
         config: fix case sensitive subsection names on writing
     
    -    A use reported a submodule issue regarding strange case indentation
    -    issues, but it could be boiled down to the following test case:
    +    A user reported a submodule issue regarding a section mix-up,
    +    but it could be boiled down to the following test case:
     
           $ git init test  && cd test
           $ git config foo."Bar".key test
    @@ -32,7 +32,6 @@
     
         Reported-by: JP Sugarbroad <jpsugar@google.com>
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/config.c b/config.c
      --- a/config.c
    @@ -41,7 +40,7 @@
      	int eof;
      	struct strbuf value;
      	struct strbuf var;
    -+	unsigned section_name_old_dot_style : 1;
    ++	unsigned subsection_case_sensitive : 1;
      
      	int (*do_fgetc)(struct config_source *c);
      	int (*do_ungetc)(int c, struct config_source *conf);
    @@ -49,7 +48,7 @@
      
      static int get_extended_base_var(struct strbuf *name, int c)
      {
    -+	cf->section_name_old_dot_style = 0;
    ++	cf->subsection_case_sensitive = 0;
      	do {
      		if (c == '\n')
      			goto error_incomplete_line;
    @@ -57,7 +56,7 @@
      
      static int get_base_var(struct strbuf *name)
      {
    -+	cf->section_name_old_dot_style = 1;
    ++	cf->subsection_case_sensitive = 1;
      	for (;;) {
      		int c = get_next_char();
      		if (cf->eof)
    @@ -70,7 +69,7 @@
      		if (cf->var.len < 2 || cf->var.buf[cf->var.len - 1] != '.')
      			return error("invalid section name '%s'", cf->var.buf);
      
    -+		if (cf->section_name_old_dot_style)
    ++		if (cf->subsection_case_sensitive)
     +			cmpfn = strncasecmp;
     +		else
     +			cmpfn = strncmp;
3:  6749bb283a8 ! 3:  6b5ad773490 git-config: document accidental multi-line setting in deprecated syntax
    @@ -29,7 +29,6 @@
         spend time on fixing the behavior and just document it instead.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
      --- a/Documentation/git-config.txt
