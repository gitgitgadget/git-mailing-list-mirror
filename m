Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DAEC20248
	for <e@80x24.org>; Wed,  6 Mar 2019 10:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfCFKmZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 05:42:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46976 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfCFKmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 05:42:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id 196so8088943pgf.13
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 02:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eSGvoVzcpHEYOsavRrwgAYLkw+LMlDt7QOTCrPHOXDs=;
        b=TY7IR1wWXclid3U18GvLOz4ZfLIMs0bJtV/92kJgX4ouZOgSq+PHFo7SEjfRGjTiQT
         EGCvuBFVGcWHBojmObGbeDRBtLzjlbTRc0xYD05f+vWSL031Fl8eHGY6QQ6x9XCZz7u3
         iSkc5hisAbmUffOk2mvpGsNQzILCwBsANk/v4S6dKVki5cq7qszdT1ykko+vDtbFhk1J
         2wMUM2GglO1B8pQ4RZwfxi7qMGx2XH9xBgNCxrzQzvKZXbRRRf53R0s1EHpBgMiXz0pb
         s6JY8hyeKdKMNDdyMGHSNhmhZx5BG55nLSvuphIk91j4lbEa70kGRqk2lziP9MT06zEk
         D5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eSGvoVzcpHEYOsavRrwgAYLkw+LMlDt7QOTCrPHOXDs=;
        b=BqkwaTGGu6mxfYSvOaMjEOBCaa59x2nOxwgsNU+JbaI9U32zYgQ8zrq1FlE195C0zC
         +JAPdhAi13cZppfjmEI7BTBepCW9PBkU4hRpkqBRJbLvPhBEdx4F4rZl1KnFBCk+qexP
         8DMm8nIcHysWgsyP8EHqccUY577rhY8EZkjx9KT+vr8ctYl3oJXCt96LoqvWbURQIQGS
         VbBm43o512ZdPJC/vyk1NQxEyMKaFvZPe/nw6fXqbr7k9QXFuWqIogcQ0n70wIxYPzwP
         /I9WCfpPuAN7eiersvKbac27c734vruE3XF5sv6hkiOOA8mf+Xb9fG0XC/nRhkHJHkXD
         8OPw==
X-Gm-Message-State: APjAAAXdzp9CR+WUDZC2d2Zu7cApwYyKsguGjInXW0Wgp2cuYydxOuat
        Rh7sEm0UvDYYDRcmjv4UnwkHOmvT
X-Google-Smtp-Source: APXvYqxBnuyXt6CbS+WSlw3pWMQa/WrqDRaEH20gtJvB7HbMSRopJRaGSoAmdCnQ6l/CozV+I8lahA==
X-Received: by 2002:a17:902:9a4a:: with SMTP id x10mr6042807plv.93.1551868944036;
        Wed, 06 Mar 2019 02:42:24 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id k72sm5407706pfb.122.2019.03.06.02.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 02:42:23 -0800 (PST)
Date:   Wed, 6 Mar 2019 02:42:22 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     rpjday@crashcourse.ca
Subject: [PATCH 1/1] git-clean.txt: specify core.excludesFile variable is used
Message-ID: <f8bc322cc5727d9cf45037f4231f88956f07b7f3.1551868745.git.liu.denton@gmail.com>
References: <cover.1551868745.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1551868745.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the git-clean documentation, -x and -e documented .gitignore,
$GIT_DIR/info/excludes but neglected to mention the file pointed to by
core.excludesFile.

Explicitly mention that variable so that the list is exhaustive.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-clean.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 03056dad0d..c6023b742c 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -55,13 +55,15 @@ OPTIONS
 
 -e <pattern>::
 --exclude=<pattern>::
-	In addition to those found in .gitignore (per directory) and
-	$GIT_DIR/info/exclude, also consider these patterns to be in the
+	In addition to those found in .gitignore (per directory),
+	$GIT_DIR/info/exclude, and the `core.excludesFile` variable, also
+	consider these patterns to be in the
 	set of the ignore rules in effect.
 
 -x::
 	Don't use the standard ignore rules read from .gitignore (per
-	directory) and $GIT_DIR/info/exclude, but do still use the ignore
+	directory), $GIT_DIR/info/exclude, and the `core.excludesFile`
+	variable, but do still use the ignore
 	rules given with `-e` options.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
 	conjunction with 'git reset') to create a pristine
-- 
2.21.0.317.g7f43cb445c

