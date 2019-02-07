Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B043B1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 12:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfBGMjd (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 07:39:33 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:38220 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfBGMjd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 07:39:33 -0500
Received: by mail-ed1-f47.google.com with SMTP id h50so8866293ede.5
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 04:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eKR65H82HwwaotUpl2zs1PYlwvNRr2n34E6/oinqNuA=;
        b=jM+00D+RsvePkMVoZMQpj04Qyz0mW+CzDV9u6rHIG7hyBNkl9MyubbCUjp6l9mW9GW
         a1qgBm1OfMol+hkRqY3gFz4kJJ0knGxVs2jqxCKAbsx13lwrw7n5CZ3jJtQQXRyCN1bd
         F1wJGKqOSR1Q9TAAqme+c7vdXblDPXLmaqu3XmKrM+GIGmKLWL1IA3bmaoPc7XKW23T7
         y4erpWX+ap3KfvlwB0LMX0FHMD56fGKTRKGK0l3h6Vms01SiFCRPePzCz40jeqzg9PlW
         6ZdGGWa1HMfYhRALmITEF4hO63Dcu0PdfjDlZcbOSTPC1PHDE5WZLHwCaIUySP4Ok0b/
         c1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eKR65H82HwwaotUpl2zs1PYlwvNRr2n34E6/oinqNuA=;
        b=f3wygz/L1A7GsQX0YRk/+NTeQlRvjwv8Eg1yNSW4T+iNZse9KVNmoOCFq3+a+qzLGK
         Ex8l/oGY2mfOY4r6lF78e4J9tzKFjoebZqHdbtfayOIxI1L4a1gkuAQEifKjOvn94/v9
         cIc3xgki3+N2cEkRCnPWV6SFLzEP223V2PDaog/Jk8gQQvmOfF7zmGmzhBbIfacxBRTX
         LYmeiW01rz1My2NKFs2Nyyh4rjM05jptit/OvnahVzAtJosMSgLSNXFMY3JYZ7YcCpDB
         1XX6JBziizLekUTzk3cc1HpXXpDA8XTQi1icmCdY0xwMyktZv44QM/quUX6Jdnt2d5lm
         gAbQ==
X-Gm-Message-State: AHQUAuYzKEvKa/NkNAEewq3jlaaDBsrGePQSmxzyAGoNY1U2f46ZXwlm
        5HWg/lQXJy+QhgdNKQpw2iIgvHLAtI1bpv8R3ho=
X-Google-Smtp-Source: AHgI3IaVI3fNqIZgEKqtNk+c+r+xPzTbm0IG03FemSWqsKXBbGrxESjWuMNA5dO9JWiicyeaSnkGqns86OUvGJ3xV9o=
X-Received: by 2002:a05:6402:796:: with SMTP id d22mr12731743edy.81.1549543171762;
 Thu, 07 Feb 2019 04:39:31 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 7 Feb 2019 13:39:20 +0100
Message-ID: <CAP8UFD3-oYPVmnzS09YOfF1r85BBQDiYTUSyyu+DHF4D3mwrGw@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.21.0-rc0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 7, 2019 at 8:30 AM Junio C Hamano <gitster@pobox.com> wrote:

> New contributors whose contributions weren't in v2.20.0 are as follows.
> Welcome to the Git development community!
>
>   Arti Zirk, Brandon Richardson, Chayoung You, Denis Ovsienko, Erin
>   Dahlgren, Force Charlie, Frank Dana, Issac Trotts, Laura Abbott,
>   Patrick Hogg, Peter Osterlund, Shahzad Lone, and Slavica Djukic.

It's a bit sad that Tanushree Tumane is not in the list of
contributors though she contributed a lot to getting tt/bisect-in-c
merged in this version.

I wonder if you could use something based on the Signed-off-by
trailers instead of the Author fields to compute the lists. Maybe like
the following:

git rev-list v2.20.0.. | while read -r commit; do git show -s
--format=format:%B "$commit" | git interpret-trailers --parse; done |
sort | uniq | perl -ne 'print "$1\n" if (m/^Signed-off-by: (.*)<.*$/)'

Thanks,
Christian.
