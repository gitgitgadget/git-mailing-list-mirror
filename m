Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E58B1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 12:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbeKVWkH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 17:40:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42821 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403805AbeKVWkH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 17:40:07 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so1853283pfr.9
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 04:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zg/dhvk3XB1DIsq0zDg+pv8FwUluHiw7RzJQNpCZ4pQ=;
        b=X0SjjItIYdwvSsZMLBkf/9PW1lPaKxp/6JXE/Iqa4RPCwAWgJRGZ8TyyI7735yL+If
         yzGsexGostApzG6TP8bUvVPhYRtHSUVGXqUjnXXKY3pysaggBcbdwVF/0Bu7wq6Bx0cs
         xbRPVs94y7dAlHA3/9FLNTt0d+7H27Tm5zAXUFPkRobJKNU2vTokD8pdXwFRpD64SJ2d
         7zhg+WEUqtMVgyPuBz2N55ArEFQ+BFSf6go1QCjC5JeA3lWPZoWTbx+CRuqb/TMqDptN
         GJC38vRvDaO8S8XPvEIuWEYud9nADYzaM8pzcXPtnGfOYJHHFjoounL3ymAi/zBeBNME
         2CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zg/dhvk3XB1DIsq0zDg+pv8FwUluHiw7RzJQNpCZ4pQ=;
        b=M7FkgZFFEpfyRHiS4u/UHVugZt2nhmdTBPNIXHHAEy0Q5M0FAYOCu204Ofq0nztouU
         103uAgPXzj47fgw794z/kfbXsRX8HSk3b1fOxXAdrjGZtJs4OoOhLqo7AolpzHX1eX3D
         1hC7f3h/j0SMlS0ndSofjcJ3gHMJA6hRh8He0G7fDfUTiOxm2dF7DtmE+zJvpIyymf9/
         QKL8sli6C0uAPmKA/O2/xp1fqqX4lcgE5kbY6wugsDwpzUfEowWlimMCa2jSfBUjFk1e
         oGhms327U9MTl8rshpup0Pzt0vb/KkFVsom1YNMojG10S3MDiQ6lXyBCK8GzyUOODE7I
         b+Pg==
X-Gm-Message-State: AA+aEWb0unbSqY6PZJgImvVzO06oCDR7nWhdGafxd/3UECewV87hWDNP
        SEMaaMi96TWKTkBp4RCF+u7zXSEx
X-Google-Smtp-Source: AFSGD/VusVIv7sGKUwDCenBpC9O9j2k1YRMzSrPhXAJDuukCE9tzIZ2vCgeEyEesggN7oOdBWFMVVA==
X-Received: by 2002:a63:5518:: with SMTP id j24mr9627285pgb.208.1542888060995;
        Thu, 22 Nov 2018 04:01:00 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id n87-v6sm67162511pfb.62.2018.11.22.04.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 04:01:00 -0800 (PST)
Date:   Thu, 22 Nov 2018 04:01:00 -0800 (PST)
X-Google-Original-Date: Thu, 22 Nov 2018 12:00:56 GMT
Message-Id: <617f1e7b084ff95f4cc7c5a4b7b70b9a5c0d1af1.1542888057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.87.git.gitgitgadget@gmail.com>
References: <pull.87.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] ref-filter: replace unportable `%lld` format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `%lld` format is supported on Linux and macOS, but not on Windows.
This issue has been reported ten days ago (Message-ID:
nycvar.QRO.7.76.6.1811121300520.39@tvgsbejvaqbjf.bet), but the
corresponding topic still advanced to `next` in the meantime, breaking
the Windows build.

Let's use `PRIdMAX` and a cast to `intmax_t` instead, which unbreaks the
build, and imitates how we do things e.g. in `json-writer.c` already.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ref-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3cfe01a039..69cdf2dbb5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -897,7 +897,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 			v->s = xstrdup(type_name(oi->type));
 		else if (!strcmp(name, "objectsize:disk")) {
 			v->value = oi->disk_size;
-			v->s = xstrfmt("%lld", (long long)oi->disk_size);
+			v->s = xstrfmt("%"PRIdMAX, (intmax_t)oi->disk_size);
 		} else if (!strcmp(name, "objectsize")) {
 			v->value = oi->size;
 			v->s = xstrfmt("%lu", oi->size);
-- 
gitgitgadget
