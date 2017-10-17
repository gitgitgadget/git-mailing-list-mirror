Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5CE202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 03:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbdJQD6V (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 23:58:21 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:43629 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbdJQD6U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 23:58:20 -0400
Received: by mail-io0-f171.google.com with SMTP id 134so777155ioo.0
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 20:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Qq5fRWTqYpJdD1vHd7qfNO/O6mggsPY2vjC4gGE/lkc=;
        b=LS3J6Z0UObuN3Reh+MUDXoTAxYdD12GX7MEYSOGF2nGKjllmwfxwz3rwkSZTnaA9hF
         Bk8YAd9Imy9D4wUP9Pqhv6kFWhIVnEDV7rBFLUKXKEXBTn/VR34ghtZT2fXyzX2n0Ise
         FlZywZmltYkSIgkCeolvBvxVQlAcohP3fHh1tvuKAPoqrnryXYEECgkGle3KZrjS+JEc
         Cl2okpCrkM5UTuhXx0Ng0q/tPLUOqDgL4gMS1bt82TXDi4leBXGNOePTDsUoVt9nukV+
         PkinrKBxFWfPDowxUcbztPji3PsylQ+GLDt4ozWugKNtnDDm+CICkX/LHkK+dZkHbC+Y
         00mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Qq5fRWTqYpJdD1vHd7qfNO/O6mggsPY2vjC4gGE/lkc=;
        b=hxNcSyjj0ozi19OOUAQR02O43FIqZFLS3nWVs3r4P/cjAycFFtFGvIqj/Fy1k9IkLb
         SdIEebp4AthHfCgtsnCVlMCW8RE/YFupzWDmM/YsM3ljiEJbqQvVvhFLDGBxFINlE2+Q
         RD8jiGnOh2P+pN0VuxbXvscSfWbGSwiGWYPuoH/F7vqqTAKo7uacWmWryVSvb9klr0fw
         ntstZe9QJ8/fCLtgrJn+yccyXsJ1zsT3UOljJgWnX1Xq+LZxd1224K5EudLrbjRW8YUf
         GXr9CAHk1NrC9uI7vSWnb7mD9uzptvslAUyv3LxA8k3gbRxXE1nEPMlYbw1hTjKdqqUy
         4xDg==
X-Gm-Message-State: AMCzsaULyOf0FeShY4zjcGHI8T55utxPtkUEOcu0588XNm9bYAcZmDhX
        LUlQWcrlVSSfej2TL25QyPvHIFlPzZYL5mBjiFI=
X-Google-Smtp-Source: AOwi7QAx9FSUe4H4KmTOVDJkDHKIs8D/Y3ePqd2hXfBW867JjXLgF/qwnh0FAKmdBtwTldWZDhLdD8C1lmqSScY8GH4=
X-Received: by 10.107.164.105 with SMTP id n102mr16088439ioe.45.1508212699224;
 Mon, 16 Oct 2017 20:58:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.113.81 with HTTP; Mon, 16 Oct 2017 20:58:18 -0700 (PDT)
In-Reply-To: <xmqqmv4x11y9.fsf@gitster.mtv.corp.google.com>
References: <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
 <20171011202505.10113-1-thais.dinizbraz@gmail.com> <20171011202505.10113-2-thais.dinizbraz@gmail.com>
 <xmqqa80x2mb4.fsf@gitster.mtv.corp.google.com> <CAP8UFD3VnVod7SPTM11XG=vHBYD4EwA+xZB563iwpL1Ue4pPnA@mail.gmail.com>
 <xmqqmv4x11y9.fsf@gitster.mtv.corp.google.com>
From:   thais braz <thais.dinizbraz@gmail.com>
Date:   Tue, 17 Oct 2017 01:58:18 -0200
Message-ID: <CAP2EEmdA9txQa9g32ZJmNr3bRVwEkBF=_RrSEJck+Rf87FRZTA@mail.gmail.com>
Subject: Re: [PATCH][Outreachy] New git config variable to specify string that
 will be automatically passed as --push-option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        marius.paliga@gmail.com, git <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to clarify I did not see Marius patch.
Did see Marius' comment saying he would look it in the leftoverbits list,
but since i didn't see any patch i thought i could work on it and did
so based on Stephan's comment
(which i suppose Mario also did and that is why the code resulted to
be similar).

And sorry send this email as patch. Didn't know how to use git
send-email just as reply

On Thu, Oct 12, 2017 at 12:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>> Can somebody explain what is going on?
>>>
>>> I am guessing that Thais and marius are different people (judging by
>>> the fact that one CC's a message to the other).  Are you two
>>> collaborating on this change, or something?
>>
>> I guess that Thais decided to work on this, because we ask Outreachy
>> applicants to search for #leftoverbits mentions in the mailing list
>> archive to find small tasks they could work on.
>>
>> In this case it looks like Marius sent a patch a few hours before
>> Thais also sent one.
>
> ... after seeing Marius's already working on it, I think.
>
>> Thais, I am sorry, but as Marius sent a patch first, I think it is
>> better if you search for another different small task to work on.
>
> In general, I do not mind seeing people working together well, and
> it is one of the more important skills necessary in the open source
> community.  I however tend to agree with you that this is a bit too
> small a topic for multiple people to be working on.
>
>> Also please keep Peff and me in cc.
>
> Yup, that is always a good idea.
>



-- 
Atenciosamente Thais Diniz Braz
