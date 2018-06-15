Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475C11F403
	for <e@80x24.org>; Fri, 15 Jun 2018 17:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756142AbeFORKa (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 13:10:30 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:39908 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756005AbeFORK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 13:10:29 -0400
Received: by mail-vk0-f50.google.com with SMTP id r83-v6so6082196vkf.6
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 10:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K7vL5NqpvZFKDnH4CW1vsr2HeBz5XB5EZENwVqa4KTw=;
        b=vdrFVkOgBNffvkORvRLgNhlOcwrraQNBs6TY4/gMR1luB4Zir6AxKfdUVjIZ5/nAKE
         FrcxZJeFwNn9EEpS1u+Xkv6nuLGfGOQbivzVnB36t1zTsa4P4lou/2bLnPYxwPln9/xW
         ZKmTO8SAFzEpamFlghrVRMvouV64VppwaULGWAP/cevwGae1ozHgAGnKCVIFBgCu5PNT
         alebMVjpx0wV9tMDhDpEfJQmdni9mg5h8DcZtTvnGvJzoFGqyRLsFwRCVpgQUqmW+4+q
         yyqMZoDx/nDu53t81SROLlAoHsn8snoYMFcHoV5wvVss5V3Y+8jNrzZ4OTO/oGh7Uldv
         FJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K7vL5NqpvZFKDnH4CW1vsr2HeBz5XB5EZENwVqa4KTw=;
        b=tpnRaRkIQ5x2AbJ28Ofsn5X/49QnIPv8HDYqe2i2IEHxai+GqkPu/EMu05+JWoY9rC
         qY/cX9Kft+0GAt8wq71Rg1VTgNI1HLt81kSAQci+O73Jz2+dKd4pF3nIXkEgKQHwv0/V
         vzNG/KEkTa+g0WhjcNQNc3qsBSbgCjPT61MG3ABGIYXD2iLFdotPt32hfOkpAzoE+fGO
         ug+rUKReLO4zbQ6g4L2VaJg+KB+qwGuaFl5+g0VkntDENWmUqNihcMs8hfKiNEzF6Luj
         azl1UZHYzFQ/9a4A+eoEe6H5noYMtPeAI+kFJuW2AOexy3Qz3ljG+NQxvOp9hqemaJ7z
         b/Dg==
X-Gm-Message-State: APt69E2tzbI1zXjFewe1Ws9xNiwAbmLrjsscokcwwTpwArkzFzZnsUw8
        7WZCa5oSdB1Spa2FLn5Z5xsVTqpLtM6uGFAL/zJ5rw==
X-Google-Smtp-Source: ADUXVKIysPmlIDkIIWxvORYzRTkUH4BFHHxsVujE0a/tpR/X/gpuVm+D32+mxkTZIUucBxmlZ/uA8DaL9v1WxHDSKrE=
X-Received: by 2002:a1f:fecb:: with SMTP id l194-v6mr1587673vki.120.1529082628744;
 Fri, 15 Jun 2018 10:10:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:3105:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 10:10:28
 -0700 (PDT)
In-Reply-To: <xmqq602k2f9o.fsf@gitster-ct.c.googlers.com>
References: <20180615032850.GA23241@sigill.intra.peff.net> <20180615033112.GA20390@sigill.intra.peff.net>
 <20180615091432.7155-1-szeder.dev@gmail.com> <xmqq602k2f9o.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Fri, 15 Jun 2018 19:10:28 +0200
Message-ID: <CAM0VKjnZXfaNskiba9VsFWwwOx_kvGxZDY_AiyQv8L6gCPX4Fw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ewah_read_mmap: bounds-check mmap reads
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Luat Nguyen <root@l4w.io>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 15, 2018 at 6:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>>> +    bitmap=3D$(ls .git/objects/pack/*.bitmap) &&
>>
>> I think the 'ls' is unnecessary and this would do:
>>
>>   bitmap=3D.git/objects/pack/*.bitmap
>
> Yuck.

Oh, wow, now this is embarrassing...


> I said "yuck" because the original does not work if there happen to
> be more than (or for that matter, less than) one '.bitmap' file
> there.  But at least as long as there is one, it should work ;-)

Well, the test starts with 'git repack -ad', so there can be only one
bitmap file.  (Unless something is broken, of course, but the second
test would catch that much earlier.)
