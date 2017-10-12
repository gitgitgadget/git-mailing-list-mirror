Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D37B20372
	for <e@80x24.org>; Thu, 12 Oct 2017 21:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbdJLVAi (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 17:00:38 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34943 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbdJLVAd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 17:00:33 -0400
Received: by mail-oi0-f65.google.com with SMTP id e123so2946520oig.2
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 14:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=rHqEk2/xROzgV9bRNulfjdjwBKQ/kYnwEgFuRtOaTV4=;
        b=gX+dO3EO/tDEts84CbXtKUlo9NXE/MNCrtRDvGfkrIAD2aZJioTtzt1N3hHDJpfI2B
         Ex44GCbzNHnEXXziMn/xPIPDlo03CjoDOXlkENPnsH0/siFZGOCHuiGA6TRQnUBJUcRf
         edvgA+7VDQ/NOtnhSqUd9aCAjWhl1aioS4wkgWfhEH625Iyzs6ndGJdl0AmkPmpTKNHW
         XGXELm0d6oIcAe50XIw3rsmwkbbjN99rslIbZ8YgEsTKpiMsRanvemCUMrhnBn5fPyiN
         px/OAyBm/vHzGzVny6d7S8FVFeE01xgFVsegelbUcsN2SIKUBwOUxnbne5KPzI6Li2Lb
         eZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=rHqEk2/xROzgV9bRNulfjdjwBKQ/kYnwEgFuRtOaTV4=;
        b=L8ltQBSidvv4R1tgfrM+OZi+dirxzmYnpPo21ZLTk1r/F2ZQOd3Fu+RnYmP4T6ODvv
         NDDNjiyROLxP0hbuQGbym/Lk9cBX20tfalmsljWFfJwfwbsNkSUzgRcfSNG4OO0UoTnz
         NOOfWaUeVpBJeid0gCAfcpFl0qyXscJPo7il4DXR7KIQfo46ed1Sc7jrxM2ZD3JZwuAY
         Si/zSsMG6f9JJ62Vtk/ni3RpXNMiFIGl50q4srEUFuoZM2Uvn3uZYb0+FbYlerThmYnX
         9FewLylN/MRZC6V+uo8786duVyySOM/GO1Ry+4Oe1Biz+zdmwjs17d92x4sakVTYV8mK
         FRTg==
X-Gm-Message-State: AMCzsaW4385Gz+H50poTXGqi98iNgU/eOFAxrqXiYCoaNQ9oubwRZQXT
        urPDUAR+b1FlvGQfv0FEtTLoDjdLCJkjJFsHUH4=
X-Google-Smtp-Source: ABhQp+QrVqaeZ+/u4JScdIuKynujrnspwxTa2LCrzgDbbZP07/HfpsvXoIc5a1E6LHop/7GZMNqU7Ne4K6AwopLITH4=
X-Received: by 10.157.0.37 with SMTP id 34mr2615777ota.468.1507842033432; Thu,
 12 Oct 2017 14:00:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.19.87 with HTTP; Thu, 12 Oct 2017 14:00:33 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <20171012203832.ui52j7cdrztc6vhs@sigill.intra.peff.net>
References: <CAH8yC8mvG3bSpgshHay7B0SSyAafWLrPTtVZRuq2cShn9xQ9JA@mail.gmail.com>
 <20171012201023.wrfbs7p7lups5glz@sigill.intra.peff.net> <CAH8yC8nHpdA+fX3pcaLRzEYwTCmoxF3NKSh6SUkORZuEvg0JGA@mail.gmail.com>
 <20171012203832.ui52j7cdrztc6vhs@sigill.intra.peff.net>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 12 Oct 2017 17:00:33 -0400
Message-ID: <CAH8yC8kSpON5UP=pfsGXQ9JhhZOHVPetFHbr0BqBPnoYzj4Hog@mail.gmail.com>
Subject: Re: undefined reference to `pcre_jit_exec'
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 4:38 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 12, 2017 at 04:34:38PM -0400, Jeffrey Walton wrote:
>
>> > It looks like autoconf turns on USE_LIBPCRE1, but isn't smart enough t=
o
>> > test NO_LIBPCRE1_JIT.
>>
>> If Git wants Jit, then I am inclined to configure PCRE to provide it.
>
> It does make things faster. OTOH, we lived for many years without it, so
> certainly it's not the end of the world to build without it.
>
> There are some numbers in the commit message of fbaceaac47 (grep: add
> support for the PCRE v1 JIT API, 2017-05-25).
>
>> A quick question if you happen to know... Does PCRE Jit cause a loss
>> of NX-stacks? If it causes a loss of NX-stacks, then I think I prefer
>> to disable it.
>
> I don't know. =C3=86var (cc'd) might.

Thanks. Building PCRE with Jit enabled results in:

$ readelf -l /usr/local/libexec/git-core/git-credential-re| grep -i -A1 sta=
ck
  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RW     10

So it looks like the NX-stacks were not lost.

Thanks again.

Jeff
