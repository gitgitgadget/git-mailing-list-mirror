Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3249B20229
	for <e@80x24.org>; Mon, 24 Oct 2016 10:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757141AbcJXKmh (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 06:42:37 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34090 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756875AbcJXKme (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 06:42:34 -0400
Received: by mail-pf0-f194.google.com with SMTP id 128so16286114pfz.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rdRRqESv3oXTrgI7EjciDAVN0H2WCSekgGhOHhPifw8=;
        b=FsnNh1sd6cdLKrRd67fjg5/RnSCiAucSuOYP6+eRKGBuUA7wsQj7zgfox65dg1Xm8X
         aVJhjEp/hDGdunRHgrzmEicJP/F/rQzpfqn2MZFAaI0TaSYfNHuf4SYA4A7l5BrA8oGE
         KjlX98dOTGyl8HBj4OwG6ZJD0sIvgcgcGiLFObCAoJmAEfakGq9HzaAIlVbX6c8lq3VQ
         vSyOOVIbn/fG/EzVOc50qUOQwxMBGgQUg8m143ERJBJ1SDbeD9QNnSjUek5n8HVoe8db
         1ptEHeq8uKm73MdMO5gUEw0eXOjiZIM9r2WuBaXeD483kiKw4VeVqdWmwCvIe1JEZ8FB
         TmsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rdRRqESv3oXTrgI7EjciDAVN0H2WCSekgGhOHhPifw8=;
        b=NSXifGxtUMY4124bcxHOkmmDjWYrNouCybA4wrIbDgqcI7t4hwmm5d6YmD0ORjt8JJ
         OP1gnGyoSiyr7ciRZ0QXPk2Ai4yMXZNtekdJyDh8rlNhl+3ho+JJI5s8YWljDOdG3wJx
         2LrcJnTLbGVIn80pOW/nrhFbDCcuzvm1bh3iYcAxT+wZ4csHj2KOTmAx8pT779CrUbiZ
         Wh1eo6l4BNfmS8Bmb9mH2qVE19/d7zYRJwx65q9qguLtZGvtSqENlzZsSqLnIP1NUeMH
         qYig1QKB4Sb0vdXkiml0j/cjmidqCfqU6sPHZVlTVSvLPb11k6D7D4WXqISXr7putrNj
         qT0A==
X-Gm-Message-State: ABUngveyymCs8JRJjy4qqmQRNrM6+ZJyiDtrQJEJbCLH4JfzoIIAU5P7C+DuaqfjNwZVlg==
X-Received: by 10.99.55.66 with SMTP id g2mr10550027pgn.65.1477305748567;
        Mon, 24 Oct 2016 03:42:28 -0700 (PDT)
Received: from ash ([115.73.162.90])
        by smtp.gmail.com with ESMTPSA id z3sm24295943pff.89.2016.10.24.03.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Oct 2016 03:42:27 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Oct 2016 17:42:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 0/4] nd/ita-empty-commit update
Date:   Mon, 24 Oct 2016 17:42:18 +0700
Message-Id: <20161024104222.31128-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160928114348.1470-1-pclouds@gmail.com>
References: <20160928114348.1470-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version splits the old 1/3 into two, with better description in
1/4. The index_differs_from() also takes a flag to set/clear this new
flag instead of relying on has_ita_entries like the old 2/3.

The name ita-invisible-in-index is not perfect but I could not think
of any better. Another name could be diff-cached-ignores-ita, but
that's just half of what it does. The other half is diff-files-includes-ita...

Nguyễn Thái Ngọc Duy (4):
  Subject: diff-lib: allow ita entries treated as "not yet exist in index"
  diff: add --ita-[in]visible-in-index
  commit: fix empty commit creation when there's no changes but ita entries
  commit: don't be fooled by ita entries when creating initial commit

 Documentation/diff-options.txt |  8 ++++++++
 builtin/commit.c               | 13 +++++++++----
 diff-lib.c                     | 18 +++++++++++++++++-
 diff.c                         |  4 ++++
 diff.h                         |  3 ++-
 sequencer.c                    |  4 ++--
 t/t2203-add-intent.sh          | 41 +++++++++++++++++++++++++++++++++++++++--
 t/t7064-wtstatus-pv2.sh        |  4 ++--
 wt-status.c                    |  7 ++++++-
 9 files changed, 89 insertions(+), 13 deletions(-)

-- 
2.8.2.524.g6ff3d78

