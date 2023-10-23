Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1AF224D0
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkXzXa/V"
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92061FCA
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:23:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5210a1515so56543521fa.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 12:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698088992; x=1698693792; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZklUm/LvZJelmPjw8WgYValzz3OOt6SLz27955vKWTA=;
        b=LkXzXa/VIB4xONgjAvcZYymFsl7yyJZiUzBXT1TV22xFe+3ky0Z0zJq27fVflgnZUs
         6YHhG/vDZHmGS+XFM5EPhKF52khgI1pZJrBIR9MovcdBSv/NSSWqQCFJX5SuniOPQjDe
         2DXSm0TNr1ttkdgJgkO7PSCgQl67mm1E5jTFnrIo2t9zBTs6IQo++UK0rjHT1h9tX3kc
         SAsvhWp1fP5cNBXAUITohT4MLjKv1rqD0PUj0qzvV4NrdRUz/e3TIJ1hravR4z4UtEEe
         UyFpLeuH8wvgbAuX8+lxLTjOqSTNUa5QCsSfs2NVY9MbaS+10nzDKmgAP5yM70JErhBd
         hEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698088992; x=1698693792;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZklUm/LvZJelmPjw8WgYValzz3OOt6SLz27955vKWTA=;
        b=TO6AXycoaAvFPYkR6GF+RrPN3E3O3dgJKP62CY79qAVPCoTngnbusyB07/uys/kabi
         dNQp5pT9Eed7W1wtcTkumbtVCWnDealDTuzf5vJxD8iZ1c/OKKcUeINL6rEQe9ZEubMt
         tSpVXBkO/GKqmj/XMSxSBXL1HS/Z05cKEkGglnaKFIXy820B65vt1cZ3yTAiTNIGaeg6
         0KEJVNLQG8bPxto5InwYdLgg3uwtXtKvCB7QPkJ6lHmc0azmXqZ8iSGBiZSowQkOXb7u
         lq3qSyDRo6lFmeukfP70YHMJQOMgpRqR5aKxNaYQd8dcSHoVLQd0SaXqlGe+1XV1sdiN
         UwGQ==
X-Gm-Message-State: AOJu0Yx0AGHLKTdvCtVqMOOAcTDlC+8nSILr0T7WWHS9J45GXlb9Uz8X
	p7kuDMF1zdffvBhnV2PdTSfK0+w63jQ=
X-Google-Smtp-Source: AGHT+IHHcloSDvZBRpN8Bf0q53YVaaQK1M/EBKECDhsoIRk7609aghevFfkWUE1PUBOIgi7Olbo1UQ==
X-Received: by 2002:a2e:b5b7:0:b0:2bf:fae2:f97 with SMTP id f23-20020a2eb5b7000000b002bffae20f97mr6582033ljn.12.1698088991757;
        Mon, 23 Oct 2023 12:23:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600c150c00b0040586360a36sm14702860wmg.17.2023.10.23.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 12:23:11 -0700 (PDT)
Message-ID: <pull.1602.v2.git.1698088990478.gitgitgadget@gmail.com>
In-Reply-To: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
References: <pull.1602.git.1698004968582.gitgitgadget@gmail.com>
From: "cousteau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Oct 2023 19:23:10 +0000
Subject: [PATCH v2] doc/git-bisect: clarify `git bisect run` syntax
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Javier Mora <cousteaulecommandant@gmail.com>,
    cousteau <cousteaulecommandant@gmail.com>,
    Javier Mora <cousteaulecommandant@gmail.com>

From: Javier Mora <cousteaulecommandant@gmail.com>

The description of the `git bisect run` command syntax at the beginning
of the manpage is `git bisect run <cmd>...`, which isn't quite clear
about what `<cmd>` is or what the `...` mean; one could think that it is
the whole (quoted) command line with all arguments in a single string,
or that it supports multiple commands, or that it doesn't accept
commands with arguments at all.

Change to `git bisect run <cmd> [<arg>...]` to clarify the syntax,
in both the manpage and the `git bisect -h` command output.

Additionally, change `--term-{new,bad}` et al to `--term-(new|bad)`
for consistency with the synopsis syntax conventions.

Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
---
    doc/git-bisect: clarify git bisect run syntax
    
    I saw someone in IRC wondering about the syntax for git bisect run for a
    command with arguments, and found that its short description at the
    beginning of the manpage is not very clear (although it gets clarified
    later when it is properly described). It describes the syntax as git
    bisect run <cmd>... which is a bit confusing; it should say git bisect
    run <cmd> [<arg>...], otherwise it somehow looks like you have to "enter
    one or more commands", and that each command is a single argument.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1602%2Fcousteaulecommandant%2Fman-git-bisect-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1602/cousteaulecommandant/man-git-bisect-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1602

Range-diff vs v1:

 1:  ce4c60a6f4f ! 1:  8de70bb060e doc/git-bisect: clarify `git bisect run` syntax
     @@ Commit message
          or that it supports multiple commands, or that it doesn't accept
          commands with arguments at all.
      
     -    Change to `git bisect run <cmd> [<arg>...]` to clarify the syntax.
     +    Change to `git bisect run <cmd> [<arg>...]` to clarify the syntax,
     +    in both the manpage and the `git bisect -h` command output.
     +
     +    Additionally, change `--term-{new,bad}` et al to `--term-(new|bad)`
     +    for consistency with the synopsis syntax conventions.
      
          Signed-off-by: Javier Mora <cousteaulecommandant@gmail.com>
      
       ## Documentation/git-bisect.txt ##
     +@@ Documentation/git-bisect.txt: DESCRIPTION
     + The command takes various subcommands, and different options depending
     + on the subcommand:
     + 
     +- git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
     ++ git bisect start [--term-(new|bad)=<term-new> --term-(old|good)=<term-old>]
     + 		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
     +  git bisect (bad|new|<term-new>) [<rev>]
     +  git bisect (good|old|<term-old>) [<rev>...]
      @@ Documentation/git-bisect.txt: on the subcommand:
        git bisect (visualize|view)
        git bisect replay <logfile>
     @@ Documentation/git-bisect.txt: on the subcommand:
        git bisect help
       
       This command uses a binary search algorithm to find which commit in
     +
     + ## builtin/bisect.c ##
     +@@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
     + static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
     + 
     + #define BUILTIN_GIT_BISECT_START_USAGE \
     +-	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]" \
     ++	N_("git bisect start [--term-(new|bad)=<term> --term-(old|good)=<term>]" \
     + 	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]" \
     + 	   "    [<pathspec>...]")
     + #define BUILTIN_GIT_BISECT_STATE_USAGE \
     +@@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
     + #define BUILTIN_GIT_BISECT_LOG_USAGE \
     + 	"git bisect log"
     + #define BUILTIN_GIT_BISECT_RUN_USAGE \
     +-	N_("git bisect run <cmd>...")
     ++	N_("git bisect run <cmd> [<arg>...]")
     + 
     + static const char * const git_bisect_usage[] = {
     + 	BUILTIN_GIT_BISECT_START_USAGE,


 Documentation/git-bisect.txt | 4 ++--
 builtin/bisect.c             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 7872dba3aef..191b4a42b6d 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -16,7 +16,7 @@ DESCRIPTION
 The command takes various subcommands, and different options depending
 on the subcommand:
 
- git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
+ git bisect start [--term-(new|bad)=<term-new> --term-(old|good)=<term-old>]
 		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
  git bisect (bad|new|<term-new>) [<rev>]
  git bisect (good|old|<term-old>) [<rev>...]
@@ -26,7 +26,7 @@ on the subcommand:
  git bisect (visualize|view)
  git bisect replay <logfile>
  git bisect log
- git bisect run <cmd>...
+ git bisect run <cmd> [<arg>...]
  git bisect help
 
 This command uses a binary search algorithm to find which commit in
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 65478ef40f5..35938b05fd1 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -26,7 +26,7 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 #define BUILTIN_GIT_BISECT_START_USAGE \
-	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]" \
+	N_("git bisect start [--term-(new|bad)=<term> --term-(old|good)=<term>]" \
 	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]" \
 	   "    [<pathspec>...]")
 #define BUILTIN_GIT_BISECT_STATE_USAGE \
@@ -46,7 +46,7 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 #define BUILTIN_GIT_BISECT_LOG_USAGE \
 	"git bisect log"
 #define BUILTIN_GIT_BISECT_RUN_USAGE \
-	N_("git bisect run <cmd>...")
+	N_("git bisect run <cmd> [<arg>...]")
 
 static const char * const git_bisect_usage[] = {
 	BUILTIN_GIT_BISECT_START_USAGE,

base-commit: ceadf0f3cf51550166a387ec8508bb55e7883057
-- 
gitgitgadget
