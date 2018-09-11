Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9561F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeILEvo (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:51:44 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:35901 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbeILEvo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:51:44 -0400
Received: by mail-ua1-f74.google.com with SMTP id m19-v6so53598uap.3
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 16:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UY9P6GTLun6sLU3lqilisBa+iFBbQb4RZUF6QIpwrXk=;
        b=tvjyCuZzGOSyLyMq9Nq+jvB7e/EdyMLQLB8AZn6NlXyNXaEtZghVJ4jADhogYla06G
         AnGsrsj4YBCH1pKX0VxB6rm4IoqaHP59rDxFg+lHe+DEXyMjAexZS816Z0sBDmR1sdVO
         yoSErZVbDKOT/3NvxviBxj1SoT9aJdbp2R9ahpndJ+TjpYMul2RxuWdmuGbxMamdNlvW
         CAZRC24NzBK8vfq+kW0kpzEbNEUG9Gtil5L/s3b0+fJwn/akPLcL1LljA2ta6P4qKJo4
         sYuo71YDDCZij2InFpj1utBg2juBucRy0fu7JZVSmprPrre+9i1r1FpOH+WsJXu5bcTV
         5FRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UY9P6GTLun6sLU3lqilisBa+iFBbQb4RZUF6QIpwrXk=;
        b=t2rL5x90kQcEqUDXbRrgHWvzqDxfC+eE2AGa6qqAHdZDYp1wH0eOPK+1APpI+1S/OX
         okFW8O+/fYm7G54cbzMpsjjTtB7uPhiKZqmdSAJAwyMj+C/WGeYzosbd9gMcXzmWRlFl
         TJIAMyMvRKtV3Jd0XHErlyEWj6ND8hMVVK93natvv3liKBVpNs8UYJ4x29Zy259R3igc
         KHTpZCf77NgtiSi5epLFu52XDv3kRs5p5R4GiYKkK9B1ltLFV7fIzpBlRadMAUHnHClG
         uuMoZf6ZihHZ/Wzb6oug2cl9Me2IyiMIIvrpxboLpASvK7VsSDgO7jAsibIHQPwhEq9L
         +fBg==
X-Gm-Message-State: APzg51Dvz9/p9JqkyljVeeIfiPIV8g/mEyACm4aT5iHoBU/HcM+xeyHk
        nTZLw2pGi9nui78itHY/nlTGq48IBdnLrrhV3b4RD+hUtq+OShkf7ElhH+TIR7tK7J+mO4pLSE9
        26s+6qn/dIVP6tZuS+mEljjznHFp0MwIsZfQTw4B6JSFSnOgXCKJhJ4WRfCRf
X-Google-Smtp-Source: ANB0VdZhAOP/NEE0q97S40Ga/+BJc4A9oKw4ws75vV31UZ3CMowpZwEcqm+76t3IDb8+INSOGa6USeh53dU4
X-Received: by 2002:a67:3e1c:: with SMTP id l28-v6mr2979932vsa.54.1536709805251;
 Tue, 11 Sep 2018 16:50:05 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:49:45 -0700
In-Reply-To: <20180911234951.14129-1-sbeller@google.com>
Message-Id: <20180911234951.14129-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180911234951.14129-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 3/9] submodule.c: fix indentation
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule subsystem is really bad at staying within 80 characters.
Fix it while we are here.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index a2b266fbfae..d29dfa3d1f5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1244,7 +1244,8 @@ static int get_next_submodule(struct child_process *cp,
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);
 			if (name) {
-				default_submodule.path = default_submodule.name = name;
+				default_submodule.path = name;
+				default_submodule.name = name;
 				submodule = &default_submodule;
 			}
 		}
@@ -1254,8 +1255,10 @@ static int get_next_submodule(struct child_process *cp,
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
-							 submodule->name))
+			if (!submodule ||
+			    !unsorted_string_list_lookup(
+					&changed_submodule_names,
+					submodule->name))
 				continue;
 			default_argv = "on-demand";
 			break;
-- 
2.19.0.397.gdd90340f6a-goog

