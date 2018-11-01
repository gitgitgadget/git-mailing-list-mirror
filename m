Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B20C1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 15:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeKBAgk (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 20:36:40 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:46983 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeKBAgk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 20:36:40 -0400
Received: by mail-io1-f52.google.com with SMTP id y22-v6so12478611ioj.13
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rbJpnMd8ypW3xZfiwbaj/i25IZhxTWh2J/Xe/dckZl8=;
        b=bDTtCFeRD3seUTn6tbolVER/M1fxYyDK/zHFHQF3fAg2eICcwn7sUuTWClotgvoedU
         pzS5mCtxruHGGjW464n3RKk+uqK8rB/gOjSjpxNXUWAY6iXeZL603HPlZJ9hXlOkXcRt
         MTARbhCcmbwfwKFFhU05soKj5pI0ij96cXKDO6anEM5pIWE1Bg0RYBx1a/5YarMfttXE
         AdfdxYfTeREYOq6na9Cd+KeNUe7TNhC1FuAheD3jVCcA295LHvGBuJjUx7jCN4MwbCW1
         tlsgrxuhZfPBU8wjAT/Tf0lHWEdDY7Psg++y6JYB4UNjRwCHf40Axokx3C2ITNdS62BP
         TcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rbJpnMd8ypW3xZfiwbaj/i25IZhxTWh2J/Xe/dckZl8=;
        b=rFbovu3Oyw3o883E1RcWbIccpQz7wSsvSREe32Lu5mYdlrk5FgrHEkUXFYhrBCEJbV
         mxcbLeRvIdfVkUZKK6BcMXTGa8tiwHAG58Ny/JlmTQJlUBPC1AAEcx6QKwi/5nC2eLtK
         AepOHp6UjyvxsyTm2aaRvMQ0IDgL95hniHjuRFyNlKLSRaTZ3b8wPtZWA5VHZxIIWBOk
         Bg4WQ8SlBygjfiM40l9BpEcd72ejseq9mnH46UC8u8XiEYXQd274XG6+n3QSJ7YII84P
         xIWxKKsFo+uTD5Ux/2fmKvGLRPftqvDa90RpqITePXt1w2EzeN620tItjmodx32k3N0z
         gAkw==
X-Gm-Message-State: AGRZ1gJG91wU1bPw8PEL6Lw+KKsMuBt0vyEJ+ylX6+uUmygXZxMWdHqv
        Qo6PuB6oOllwtfiYqVReG9Fi27OU4S9iK69T2jM=
X-Google-Smtp-Source: AJdET5cn/0l/mhyqZnRI4cupviF6XOGpRvtmGMNjcZnIZ6BKVt+b7wBbuehtqeY0Q1kAK0BDykMNsrd7XMCAsLhLLtA=
X-Received: by 2002:a6b:9383:: with SMTP id v125-v6mr4890024iod.282.1541086393143;
 Thu, 01 Nov 2018 08:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0rpt8wy.fsf@gitster-ct.c.googlers.com> <8736slkqmu.fsf@evledraar.gmail.com>
 <xmqq8t2dsz8x.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8t2dsz8x.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 1 Nov 2018 16:32:43 +0100
Message-ID: <CACsJy8B4KtVHkFPKzt66JzfTp1sOL=MKNGdJuWW45vX1ht2PqA@mail.gmail.com>
Subject: Re: ab/* topics
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 1, 2018 at 3:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > Could you please pick up
> > https://public-inbox.org/git/20181024114725.3927-1-avarab@gmail.com/ ?
> > It seems to have fallen between the cracks and addressed the feedback o=
n
> > v1, and looks good to me (and nobody's objected so far...).
>
> If this is the runtime-gettext-poison thing, this did not fall thru
> the cracks---I didn't get the impression that "no objection was a
> sign of being excellent"; rather I recall feeling that you were the
> only person who were excited about it, while everybody else was
> "Meh".

I would be more excited if the scrambling patches go first (*) and
then we start to make "make test" poisoned by default. Scrambled
output is still very readable and it will make people not forget about
grepping translated stuff the wrong way. Of course *i18n* functions in
the test suite need to be updated to to grep/compare for real, not
just exit early like they do now.

(*) The pseudolocalization idea is also good, but printing unicode by
default may be a bit of a stretch. Not everybody is running the test
suite with a unicode-capable terminal.
--=20
Duy
