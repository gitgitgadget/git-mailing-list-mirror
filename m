Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FDECE7A86
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 21:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjIVVec convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 22 Sep 2023 17:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjIVVeb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 17:34:31 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0BCCA
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 14:34:25 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-65628b1181cso13751766d6.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 14:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695418465; x=1696023265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PazJ5sLJKoaJ+FJ/PEyazGAAKSer3WUPIoych5jmTZE=;
        b=rmL6x6GA42fiA5eTZ9KB0GwLFirxpiorR8FQRaJRH0dz8n0Tzvmx4D1/oZVKFX92eC
         IGlasXK4MKCZYQ6KcfW1qPbFKHTSh/4TpJKVGxn79JmlUL42ZXvg1v3p7ORz4J4L+8us
         NjbhdlUq0wcmuR2ujOzbqVB/P6zuGh1l2AyEuj/iL7OkNdF9zj36zd97e8+FUJE2/LYx
         s9nH85FHNvZWD4uEkqtE0V6duyermWDZFukxv3Az4yrKjcOl3alsiiLuoIQRdoj6+KLJ
         kaQvogto3+7ZfMUO0tEEojDOFmZeLq9N3H1AVcwXL7scoy8QuqgM3RZHzCD6adsu8gNj
         tdjg==
X-Gm-Message-State: AOJu0YwJCJxz6HF3+hLGVuqocUDnY4LfmSjL8OSOyk1kRyLaLmwTmVTT
        4Rv0EB9Uxm6b6zwc+UZwN0sMn5GyMDuzli9OQ40=
X-Google-Smtp-Source: AGHT+IHd5u08q24hwy7bh3sfw/tYtGurhfGZ2ckRxXB/ivfxjw877lTIFn70FrTHFbVnMWy3xzBSJAbIbRlVE5r8sv4=
X-Received: by 2002:ad4:5cec:0:b0:655:f784:9d25 with SMTP id
 iv12-20020ad45cec000000b00655f7849d25mr670767qvb.59.1695418464910; Fri, 22
 Sep 2023 14:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1589.git.1695392027.gitgitgadget@gmail.com>
 <f9f3f4af1c8889eb69f777a322348afc53feeca2.1695392028.git.gitgitgadget@gmail.com>
 <CAPig+cRc49GCr+z+LA65VFS8RTaOEkKe8KszQOUhFPxZGQ_QmQ@mail.gmail.com> <CACZqfqC_UwSPfn0f9L4TfkYDGU64t_en6=7wYMsnxA9fB2rSjw@mail.gmail.com>
In-Reply-To: <CACZqfqC_UwSPfn0f9L4TfkYDGU64t_en6=7wYMsnxA9fB2rSjw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Sep 2023 17:34:14 -0400
Message-ID: <CAPig+cT7G2G-PQ05cSAxLLoZPbz4eyHjPxUjMWhDB5ondyD0sA@mail.gmail.com>
Subject: Re: [PATCH 2/4] doc: update links to current pages
To:     Josh Soref <jsoref@gmail.com>
Cc:     Josh Soref via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 22, 2023 at 5:31 PM Josh Soref <jsoref@gmail.com> wrote:
> Eric Sunshine wrote:
> > > - * [2] http://json.org/
> > > + * [2] https://www.json.org/
> >
> > Not sure why this change is needed considering that the simpler
> > s/http/https/ seems sufficient.
>
> This is because that's their preference:
>
> ```sh
> % curl -s http://json.org/|grep REFRESH
> <meta HTTP-EQUIV="REFRESH" content="0;
> url=https://www.JSON.org/json-en.html"></head>
> ```
>
> It's somewhat traditional to respect sites' self-identification.

It might be worth calling that out in the commit message of both
patches if you happen to reroll so other reviewers understand the
motivation. (That said, on its own, it's probably not worth a reroll.)
