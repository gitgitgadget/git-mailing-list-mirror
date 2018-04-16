Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A78AF1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 18:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeDPSZN (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 14:25:13 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:46451 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbeDPSZL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 14:25:11 -0400
Received: by mail-wr0-f172.google.com with SMTP id d1so28666065wrj.13
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zUz11aFwN1hCd5bTYd8nswGHxvq3Snrv7uanHjxPnlY=;
        b=kiVXzU6ZYuRmSZg7eAyBgzkh5iL6l4f5YZDaLQkoBauL6yn8qS95xXJg/7Dg3alDWc
         kbp10PJcUdf4y3dEc2bfFhF9Hk8DuPGhD+5Dx9F4anP17gjDMesl8p3jgEBMIjG5wzWX
         nIx2qWf2/tcKVYcFh5MmGHXMovmSZK90nENKxfCOAv/aDcgO+H8X0Jt1Y8Gkc2Ip7UoR
         1MVXdbrVvw4wbr7Veg9xYNYSGErO4pliuZzY294FkJ4dw8YnwXVThosvQ1/9Kjct5hUI
         /n2aD4mfZQUfsO1lV/vJ2CdhansZ/p3fNYes6fd174v4mSCe1fMOiZXQXpstnMhNWwEL
         IcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zUz11aFwN1hCd5bTYd8nswGHxvq3Snrv7uanHjxPnlY=;
        b=sT8JBh3RI0MsdhlZtdmzjYZd82yiorxJhuYt+rHqPLHY5jxjqxSAkROtBJhdNGw0PH
         2C7mg+Luo/hcfJLt+JAECPnIiBxmBW/JbDiA0soyynHie6JI49ZoJEzIh/fA8SnyUQXt
         l9kLYwb94uwzj637ulMwNVOC/1LgOjhum30xUdiX5jxqMhDBSVRmS/L5Rj18v/RlQPS7
         i0h92/WxBdX07y4CA2qhCd9kaZvifUZ1h5yj4j/8leti5X0lz/Cr8HE8bMrtjfkMAesz
         CFQlZnQks/S6q9Mt+XyX4zZQ4bQ2JhcFwXRBtI8PrUlsyQmTRtyNc7ytyonfA5dFlW3Y
         6TsA==
X-Gm-Message-State: ALQs6tA1reFXYLPMcnAMwId1f0JXA0t+4ZbFi42QG6glVO+PjPx9NGaT
        30Ykv5a6DaPMbNRUJgGzKYwV53qOlkP21xCSFEI=
X-Google-Smtp-Source: AIpwx49PhGe0FeeIM/WD2572hS35e1hHQ5Km3r/Zr9qRaDjiChvFHHMtTvbX7T0+NLhcCeH6pF6h2SwsFoPHUbbh41k=
X-Received: by 10.80.171.72 with SMTP id t8mr2371209edc.133.1523903109901;
 Mon, 16 Apr 2018 11:25:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.180.180 with HTTP; Mon, 16 Apr 2018 11:24:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1804160659300.6118@localhost.localdomain>
References: <alpine.LFD.2.21.1804160659300.6118@localhost.localdomain>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 16 Apr 2018 11:24:49 -0700
Message-ID: <CA+P7+xow0HSMJJn8DFgqhnU1ZLdrLPZy8Wv0tTLAE3ufQmpD_g@mail.gmail.com>
Subject: Re: "proper" way to deactivate push for a remote?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 7:03 AM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>
>  another feature i've seen for the very first time ... working with
> kubernetes so i checked it out of github, and part of the instructions
> for that is to make sure you don't accidentally try to push back to
> the github remote, so the directions suggest:
>
> $ git remote add upstream https://github.com/kubernetes/kubernetes.git
> $ git remote set-url --push upstream no_push
>
>   fair enough, i just assumed the word "no_push" was some magical
> keyword in that context, but as i read it, all you need to do is put
> *some* invalid URL value there, is that correct?
>
>   and is that the accepted way to do that? what about just deleting
> that line from .git/config? is that valid, or is there a different
> recommendation for doing that? thanks.
>
> rday

I've done this in the past by using a push hook which just reports an
error. That's how I'd do it.

I think if you also set the push url to the empty string it would also work.

Thanks,
Jake
