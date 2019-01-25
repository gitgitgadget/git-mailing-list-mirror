Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAFA41F453
	for <e@80x24.org>; Fri, 25 Jan 2019 12:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbfAYMXe (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 07:23:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34527 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYMXe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 07:23:34 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so7266979ede.1
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 04:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=CCGY9evoCg2Nvx0IbI6fLg44aqx7z9e0wKfO9Za2oiw=;
        b=kvolAKnkKQ9I8ActpkUCZE1ijxcNWh9a1tUCPEqaHb6F2KxF31kTAuvyBgjcHoH1x1
         e2LgVyGXW30jm23V4NezkSMdN+qO8nRs4LE31LaD9ur+FaTAW/QrLUw2ocUmRk4dYGON
         LGiOZ1Y9UL+WtUXlCaXzpTpFib3pkdMV+p/XGA99Oxe3nDr6/CYlRJc/XWRpgu8nBDjE
         insUhOKK3/u9D5fJ2rZgdZxQE+SNUfLQT2Sm+yLWPaBqQSXhEIYHuSHQx1QreTUTXT4k
         pUzIEWv6VKYc3sUO5B/1xy5Z7Wmvie2a/Myns3pxoOqscqw1KZelJmuCbPidNNHslNGD
         CRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=CCGY9evoCg2Nvx0IbI6fLg44aqx7z9e0wKfO9Za2oiw=;
        b=PeMSpEqPxLs+teDhbi0ogqr2cIad9cVVManXRDMjK4d3fDG6uYPNmkkmdhV3itCpg2
         v8614z5HijxOqVe6cYhs/XOkJlg94RQEvS9/LBySQARRbMgTZRIAQQS3fQJMoGEOordf
         VnhO6Oa0Sd55m2lGDqbbYerlQEj0TC//m9EnkyO/vxHwgsgBMSLmsB5ZBRbaXrQkzZ9V
         +UP1rJqOmS1gmhjFDksfnn0hvkfPyON2JLZVViWB9zuFs17mCtxjh3bXmuje0/Ibxu9/
         NtYN54C44UJbS9w3pfOo0hOL3FbpPpD2H0ln16B3Xzbnb6w9hWLfuHiBTFJx8uatagFY
         np7A==
X-Gm-Message-State: AJcUukdBnWzmf/F/LGIoG2Z3/mexzppUxNZvxaO+++ZE8YNkrAjXT2aR
        OAxCd4yVRKxAYaEyYmtP2XMpKRoV
X-Google-Smtp-Source: ALg8bN4ET70oKlJPIHP+w6guv3VuR/XtZLrZT2O35Qx3YY1q6NQushraZYLwgEhQlryaCW/vAqinaw==
X-Received: by 2002:a17:906:f189:: with SMTP id gs9mr1123627ejb.164.1548419011219;
        Fri, 25 Jan 2019 04:23:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e51sm11763872edd.35.2019.01.25.04.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:23:30 -0800 (PST)
Date:   Fri, 25 Jan 2019 04:23:30 -0800 (PST)
X-Google-Original-Date: Fri, 25 Jan 2019 12:23:22 GMT
Message-Id: <pull.103.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v3.git.gitgitgadget@gmail.com>
References: <pull.103.v3.git.gitgitgadget@gmail.com>
From:   "Slavica =?UTF-8?Q?=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/7] Turn git add-i into built-in
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first version of a patch series to start porting
git-add--interactive from Perl to C. Daniel Ferreira's patch series used as
a head start:
https://public-inbox.org/git/1494907234-28903-1-git-send-email-bnmvco@gmail.com/t/#u

Changes since v3:

 * add error check when calling add--helper's functions from
   git-add--interactive.perl
 * replace trailing whitespace in the test with variable $SP used in earlier
   tests

Cc: Phillip Wood phillip.wood@dunelm.org.uk [phillip.wood@dunelm.org.uk]

Daniel Ferreira (4):
  diff: export diffstat interface
  add--helper: create builtin helper for interactive add
  add-interactive.c: implement status command
  add--interactive.perl: use add--helper --status for status_cmd

Slavica Djukic (3):
  add-interactive.c: implement show-help command
  t3701-add-interactive: test add_i_show_help()
  add--interactive.perl: use add--helper --show-help for help_cmd

 .gitignore                 |   1 +
 Makefile                   |   2 +
 add-interactive.c          | 263 +++++++++++++++++++++++++++++++++++++
 add-interactive.h          |  10 ++
 builtin.h                  |   1 +
 builtin/add--helper.c      |  43 ++++++
 diff.c                     |  36 ++---
 diff.h                     |  18 +++
 git-add--interactive.perl  |  17 +--
 git.c                      |   1 +
 t/t3701-add-interactive.sh |  24 ++++
 11 files changed, 381 insertions(+), 35 deletions(-)
 create mode 100644 add-interactive.c
 create mode 100644 add-interactive.h
 create mode 100644 builtin/add--helper.c


base-commit: b21ebb671bb7dea8d342225f0d66c41f4e54d5ca
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-103%2FslavicaDj%2Fadd-i-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-103/slavicaDj/add-i-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/103

Range-diff vs v3:

 1:  737767b6f4 = 1:  737767b6f4 diff: export diffstat interface
 2:  91b1963125 = 2:  91b1963125 add--helper: create builtin helper for interactive add
 3:  d247ef69fe = 3:  d247ef69fe add-interactive.c: implement status command
 4:  4950c889aa ! 4:  fb3f9378ac add--interactive.perl: use add--helper --status for status_cmd
     @@ -2,12 +2,21 @@
      
          add--interactive.perl: use add--helper --status for status_cmd
      
     -    Call the newly introduced add--helper builtin on
     +    Call the newly introduced add--helper builtin in
          status_cmd() instead of relying on add--interactive's Perl
     -    functions to build print the numstat.
     +    functions to print the numstat.
     +
     +    If an error occurs, it will be reported, but the Perl script will
     +    not exit, since the add--helper is called within an eval block.
     +
     +    As the Perl script will go away soon, so will this scenario, where
     +    the built-in helper is called  from the Perl script. Combined with
     +    the fact that it would be hard to test, we'll pass on adding
     +    a regression test for this.
      
          Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
          Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
     +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       diff --git a/git-add--interactive.perl b/git-add--interactive.perl
       --- a/git-add--interactive.perl
     @@ -19,7 +28,8 @@
      -	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
      -			list_modified());
      -	print "\n";
     -+	system(qw(git add--helper --status));
     ++	my @status_cmd = ("git", "add--helper", "--status");
     ++	!system(@status_cmd) or die "@status_cmd exited with code $?";
       }
       
       sub say_n_paths {
 5:  581b108c9c = 5:  ab16afd1d5 add-interactive.c: implement show-help command
 6:  aede733318 ! 6:  0a27304a84 t3701-add-interactive: test add_i_show_help()
     @@ -7,6 +7,7 @@
          Also, add it before changing git-add--interactive.perl's help_cmd
          to demonstrate that there are no changes introduced by the
          conversion to C.
     +
          Prefix git add -i call with GIT_PAGER_IN_USE=true TERM=vt100
          to force colored output on Windows.
      
     @@ -21,7 +22,7 @@
       
      +test_expect_success 'show help from add--helper' '
      +	git reset --hard &&
     -+	cat >expect <<-\EOF &&
     ++	cat >expect <<-EOF &&
      +
      +	<BOLD>*** Commands ***<RESET>
      +	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
     @@ -35,7 +36,7 @@
      +	<BOLD>*** Commands ***<RESET>
      +	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
      +	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
     -+	<BOLD;BLUE>What now<RESET>> 
     ++	<BOLD;BLUE>What now<RESET>>$SP
      +	Bye.
      +	EOF
      +	test_write_lines h | GIT_PAGER_IN_USE=true TERM=vt100 git add -i >actual.colored &&
 7:  b9a1a7e37a ! 7:  ca2a7c4375 add--interactive.perl: use add--helper --show-help for help_cmd
     @@ -5,7 +5,15 @@
          Change help_cmd sub in git-add--interactive.perl to use
          show-help command from builtin add--helper.
      
     +    If an error occurs, it will be reported, but the Perl script will
     +    not exit, since the add--helper is called within an eval block.
     +
     +    Just like the change where the Perl script calls the add--helper
     +    to print the numstat, also here we forgo adding a regression test:
     +    the Perl script is on its way out (and this patch is part of that journey).
     +
          Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
     +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
      
       diff --git a/git-add--interactive.perl b/git-add--interactive.perl
       --- a/git-add--interactive.perl
     @@ -24,7 +32,8 @@
      -diff          - view diff between HEAD and index
      -add untracked - add contents of untracked files to the staged set of changes
      -EOF
     -+	system(qw(git add--helper --show-help));
     ++	my @help_cmd = ("git", "add--helper", "--show-help");
     ++	!system(@help_cmd) or die "@help_cmd exited with code $?";
       }
       
       sub process_args {

-- 
gitgitgadget
