Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B78E1F454
	for <e@80x24.org>; Thu, 31 Oct 2019 20:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfJaUlv (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 16:41:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52417 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfJaUlu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 16:41:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id c17so12028wmk.2
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 13:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gRlYzP/Tdc9TBHQ63b4M2R2CFqE0du0IqxoOrRzDEqM=;
        b=ubn/NCDkBiV59tW6cXyn5PsqCeNhnCpTtEWeqCWKUQhAP7wKsNFgqncutxU3o0zHY6
         wpD9VatF/SnwJt5uz0CmawpLNorzgeSkncqGEAMik0T0i1nvfD6bRY12iQD3MYFytswx
         y5MSW5gJyXoqvoWHerXKp5OC5LTzpa9ZQbIAhRWwcMzkWog2ZS5gkwxdg6LJ8tPF9Ye8
         v+1MemJqSliTP0IiK3Ox77tSb3fs57lDlM3bkK6mUKRD8jKOdJbeyZt/vkqvWiMnAwR9
         Ri3XW7vSlWf/HkoL4HGx7eiCTicsMB7MnhQWZHej28BHhu70DaEjRZZB63Z1wEjV4Jcg
         6ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gRlYzP/Tdc9TBHQ63b4M2R2CFqE0du0IqxoOrRzDEqM=;
        b=GKonRdJhP0M+CqhsBgcuojS6nuS0P0XTZ4/TzcrXqdyMJfLp9W33R+GmKSjmFtLdzr
         UMONE46YmEGIwZvUrCwTJOngMxDBGwPH15ekkUyH0x8e1A1beuRfgVEfyZZmp4OA0zis
         4DPfUJerIGXCdU5Y/CN+8fgc93laO3wfrmM/iS9aqENVOm0oAOgBu0kph3qF496k+rNx
         52dg7UU57waptFmglV3x4kb+wSlMbKwIq7b7eIe5NuWFAHgcRU5FIA8zU224ESrDqZ3p
         LcE7v5i3JXM+0Op2Ct8LqgTjACTnW5vYok0A1uhKvG26FhWrTN+IubpHUtW4BhAsVkyF
         swlg==
X-Gm-Message-State: APjAAAWncB8tyVc6tl1nrrEjJ5B80gY3YlrZxTpETNgr9NM/AC/YEGAE
        Ng7R+waZafIYWpQ8TB9UANQukH+F
X-Google-Smtp-Source: APXvYqwEryIESKpANS5/jrHrKL4eKA6cyT9e78GFnta5khlkF+w16rgk+Bn3vOoBS52mCAq1wd6SdQ==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr7286738wmc.143.1572554508194;
        Thu, 31 Oct 2019 13:41:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k4sm4398032wmk.26.2019.10.31.13.41.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 13:41:47 -0700 (PDT)
Message-Id: <70f10fe44716e50765a9d8f7794116f390f09dbc.1572554506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.441.git.1572554506.gitgitgadget@gmail.com>
References: <pull.441.git.1572554506.gitgitgadget@gmail.com>
From:   "Ralf Thielow via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 31 Oct 2019 20:41:46 +0000
Subject: [PATCH 1/1] fetch.c: fix typo in a warning message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ralf Thielow <ralf.thielow@gmail.com>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0c345b5dfe..f9a934f098 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1411,7 +1411,7 @@ static int do_fetch(struct transport *transport,
 		for (rm = ref_map; rm; rm = rm->next) {
 			if (!rm->peer_ref) {
 				if (source_ref) {
-					warning(_("multiple branch detected, incompatible with --set-upstream"));
+					warning(_("multiple branches detected, incompatible with --set-upstream"));
 					goto skip;
 				} else {
 					source_ref = rm;
-- 
gitgitgadget
