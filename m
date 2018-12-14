Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207A620A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 17:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbeLNRr0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 12:47:26 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33886 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeLNRrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 12:47:25 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so19497568itd.1
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 09:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wPUjsuxz3AH9THxXu6MrvVRjbs8OUAUB4o5nv51RFI=;
        b=ZfeL+d5+OetGs2R0kq7xQfgZkI3waMjTrtWdNFbQ9ukYEluUcNYcEKGlqLUXFcG7GY
         Z+qMnwTBINkg+oDwmS+lrtvC37jDnAclxzfYM15eMFSlQSZzSJEIepsmxY8jnN9wOwmK
         iEMZQHwstA//LdQAL5FUUqulDSc9RIdibNMMpv/dILHLwQ9hGL8Qg2ZyVLBc7zx0gd+j
         U8yH2MUTP+Dgzzgw0KEr2eu5DodJjaycDhuoXrjA+8Os5N0Pjff3kkVdqp2+GZNOU49Q
         n1lLDzr4JQdy+fdZMM4+y0EXJpCD0EfumEE2pmrik13wCDWlHtZmb35uadyAnLJ6UFEN
         tbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wPUjsuxz3AH9THxXu6MrvVRjbs8OUAUB4o5nv51RFI=;
        b=iW0v59O4WSWZ5ndiqecc3aSLm2AV1iOKmEj8u4qcTEdIpBjY06HhQllGZ8OWe5x/kr
         mVXZRb5C2Zb6wx6d8QEYCP4ubn/nvN3C2vpfCeIyBocUtTg+VT3jhoL+bzrrVx82PluM
         3bWpajAMY09BmHQtQD18FpmiUYZN9Lup2AK2lLXS/ZFYyJOfcCU3qmG+ySvUB53oCQY7
         j4ES+0I5d8f2Pl5L3aPU40UhFINaYwXZ9RWUwdhfDLYV6R99L/7raFanxXJfBr66786U
         /v24JcNahrSXGiG8omzYTi5QSO80XaY0yDDw/tzQRKv4Awyl4Y4/lWAlDIIV8HwkCSZj
         5eTQ==
X-Gm-Message-State: AA+aEWa5ajSRF7zujaRr6KIiVZCeLi9Hw2fpVBjjXinJS5JA5sGf9Mt2
        VGAq90huGD67tBNUO4FqeMJ6EcOLyDecR8a2K6g=
X-Google-Smtp-Source: AFSGD/VzhSTAmKv7MzF4lPCOFvmn3QSrwtvrpq8odFawgoOzkQQgMTKjMhV4pRe8WH4VC0Td438+ZXb/88gYADkBQ6c=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr2892840ith.123.1544809644806;
 Fri, 14 Dec 2018 09:47:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
 <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
 <CANoM8SVMYBRg-nL4r=JJDFU_qZ=grzSmRs-B2nLYUnv5kFc00Q@mail.gmail.com>
 <CACsJy8Bj=8xHp3JA8dLbyM=RwJey7utMK6DTVe_0AjBNVHxJyg@mail.gmail.com>
 <CAGZ79kYnQPhGMStmKSFb5_4Ku-nv54nHwta==jE82ZR4NOPETA@mail.gmail.com>
 <CANoM8SWQTAEYGiUC9PnWi8u9oAJYPcyiE5+5usoRvR7Vw2z0JA@mail.gmail.com>
 <CA+P7+xonxvfuhw4W+FUL87We8CaOwxsndFkN5bcgBhdsnZ5QAg@mail.gmail.com>
 <CACsJy8D9qfBLOUCyca+ws66uHx_tgoFZSTbTBxxW2fRQmyr_Nw@mail.gmail.com>
 <CA+P7+xoxE0o=5fMQrDoyCgWMQ-By2t1LdApecRDWmoXXCfnFuw@mail.gmail.com> <CACsJy8CT8K9SHnTsJT4HrxAK95yTz-x2DnNRBYKkvMyGbBZCgg@mail.gmail.com>
In-Reply-To: <CACsJy8CT8K9SHnTsJT4HrxAK95yTz-x2DnNRBYKkvMyGbBZCgg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 14 Dec 2018 18:46:58 +0100
Message-ID: <CACsJy8COqOMEk3Wzr==1-hsuGqdgKnbNfG_c90+xpU_oS-bW6A@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Mike Rappazzo <rappazzo@gmail.com>,
        Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 14, 2018 at 6:38 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Fri, Dec 14, 2018 at 6:22 PM Jacob Keller <jacob.keller@gmail.com> wrote:
> >
> > On Thu, Dec 13, 2018 at 11:38 PM Duy Nguyen <pclouds@gmail.com> wrote:
> > > Even with a new ref storage, I'm pretty sure pseudo refs like HEAD,
> > > FETCH_HEAD... will forever be backed by filesystem. HEAD for example
> > > is part of the repository signature and must exist as a file. We could
> > > also lookup pseudo refs with readdir() instead of lstat(). On
> > > case-preserving-and-insensitive filesystems, we can reject "head" this
> > > way. But that comes with a high cost.
> > > --
> > > Duy
> >
> > Once other refs are backed by something that doesn't depend on
> > filesystem case sensitivity, you could enforce that we only accept
> > call-caps HEAD as a psuedo ref, and always look up other spellings in
> > the other refs backend, though, right?
>
> Hmm.. yes. I don't know off hand if we have any pseudo refs in
> lowercase. Unlikely so yes this should work.

One thing we could do _today_ without waiting for a new refs backend
is, avoid looking up pseudo refs if the given ref name is not
all-caps. So "head" (or hEAd) can match refs/head, refs/tags/head,
refs/heads/head but never $GIT_DIR/HEAD. And yes I checked the code,
pseudo refs must be all-caps.
-- 
Duy
