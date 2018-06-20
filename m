Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB0EF1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 21:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933383AbeFTVug (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 17:50:36 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:41701 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933227AbeFTVuf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 17:50:35 -0400
Received: by mail-qk0-f201.google.com with SMTP id b195-v6so850730qkc.8
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Sen9V+9CXHur3UzEaNgmw+mvyUYnO75ipdbz46TmH84=;
        b=hZsXEhdrZOfp8ggiXOxQjNlSlMG4oj8jjH2vEGAlLHVE90AkmIUaGIjlIagfdjpHEa
         5drd0bpemEJbuFDCyTv6IRZkOY1FfefSJ1vF3k64e51iiwBluGKPK4eNpWVrmk0yloVW
         BsBCTXCs9/0K0tK7m14VJ7MOrlhN7+WoonueCmVBCCjc9QU6mUQ4RqwpuPIYjed6XdiG
         TtHfFj6QstrbrsKuwa5p7KmLYHGoyyG/NsWBSoIvV+6BwkKw1NOOpL+9kdcOv0kKji6t
         O7i11R4At9L2ybKzZq0BkbQuBZyrrfWP/Yqf6iHAJfSecLdJGg7fXUTvqVWMPKTSkOY4
         WODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Sen9V+9CXHur3UzEaNgmw+mvyUYnO75ipdbz46TmH84=;
        b=eK/EdEMror+iMibdzOcPu8lV3ePP1ZTcNIpgE1HEi121p0Ez0L7j9CyPSgJynNbzWN
         HoHrfh1c48oIhT6SV/W+tZ5CZeAo6B4z/m1zHqX9Lb60R+adXJ8MN72KtkYma0uwUX+a
         yYdMThB5t5zZAS8rAq7rC7yJ4BhEz94MsLoVb3oF7sfv0MNDSxlWxhBtjx5mpFF2eAwm
         /4ySYUdwXGuyAkd3MxdBQmriwMBh++M5xo4t9sR7pl3cc2hv3gLR+v5k+llCJ+VT9mqa
         VbALPwCyoedWtlnJmHluDClicvQ+2TTQbZ3h/VPJ+1hEmJbEVIGBKORULzRzLQ/zitat
         vM7A==
X-Gm-Message-State: APt69E2k19E6EuOdaoXBJOj14437ifQnKSQ+t3yHYtcbNJaxAW5ZCLoO
        AN89e7D5irLWzVEB7+sANOaDvHWT+j8V3eqdowRUptLj5mDxHDuq51TbDUK7HuDGyFN9RfBeJAK
        XEPR4lIuSX9kWAQagTGbqPVKINfxzx81qsBG92LW67GLXhsgb7UOa2cbRHw==
X-Google-Smtp-Source: ADUXVKJDzrPHkWkwToEJ9Ie5YCaG/iTAKDqiVWbZbvfH5EjxpPAyT+zVppynSrMy1XcHAFmF2Qm8bNcNhKk=
MIME-Version: 1.0
X-Received: by 2002:a37:ab0e:: with SMTP id u14-v6mr12306152qke.46.1529531435240;
 Wed, 20 Jun 2018 14:50:35 -0700 (PDT)
Date:   Wed, 20 Jun 2018 14:50:30 -0700
In-Reply-To: <20180605202449.28810-1-bmwill@google.com>
Message-Id: <20180620215030.21829-1-bmwill@google.com>
References: <20180605202449.28810-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v2] docs: link to gitsubmodules
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a link to gitsubmodules(7) under the `submodule.active` entry in
git-config(1).

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a..340eb1f3c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3327,12 +3327,13 @@ submodule.<name>.ignore::
 submodule.<name>.active::
 	Boolean value indicating if the submodule is of interest to git
 	commands.  This config option takes precedence over the
-	submodule.active config option.
+	submodule.active config option. See linkgit:gitsubmodules[7] for
+	details.
 
 submodule.active::
 	A repeated field which contains a pathspec used to match against a
 	submodule's path to determine if the submodule is of interest to git
-	commands.
+	commands. See linkgit:gitsubmodules[7] for details.
 
 submodule.recurse::
 	Specifies if commands recurse into submodules by default. This
-- 
2.18.0.rc1.244.gcf134e6275-goog

