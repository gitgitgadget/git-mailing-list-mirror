Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C398C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 02:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5A2C22BEA
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 02:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgG3Csh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 22:48:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39677 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgG3Csg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 22:48:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id q76so3592200wme.4
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 19:48:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHfryl5RqhNCarEAlOHb5P1fViRyuMNABXhOi9J2oFU=;
        b=NQWnmhTANgAzPAfY14Yo1gPLy+bVIKf4UzcC9GXzlTunOB95AjjJL1kYKAMifqL5au
         ioy4nB9iQK3w2UGQ5JPY8C2PmteHFtjV0zBihRh1b6yZP66QdONpV2zNeSmi+wfj47mH
         qG/RZ4tEcBw32PbbOefiidP8lfvW9ItqhsTGp2sTMrnrkcHCVYMosFjovhUK9FgIYhz1
         qGr5FPQAMsuGtiAIl7ZZiiGJ9sPCG4aRACDwz7n9CLc+V1VafyIXUOP33ewhRz8XUZ/8
         HvW1hmxxr+YjAYKdWRmUGT2fOjX8HtdyVptB9+YQQ3aB1mAb5FkFEhO/MfZYxFZLLvOx
         o6ZA==
X-Gm-Message-State: AOAM531kZjgLi/GZoknVHpGVk7lK+hmpFNRZEQHfKmge694dVNzuiRVE
        PZ4qbE5QMuyzpH7/zUrRD31NWDpoC8mkD/cEmhWyYGSB
X-Google-Smtp-Source: ABdhPJz3hnIAC3wYEX/dG5cScoq7zoKCUEWYZy9OfYU/XCqS/6ix8Mgk+zPx7MCaSo/UB86lqA1Bgqftn9sz1TMOXVk=
X-Received: by 2002:a1c:4e0d:: with SMTP id g13mr11237845wmh.177.1596077315033;
 Wed, 29 Jul 2020 19:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200728233446.3066485-1-sandals@crustytoothpaste.net> <20200729231428.3658647-1-sandals@crustytoothpaste.net>
In-Reply-To: <20200729231428.3658647-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 29 Jul 2020 22:48:24 -0400
Message-ID: <CAPig+cTxfheSPHJvC3_=jQjef0S7FiMEWCQ71ER7epfpeD_5OQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/39] SHA-256, part 3/3
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 7:15 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Changes from v5:
> * Remove useless test_oid_init invocations throughout the series.
> * Fix a commit message for grammar and style.
> * Fix a typo in a shell case statement.
> * Fix http-fetch to allow parsing options before failing on a missing
>   git directory.

Thanks, I think this version addresses all the comments from my
reviews of the last several versions of this patch series.

I've read through the entire series a couple times and paid close
attention to the range-diffs, so FWIW, I'm reasonably comfortable
giving v6 my:

Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
