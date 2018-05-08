Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SORTED_RECIPS shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE57E200B9
	for <e@80x24.org>; Tue,  8 May 2018 18:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933277AbeEHSZ7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 14:25:59 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35964 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932460AbeEHSZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 14:25:29 -0400
Received: by mail-oi0-f42.google.com with SMTP id v2-v6so29231502oif.3
        for <git@vger.kernel.org>; Tue, 08 May 2018 11:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+ItZ13s+D3rJlaFuHYN9w8WVJGUILSyHCG3smVzrjyo=;
        b=U7B0swyLVjp+0NcE3bQ73PazGEcpX0EL1hSQpQYAXFifeUgT/lN3rLid0kww8MnLk5
         L2o16AFZkO7SvdP745/cBdwu61t8Q1FcFuqIJafcFnUKM8/1fSRSW01/6qMC4aPxkun5
         zIr58C80ZL6U90nGMRH+6ocRUyxVZzd4TAB2l0v1hwdk4sgw8TyhUEAROrIsDJ8ItFN8
         t0o/++A/8kL5IbsM1BeQ2iPVQ1W3KoZgiHpKc6Xq+KGTzPDh8JmTO8+d3sBjQWpkNwbw
         hHPq3+fRd7ycYnPnJSkDDBeDtc8ZSQ/teb03d+4cT5iSvG8opFsn1WZnTNMgMdLQ4ExK
         lWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+ItZ13s+D3rJlaFuHYN9w8WVJGUILSyHCG3smVzrjyo=;
        b=l1ObNQToDezWyysi7ymxMLIXpMgWcizyokHF1CX8F+/i51z6me/1cEPif/j2InXMOC
         q4erMpdx0NrsxfCnOk9926TC6WA2npHSZAEu2DpOXK1jcK+STESySm351LBLLW83N0sj
         vIrHOps7pn3Pw9SLSaadUaWnZzwT3et6iSNBCVAiSnXsQAYhV8rrVPF/cHCxG2czuqv+
         TY6L5rfY0K8RXG42fSrreu4NkdCo2ZWRrDRQcupqhiF25ZigwecelATLM/iNlVQ4/Gz2
         AnxKgdRqJFoHg4dbH5BIdQR2pj6rGHOklt0Iw+RBUmCCG5kPZpYtAo2zNuh5p5A5eZRa
         UCMw==
X-Gm-Message-State: ALQs6tDHrI1FOUacbZjGfwUiUzR8EKYm2mF/OKpQn+Y10xUMczecjrz3
        P8t8OTxAi8gj7SDHrf6nJzCeowR1muOf8fGQud4=
X-Google-Smtp-Source: AB8JxZqCXhJ7VYaZCRzOy7r725oi1JfDThAOlNf5ud0lX2vp5a7vWZ0Ouk2RepM+WZGYMeCOhIjeasOiVQXO5AX3S3Y=
X-Received: by 2002:aca:aad3:: with SMTP id t202-v6mr27821436oie.30.1525803929329;
 Tue, 08 May 2018 11:25:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Tue, 8 May 2018 11:24:58 -0700 (PDT)
In-Reply-To: <87bmdqxb2s.fsf@evledraar.gmail.com>
References: <CACsJy8AkfNfupdr1MqZSaxNCbPwBVzxXNMMqPvwif0NtuCxDaA@mail.gmail.com>
 <20180508155627.19245-1-pclouds@gmail.com> <87bmdqxb2s.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 8 May 2018 20:24:58 +0200
Message-ID: <CACsJy8AYjsLxvwCMXZ1PGu7iG=Vu5Dc7da-L-EmY+fBg_A4X8w@mail.gmail.com>
Subject: Re: [PATCH] pack-format.txt: more details on pack file format
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 8:21 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Tue, May 08 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> The current document mentions OBJ_* constants without their actual
>> values. A git developer would know these are from cache.h but that's
>> not very friendly to a person who wants to read this file to implement
>> a pack file parser.
>>
>> Similarly, the deltified representation is not documented at all (the
>> "document" is basically patch-delta.c). Translate that C code in
>> English.
>
> Thanks, will drop my version from v4, although a comment for the enum in
> cache.h pointing the reader to these docs would be very useful.

True. I will add some together with the pack-format.txt update.
--=20
Duy
