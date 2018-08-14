Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 959B41F404
	for <e@80x24.org>; Tue, 14 Aug 2018 12:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbeHNPqK (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 11:46:10 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40796 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbeHNPqK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 11:46:10 -0400
Received: by mail-ua1-f66.google.com with SMTP id m13-v6so12984341uaq.7
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YINiDNE/eEzk415qLtfgui9s+Q8CZdtR02NKFo/MSJg=;
        b=qv+4d8X2GX1p4+wHlif46ZnhDycUYE9ELTIcFe2dxLbhclzsGWrNjTvWKuu9uGI2Os
         XwTbxef2frsXnvJVgNHNP6fQEXS7E+ZSAHmW1GN6umV+eRWxhwxqoEwpyBzceMBopL/d
         9s2ZPcvF78KaQw5wJ1ra+kZcVTsohXQperf6SHrVJ8lEjuURr2TuSH6A9eVTCE+U4wjo
         Out6+BjsU675ODNUMBe8iEKjH9jcOvTDhQY/y9FmE5IZzwAXErXZzdjrpsOe4p5+QzG+
         pwpGcw7EUpxrevGTtkVq7oBazTu2c18Z2z7pBUSqWJJdymiqXACACz9hFuLwXwTKFJ0O
         ggZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YINiDNE/eEzk415qLtfgui9s+Q8CZdtR02NKFo/MSJg=;
        b=hfEqxDU4BNQ6p5y2ouYRcIa3KJZdF+MgFS4RK5E1ahEHFVA1Z4U8hDZu/XaWffprI+
         XIdQ0Om/G1z8xvZA3nfqZJWPXhZedCfgxAPjaFfy83iB1f6R4ywqBhQrfeXvnfJ7zsbq
         Dvl6dT/0qMc5EW3JVWbEWc8dkNf8xVmBXWlErnjUkEJ1FrPg9FcTcvEiX6nY5z+5o+UN
         pwDfWD+XwOI6l+Y2ink99EEb8ipje3piB3O47RDeulNWl5n50Qpf/nG2VYi+sSi4puMP
         5adg3eu0TkecfslKP5ACHO7sOwdtE9nRq80o+ACRQFZ0aON6wpnjgXdlqhsm6pqg+9hC
         4GAg==
X-Gm-Message-State: AOUpUlGb0lFCae8cmTCE8MZn/RkbN5g16bwlXgmAwp+QXRy9B9o7YT+2
        m9Wc1f5NptabkAW71hBHfWW6xx5ipQqNp6uV0JIZtkWe
X-Google-Smtp-Source: AA+uWPyZ+m+9Uw0QNhNJa8U004AjUqPZI20z7ibPKkJRhQAd4UJr21lJ1vQQf+PfoDyIhY0fm42dLZwgtnkxyBQdpPs=
X-Received: by 2002:a1f:b043:: with SMTP id z64-v6mr13546153vke.119.1534251544453;
 Tue, 14 Aug 2018 05:59:04 -0700 (PDT)
MIME-Version: 1.0
From:   William Pursell <william.r.pursell@gmail.com>
Date:   Tue, 14 Aug 2018 06:58:53 -0600
Message-ID: <CAJPQ5NaYn=rMb2j1KxEk8518Z3vD+-uEOamuu1QWacgnzNtKWQ@mail.gmail.com>
Subject: [PATCH] doc: git-describe
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

commit cc4bd5268b2dbe90279198acb400a528ee23f5d5
Author: William Pursell <williamp@wepay.com>
Date:   Tue Aug 14 06:41:00 2018 -0600

    doc: Reference <mark> for --dirty/--broken

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index e027fb8c4b..f7d67306c0 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -39,11 +39,12 @@ OPTIONS
 --broken[=<mark>]::
  Describe the state of the working tree.  When the working
  tree matches HEAD, the output is the same as "git describe
- HEAD".  If the working tree has local modification "-dirty"
- is appended to it.  If a repository is corrupt and Git
- cannot determine if there is local modification, Git will
- error out, unless `--broken' is given, which appends
- the suffix "-broken" instead.
+ HEAD".  If the working tree has local modification, "-dirty"
+ (or <mark>, if supplied) is appended to it.  If a repository
+ is corrupt and Git cannot determine if there is local
+ modification, Git will error out unless `--broken' is given
+ in which case it will append the suffix "-broken" (or <mark>,
+ if supplied) instead.

 --all::
  Instead of using only the annotated tags, use any ref
