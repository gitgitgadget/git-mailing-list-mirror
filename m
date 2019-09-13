Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF4D11F463
	for <e@80x24.org>; Fri, 13 Sep 2019 20:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389632AbfIMUT6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 16:19:58 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37776 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbfIMUT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 16:19:57 -0400
Received: by mail-vs1-f68.google.com with SMTP id p13so4254766vsr.4
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 13:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIohkNgy89lnhbWqvIsrNo+Xxp8tivzey2mbUuqBaWc=;
        b=BVTiiue4OXcE/d8qLl0Cik6rk6xg4F6x9h1+jT0OPMgEvsLYwkdRMfALFHNdc0tIoN
         TXsyEJJOOkxOZcH+PnEIcfdItuyr800c/F/v1En9O3FAXQdtyNOH0wmR0yrJTv+g1tvc
         9sXSJfO1QKsO/ohUcY3WV8/LgghFZJ3GGXjfmB2TKKAtMRgySN4msym1l7XE7tze9d85
         bf+0xM6ivmOZzESVj3ErpZ9wtUqvHlJpRj6NXNc2lfvfv0USbK38JrUcpcdbgUUpAAiu
         aiJAZEY3D7Smiacixu5zVxguKoPk0hKvC25tFYcu73IL1tdSHR31wsDys9e0AYGwopcL
         yDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIohkNgy89lnhbWqvIsrNo+Xxp8tivzey2mbUuqBaWc=;
        b=iHYNmIcZ2TJ13LBPM3vsfhqlDhpEvPiqkkBb90elNgiuCA475sfv16u7R7c4qV8FQ4
         /buJrR9EwW9/QNCKKkRY1KIBHI8iaVfd8kHyNBtFF/HPTJpvmi62UDkIrn17uwQnJ5W2
         zhRGcqsaQHJpcU8HeMh6nI8YFAa2ZS3PttMrZ3oe3Vk8ynx0t7Ga1ZnQrYX8HI3iZRXk
         fKDDJ/GgXDFpyaXTlLU7F6F5hq4pBIFwWvy5mVFCk8JHvrItvfXsRu/jopk0ZDltZc9O
         M2/8htYVa8HUt85f3uCdzmaNGeza88/EgaashCB2EPS9dC/z+aMsDeowuEASFAOEZWNv
         feFA==
X-Gm-Message-State: APjAAAU4deV8IAEwEzDJlYr/nM5VgCRaZA0CufvuRnwbArZQSxL6TDY1
        /vQFmXC8ynGNAZgvKtb2NZRLxEkYPsc6cNyEGsQ=
X-Google-Smtp-Source: APXvYqy37IN3p/gVHxvwuNy+HVkhLkSVlhPsSiT9n3KrWprkfE8L/4bddsdR4rn7n23mlutC1tW3J690xW5s/kxoxaI=
X-Received: by 2002:a67:c991:: with SMTP id y17mr12111355vsk.85.1568405996848;
 Fri, 13 Sep 2019 13:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <b3f1cd2b-7462-89fd-ff2d-9e53da286027@iee.email>
 <a2026a3d310f90b70a191e2c24106d600195d2b1.1568354429.git.bert.wesarg@googlemail.com>
 <20190913194911.3vwki4wa4jd3capr@yadavpratyush.com>
In-Reply-To: <20190913194911.3vwki4wa4jd3capr@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 13 Sep 2019 22:19:45 +0200
Message-ID: <CAKPyHN0pSpX6-5TTNZWNshMKa2Bfj3_tujn=HbLNSzBmeRfrYw@mail.gmail.com>
Subject: Re: [PATCH] git-gui: convert new/amend commit radiobutton to checketton
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 9:49 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> You missed fixing the typo in the subject. s/checketton/checkbutton/.
> But no need to send a re-roll for that. I can fix it locally.

thanks, I also fixed that locally, but again, it slipped thru in the
patch mail. Still don't know why this happened.

Best,
Bert

>
> Other than that, LGTM. Thanks, will queue.
>
> On 13/09/19 08:02AM, Bert Wesarg wrote:
> > Its a bi-state anyway and also saves one line in the menu.
> >
> > Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> --
> Regards,
> Pratyush Yadav
