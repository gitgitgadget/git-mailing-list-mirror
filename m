Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3039020A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 02:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeLKCAo (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 21:00:44 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44415 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeLKCAo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 21:00:44 -0500
Received: by mail-ed1-f54.google.com with SMTP id y56so11162597edd.11
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 18:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jqp5yO/6XfFUli5yKhBlaiTBZ9k/WdPkRR5hcUuJXy0=;
        b=Kcyj6Y/FAzvF0MKCADoWUS2s1CTEdtv7PH54gVf6/Xq+d1rY+NxLD/6QQnu1aU5ALQ
         fWa/M8j3MS9wakJUPs1COvU3299shgTHFM3DMC0GuQt3v/2zmorth8qOwtUpueeXqCfY
         4sdzK5gcG7j7R2fDCrgf03/f1NKPXUFZW9N6JpqjIhAoPHeA+KUwicMdHUmgZTd35QYE
         QXzUTPwpFeP73yNJIuD7+kiSXnYixWyv0KWjyKpp6dG0ZE0M2aEIWI7OBppUDL1UjRye
         FVB7xoSSUcOi/vu2cdXbf2+td55PEykAk2wlZt4VLWY3BTUgQdoqwNZLIzZ9VidzQ+YK
         S1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jqp5yO/6XfFUli5yKhBlaiTBZ9k/WdPkRR5hcUuJXy0=;
        b=Qm2dQGUoNz0nc8+kCEr4LkwLYU1kOHAzRXhwpJmU7aShfA8Ju2aUc8S3r2Uf5DO7DI
         KGK6+67z5yQ7M7nIXDu5O9+ophth/YorQXD7AhZmUNPonulgpT9sYZsAvAcb3vPK8Mxk
         FJ23KDwbdkZ8MiRU1QyytVHZgA4ctaDbxu1Rh+Nkejr2/fP3MsAtsa0yYzHnrwvAv/3v
         bQrQdyuXSWWU6GtIHZ0D3xG7q9FIaQtt91gHblbY4gflBlCXAGRpqomt/ZgrikXTrhl+
         3ygHQtOd7MeAxKRiQw2EtgLt7LdU2K/+CAFo0WsMTd+ZxNsw/x64sLDe9mLwmpEWgwkB
         oDhg==
X-Gm-Message-State: AA+aEWZOSl5GNTjnojWEZ8rFaGCtarY2aRn3y2DUcOVdl28oLMYk9WZY
        PlvdjEOU5BRgcprXefonwSTNJql5DhaV17HLrgUtEPjKxEhkMw==
X-Google-Smtp-Source: AFSGD/W1P0jzVL0itaZFmHMCkFpo7/Bmzq874AZE7jBm9rbPwS0zOaqi948tudX4JT3eqWNpICk3T+nJfsi9Twjmghs=
X-Received: by 2002:a17:906:3712:: with SMTP id d18-v6mr10987952ejc.126.1544493642018;
 Mon, 10 Dec 2018 18:00:42 -0800 (PST)
MIME-Version: 1.0
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Dec 2018 18:00:30 -0800
Message-ID: <CAGZ79kZrYP05=eSx4=09Y9Nx9pNMyyKz=tGXjueuhVgJo=Z5bQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2018, #01; Sun, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * sb/more-repo-in-api (2018-11-14) 23 commits
>   (merged to 'next' on 2018-11-19 at e5d2a129da)
> [..]
>  The in-core repository instances are passed through more codepaths.
>
>  Will cook in 'next'.
>  cf. <20181115221254.45373-1-jonathantanmy@google.com>

Looking into that.

> * sb/submodule-recursive-fetch-gets-the-tip (2018-12-09) 9 commits
> [..]
>  "git fetch --recurse-submodules" may not fetch the necessary commit
>  that is bound to the superproject, which is getting corrected.
>
>  Ready?

I saw you picked up the latest iteration of the last patch at
https://public-inbox.org/git/20181206212655.145586-1-sbeller@google.com/
which has received no review comments, yet, and you seem to have
just taken it for replacement without looking closely.

I think it is ready, but I seem to be an optimist at times
when it comes to my own code. :-)
