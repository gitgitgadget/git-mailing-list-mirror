Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48ABA1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 22:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeHUB7C (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 21:59:02 -0400
Received: from mail-yw1-f52.google.com ([209.85.161.52]:37542 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHUB7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 21:59:02 -0400
Received: by mail-yw1-f52.google.com with SMTP id x83-v6so69984ywd.4
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 15:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8mTI1+a5+TRH2Lwrujn00YE6MhN8HUV1/tJyCBu9yA=;
        b=MlykcVASvSGOYgQ7ZfQ6ijx99M1upT1bPpbOtNa8UQJ2JC+0fbhzPp8c6XwU/KaSI0
         dfPk4+Xp/sG0XrSMtffS44UOJtopICv3Q4lg1eEOVCydET0GukxbNO8BOBAmoMjr+T9Y
         nRWkRcIhB/2Ctui/0p13fxwt8tW48QhCZP+W6rStj7VtJ3psabi7Aheg7TbJ90KypekK
         72zyQnimPK0UWsEObVpevvT7VYRMhT6BaJalMttqpHSxekWorpxXfwfLEC2XhNaQen1A
         2j1vzArod+r+RC3FwRPUwlX2JpNOnv88r4+sq5ukBmyVMOTZEa+YhdWYdE40QvIjGfkI
         +2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8mTI1+a5+TRH2Lwrujn00YE6MhN8HUV1/tJyCBu9yA=;
        b=K+rVpMPWA5UzBcrJqUA/jnq7K0sxrw6fQf+Q0HLhAJzmx+iSL/YqktG7UoeM+ZZnqP
         cie3V/uD/TBWGzi/AbrmZwxqT2MhWkzQ8DKgGH9n6bfkaMflQU/00+lZ7NJRX6Jf6iQM
         NQEozHaoBiWIhaDd9D5vPZvXMj4V/QyR7FQUOHi+QARilLIv1XTecOuR/Esz0rvqkx0+
         m9kI4FA+TaXzLbXI2GqtQhPQrg4KzRs7+e6f3pmsEWaVJ2XYP1YemTGw2qy9P6rT64nD
         aC85JrcSaeAfRxJXG/uhkwbELEBxV0cRjWE1KtUoGusVmy0JUUN4uAU/zU98nb6OFhs4
         cwuw==
X-Gm-Message-State: AOUpUlGICXPrQSJGUQnLIjrgoFV9jzgNcHn4+XX0pwAa/skezNoDPLSK
        6a4iJzPSK+m01o8w7sxaPXXprOCwrCwxRbMHnJiwLw==
X-Google-Smtp-Source: AA+uWPysgqxw3NKt5xTCv3YKUFTLH/Rq8AxyFbvSODgKjeqW+2ih1WvEOG75XmScZjMglRW2Ww4AnTyO06Bpfrc90b8=
X-Received: by 2002:a81:6a45:: with SMTP id f66-v6mr7909387ywc.300.1534804892721;
 Mon, 20 Aug 2018 15:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwoskadpe.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Aug 2018 15:41:21 -0700
Message-ID: <CAGZ79kbrv62ttBYt7nwO7E4S7wTVWZGceqE6hPjAbhPPWfRkEQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.19.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>  * The conversion to pass "the_repository" and then "a_repository"
>    throughout the object access API continues.
>
[...]
>
>  * The conversion to pass "the_repository" and then "a_repository"
>    throughout the object access API continues.

I guess it continues twice as two large series were merged? ;-)
sb/object-store-grafts
sb/object-store-lookup

The latter one is not the correct one, as later we'll have

  * lookup_commit_reference() and friends have been updated to find
    in-core object for a specific in-core repository instance.

>  * "git submodule" did not correctly adjust core.worktree setting that
>    indicates whether/where a submodule repository has its associated
>    working tree across various state transitions, which has been
>    corrected.
>    (merge 984cd77ddb sb/submodule-core-worktree later to maint).

Personally I do not view this as a bug fix but a feature
(but then again my thinking might be tainted of too much
submodule work) hence I would not merge it down.

Stefan
