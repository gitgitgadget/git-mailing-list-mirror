Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D68C1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 13:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeCNNoF (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 09:44:05 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:39031 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbeCNNoE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 09:44:04 -0400
Received: by mail-wr0-f173.google.com with SMTP id k3so4803020wrg.6
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kgANx74ji6ELhpFwcD8nn4bJSMXo6XGjRQYIx5PgKJ8=;
        b=gxKUyxlYMr/pG1FiFtJ3O8KEvHVAPSzDwT/obqVx4pqNPoLi/p/oG5vinDwqn059i6
         8S0jGVUjeIwjnK78KMY9f5GnY4lG9IzR3LPfhmUNoJTM1wJ2KKo0V2kRgSpNuEnfihs3
         AWQRYWNGnyZZXRMppEzAWzjRiomQBd1Erxq+Q/MHUrK/zkCX+jD1vGdscOkIVj7Cm7dy
         fKR2JXuJBs5Lb5driJNoEz8ewr1Q8c07j6B6FdlqaphrXFtYmT1Rqri4A0auLJY4poTG
         q3EQXWjnlrXTMccuW08kpb5tcM7RgSSITpjYCSAlAUi+NV8OuoJ/SjQR1fBZWndNqUrl
         4XOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kgANx74ji6ELhpFwcD8nn4bJSMXo6XGjRQYIx5PgKJ8=;
        b=r8lwX8l1F8R6V+UrZKoaFQtzDtxwdfCy0k2m1EHyOYH0Q0CEKP0cEZmuZJwXASIz8n
         k/r41ygrYUlq50ZbDhJTGSs+z2xGvz9DO+NrGeR1Bs2l4reuZoYggYbohUJQi96LC0L/
         CoUHAzaAP8FhMdBGl4ZrMCnyrZ1pCVCE3muFvYQvG1MPrs7MBciOn9GTI5qFwTPZSbjd
         W63PQm5JAfZKjuxqH+hGY06qBsl0WHVVtFUu9yfShJ5Zdjnv8xm1gWjuipMOXkZMzEPe
         aw7Ck0fJCLgjOGQaGN4eIOL2aIlXBVTA3MXDk5iap9p0KG8PDRiG3o0vbgUys4xSXhym
         Ztgg==
X-Gm-Message-State: AElRT7H7QMgqKcNY66F2qTI2FUBpwMackL4H7HPW5j1yo+JpXWmGnnhE
        FVk0NK5/jOCe94NaGlkK3wUfqx5sft6FxaPvqipWRA==
X-Google-Smtp-Source: AG47ELsDgWZ9SaxP/vfFQCo2tg5v3cT0p6qcU8xAf/uC7frWVEYhmzULaAkJPWnUbgA5/R1IKCaJzjO7TedchrOl494=
X-Received: by 10.223.133.182 with SMTP id 51mr3660871wrt.226.1521035042789;
 Wed, 14 Mar 2018 06:44:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.197.147 with HTTP; Wed, 14 Mar 2018 06:44:02 -0700 (PDT)
In-Reply-To: <CAN0heSp-Vsvr95zc3J0iokRMJt74pxFH7OsoiR_3gnkMxpAAKw@mail.gmail.com>
References: <CAL21BmkmXKzdwYHu1pNxuHhaxqei4ekVbutbuv2jmv6=GgcG_A@mail.gmail.com>
 <CAN0heSp-Vsvr95zc3J0iokRMJt74pxFH7OsoiR_3gnkMxpAAKw@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Wed, 14 Mar 2018 16:44:02 +0300
Message-ID: <CAL21BmkgeytOKJ64NRJwhvo4Bk19iOVxxi-sOu-LWdf5rFfurg@mail.gmail.com>
Subject: Re: [RFC 0/4] ref-filter: remove printing from formatting logic
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-13 22:26 GMT+03:00 Martin =C3=85gren <martin.agren@gmail.com>:
> Hi Olga
>
> On 13 March 2018 at 11:25, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=D0=
=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>> The main idea of the patch is, if you want to format the output by
>> ref-filter, you should have an ability to work with errors by yourself
>> if you want to.
>> So I decided not to touch signature of show_ref_array_item(), but to
>> move all printing (I mean errors) to it. So that we could invoke
>> format_ref_array_item() and be sure that we cold handle errors by
>> ourselves.
>>
>> The patch is not finished, but I decided to show it to you. There are
>> still many places where we could die in the middle of formatting
>> process. But, if you like the general idea, I will finish and re-send
>> it.
>>
>> Another question is about verify_ref_format(). Do we need to allow its
>> users also to manage errors by themselves? I left the old scenario,
>> printing everything in verify_ref_format() and die. If you have better
>> ideas, please share them.
>
> I think it is a good idea to stop die-ing in "libgit". This seems like a
> good way of achieving that, or isolating the issue. Do you have any
> particular use-case for this, i.e., are you setting up the stage for a
> patch "5" where you add a new user of one of these?

Yes, I want to reuse formatting part in cat-file command. In cat-file
sometimes we have an error but we want to continue our work and check
all other sha1s. But, anyway, I find these changes useful not only for
cat-file.

>
> I do wonder whether a helper function to call strbuf_addstr() and return
> -1 would be a good idea though. I mentioned it in patch 2, then with
> patches 3 and 4, it started to seem like a reasonably good idea. It
> would be a shame if this sort of "boilerplate" for handling errors could
> have an impact on code clarity / obviousness.

I am also not sure if the code will be intuitive enough.

>
> Another issue is whether passing NULL for an error-strbuf should be a
> way of saying "I don't care; die() so I do not have to". Well, right now
> I guess passing NULL would indeed terminate the program. ;-) Such a
> construct might be another reason for providing error_strbuf_addstr()...
> Of course, it also means we keep die-ing in libgit..
>
> I feel I'm just talking out loud. Maybe you find my input useful.

I do so! Thanks a lot.
I fixed all that you mentioned, you could find new code here if you want:
https://github.com/telezhnaya/git/commits/prepare
I will not re-send it to the mailing list now. I want to finish the
patch at first, there are still some die() calls.
If anyone has other thoughts or ideas - please share them.

>
> Martin
