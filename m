Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09141F453
	for <e@80x24.org>; Tue, 23 Oct 2018 18:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbeJXDQy (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 23:16:54 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39445 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbeJXDQy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 23:16:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id g10-v6so2783733qtq.6
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1BJwLz9Cx1fui0GxgEXeG/fY2moHMPUmCq5/lRa1JrQ=;
        b=DqupPbNvC5ijdLKp+fGqYShHDVXD/OUqK6LUrPMaaGkNblfVmfJpzOwgqIpuRaMMpe
         YsvnKGDUqo1gxU4PguC3qoBHTyyLv5L7GvEpSiOyS89bgLZnHuc8aoUXWDdyC76Co+Zi
         1iz1t360mIPqHjdt2FpBeR+/LJVJz6G6xB6Y88W4fPTlLygP1fAFSpVTpe+aky3nMgKS
         F02Qr2MV4IN2gDYe2wp4GIMqQZ3JDfFuofwp59+FbuVG6LRZCGAyKs54JaLvdcEUn2fN
         T9MIvlzNhcPRoxEQuJcJ8mNqa0AlEhdni2ISwsrNGaTsxc0Er6AASNh0yNjq/1m2QU7Q
         9LOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BJwLz9Cx1fui0GxgEXeG/fY2moHMPUmCq5/lRa1JrQ=;
        b=nnZXRSPD9LzbyMmZd0ma1cAg+C+shv1l86SZXGVD7xQ2cILo6nNsVghN//8VvrIwcZ
         NrlN1Urb0lYwqzhhSvR0lrvYBb++9aC3ekGp7H7Ohn/SxU8iZ3E79XeLLvQrfRB8GUqY
         2InQaYPfWFxj1LQZlgEhHWp5WuhnGvISpl2lxNUtZ8taNMRx4JOqtPj7ILkFimJMMQ4O
         OderYwcg2WopbiucKnyySfaaFOJzU922S5wv8A77vsQK63ObfxzDXx7x/Om6PTdsRaQz
         vNB0+3ygBDUGtakECfa5al1zYtHm+xs6pUSAvjydDI7Xt3E7tfFqKTTUOv56xxWkF/ZY
         O1mA==
X-Gm-Message-State: ABuFfojSBEdkBSXKaEot2xhe5Rt2Jm4Gt2TOBZy39ISXzHcaVklI8UEH
        y1nUkDrC6sUX/ewsIovbQpINFg6eSDAV4fO/C5oFaxBp
X-Google-Smtp-Source: ACcGV60BA3FVK3j+/DLh553Y9+oVf+1/J4zeJ5IzAmxffibaATjnQrvTNmTnOUIHhboV+YUe1DzR8WaFHPkVOcVntnA=
X-Received: by 2002:ac8:86f:: with SMTP id x44-v6mr10192401qth.90.1540320737093;
 Tue, 23 Oct 2018 11:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20181023162941.3840-1-slawica92@hotmail.com>
In-Reply-To: <20181023162941.3840-1-slawica92@hotmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 23 Oct 2018 20:52:05 +0200
Message-ID: <CAP8UFD35aOb5weDcDVFth96e+H-as_Q9bLPuCpSDReKJERnM7Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] [Outreachy] t3903-stash: test without configured user name
To:     slavicadj.ip2018@gmail.com
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        slawica92@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 6:35 PM Slavica <slavicadj.ip2018@gmail.com> wrote:
>
> This is part of enhancement request that ask for `git stash` to work even if `user.name` is not configured.
> The issue is discussed here: https://public-inbox.org/git/87o9debty4.fsf@evledraar.gmail.com/T/#u.

We prefer commit messages that contain as much as possible all the
information necessary to understand the patch without links to other
places.

It seems that only this email from you reached me. Did you send other
emails for patches 2/3 and 3/3?

[...]

> +    (
> +        HOME=$(pwd)/none &&
> +        export HOME &&
> +        unset GIT_AUTHOR_NAME &&
> +        unset GIT_AUTHOR_EMAIL &&
> +        unset GIT_COMMITTER_NAME &&
> +        unset GIT_COMMITTER_EMAIL &&
> +        test_must_fail git config user.email &&
> +        echo changed >1.t &&
> +               git stash

It seems that the above line is not indented like the previous ones.

> +    )
> +'

Thanks for contributing,
Christian.
