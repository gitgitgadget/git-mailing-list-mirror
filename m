Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6B591F461
	for <e@80x24.org>; Tue,  3 Sep 2019 22:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfICWlL (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 18:41:11 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35421 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICWlK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 18:41:10 -0400
Received: by mail-vs1-f65.google.com with SMTP id b11so6949615vsq.2
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDDWuEOLdIgU0cz8D0Jam95EKsSQnsGsBdC38RkWwak=;
        b=jAJjftaEnECHM5aZQ1GWZcxynTdDwcxRgPNnXwfao0VfvuTwREMCkKf6WFcRmex5AX
         FYlYwc3SZpz9Mbk/x+juS9VG1DXVaTS0BjW1o0764oTH02HXJ12/Bqz9ShkhPQVxPTUT
         QJrM4t6sZndIP6iuA3/ldabgAamhaJ8NLA3CKAAIYcl8+y1+jPNk4BeuijKd+C8M0QfQ
         kKSyG5d4xrJkIehIUuh3Fv6fapdnR3DcrJdodB8oreJNudMYy/8yR9/vlQrpDf3DCOt2
         tghW5paR9qguvnKnR3vry0oCYQ7oigGxdYA13sM3MSAK+oDCb215eaVptPoiLyD4mWBi
         j0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDDWuEOLdIgU0cz8D0Jam95EKsSQnsGsBdC38RkWwak=;
        b=kW8sGt8EDRPusQyWRqa8EgXOfjcO4CzxUvLS3ZArLO2MVR2PEhbKu4MgMB43qy6Txc
         25OJW9MmBhio5vruZ9kXys+EzckbarKadU6oNccQP8fQzjOXD0CgijAQDfzc3cCCwHxa
         HwX62R4wxMxK2KYPDXrymPH1U0acovjKbEhKEq4R4qorC0UZQ4Sq+QontjsSImt8Ddar
         VCHxZaHxdcWKE3Ap1D34ckFnZydW07pnldozaOB5OiUvJ95e/CokVxZQK3Don3TElFYW
         pmzg9bKF9awSxEjqT3fIOkYUXs9AUUASW7BbH53qTN/FKnDNr9cNbam+0pEfkDz6vbAH
         mx6w==
X-Gm-Message-State: APjAAAVfymXspQnBzNYsTkqlScAqEJzYhdKFuo2tR06onaf5Y5cjhfnU
        MLxPmSIG5OnmZsT/Fun4uxVxRPmRNN1jcpZm6ds=
X-Google-Smtp-Source: APXvYqytgCs9epf0kd7gucCAeMBRTwLloBm0rH1VIrn7dxk7xxF73nIunRyYTG0cbP/SFoNiFTTUrs2sffm96G7ZRJU=
X-Received: by 2002:a67:e30a:: with SMTP id j10mr7824790vsf.40.1567550469632;
 Tue, 03 Sep 2019 15:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.327.git.gitgitgadget@gmail.com> <4a02c38442dd8a4c0381adc8db0dce81c253da09.1567432900.git.gitgitgadget@gmail.com>
 <444f3ec4-abdf-1aa9-e8a8-8b5346b939e8@gmail.com> <xmqq5zmav9ej.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1909031256290.46@tvgsbejvaqbjf.bet> <xmqq5zm9taza.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zm9taza.fsf@gitster-ct.c.googlers.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Tue, 3 Sep 2019 18:40:57 -0400
Message-ID: <CAOjrSZsFeGsuNM2v=fPMnbHJH27Z6NU3UQrgoWt-peXjzWsD+w@mail.gmail.com>
Subject: Re: [PATCH 1/1] rebase -r: let `label` generate safer labels
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Matt R via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I agree that the code locally was simple enough.

Ultimately I feel that sanitizing and uniqueifying the label should
probably be done closer together/at the same place.  I'm just not
familiar enough with the codebase to know a good place (if any) to move
that to.  Eventually though this would still need to be expanded further
to protect against reserved filenames (e.g. NUL on windows).  Although
the behavior around these (espescially with file extensions like
NUL.txt) become less reliable, and although they are much more unlikely
to be encountered in practice, are still allowed by git as oneliners.


On Tue, Sep 3, 2019 at 3:51 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > If you care deeply about double dashes and leading dashes, how about
> > this instead?
> >
> >               char *from, *to;
> >
> >               for (from = to = label.buf; *from; from++)
> >                       if ((*from & 0x80) || isalnum(*from))
> >                               *(to++) = *from;
> >                       /* avoid leading dash and double-dashes */
> >                       else if (to != label.buf && to[-1] != '-')
> >                               *(to++) = '-';
> >               strbuf_setlen(&label, to - label.buf);
>
> Simple enough and is a good change when judged locally.
>
> It still would cause readers to wonder if label_oid() later append
> '-%d' to end up with double-dash near the end, etc., which made me
> wonder if the resulting code becomes better if sanitization and
> uniquefying are done at the same single place in the other message.



-- 
Matthew Rogers
