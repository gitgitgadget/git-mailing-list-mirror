Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 872861F4DD
	for <e@80x24.org>; Wed, 23 Aug 2017 21:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbdHWVy7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 17:54:59 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:36707 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdHWVy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 17:54:58 -0400
Received: by mail-yw0-f179.google.com with SMTP id y64so8494087ywf.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Nx5BC2biyRzG9ajP/CHIr9iAgh3X+x6yBYkiOUBtyxQ=;
        b=R5Euf9CK1YJ/K2BVA6N+Ala7rdJtRRNt599namrO3u6jA0GLWSfLJp6gOeWtyicbS/
         iN7lPUILV9PYP4x3ysycQu5aho1hcmVVTF3JpfV5TUAHbKbEZXWAtTL4xFCSVlh16x+C
         r0sea2cExp0yv9RuM197Btc8XLkSeJp4HjhsCKOd0G+B8P+syh/pjodc+fJ28M/5Y0MD
         /AyjiK1U8M+WSM9droBaXED5444tVqqsgWf2+PaofQIOdFjcNhPIWEmb1kFuoti8T4XZ
         69F998ddqpZo7VCw+yG5m1e9I/7ADMZLRHzwUnzd063gxqQCJ0nQ2rPHklD7PmtODk2L
         fwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Nx5BC2biyRzG9ajP/CHIr9iAgh3X+x6yBYkiOUBtyxQ=;
        b=ofI6x5xJ7YZ7z8ZQ4NQZdN9g3ZFQf4p8yOE7kZ+T8uGrAtA4yOb/Gl43D8oE5ve4DV
         nOeQRNGYi5qiwxtTR1Rt+lN5aNx1Eo7ZpHwHS3689uTA3DUKPdt97dghhbWQJz37HHJQ
         jRUt1DLqYtCK6+OYGTKTPhjHju59t98Kz/d3EKc4/UDO0J04eaZHbUDnb3X2TFZqFM2e
         JXITnYzdLIrCAQbmieQ1j6dbSlo3CQQqNqVEWZTbwXAapsiUfMS+jJuWNC77QORwf4ms
         nkrz86s5K7AgycmvB2ybyiljS93dsjoAvJ1ockSwiDxQ8CLi1J4SITfq0AcfaAmVv61D
         SKHA==
X-Gm-Message-State: AHYfb5hm8uuPvOxDc8KR4WR49vQryfde54yE005p487gU4lcQY3WzP8K
        fanlAJ2SXYlqv0aPn1BtTOxW5AXdLQ==
X-Received: by 10.129.104.130 with SMTP id d124mr3546222ywc.207.1503525297463;
 Wed, 23 Aug 2017 14:54:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.153.133 with HTTP; Wed, 23 Aug 2017 14:54:56 -0700 (PDT)
In-Reply-To: <CA+sFfMe56itAMDXOJybf0yHj+BqU1Ai1aU7inoTG3FJtdtZxyw@mail.gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <cover.1503323390.git.martin.agren@gmail.com>
 <dccd3e75fcd1b2de93263e8373a3b4cd5da0dd32.1503323391.git.martin.agren@gmail.com>
 <CA+sFfMdXv+nqpXmwfLTHtkRLuGkAEAwWXZCvOryVZ=aLb_UmbA@mail.gmail.com>
 <xmqqh8wyxag1.fsf@gitster.mtv.corp.google.com> <CA+sFfMe56itAMDXOJybf0yHj+BqU1Ai1aU7inoTG3FJtdtZxyw@mail.gmail.com>
From:   Brandon Casey <drafnel@gmail.com>
Date:   Wed, 23 Aug 2017 14:54:56 -0700
Message-ID: <CA+sFfMdMgrGBhECegBe09c38nRM+Zt5JK4gJaZ96DO-9zC-8qA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] strbuf_setlen: don't write to strbuf_slopbuf
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 2:20 PM, Brandon Casey <drafnel@gmail.com> wrote:
> On Wed, Aug 23, 2017 at 2:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Brandon Casey <drafnel@gmail.com> writes:
>>
>>> So is there any reason why didn't do something like the following in
>>> the first place?
>>
>> My guess is that we didn't bother; if we cared, we would have used a
>> single instance of const char in a read-only segment, instead of
>> such a macro.
>
> I think you mean something like this:
>
>    const char * const strbuf_slopbuf = "";

Ah, you probably meant something like this:

   const char strbuf_slopbuf = '\0';

which gcc will apparently place in the read-only segment.  I did not know that.

And assignment and initialization would look like:

   sb->buf = (char*) &strbuf_slopbuf;

and

   #define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = (char*) &strbuf_slopbuf }

respectively.  Yeah, that's definitely preferable to a macro.
Something similar could be done in object.c.

-Brandon
