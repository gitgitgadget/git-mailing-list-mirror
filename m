Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B2BC433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 12:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbiDEM7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386749AbiDEM6C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 08:58:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3846DA8EF1
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 05:01:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id h19so11901157pfv.1
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 05:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ylAsXjb+SmNnzePbqQdYfKfpMjXCCSGFzZlijzYNnLg=;
        b=SErZCc8kQ2ZfmcN7GTzG87ZbTzSBTifTX0GRUohrsi63sBjapTfnmJHnrYmq47UlQe
         H2JiUxMx7Y3FLDcK03n/Q17rehliG6xj89mDNFTYvmJOFIX8KfXER/zrUsQ/PFDHZ8D7
         oPKXYtJCkBouI6dkVaUUC8eJ1gGSumSWHP0aStqD9mgF9mcT6DdN6iK+6ciE7I0JifpE
         u8EbPzevdMv6EsMWV6kfeJNm047URIvQP5EvyzaGeJrcXNbo+fSuV9X8wl2mI6jQ3KbC
         XWftQDpMxYl1+6OtxbTxtXjidgPgCrQp23h1nfcvGi0AXI0DoBaPWnk6B3WBnRu0ULNe
         CzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ylAsXjb+SmNnzePbqQdYfKfpMjXCCSGFzZlijzYNnLg=;
        b=cwM/pwIsHL31aXfqDvIbVDtS9RPjGoyN9Dmp6enD70aj4B4QWpw/gnePEUgJ8KAC0i
         EDP3IYOnxc2sgcYiAtaCZ9jmhNFnRLjS0+/Z4NAQefyTW3sd238TgXfCQ0b0ApgR4YZ6
         xXLrWvK3yjg1QnB5WPL0S7eXex1+NqzeROJcGQ1BD0ll+bcPv5+4hw4CPKNY2i2usdQW
         4LGZspGC+8Swd5np6obftdeP5nZShihVXCsIEbO6i0wzsIQ3EBsCp0OCkpCKUl3KrVX8
         C2IetdT6eCpizNeMpbn2rtmGrI9q4cDMizhc8FFBIq5C4Y9mXVPt0w7ItcYNUc5PY0vQ
         e7BA==
X-Gm-Message-State: AOAM530K/GWWb36sIBkGSEWpa8v8eTl4nORR7CuxwkrqtIv5dPYeRfkb
        Jax3rmJ5udETBMU+vsffUE5zJ1DQ/qGHqf6ZiCJ6ryonWE4=
X-Google-Smtp-Source: ABdhPJzq4clmyxmW1g23agqT4PhqEIMFy0fQL5oeu9Ki1XlZkxh6pNdXwtFcWHC4JGiZCEb/Yfo7IvOm/TqkcxO5Tng=
X-Received: by 2002:a05:6a00:87:b0:4fb:39f9:bb9d with SMTP id
 c7-20020a056a00008700b004fb39f9bb9dmr3276390pfj.48.1649160093316; Tue, 05 Apr
 2022 05:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <BYAPR06MB4517DD6F852491B795FBC922E6E09@BYAPR06MB4517.namprd06.prod.outlook.com>
In-Reply-To: <BYAPR06MB4517DD6F852491B795FBC922E6E09@BYAPR06MB4517.namprd06.prod.outlook.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 5 Apr 2022 14:01:22 +0200
Message-ID: <CAP8UFD2cy++9FURkNCXFvvrP=--SXAGdV--mnXy9a09k3Mta-g@mail.gmail.com>
Subject: Re: [GSoC] Applicant Introduction, Microproject Selection
To:     Jack McGuinness <jmcguinness2@ucmerced.edu>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jack,

On Tue, Apr 5, 2022 at 4:33 AM Jack McGuinness
<jmcguinness2@ucmerced.edu> wrote:
>
> Hi,
>
> My name is Jack McGuinness, I'm an undergraduate at U.C. Merced, majoring=
 in Computer Science & Engineering. I very recently found out about Google =
Summer of Code, and as someone who has been very interested in the concepts=
 of open-source software for a while, I thought it would be a great opportu=
nity to get involved and start learning more. The git-scm organization imme=
diately stuck out to me, due to both its widespread use and my personal use=
. I've looked through the idea list and I plan to apply for the "Unify ref-=
filter formats with other pretty formats" project.

Thanks for your interest in Git and in this project!

> In preparation for this, I want to do the "Modernize a test script" micro=
project, but I wasn't sure if someone else was working on this already, so =
following the recommendation from the description, I want to instead modern=
ize t4202. However, I want to check beforehand that someone else isn't alre=
ady working on this, or if there is a better test script I could modernize.

From a quick look at the mailing list archive, it looks like no one
else is working on modernizing t4202.

Thanks,
Christian.
