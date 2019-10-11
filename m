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
	by dcvr.yhbt.net (Postfix) with ESMTP id AAD3C1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 22:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfJKWaR (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 18:30:17 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45929 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfJKWaR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 18:30:17 -0400
Received: by mail-vs1-f67.google.com with SMTP id d204so7216338vsc.12
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 15:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGhQSYI1EhXkNpdHmeFqG1O4gCqugU454aejAbKOzRQ=;
        b=tgOMRvQFkPvpZWxAFvtoWIX94zID2wMAIpqT2+JJsUjUjtnaWAoB28lbo4H82hOtB+
         8pQbLkgovK8Exyue6TPlXsBNQ0ZYPT5DcXZfTcZZvoaa7knysoM3iV1QHcjbi2760Ekg
         PRA5tuKeCTUy+RoJm+csMYk5pjb7MLYSuYVEWSCXbzHU1/DDN4E+sl8mWzXhxROxyUDw
         TWjhSw5Sy15d68V/fGK57HePtLDemlZtGsjerfl2E9+6cA0yDJ3RmsE+jadi0M85mj0D
         7LvyKT47n6alOvS1SA5r3wWDrNZgHeXF20i8Ja2164vYUd38gFH0m/5xFevx5n5xwhw0
         RKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGhQSYI1EhXkNpdHmeFqG1O4gCqugU454aejAbKOzRQ=;
        b=WI4bimlKcJkgKlgT2dqr9WM2ZdLvHut2ADxr51pJclEDfeRk1V1i2VaD622uHEXjyQ
         2/9llKD1XvyJNF+eFap4cWnaJMs+WQg0o0jIniJqKU6fSkUunmotqz2EC8XNeERYQjRF
         LG7LIF6F/ZoiT5ax3Jsk55eod2Zl1yLlmh8C0181DkOk+luYjGjdkmcTotJiOEvLUtj8
         hEMAxzyD436vBPs6zN8tOdnuEFdAk5F5gVwDEkqEkq0PoaBO+PJ7qQXKLLTXJVIUbSis
         J6LWaDdZ69jcpqg1iWpS6H1aWWGypsS7Yj09XKpEKUpVmKINt8ZkydS9mPYTnysBAsT2
         m/GA==
X-Gm-Message-State: APjAAAUYlC5GQts/22mkKFPWwrfDOLW6mPsd9kTYfLe090zDUbvCQFJ9
        mBDSD4iILle5wcaNoG0Epusw1gFRWZdbHJt7oiM=
X-Google-Smtp-Source: APXvYqwAmKE4QsIfOozi7bEz23rcN00klXP5TB55zxvjP2yAL3iqPc16O1DDe/W25Ye/cfk+K/kY7r6wiESyZJzDu5E=
X-Received: by 2002:a67:b30c:: with SMTP id a12mr10383708vsm.175.1570833016663;
 Fri, 11 Oct 2019 15:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.v2.git.gitgitgadget@gmail.com> <pull.316.v3.git.gitgitgadget@gmail.com>
 <6ce1d60b38a249f8d9f85d1b1a1ed556aef2469e.1570478905.git.gitgitgadget@gmail.com>
 <CABPp-BFaSh6O+eMsZ_ghMNUXdwh5kh2P9JF9msQSgz_XG2fENA@mail.gmail.com>
In-Reply-To: <CABPp-BFaSh6O+eMsZ_ghMNUXdwh5kh2P9JF9msQSgz_XG2fENA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Oct 2019 15:30:05 -0700
Message-ID: <CABPp-BE=p1SnpLnOPpC=5ZsK5DtW7+DsgTwZRDWHor_p3Vx36w@mail.gmail.com>
Subject: Re: [PATCH v3 04/17] sparse-checkout: 'set' subcommand
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 3:26 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Oct 7, 2019 at 1:08 PM Derrick Stolee via GitGitGadget

> Looks good, thanks for the fixes.  I'm still slightly worried about
> folks not looking at the docs and calling sparse-checkout set without
> calling init, and then being negatively surprised.  It's a minor
> issue, but a warning might be helpful.

Looks like you added that to patch 5, so nevermind.
