Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060CE1F406
	for <e@80x24.org>; Thu, 10 May 2018 19:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbeEJTTm (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 15:19:42 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:42197 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeEJTTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 15:19:41 -0400
Received: by mail-wr0-f169.google.com with SMTP id v5-v6so3049281wrf.9
        for <git@vger.kernel.org>; Thu, 10 May 2018 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=yyABwkEGRqoecYQtVzTIExyBsJpObTLAIkrmkC5PNxY=;
        b=DVElOwx9JYv1xYzSGUdb2l0Z4bgGqHxg8bV+nMNsl+XnoF01dqa/OroBzmerMuFJcS
         dn2cvZSTGZV3Vwxd5/T46trUOSlDHkVBaAA1N7kMtIZ4/LlZ4jrMwHrBP5uOQ61qkjB+
         hnRgYVj/MeC9Pj56dXQ97r42/pngF1g0t0eHy6bY+A5iM6wy36U2TYPjfLcQK6hGANXX
         OiUNb7mrZAnsbidZ/JYnNQpGxK8bPX6pbRxD8ve6TOkzzFfTUN8fznXahWPWdOOXH8oA
         GfWgoloQScvmhIOhn0KL5vW3EtOU6B5wxp+DZlJuGHs/YYzntbslXzVSwo0+Uvk16nLQ
         6OqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=yyABwkEGRqoecYQtVzTIExyBsJpObTLAIkrmkC5PNxY=;
        b=Ck0gs0PqTnd1yJ/n0xWT9A4M4ud+t5p6Xwf4saYvP+rajiqG94wVkZvKgsZN4IxVp4
         fWtTLXlaDX0zHATl76/z3aNnNya0CvYzzAC4eNIUaaUtMtoEESKwuWq7GNQdTReARnGF
         jd6OFIP4K0STEy2PhfrK/JYtx/K7bJOJ3cHN6X8/AuRHKeu14ROkvSeTCBhhC3Ebc2LE
         rfK0XsfrFI4CxQrwtcJ5T7/FVKezd9QMGWEOGGk8wXYCYJ9Lg2gCDQqAeUWMcCD42A8F
         wmiIHK46Q3tNY8HZsFJX+emVi9MxZ4SnC3s3IspEnDA9dFAQm53i9cHs/tDyuq/rclHH
         a4Vw==
X-Gm-Message-State: ALKqPwfX4ciaxcJP1MSNoKu97FBFlozhk8Wq21ObkFSnBX77bp6lwql7
        Msfu80kdcw03R4apD8FiTZJXWA==
X-Google-Smtp-Source: AB8JxZqgIU+nrvz8svc3laepasTtMfOfFs74ATLpaPDbwtLcqnQWhJ3OKna7KWrtyGk/Qjo7eMRVUA==
X-Received: by 2002:adf:8567:: with SMTP id 94-v6mr2114856wrh.156.1525979979801;
        Thu, 10 May 2018 12:19:39 -0700 (PDT)
Received: from martofr (187.186.24.109.rev.sfr.net. [109.24.186.187])
        by smtp.gmail.com with ESMTPSA id x65-v6sm2209911wme.31.2018.05.10.12.19.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 12:19:38 -0700 (PDT)
Date:   Thu, 10 May 2018 21:21:52 +0200
From:   Martin Kunev <martinkunev@gmail.com>
To:     git@vger.kernel.org
Subject: Bug: Untracked file deleted by git-stash
Message-ID: <20180510212152.08d2b9a7@martofr>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I stumbled upon the following issue with git 2.11.0 on Debian 9.

When a tracked file is removed and a directory with the same name is created, git-stash would delete the directory with all its contents. No warning is displayed and git stores no information about the deleted content (as far as I can tell). The following steps can be used to reproduce:

$ mkdir /tmp/bug; cd /tmp/bug
$ git init
Initialized empty Git repository in /tmp/bug/.git/
$ echo 'original file' > entry
$ git add entry
$ git commit -m 'entry added'
[master (root-commit) 483319e] entry added
 1 file changed, 1 insertion(+)
 create mode 100644 entry
$ rm entry
removed 'entry'
$ mkdir entry
$ echo 'data that will be destroyed' > entry/content
$ git status
On branch master
Changes not staged for commit:
    deleted:    entry

no changes added to commit
$ ls -l
total 4
drwxr-xr-x 2 martin root 4096 May 10 21:16 entry
$ git stash
Saved working directory and index state WIP on master: 483319e entry added
HEAD is now at 483319e entry added

After the stash, the working tree contains only the regular file entry and the stash contains no information about the directory or its contents:

$ ls -l
total 4
-rw-r--r-- 1 martin root 5 May 10 21:16 entry
$ git status
On branch master
nothing to commit, working tree clean
$ git stash show -p
diff --git a/entry b/entry
deleted file mode 100644
index 1269488..0000000
--- a/entry
+++ /dev/null
@@ -1 +0,0 @@
-original file
