Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6115F1F462
	for <e@80x24.org>; Wed,  5 Jun 2019 20:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFEUKO (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 16:10:14 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:32907 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfFEUKO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 16:10:14 -0400
Received: by mail-it1-f193.google.com with SMTP id v193so409270itc.0
        for <git@vger.kernel.org>; Wed, 05 Jun 2019 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1e6Ic01pflH6CE1BV9H5GiUI2c/j0PW20898M+daplo=;
        b=OP0GBOwQMyIKCW9I2LLtncYl9jPQNLYndUllD2lnQp9XUf9CsrawSh3zCUl/2Fw8/v
         DAbihUhkrg5fOmcvn0dszR7zQ6m+NkXkvJO3DgsqS1m4vLDGg4RUNG1qzFGvS26DJy1y
         3BQi+yKDDs2WWnz6WJ/yaMAeNqOLjRsy37cMP/fDGsTnk7VBxVlKvfnDyODNJ23fQxd7
         jYgb7B5KKidyZ617lYp7YM76hZHuq235sb3gTlSdX1hc5XKJUwJUOZlZRPWFXHdNoAvr
         TU23XK7kChxvYcVph9Yq6yv15sLXGaerC/RtFi6B5lDUULVEMcfpS/aJrVNMoFsTTcfh
         yq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1e6Ic01pflH6CE1BV9H5GiUI2c/j0PW20898M+daplo=;
        b=hT1JRfM9BXOtiG+guF5fkoi7J6RVDFschh0NnmZryIfpCildBYQRThlrZlf7F5Vza6
         7QyXR5CVVVO2dIq62TMgKMkxUFQUhXw9+74xcX+Lk7Tn4ccjSeqT7wioEY5CqXfw8iJ3
         VtglfaI3OCQGYwu+91JMyUAGn/XLqxvurAzd8bpoeSWq13GqvsQ6b6RbPVSgnGYJVAII
         HRCdvYKBCLmXUrY3OqXXpQqHShh6eUEfqMonKtLvojTbYlDGz37ZUm0/5PVlVMbJZK0l
         3E3OL68MtJTvP8Ga+wJjG9jRRPL0NbS3ZXQl903sCaT0sTTN3LiGPVIMwLXbUC0uMTqE
         LHsg==
X-Gm-Message-State: APjAAAWmi1MUNQBVquLMDa4FM5uaNIE38A09RLTRntPByqBU+zU5Xv5y
        gGn0eN1TglKihsANK/2tEw8EWj+Q
X-Google-Smtp-Source: APXvYqxVgDMkJAOTrtpwteZXHtww6q2kdp3vJ9q4CwNmT493VTGJDvH0RLWqn5UqHfzGplvw0+vVgA==
X-Received: by 2002:a02:7087:: with SMTP id f129mr17379972jac.38.1559765412996;
        Wed, 05 Jun 2019 13:10:12 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id c17sm4824527ioo.82.2019.06.05.13.10.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 13:10:12 -0700 (PDT)
Date:   Wed, 5 Jun 2019 16:10:11 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 1/2] config/alias.txt: change " and ' to `
Message-ID: <bdc99e133258e01bc6d88ac66de22c15f9aa70c8.1559755652.git.liu.denton@gmail.com>
References: <cover.1559333840.git.liu.denton@gmail.com>
 <cover.1559755652.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559755652.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, the documentation would mix " and ' for code and config
snippets. Change these instances to ` so that they are marked up in
monospace.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/alias.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/alias.txt b/Documentation/config/alias.txt
index 0b14178314..5425449a50 100644
--- a/Documentation/config/alias.txt
+++ b/Documentation/config/alias.txt
@@ -1,7 +1,7 @@
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
-	after defining "alias.last = cat-file commit HEAD", the invocation
-	"git last" is equivalent to "git cat-file commit HEAD". To avoid
+	after defining `alias.last = cat-file commit HEAD`, the invocation
+	`git last` is equivalent to `git cat-file commit HEAD`. To avoid
 	confusion and troubles with script usage, aliases that
 	hide existing Git commands are ignored. Arguments are split by
 	spaces, the usual shell quoting and escaping is supported.
@@ -9,10 +9,10 @@ alias.*::
 +
 If the alias expansion is prefixed with an exclamation point,
 it will be treated as a shell command.  For example, defining
-"alias.new = !gitk --all --not ORIG_HEAD", the invocation
-"git new" is equivalent to running the shell command
-"gitk --all --not ORIG_HEAD".  Note that shell commands will be
+`alias.new = !gitk --all --not ORIG_HEAD`, the invocation
+`git new` is equivalent to running the shell command
+`gitk --all --not ORIG_HEAD`.  Note that shell commands will be
 executed from the top-level directory of a repository, which may
 not necessarily be the current directory.
-`GIT_PREFIX` is set as returned by running 'git rev-parse --show-prefix'
+`GIT_PREFIX` is set as returned by running `git rev-parse --show-prefix`
 from the original current directory. See linkgit:git-rev-parse[1].
-- 
2.22.0.rc1.169.g49223abbf8

