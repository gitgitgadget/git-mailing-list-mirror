Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E4F1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 23:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfHSXwz (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 19:52:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39626 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbfHSXwy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 19:52:54 -0400
Received: by mail-io1-f65.google.com with SMTP id l7so7511650ioj.6
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RmbJmGwcbrez7IYtDTPKJWe+HKlSRxeFuEJIgp3F9xs=;
        b=fqQEq1HgRnAM+R98utmKkC+Hxz3PQlMaY121o7trgyRsyMspC4ZM29KmnJTj+C0XV/
         sPq9lm4iqUBRsg+XkSm1QN8iLQneZFU9zqP2dP1iQ7EjMnycxHJUn6x2NL7nQBvSctre
         PM1vRjys0HYWFehAjyDjCHy61A2RcfUivErR0BJZOFeLvFcnFBDxUoVG/RbWyyskUe9f
         FLQ0+A+KsfG6PMOZny/gmF+BGC20g35G7Yu6F6STAav3fJRzAF/T+Mwxskow80nFDF02
         lWf8DNPR/W4VZaXLrm41LtKuH+ImEhNmgmTyMU8QBtlLnSkTwzoW51z0QPve4+nomp7d
         Pv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RmbJmGwcbrez7IYtDTPKJWe+HKlSRxeFuEJIgp3F9xs=;
        b=rua9VBq4B0I0woKajd0hCbZkRGUBUJzTm/4jO2y2KWiHgkN/M4Iv0836AWNI0/PvIB
         S5rrtL2noomlPgcOrEDKMUDqIryotwUH0SJaQ3z0gjQRbcMTWeXUn7xWIbT4st8q+G0f
         KHcFUdpely652CYRkPr6qeYtyA9uSl5Di3TswQIvIHgjWzOHHrEle26/6TIoCat8hYOI
         iXTfK2A8KphQDsYjsIpn7CiEPb3VeaSmgdMR//4Lk4h8kNsG8TD9lgL87/bIuAAI4O13
         Zqzj/Fcee/lFM7y//qrA+2bsTWPoECR6nrAIbIYTvP/xrc2rlAQTctwe/CBZEMzuL+nF
         9ybw==
X-Gm-Message-State: APjAAAXFBmer6fAJ17QDJDaaMkpWsu6wl6OsEhR9td0C7tBqSouNVKKK
        y8ZmnPmDXhybtjLdzinl55iRR5p1
X-Google-Smtp-Source: APXvYqwDwCgU98MCAi9DQL7qMpjs08QXgAsVeEkGIZVzgk06aGsEgTbv1lxui+H4T6/uHAZq8Ts5PA==
X-Received: by 2002:a05:6638:35a:: with SMTP id x26mr538022jap.104.1566258773199;
        Mon, 19 Aug 2019 16:52:53 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id o3sm15427739ioo.74.2019.08.19.16.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 16:52:52 -0700 (PDT)
Date:   Mon, 19 Aug 2019 19:52:51 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/4] config/format.txt: make clear the default value of
 format.coverLetter
Message-ID: <94a778c9aa561c8cbe5ef39e21695db3124611b4.1566258525.git.liu.denton@gmail.com>
References: <cover.1566258525.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1566258525.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 414a5a8a9d..60e4e92885 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -74,7 +74,8 @@ format.signOff::
 	Please see the 'SubmittingPatches' document for further discussion.
 
 format.coverLetter::
-	A boolean that controls whether to generate a cover-letter when
+	A boolean which lets you enable the `--cover-letter` option by
+	default when
 	format-patch is invoked, but in addition can be set to "auto", to
 	generate a cover-letter only when there's more than one patch.
 
-- 
2.23.0.248.g3a9dd8fb08

