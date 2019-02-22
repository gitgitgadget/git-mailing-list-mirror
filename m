Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 836F520248
	for <e@80x24.org>; Fri, 22 Feb 2019 13:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfBVN1O (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 08:27:14 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:36871 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfBVN1O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 08:27:14 -0500
Received: by mail-it1-f182.google.com with SMTP id z124so3062201itc.2
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 05:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wFCxeyZ4bwm77G5V+PmcdbNQ2s1tYiyRBRoo5RbO3mA=;
        b=FCa7Xli/fyBfMPNgPXwO/rxOQoSk8YAvnOuu8gf4YIy9Ybwf3stx0ruCp6QyMXoGcz
         SG4kMBdYubTLualKPNBw6p6ddi01DFm1OP061EM7ShGuvKU1gMw8HxAHP2IWfvqKlaVX
         /IyFeJ2jGlpYySKOtCVchNqSVmlPrwiqGxqMbCQASLhMDzvf4dcyVH2ymj4pwKBmsJzK
         4AJKUvjiBWju+tS8l/oLaqLLBEwTMN5QHGGo5ZuDYGW0nbBvOXz0uBJbbuMejzqZVHRn
         33RCgG/WJAGlNhnOiE2N9W5URf96ViT/UV7cqGOuCgkCIBbqgghYdq01k44DsNLdnhIQ
         TNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wFCxeyZ4bwm77G5V+PmcdbNQ2s1tYiyRBRoo5RbO3mA=;
        b=dTFi2O9NU4UjB5dGZx8ezP05iMJAxxR4VV7IMqVIP7b3E9H45X0E/srYy6czp3xPJB
         QIDF3BNWz3OA34O1RPV6HWK62j1w00Ly94Qf6LRiA3a0f7+X4rsyxjxSolx0t0mMIcKo
         ItAc/9dGOot8U8jbmiXR0gSpyTLQSCR11QhqFTtjbd5M7dHHHiIrQvph4h8e5jUJkcIA
         qDavd+Z/64PT0P6YItdQhx0oSLm/hAlBYKbPZta+MuxEzbjdMnlA+gKIVtqQ7Sf9klk9
         bnIoVXL9H4CjY4lrsPpOCZcLF43LT/B1h1ytMsvsUJafWYTLZ0DUEiMDohJ94GPhaTzz
         51Wg==
X-Gm-Message-State: AHQUAubMQlciccEAJLy4AV0X0SnKC86foBVU/4Tc9WzX+cWTYVVHBaYe
        6ux3QpgmM3dl+2IpO98d0xVG6Gp42V1g81MO9u80E0Do
X-Google-Smtp-Source: AHgI3IZoEoJCVPByjosFzhOF0r6TKzFotGm8cbc+NBI3xa6wRNuR/DP3cM11DoFCus8dy9DUwClKtgU4vurs36VYS6g=
X-Received: by 2002:a24:6344:: with SMTP id j65mr1987976itc.40.1550842032869;
 Fri, 22 Feb 2019 05:27:12 -0800 (PST)
MIME-Version: 1.0
From:   Krzysztof Sobierajczyk <sobierajczyk.krzysztof@gmail.com>
Date:   Fri, 22 Feb 2019 14:26:51 +0100
Message-ID: <CAM3o+_mX6euHa8Trq5cArcYBc9Wm0FH2L56S6Z3ojdhTcc0CWQ@mail.gmail.com>
Subject: bug - git version 2.20.1.windows.1
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

for example, I've created a simple repository. Containing two files
('to rename.txt' and 'to remove.txt'). I wanted to prepare for the
index changing the name of the first file and deleting the second
file. what git shows you looks wrong. Please check the four
instructions

$ git add .
$ git commit -m " first commit"
$ git mv to\ rename.txt new\ name.txt
$ git rm to\ remove.txt





SAMPLE REPOSITORY AND TEST

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        to remove.txt
        to rename.txt

nothing added to commit but untracked files present (use "git add" to track)

ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ git add .

ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

        new file:   to remove.txt
        new file:   to rename.txt


ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ git commit -m " first commit"
[master (root-commit) 46011e3]  first commit
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 to remove.txt
 create mode 100644 to rename.txt

ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ git status
On branch master
nothing to commit, working tree clean

ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ ls -all
total 8
drwxr-xr-x 1 ksobierajczyk 1049089 0 lut 22 13:40  ./
drwxr-xr-x 1 ksobierajczyk 1049089 0 lut 22 13:38  ../
drwxr-xr-x 1 ksobierajczyk 1049089 0 lut 22 13:41  .git/
-rw-r--r-- 1 ksobierajczyk 1049089 0 lut 22 13:38 'to remove.txt'
-rw-r--r-- 1 ksobierajczyk 1049089 0 lut 22 13:40 'to rename.txt'

ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ git mv to\ rename.txt new\ name.txt
                        <--- rename

ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        renamed:    to rename.txt -> new name.txt
                <--- rename is ok


ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ ls -la
total 8
drwxr-xr-x 1 ksobierajczyk 1049089 0 lut 22 13:42  ./
drwxr-xr-x 1 ksobierajczyk 1049089 0 lut 22 13:38  ../
drwxr-xr-x 1 ksobierajczyk 1049089 0 lut 22 13:42  .git/
-rw-r--r-- 1 ksobierajczyk 1049089 0 lut 22 13:40 'new name.txt'
-rw-r--r-- 1 ksobierajczyk 1049089 0 lut 22 13:38 'to remove.txt'

ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)

$ git rm to\ remove.txt
                                   <---- remove file

ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        renamed:    to remove.txt -> new name.txt
                     <------------  AND FAIL
        deleted:    to rename.txt


ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ git commit -m"second commit"
[master 30beac5] second commit
 2 files changed, 0 insertions(+), 0 deletions(-)
 rename to remove.txt => new name.txt (100%)
 delete mode 100644 to rename.txt

ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ git status
On branch master
nothing to commit, working tree clean


ksobierajczyk@KME43 MINGW64 /d/Simple repository (master)
$ git show
commit 30beac5b0578d4e4b6e64ea3a3c9a323f14e6277 (HEAD -> master)
Author: Krzysztof Sobierajczyk <sobierajczyk.krzysztof@gmail.com>
Date:   Fri Feb 22 13:45:21 2019 +0100

    second commit

diff --git a/to remove.txt b/new name.txt
    <------- Wrong information
similarity index 100%
rename from to remove.txt
rename to new name.txt
diff --git a/to rename.txt b/to rename.txt
deleted file mode 100644
index e69de29..0000000
