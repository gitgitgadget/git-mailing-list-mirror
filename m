Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA0AB20179
	for <e@80x24.org>; Mon,  4 Jul 2016 15:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbcGDPIx (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 11:08:53 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35831 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbcGDPIw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jul 2016 11:08:52 -0400
Received: by mail-it0-f43.google.com with SMTP id j185so31869149ith.0
        for <git@vger.kernel.org>; Mon, 04 Jul 2016 08:08:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mBpJtOqdaCruNJEZgnkE9aVuVtqRQ8LtvXZ349MgIuI=;
        b=Pv9P+V/+ZzdHAenM0CxLUdVBTey0KrKj3jqX39hnwDY3DxjtzD8VG2KPdF8G9V00ja
         v+rIEihlqx7/6Ynu0htErrg4BvW+LptRWB9e04p1c6fQ6EGuBy/WOf00TDonTio/aM19
         wfjRb0hdd/YQwyxg9wHUez9gm8qotCx04YR0iYoaqa330pJpyCwiLGPchcIdXJajsDW1
         2JlmJVycIiHZ1ed2zdlBgUB+NDAxfkiHcD/QWPxf4GD2wpwGolhV+m7beQxpgO33jvGg
         rO4W+J+nadxvNgKfAxmQz0xjH1aOGFsNsZonrX7gmyVaWJgqiLA1xuSbWJ/R7dmsMdjz
         JsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mBpJtOqdaCruNJEZgnkE9aVuVtqRQ8LtvXZ349MgIuI=;
        b=KTO5kde2KL0A5RI4AZEBoMqUAX6P9MGrUFRiRc9PRRaa06mn38Leixp2eeqMKMhgVR
         w1Uwe3GCsWkZ5u0m9eNDJDc32L5SsmRFLolRO84WHV/KROmNpFr1b9kUwjcnC8W64WuS
         mcBj1hoi/pDFDbP3FC1dOIirvHpdBWfvHgtKpUoYHN2PlpfxuD31FeGrel3azSZdTcdI
         InfOOGsngI0qBCn1y+CXsOhqh7gLl8SlrOyqng0on7bDUwWL7OxwPblrdDEtDjI9o8oB
         Y46oPkGM9Sa8DCdu6ft57xOdkNnhCDT87U5qz8Gaqg7iJ5u4+/23GCShXnDUsEiNmUPb
         Hm/w==
X-Gm-Message-State: ALyK8tJE15ckl6Z4nJla4yeHDAfBVmc6APU9FgCooqHEKplNpf1eE3+lISGDkatLiJQn8uYn33ptgRVCGWf6lw==
X-Received: by 10.36.33.22 with SMTP id e22mr9774768ita.42.1467644932125; Mon,
 04 Jul 2016 08:08:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 4 Jul 2016 08:08:22 -0700 (PDT)
In-Reply-To: <577A61F7.6010109@xiplink.com>
References: <20160626055810.26960-1-pclouds@gmail.com> <20160701160331.29252-1-pclouds@gmail.com>
 <577A61F7.6010109@xiplink.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 4 Jul 2016 17:08:22 +0200
Message-ID: <CACsJy8AGDTgE-Kgj+wNZuiqg9yo_NhyQXEFFJZvAdSts+7R1tA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] Better ref summary alignment in "git fetch"
To:	Marc Branchaud <marcnarc@xiplink.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 4, 2016 at 3:17 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> On 2016-07-01 12:03 PM, Nguyễn Thái Ngọc Duy wrote:
>>
>> v5 changes the substitute symbol from '$' to '*' in compact mode and
>> makes sure long lines in compact mode will not make the remote ref
>> column too big (it's far from perfect but I think it's still good to
>> do).
>
>
> I think the first 4 patches are great.
>
> I have no opinion on the 5th patch, as I don't expect to use the compact
> format in any of its proposed forms (and I can't come up with an
> alternative).

I started using compact mode for a couple days now and I find it nice.
Because line lengths are shortened nearly by half, I can now have two
vertical tmux panes in a window without wrapping.
-- 
Duy
