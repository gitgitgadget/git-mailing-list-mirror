Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E2A1F576
	for <e@80x24.org>; Thu, 15 Feb 2018 10:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755414AbeBOKNy (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 05:13:54 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38753 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755310AbeBOKNv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 05:13:51 -0500
Received: by mail-wm0-f51.google.com with SMTP id 141so26752522wme.3
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 02:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MvOZkyKrzYP2hwFPFGFjWW65oQoa9fLlM6vqelMOXAQ=;
        b=H1Tr5JCP4+9clRfokBH7uR7lCrT+7gaxk8EFO8aZdDeEqW5fDPBU8Lf/BN3hKG44WJ
         AhMLJsXKIwyF6gFm5+1ziY9zH9FNMPHXDlAqLxd8f78Q55wAKFUASy0+3Zl6HrOyM3AS
         ow0IzwPMutgcE86Iqlhk9oLhQJrVX0vYM71JRbvl9UMFO5xPxZzZQJYnr7TMeMaIpk9g
         QjJbMeVBQ6DYOQ2hrejJIoArSr2gwcA9AsrNtQri15EXescMuOWu5u+t44WZPBIgid3S
         Dy09GRq5aMygiP2DLdRefF0TiA62AxpM2mCYZTqeZJbvnuG1wCM4Ppf6D2fTyjGLcevd
         Uv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MvOZkyKrzYP2hwFPFGFjWW65oQoa9fLlM6vqelMOXAQ=;
        b=EBzphms735qfF6CN+VoaPcrNYtyZnAYRnVjVC27q1aJSmQFG/vlHiVQddJQAzMoW2L
         nSe1Fj33W2UGyyLACXzFwd1Rm6H3FJXEqM/1Eef0gjfIHmC9Ho3pB+gJOjc0bJepf67E
         cEyvrtHT5WTWEjAWpskvRymK8STsxZwDuxezBrQJhFlnzZjWiXn/nO1M74O5AuvpD3sY
         dEF+/kv0kE2gKNAa90FF2gMZzawrVYCHTPftCPJanjRPkuiCmYozsFheZJZ+emmiTYEw
         SBEH5jhm2I0RLaop8geNs1/g4CYKzrn9hNSzsro81asbPcBGKsQwFraRmHO9Yb9Zmlci
         SATA==
X-Gm-Message-State: APf1xPDRo9WyuQZq+167KVi4GmDygkF+a6PSCFORX9RPEVDPeld4yn8I
        LEqlzLskKqwCK8ULafwyaYVOCNWCD3bSn51CxGs=
X-Google-Smtp-Source: AH8x225syFYBEY8byfFCTRj/Sv+AYbMNb35e50AEr3cayBXCvM/68UjbAfIDVsoQjjfs9f9bCuJK9bS9lBxMuhb0/mc=
X-Received: by 10.28.182.86 with SMTP id g83mr1528913wmf.75.1518689630280;
 Thu, 15 Feb 2018 02:13:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.17 with HTTP; Thu, 15 Feb 2018 02:13:49 -0800 (PST)
In-Reply-To: <20180215054018.GI18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f435d-05435bc4-30da-41c4-8bb2-37dcccb4a413-000000@eu-west-1.amazonses.com>
 <20180215054018.GI18780@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 15 Feb 2018 13:13:49 +0300
Message-ID: <CAL21Bm=+MAEfPRVKjp=3ktTHJLp=0Qf4rfLZNPGP4YfZRd2T6Q@mail.gmail.com>
Subject: Re: [PATCH v3 09/23] cat-file: start use ref_array_item struct
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-15 8:40 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:
>
>> Moving from using expand_data to ref_array_item structure.
>> That helps us to reuse functions from ref-filter easier.
>
> This one feels weird. The point of a ref_array_item is for the caller to
> feed data into the ref-filter formatting code (usually that data comes
> from an earlier call to filter_refs(), but in the new cat-file we'd
> presumably feed single items).
>
> But here we're adding a bunch of fields for items that we'd expect the
> format code to compute itself.

It would be changed later, it's just the addition of new structure
that we have never used in cat-file before.

>
> -Peff
