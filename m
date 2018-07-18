Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669111F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbeGRSQs (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:16:48 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:45130 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeGRSQs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:16:48 -0400
Received: by mail-lf0-f66.google.com with SMTP id j143-v6so1853961lfj.12
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=j/98BzM67sPhNQkMmuLx85Iw78nW+n9VN9Ktw2gYNBw=;
        b=YJTryp0r7ZSNftqA/iDpYBq/yx7CtPQcClQLgTEmlqvUWw0IbMh+fC4Ml05po+e1Vx
         vr3xawBa3pZr8qOUTWAWh+YP0YPSA/XSJZJio+3p83x3uO4t6ecAI4bASQKSp1Yc5nwC
         lrV5s+fI/WRlx+JcJxi4ByjYnPC41SPAuLL7JZr2LsQCgY+EJ3j2KRHrlqGoghfu5qiy
         DdxyBnqws+ftvbIzdGSeyY+s0UOBlJesjoTz4U33blxfP2vCkRydj+CjuL3muDFztlVG
         8/pnAqQm8Csm/sIELlAHMWC40+OY+uqkoD/g+MtHW/kZx1SHwRzRYXEUV7y+ocsSORlm
         YotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=j/98BzM67sPhNQkMmuLx85Iw78nW+n9VN9Ktw2gYNBw=;
        b=rzCB++eoRGbSDAisHB3ytvgncElBU9V+E0ITEWH1NmEBNqvQcRdE6wpxFk75mSUU74
         rY7HRGGnuxI6/IKRWWR3ktlBXZKmGwypDAVym5tYMqmPM7jHG+bD/a0uwi0OZKa9CM8k
         PvIZq1vuhT/BLggotCFrH2V0zuC9f+Zsl0Uu3bhaFgYvNmpaBEtE2Tk+K0o1dSl8yH2B
         Y8OQI4uPfw2CdvoJ+wO41K18mAXXiVajKeS1UWoMd4N7Rn6EvVorKPv2JvsZ/yevOsg6
         AyMS8QgkeHyTel5Dg4mkHX9jJoNPB02uAe0L9048eb3+ykMdviF05wN4mg+Nj13k4l7w
         GoVQ==
X-Gm-Message-State: AOUpUlGmBbxvNQ8r36h9C8w3LMrdGJpexYw6+oVQfYCZTAKbelkV9z83
        ayCxpwm8/h60OzF3w9JQesOgWhEg
X-Google-Smtp-Source: AAOMgpdG4Gsqho012LBMtYx5fkYtrAkBo8LwEY5y/Noqi31NWJYZDatOaebfLzIqMGYwAu0/5dVsHA==
X-Received: by 2002:a19:238d:: with SMTP id j135-v6mr4780341lfj.58.1531935470934;
        Wed, 18 Jul 2018 10:37:50 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id q4-v6sm711171ljh.36.2018.07.18.10.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 10:37:50 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: [PATCH] Documentation: fix --color option formatting
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Message-ID: <ccf73807-1856-1ce8-365a-0c4fb25ea7bf@gmail.com>
Date:   Wed, 18 Jul 2018 19:37:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing colon in two places to fix formatting of options.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---

Done on top of maint.

The earliest this patch applies is on top of commit aebd23506e ("Merge
branch 'jk/ui-color-always-to-auto-maint' into
jk/ui-color-always-to-auto", 2017-10-04), one commit away from the
commit that added both of the affected lines: 0c88bf5050 (provide
--color option for all ref-filter users, 2017-10-03).

I grepped the Documentation folder, and haven't found any other
similar typos.

---

 Documentation/git-for-each-ref.txt | 2 +-
 Documentation/git-tag.txt          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 085d177d97..901faef1bf 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -57,7 +57,7 @@ OPTIONS
 	`xx`; for example `%00` interpolates to `\0` (NUL),
 	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
 
---color[=<when>]:
+--color[=<when>]::
 	Respect any colors specified in the `--format` option. The
 	`<when>` field must be one of `always`, `never`, or `auto` (if
 	`<when>` is absent, behave as if `always` was given).
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 87c4288ffc..92f9c12b87 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -115,7 +115,7 @@ options for details.
 	variable if it exists, or lexicographic order otherwise. See
 	linkgit:git-config[1].
 
---color[=<when>]:
+--color[=<when>]::
 	Respect any colors specified in the `--format` option. The
 	`<when>` field must be one of `always`, `never`, or `auto` (if
 	`<when>` is absent, behave as if `always` was given).
-- 
2.18.0
