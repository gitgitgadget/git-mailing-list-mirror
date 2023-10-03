Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F842E748FA
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 17:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbjJCRig convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 3 Oct 2023 13:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240550AbjJCRig (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 13:38:36 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1ABCE
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 10:38:31 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-65b162328edso6832076d6.2
        for <git@vger.kernel.org>; Tue, 03 Oct 2023 10:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696354710; x=1696959510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LxpVA28Ra6sRn17SBDDRNAJKkNQPPQO+15vc6eJYbg=;
        b=ixCrCYS2vLNjraaB5dA6arfsZRkjn31MnpYRMMCVpwCSZtulC88stkDAxW2FLJLBGr
         dKT1C3kmfB32vLUHNdyKhF4SLJZ+WhRMPoSJ+geqm+6IXlejlHYrAlvhgVdFbEDppnwj
         BR1cNPr6s/jXy7Fz1DJ7loQSVGOrrP2ZV35P/sja5Hdby3tT9szXqylSqmgxvzjdLPUq
         Bh+rJdKkEowjJjaKnwwwGqehSWhNifadn7+1u+3JG1TiNxHKH4ZYLPX+agtgRkXNWF+F
         YUsEi58Wgtv0a/xhJPnbW0bOB7g+bvzi1gdMskgVJhkyZVPNyeeRp69R+RVKMIxMTYVs
         1W7Q==
X-Gm-Message-State: AOJu0Yx3Brzi6Hj0/qMrec2kJyKeEV01wFYbI0vOHpXO2Q8A1zbAJ9SX
        2b/e3RgsHbXiFUfesupDBojWYj93/DdD4Wz6ZqT6mZYs
X-Google-Smtp-Source: AGHT+IGiK3wRs8cWW5zany+86vP9e/HS35Yv6OWlF2HrmiIu/O9lY44TjVKNeRyxtiCbHelsnp154TJAyeuGjRDq4dU=
X-Received: by 2002:a0c:fed1:0:b0:64f:4240:8e1b with SMTP id
 z17-20020a0cfed1000000b0064f42408e1bmr33532qvs.44.1696354710430; Tue, 03 Oct
 2023 10:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <ebcaa9e1-d306-4c93-adec-3f35d7040531@web.de>
In-Reply-To: <ebcaa9e1-d306-4c93-adec-3f35d7040531@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Oct 2023 13:38:19 -0400
Message-ID: <CAPig+cRZ_KzyjWjm-G2qn+t-QA_=CL-tMvTSyZBKrmiHK3RQrg@mail.gmail.com>
Subject: Re: [PATCH] parse-options: drop unused parse_opt_ctx_t member
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 3, 2023 at 4:55 AM René Scharfe <l.s.r@web.de> wrote:
> 5c387428f1 (parse-options: don't emit "ambiguous option" for aliases,
> 2019-04-29) added "updated_options" to struct parse_opt_ctx_t, but it
> has never been used.  Remove it.
> ---

Missing sign-off.
