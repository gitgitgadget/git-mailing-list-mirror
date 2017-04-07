Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7768120966
	for <e@80x24.org>; Fri,  7 Apr 2017 11:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbdDGLR6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 07:17:58 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33099 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753883AbdDGLR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 07:17:56 -0400
Received: by mail-oi0-f53.google.com with SMTP id b187so82316451oif.0
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 04:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o2OLM3y1SDpeok/L7Ui+FQtu9k7escZZhavn5W/3iDU=;
        b=A5L0vtGqP1zvzAEtXXCxF9PUNhUzPfaHIPRzb64aOSdxNXzLBBNAr/c9RKjjUj3TV8
         7nGD4oYpaQEbakQHFrLEaGrtLfaV0NKluM9NDGQT2qwaVfzmXWfWyVVwj3CJp+fiZgZK
         4Y+E6b5x+i2sJMLBxyU2TWU3eU0VXC1KsAhaoD2begpXRVvzQC9755q50GFqNCJh8Fu3
         wd/1+AZYqvhxuTW/ABtjmb/P3DLe88R1hvJYT84cAfPQxqlSWF3iFYnhG7C7qpjfzRW5
         icUkEaY9oc5yMUSjlq5p6wkiGKdWiUfD/UT6seFEVUaw0i2opyh9zP7TnxxpJ/85czvM
         EtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o2OLM3y1SDpeok/L7Ui+FQtu9k7escZZhavn5W/3iDU=;
        b=khowKtSGQnJVH2vtpOxMs7jDrrO4OnlL5r2KYRsuQI1lTbUEQ11M2KOrh2/z1SdTBl
         oowSLvo0o5YCMfMntd6J3JN7R5eoWVi5aeVCLfbs8fQ2xA6q3X6FT3An1O4vZAPMGhDp
         UKr4c3w5nSP4MAkfgKwioFKLAf5HpVr1vxWw7uN6GRkbtjUrEyJekmyJM8SkPbzh6T5U
         O90wOWuC/kAAaGh734I4Nl9fc0XDYtpEFEoz5hrhQUddp0PWuosPaxe0U0TtltHB/YcP
         fC6muopIeEkyQA7mojDwWHQF2N5rSAr02xfI2Xbm7aQzxTBpV4xCXLDBYxCndNa69+aj
         dXKQ==
X-Gm-Message-State: AN3rC/6sMxcj/yvO94DQs1UdBH75Et8PFC2ezjBUxThH8QQ5PxgdEndYffGMHYtVepknpncLuUTtulpz8dZHhg==
X-Received: by 10.202.77.16 with SMTP id a16mr463313oib.69.1491563875712; Fri,
 07 Apr 2017 04:17:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.25.7 with HTTP; Fri, 7 Apr 2017 04:17:35 -0700 (PDT)
In-Reply-To: <20170407063808.frjjclz7ksqgmtyt@sigill.intra.peff.net>
References: <CALZVapk4zxn-DSdMdy2q-Z0KvsBvx4MCSB5UDVOaBrBvAqw_AA@mail.gmail.com>
 <20170407063808.frjjclz7ksqgmtyt@sigill.intra.peff.net>
From:   Javier Domingo Cansino <javierdo1@gmail.com>
Date:   Fri, 7 Apr 2017 13:17:35 +0200
Message-ID: <CALZVapk1nhBv04QQSV9jOpg-KQxVE8wKgV9dgwm0m+J3fxsD3g@mail.gmail.com>
Subject: Re: Git branch deletion not based on HEAD branch anymore
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> There's "branch --merged" already. And in recent versions of git, the
> scriptable for-each-ref knows it, too. So you could do something like:
>
>   git for-each-ref --format='delete %(refname)' --merged HEAD refs/heads/ |
>   grep -v 'any-branches-you-want-saved' |
>   git update-ref --stdin

Yeah I wanted to avoid anything else that git branch -d, as it doesn't
delete the currently checked out. I am not really familiar with
plumbing commands.

> The "--merged" option to git-branch is only used for listing. In theory
> we could use it for selection in other operations, like "git branch -d
> --merged". But I'm not sure how you'd tell it _not_ to delete the branch
> that matches HEAD.

Last time I checked git branch doesn't delete the currently checked
out branch, does it?

Adding the --merged to `git branch -d` would be awesome

Javier
