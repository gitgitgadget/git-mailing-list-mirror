Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D501F404
	for <e@80x24.org>; Thu, 12 Apr 2018 19:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753058AbeDLTgQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 15:36:16 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33610 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752948AbeDLTgP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 15:36:15 -0400
Received: by mail-pl0-f67.google.com with SMTP id w12-v6so3662623plp.0
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zZZoKtKzlNk9SZ3T0J5MPMe718gxaKMoqeJTUKMT2IA=;
        b=EK8oMxbJW5fjJHFFr+q12z72zemSPkT9zmin2gg9cNq/6T0FcwVnW6IitO5bscgmfa
         AYx3vbhva/6L+2qQVS0MsvK9l3BVWuvnoAl613zn0p5GPMa9RjZjtJTpg1a53cEVYpF4
         z2SUgT5ujXgkW4zvw7fPXm4TJyB/u06hqLttElF8JkzOG+uQxED5aVO25OH4vDhY0Y4Z
         UBWIEFb6uWGM+ny0/a9KeDgc2805iO0CvyxJWdG2RMfvxNxmnDk8yBtnfpPHO/wAaqbU
         llcJUjm+d+dRILNOmmiWMsgqbae94pbWAhx5O5T7C6WkksUt/O20DDlYDp3K8/kw5R2K
         Sl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zZZoKtKzlNk9SZ3T0J5MPMe718gxaKMoqeJTUKMT2IA=;
        b=GSTSOOu57XGbcTHG7NoTQby2UDAszQRHV7KSdzwlP0T59YqEZIHyVXt/uwBdPUP2lt
         p8H7MOy4sU/2c68h2YBSB5Dj4W9D0a/4e4qr8FPxsjMdN5smQQjupFP7l2GiT+YGJhWv
         p55Xldoq3qcI77ucOHsNKlDLqpwUFoKOFTFnbUlmjz3Y/dwV5gUHw4yr6hu5miehNvjz
         VLLd2Vj1ZlFSaTX3CXdX2fhCyZtDlL++RaXEvg53tCAMlEQ9XRb2QZfvHI2y+B91lci7
         qepwFsxAr8gpy6gJLAdu37L+gCMzHAvSMOtME/EY1+2zdPc4HaTbRFHyYTHCbh/pfoXl
         Hl7Q==
X-Gm-Message-State: ALQs6tBetuq0fQjpaMSs0OVSvo/ihp8SljJG1Itc4uyUzpWDzqKaBQRn
        TYWERrA/ZiES4T/XPW2HNx8m86pvkA/e3o1remg=
X-Google-Smtp-Source: AIpwx49iyiBVI3sWNBPPn51p4LoCoaiaU4ITMWauoDxt9GsZzZYzRCaBmSemD3be28xJaTKxWGnOIX1S5+nUEsNzEnE=
X-Received: by 2002:a17:902:6184:: with SMTP id u4-v6mr2411800plj.390.1523561775092;
 Thu, 12 Apr 2018 12:36:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.178.66 with HTTP; Thu, 12 Apr 2018 12:36:14 -0700 (PDT)
In-Reply-To: <20180411210857.22598-2-asheiduk@gmail.com>
References: <b227d2b3-dfe8-09cf-2705-da70bfebd268@gmail.com>
 <20180411210857.22598-1-asheiduk@gmail.com> <20180411210857.22598-2-asheiduk@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 12 Apr 2018 21:36:14 +0200
Message-ID: <CAN0heSpD+TurNsP9Xtwh2OwQaenSCJ2GdpDbZWoifPDBC+tZHg@mail.gmail.com>
Subject: Re: fixup! [PATCH 1/6] doc: fix formatting inconsistency in githooks.txt
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11 April 2018 at 23:08, Andreas Heiduk <asheiduk@gmail.com> wrote:
> - reflow some paragraphs
> ---
>  Documentation/githooks.txt | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

I have reviewed the resulting githooks.txt. See the diff below for two
more instances that I found. For the second hunk, I have difficulties
parsing that paragraph, but I still claim those should be backticks and
*git* read-tree...

Martin

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index ab5ce80e13..e3c283a174 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -80,7 +80,7 @@ This hook is invoked by linkgit:git-am[1].  It takes
no parameter,
 and is invoked after the patch is applied and a commit is made.

 This hook is meant primarily for notification, and cannot affect
-the outcome of 'git am'.
+the outcome of `git am`.

 pre-commit
 ~~~~~~~~~~
@@ -400,8 +400,8 @@ when the tip of the current branch is updated to
the new commit, and
 exit with a zero status.

 For example, the hook can simply run `git read-tree -u -m HEAD "$1"`
-in order to emulate 'git fetch' that is run in the reverse direction
-with `git push`, as the two-tree form of `read-tree -u -m` is
+in order to emulate `git fetch` that is run in the reverse direction
+with `git push`, as the two-tree form of `git read-tree -u -m` is
 essentially the same as `git checkout` that switches branches while
 keeping the local changes in the working tree that do not interfere
 with the difference between the branches.
