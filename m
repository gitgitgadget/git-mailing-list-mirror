Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AFC31F424
	for <e@80x24.org>; Mon, 23 Apr 2018 00:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753675AbeDWAVf (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 20:21:35 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36721 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753609AbeDWAVe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 20:21:34 -0400
Received: by mail-qk0-f172.google.com with SMTP id a202so14490452qkg.3
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 17:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=TgHeG66Dl4PTh9wqLPUTDw7FR/1Y6fIkqh3mK0Nht4o=;
        b=n/lJkL9pSo+PZ8eF4pGuZ4vVsDzRdpQSO+L4Els5H6RGVORHQp4LtLLr/WQ/usV4i+
         5xoOqje5oJCoYqYEHHY/UF3oGil8NXs9Jfgr0VdKmjKhOc1dgMnRaXDkNVK8AwYGTriZ
         wdyDp5ihrXoo8ZhX7ux6VQF/hBe7t0RUIPSiGf61hj3xE2t5bCGjAarozJ9MkMLI/GO4
         5OQ/Qs6nhnt1FP/U+Fcwn4ty2GcVkCSWEiw7IwQSe0WwYFGy6CzvUlMDBTw+x5XfT4h6
         GRgXCRvkgxlZkw7E/AW1q+YuMKegnBJ87yM2SblJHynMaxAqntwVyCcUah1s0eRRIPOx
         dKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=TgHeG66Dl4PTh9wqLPUTDw7FR/1Y6fIkqh3mK0Nht4o=;
        b=I8ljs7weBLnVaIcsZR9DdUe3+jrfdq6RxRmx5aEBJErZLb7aFDFtMWJUsGDwEZUqbF
         qVhxFTgk/7+PT7Wkk1ibGUsDBWuaioNgljbemadbUhbt3hxn1iFjaVWp6lo8DK9m5j0n
         kRuIb2SiJLYv88/Dsn4LGBF/HD9XQTOdAP3p73lANjT/3G90Rf7rC0wcwvoxA2FHi32i
         ISgiFOPPwAGYdiKsiYVfVCL8Og5lfYhrAAndaBSUtVDq1gufnhnS4WABj90C+O89mbZL
         JmeBaJdKfPuwJBmj/ksI3t3rgAyd2lnKeEHsUYVjHxjYVbQn1sNS0ilvxhvqlXT/pe+N
         VflQ==
X-Gm-Message-State: ALQs6tCwLwgE/d/huEy/gt5be/ZaaTkuzmmko6V/OBN7d81ya+vzSADz
        /7t4hqV/7a3vFWL1H6572J3gCjp+vKvXp59eBnY=
X-Google-Smtp-Source: AB8JxZrfMqCzCCMq3qFiPXk5ZhXx7Sx416rFusA9xXQ52W3H+H/56XkfzwhNCbw4XprBvcWLmb4RmMA2PIuby+irJMc=
X-Received: by 10.233.220.1 with SMTP id q1mr19405655qkf.361.1524442893632;
 Sun, 22 Apr 2018 17:21:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 22 Apr 2018 17:21:33 -0700 (PDT)
In-Reply-To: <20180422232447.GA48072@syl.local>
References: <20180421034530.GB24606@syl.local> <cover.1524429778.git.me@ttaylorr.com>
 <47f06ae36ce6af48fca06b140bdb5af2582116e1.1524429778.git.me@ttaylorr.com>
 <87a7tuex47.fsf@evledraar.gmail.com> <20180422232447.GA48072@syl.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 22 Apr 2018 20:21:33 -0400
X-Google-Sender-Auth: N7OyUEx5QTFSwK_V-SK-QLgtsy0
Message-ID: <CAPig+cQXsU4cXLtZPA-C84DH+PzrgN7C8_A-NZE+6e5HoJEFCA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] grep.[ch]: teach columnnum, color_columnno to grep_opt
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 22, 2018 at 7:24 PM, Taylor Blau <me@ttaylorr.com> wrote:
> On Sun, Apr 22, 2018 at 11:42:48PM +0200, =C4=98var Arnfj=C3=B6r=C5=A1 Bj=
armason wrote:
>> On Sun, Apr 22 2018, Taylor Blau wrote:
>> > In preparation of adding --column-number to 'git-grep(1)', we extend
>> > grep_opt to take in the requisite new members.
>>
>> Just a nit: Makes sense to refer to these camel-cased in docs & commit
>> messages.
>
> Could you clarify which? I am not sure if you mean --column-number,
> 'git-grep(1)', or grep_opt.

I think =C3=86var was referring to this bit from the commit message (which
unfortunately got snipped in his review):

    We additionally teach the 'grep.columnnumber' and
    'color.grep.columnnumber' configuration variables to configure
    showing and coloring the column number, respectively. (These
    options remain undocumented until 'git-grep(1)' learns the
    --column option in a forthcoming commit.)

He was suggesting camel-casing 'grep.columnNumber' and
'color.grep.columNumber' even in the commit message.
