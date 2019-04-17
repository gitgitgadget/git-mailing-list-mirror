Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CA3920305
	for <e@80x24.org>; Wed, 17 Apr 2019 09:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfDQJeI (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 05:34:08 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:55873 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfDQJeI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 05:34:08 -0400
Received: by mail-it1-f176.google.com with SMTP id y134so3473097itc.5
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 02:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Cubi9d+7cibQHojJPl96evw6AWeBPfpQVYQklRxja4=;
        b=RTnNuT4B8Q8Qm44lZDLYqgX6wL5czVvic899xyEiDFox0i+ukdETz1R2tSuLHSom6C
         MFonF3RhdRnDJY3uxqEOoMvo1a1+BJxR3+UiglCauHZ2IPFruKZ1Yav5cXV50ncBS4Ym
         z1QJn7zsbSKTWp7CZv4PiJFSlkQLPV8PqibAT4VuOCT77STUXCctKKHBUEow5C3TND8v
         UJ7zwAVI2XpFZ6xWw8U50x8TIDT0TxS4uvyS3uOTU73jN3UcIen+hZ+Vj0mCtR0yYauq
         nh5y9oyLdXzDDcC7gTI28PEsaNNlezkC8gMk781YXYYiuK7zxsyI5adT7m+RJjZHXn4T
         2//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Cubi9d+7cibQHojJPl96evw6AWeBPfpQVYQklRxja4=;
        b=R9N3wMKqIjLReqZU4xrDUYJGa1t5thZwoP99EvmLqIy8JbsxSv0kL8uJSxotG5emDJ
         u2rnPSaJE3QonR61DwdL9k7U0Lwip37LsFYyaJdA+pMFfn7DlBQrq/1UuMjL1P397CNI
         5V55EHwS7geGnriOMcQZ/+Bidm21/QXnLm4O8j9kx8sEt9I6DAuPRwSLWR3WVAQgbCd2
         TF4N6TOtoIPpBWkaISD6iaFvmQYg+sY9G9kZUJU1shJgZhNqAfvtbUdQHqZERxShT/8d
         CX5Z0XsWdhP/H7NYakDWhQNizoyRfD0lmNhOBABBdk/NPdMP3pDYJKbyPvOJ4cjakI9P
         6vrQ==
X-Gm-Message-State: APjAAAUw9V4EWUhIT0kZkdX+S6Vtrcv0jASEo7NwZEif9ayuh+0qDmRc
        MKFPzRMRsBs3CuuFRX+tnwIFdM3dEuCtNCTtBHijIg==
X-Google-Smtp-Source: APXvYqzUXA9EK5F4RJQGjYfA/1XJt+hfvvuusMc+KWFjU+WupMg/d1I8VrGqSqkEKv75CRiLvZiSv7hpmUWjh5NjZkA=
X-Received: by 2002:a24:f8c7:: with SMTP id a190mr32561669ith.72.1555493647720;
 Wed, 17 Apr 2019 02:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqef62ozny.fsf@gitster-ct.c.googlers.com> <87d0lmatr1.fsf@evledraar.gmail.com>
In-Reply-To: <87d0lmatr1.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 17 Apr 2019 16:33:41 +0700
Message-ID: <CACsJy8B1nEKpNy8g-Ya7pgfdZwqdm8voZ0UGvMhArOjM2jPPjA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2019, #03; Tue, 16)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee <dstolee@microsoft.com>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 16, 2019 at 9:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > * nd/precious (2019-04-09) 1 commit
> >  - Introduce "precious" file concept
> >
> >  "git clean" learned to pay attention to the 'precious' attributes
> >  and keep untracked paths with the attribute instead of removing
> >  when the "--keep-precious" is given.
> >
> >  Will merge to 'next'.
>
> Duy had a message about this in
> https://public-inbox.org/git/CACsJy8AEZ-Lz6zgEsuNukvphB9TTa9FAC1gK05fhnie=
2xtfc9w@mail.gmail.com/
>
> If that was just a "I don't have time to deal with =C3=86var's deluge of
> comments" (sorry!) I'm happy to re-roll with the nits I had if anyone
> thinks those make sense (doc & test adjustments...).
>
> But that note is terse, not sure if it means "let's drop this no matter
> what" (for reasons...), ..., Duy?

I'm tired. You clearly think this is a bad idea. If it gets merge I'll
keep hearing about it. Just drop it and be done with it now.
--=20
Duy
