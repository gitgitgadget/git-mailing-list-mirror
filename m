Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A7B11F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 12:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfHLMO6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 08:14:58 -0400
Received: from mout.web.de ([212.227.15.3]:55755 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbfHLMO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 08:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565612090;
        bh=Z3xUPUb7usNfvIqji8hJowz6cxGayAZ5D79GmgBU6yg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=VJoi63GQ3rXk9B9ki/9H+9YADPoZqtqdIVGpQ0rEHFaHT9BqMx47lAvosKYfBwK/q
         ySCQLATzFVc4X4Ztq9gzk8fKB9QxSgNw1el4FcfYXN+Lv+cVs1qUFM8N6Vq82gbxpu
         71ewycjJoprqFlzPI6YOEdiu5gxgMLAllKjkGRfY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lm9T7-1iWD3j0NCz-00ZiqB; Mon, 12
 Aug 2019 14:14:50 +0200
Subject: Re: [PATCH] SQUASH
To:     Carlo Arenas <carenas@gmail.com>
Cc:     johannes.schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, michal.kiedrowicz@gmail.com
References: <nycvar.QRO.7.76.6.1908092325480.46@tvgsbejvaqbjf.bet>
 <20190810030315.7519-1-carenas@gmail.com>
 <f78b57a6-9ede-c87c-fc42-292851d79fad@web.de>
 <CAPUEspjtZhhynEmJu_weROaao=1zL+De1h50R-grG36ok+EAyw@mail.gmail.com>
 <501f946a-1f18-7c6a-2d15-8ff6375c4192@web.de>
 <CAPUEspiuuCWgjuHZ7DLyH+0hXt7MqeP++xyZuB+Zd5t-H_d69Q@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <370b308e-40a2-4edd-b0db-ab0fb84d1c9e@web.de>
Date:   Mon, 12 Aug 2019 14:14:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPUEspiuuCWgjuHZ7DLyH+0hXt7MqeP++xyZuB+Zd5t-H_d69Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hJffN/4SU/E7YHSBes7mNZp1qPdi4+9T54jpb4cTumg91Z97K6z
 KCeLiOHUCAZs6ZfaNWdosyj+rZWuqrUdXCCr537nlIq3VDpEjbqvJVu5Q9sjPot4hTrH36D
 C+d0Z51Oh3cxwtVpx8w9J3QE6VV4qr670kCWrrq3ayDWvAnB8OhfAH76itQAcSAfj0sDzHf
 LgrWH+AUZt/2W5tYCkdFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Gl1Z+nqNEI=:GFxXuJ+yeI30PWVhYnPzUF
 D72vDQOOPA95aiqDiBu6OaC8TI8vkPkBpO4dkaRmZ70HIUmhcomEGNcaWjteoGHFj+NlW3bsx
 opsmDFV99ILcR9G27EOc2TdcTm85aBn/OHzsz5pFO2LvclLkS4gvb+XnjwaHWnOAEaRsYU0se
 oLLu1EbE8KT0Yma5D2pwQo+CdHzCX6INxwVw+IzdloU47qfSdlUkaE1j1Pp+WDgeqplGp4oJr
 4U+Zhx/6x9qbUbg8NhxUiv9bKFfrkmZ0xfujSe1EJvUVjPvTkO6CeQymJF52ta8CrJMxCN0Rh
 KklAEXwgvnpyDIJliOSFY9gzsSWv6etQYPgrDbPKRBWYg6hDa2mw0jdHGQN3RSANaFguYdJ99
 sfDranH703hVwAGTQYYlty8VBi4XZwI4PQFo2bSUkPPUDTUC4L7AAAoJPEBSBwSE+eIuWWIjV
 KrHcFz+2ucJgZZ2l5BVF5zpB+bpyLzAqVvGTMl5Z7DgYQlDpgdYPqtQpzWD8RgyCpBr5/Phkw
 16R4XFKyrc03xDOFpZKhFSDiTgARRHTXg0R7yy9B+k7U3/MC1ncRXTlf07sv3NLMYVk1yWKJT
 W8y4ioS/mZOO3r84oVfNFvsLgGLiChMuyVwJqukOUM+zSYOalQwwTJiTHB/C8OuYmO2gvaEzL
 azwjOcdbkBG55VFmBsyc4/TxcMDZsq2zXBElmnE96SBRb8hvnHkF7xgHLuaE7DeUMrwQBfFB5
 9jwQ4RvEGIdquMMqN1+4FlJ/73O9ZsX8MYP5CVH+jJKJQnxb/QzXm6GmDaSkfU2uDzZj4vojd
 Ed0XHTtypEkThb2A3B3ToSLqrMPfO60eoRWYILeZvUiaM5Qozkc2CpqgfdusRaoB2ijV82HiQ
 llpGG2ori5pQva8fFwbvvlx4uHuzWm+wxQ/ALWc0+zCpITmRGE3oTv0Lth6ETEXzhwXNY8IMb
 XHJCGeSyasgi5QmEHaqJYzTI0suQWu3dP20uMr4BnshmXtK1PWSySk1kaToedPSjT4PA1tlxR
 9ipdIQfD2/lB7VkVEKjpk6LovEzx9KJUrG6a0itgxe7sY1DTbnz4VXLgldP8K3T+cpCHdyVHD
 ueLTsSWL++qv93BGV7xnHDaNrV9q3lQlGzTkfieZrf8CvnimWHdFlm1obmMht7cxz6kwPfd5O
 7z4no=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.08.19 um 09:35 schrieb Carlo Arenas:
> On Sat, Aug 10, 2019 at 12:48 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>> On Sat, Aug 10, 2019 at 12:57 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrot=
e:
>>>
>>> Do you mind then if I "adopt" your patch and submit a reroll with it,
>>
>> I don't mind, sounds good.
>
> I had to squash another fix that was reported[1] before but wasn't picke=
d up
> and that ironically might explain the last segfaults from my old V4
>
> Carlo
>
> [1] https://public-inbox.org/git/20190721194052.15440-1-carenas@gmail.co=
m/

That looks like an issue worth its own commit.

I wonder if we'd want to pass pcre2_match_context to pcre2_match() a few
lines down as well, for consistency.

Ren=C3=A9
