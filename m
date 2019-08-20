Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B95F1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 21:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfHTVbv (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 17:31:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35562 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbfHTVbv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 17:31:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so74202wmg.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 14:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNkCtjugmIwzsKsWft/dO1fa9a/TyDNbGH4F6AuLEY8=;
        b=W9igs9yXsQINAcB/qBJuwbe4RouFyOF7OoPjf85YPudgdlws7DE8FWkoMV38iG5FNV
         Ajo/Eo2gI3GQQFLrfdSUVkEMCbAYVrWylTFTcTTE5ElXA6Rc/2lWIx0daI+k0FRDvawe
         hVdJynJ8688bTaEXsAHw7zQyFiNnKAlBPavFqhTYq+M6c+bJiDnkpnG9zE5LTxXp6fth
         zoP/AFyWTZJZVan4A4g9AxXTopYFGz4pSvhJv0LejQiwrXOuFFcD468BXVqi26fAuu4x
         MVW65+eC8lbdKFJXYymBrq7mU+02x3anyX+0qBoX78SyN+ihZbUGWTmVM0tNm+cXU3iQ
         5GhQ==
X-Gm-Message-State: APjAAAW9eXkFnpxHG+FmllJHgshDNCbo/OvKJf+t19M7HUNMkeAxp8bK
        6qlp6nlpBNWsiak7jc33W1m/OQJAi+fnyD/3Azc=
X-Google-Smtp-Source: APXvYqyJlTsIaQdDY7reyGZDbdldiDR2TeZCiqSycR7sec18LU95ZH8XOLzXjz4u1R9I4vCJCuwL3tX/F4eetLJfOvw=
X-Received: by 2002:a1c:4b15:: with SMTP id y21mr2046829wma.53.1566336709798;
 Tue, 20 Aug 2019 14:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566258525.git.liu.denton@gmail.com> <cover.1566285151.git.liu.denton@gmail.com>
 <568b3a03a08faf109220aff47c1fd3e68fde3bfe.1566285151.git.liu.denton@gmail.com>
In-Reply-To: <568b3a03a08faf109220aff47c1fd3e68fde3bfe.1566285151.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Aug 2019 17:31:38 -0400
Message-ID: <CAPig+cTAQEdqHHfFzW=khX95qNL8xvyoiN=mjfaLpwJH4axDAw@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] t4014: s/expected/expect/
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 3:19 AM Denton Liu <liu.denton@gmail.com> wrote:
> For test cases, the usual convention is to name expected output files
> "expect", not "expected". Replace all instances with "expected" with

s/with "expected"/of "expected"/

> "expect" except for one case where the "expected" is used as the name
> of a test case.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
