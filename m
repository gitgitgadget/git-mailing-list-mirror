Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A492D20248
	for <e@80x24.org>; Sun, 31 Mar 2019 19:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbfCaTPC (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 15:15:02 -0400
Received: from mail-vk1-f169.google.com ([209.85.221.169]:42405 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfCaTPC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 15:15:02 -0400
Received: by mail-vk1-f169.google.com with SMTP id 195so1604807vkx.9
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuiJcVNyfMXIM8XResg7bdpt9cNKCK+IffB+x6aJ3f4=;
        b=FmS9/fkBC1c+bHlK5b9ywG6h9QubqOZrK36nOAjhZZJKlhpf5/1IYdnUwnFl6IDwOV
         4/143Fp05P4KjhNdbyfBARdQchaOF3SILA6Uz52uJ7LsGnXMdaPioX05QgB1KKJetIzG
         cigW5T07Zg0ftWQD1g0C2t8tiMBnRLqlotKqiKKxhipy7Z0IKyPTWR0TwbWhwZty1SND
         EkifAlNXmlyU9vgpbSMyBKgGZYIna5WsDLGciyYuBgS83YPwku3cGAb3NvejwYw8wfEK
         yereAmZIayi2/HekYOQqBOCZpxHBIgUPSnSnYzeSZltJEXukZPX0qiRYfeue2nqfY9x7
         2JGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuiJcVNyfMXIM8XResg7bdpt9cNKCK+IffB+x6aJ3f4=;
        b=MQ8xpMoPZhnC5FHnilKCQDfLlTc+NRI99rrFh9GWsBdxytUXsmSwGWuCYtrpSkfcEp
         3onaHKr0r6Ke04uPWpx4itL0jdnOr9/znvBHjyQMq+mBWG5rR/6FJOhT0zDTgCyyU4SC
         43x7oPfdv4HQhc8ChoAVMlAlREoGjMjyAU3JgPJBJlTb/6tXvHTEYfmau0lXAeY9riZH
         c4aMifrlAd+CkLCE3f4gVKlDDD+Gm/ya/lZ1XmvM4S3tHcxzY8IrMkgWbxH6EfZkBnkZ
         lh4NnEP/IAxrBBX3unr3NpudNDNipuOi/0LpXaaR4wcGgN9kbvBuTLsf6mgAtZ+o9I/5
         RyQw==
X-Gm-Message-State: APjAAAVH8d7KvfgsNgzr2iwaACB3+PZ9rMMcjdAfS1Fg8EbOfefUGeVS
        5mnI1tM4gg6cbixDpxiR1JRDsq1CJWEnercMmYg=
X-Google-Smtp-Source: APXvYqxw+/CPB8F/X3eJXheqMSJOMHDtmaESZUqyQembY0hsVWp3mP75vmI/jZmpH6PYYOk2+CtFOXAjKBNYtPvHcEg=
X-Received: by 2002:a1f:4f44:: with SMTP id d65mr35080948vkb.58.1554059701260;
 Sun, 31 Mar 2019 12:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0qcwZm=2YnGm+rccDT2e5yZU3pyYGUGTwr9izod+e0s0A@mail.gmail.com>
In-Reply-To: <CAODFU0qcwZm=2YnGm+rccDT2e5yZU3pyYGUGTwr9izod+e0s0A@mail.gmail.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Sun, 31 Mar 2019 21:14:50 +0200
Message-ID: <CAKPyHN2Unp7Cou86fefYo9nD_ApokMxRMih=d27=rp634bYKwQ@mail.gmail.com>
Subject: Re: git-gui: unstaged changes windowpane resets after unstaging a line
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jan,

On Sun, Mar 31, 2019 at 8:45 PM Jan Ziak <0xe2.0x9a.0x9b@gmail.com> wrote:
>
> Hello
>
> After performing "Unstage Line From Commit" action, the "Unstaged
> Changes" windowpane is reset. The reset does not happen with "Unstage
> Hunk From Commit" action.

because its not necessary when staging a hunk. Though when staging a
line it is better to run the diff algorithm again.

Anyway, which problem do you observe in particular?

Best,
Bert

>
> git version 2.21.0
>
> Sincerely
> Jan
