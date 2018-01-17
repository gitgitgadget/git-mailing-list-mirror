Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74D991FADF
	for <e@80x24.org>; Wed, 17 Jan 2018 09:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeAQJQ6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 04:16:58 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:46636 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbeAQJQx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 04:16:53 -0500
Received: by mail-oi0-f68.google.com with SMTP id d124so12632031oib.13
        for <git@vger.kernel.org>; Wed, 17 Jan 2018 01:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WBzXpF34k9cx7roznwQL6S/cPFKVMDx14WwllzGM3W8=;
        b=tR0NB+lzkWqZJMiSFZCnpQOn3f0nyVpEWXtNpv5ebsA/PIWunKHaxnBgL3KjzFfqp9
         fB0xUPSAc3YcfCZgjI7w0WmbSs5jiCYY4qP8iS86uSIMw/6Tyy6zjP5hEitQGazkePmh
         ge95N4trhwM4b0CMBJuDI1EtRex5AIopvq+AS7khSrLno28s9RoJHUjVGhmhebAvhkN6
         Je4XjYqrHRUpWHnC8vhwrz2lYB2U0hCpb2AtXI2SGUAQCyDTnLK+3CJDmx2IDw/VGqZv
         1xLbtRkPAduzJg5wtufjIgy/V17au5GwWCuoUVYRdiUbU/ml4n9MRc5tG2wRXnirChHT
         Y9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WBzXpF34k9cx7roznwQL6S/cPFKVMDx14WwllzGM3W8=;
        b=WlTojFRsSd7zaYMA/UqTOhM5pgFtF9fo1rLYuN8aXNJRlfFuMUaWUDU+NTlyyZF/pU
         nUhrrVTivmDO+34eEBJnxxPWsEhKQT2ejZ7/dAyFmVwPtdQcsQqHOl8OatHfuFDd4Wj9
         VQXgXavHboyGg69LA2gOAyNSxYC53Um7F25WZf7FsOuRph+BhlcO3/FeB0iSqAu1eBAi
         3KFowijpznP6L6z9TMJy1/hxJdqJpX3OmTfAo4Rz6RoRcFvzKEdQfGIsTfOCoamCPwnh
         vEdCvVgbx+mXc9GABXsZVkhKwU7nnHQo5k6dVqHTc87f34KmPkKbstvw3fZEr8qdNk5l
         jxeQ==
X-Gm-Message-State: AKwxytdg0Q79NSl+E2As9OzV6rJQznDswkgWyKQXV8SxWtZUEXNRd2w4
        mDIq6DNNPTMOh4Abi6fTkknDju+HfzlThDCvCTM=
X-Google-Smtp-Source: ACJfBotCgnS3oa/tjEfOcITxiv9rs3lPSHrw2TyPi2WCjp2u8vhHXLeBpBFW5nb1mpto9ljn/LiDwjCPyLZZMT8dKmw=
X-Received: by 10.202.60.134 with SMTP id j128mr702735oia.268.1516180612927;
 Wed, 17 Jan 2018 01:16:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Wed, 17 Jan 2018 01:16:22 -0800 (PST)
In-Reply-To: <CAM0VKjkz8-VsLJ8i64OHHUH4R4WY5fT6x3X+s=FKuZyfM9txkA@mail.gmail.com>
References: <20180116103700.4505-1-pclouds@gmail.com> <CAM0VKjkz8-VsLJ8i64OHHUH4R4WY5fT6x3X+s=FKuZyfM9txkA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 17 Jan 2018 16:16:22 +0700
Message-ID: <CACsJy8D3wRmP_o5iFJwWtODOJpj-r=JZsJ3P8XxWOCD8rJJrHA@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] Automate updating git-completion.bash a bit
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 17, 2018 at 7:51 AM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Tue, Jan 16, 2018 at 11:36 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy
> <pclouds@gmail.com> wrote:
>> I noticed --recurse-submodules was missing from git-grep complete
>> list. Then I found a couple more should be on the list as well and
>> many more in future may face the same faith. Perhaps this helps remedy
>> this situation?
>>
>> This lets us extract certain information from git commands and feed it
>> directly to git-completion.bash. Now long options by default will
>> be complete-able (which also means it's the reviewer's and coder's
>> responsibility to add "no complete" flag appropriately) but I think
>> the number of new dangerous options will be much fewer than
>> completeable ones.
>>
>> This is not really a new idea. Python has argcomplete that does more
>> or less the same thing.
>
> This has come up before for Git as well, see:
>
>   https://public-inbox.org/git/1334140165-24958-1-git-send-email-bebarino=
@gmail.com/T/#u

Thanks! I did search the archive but couldn't find this one.

>
> I see that your approach solves one of the shortcomings of those older
> patches, namely it makes possible to omit dangerous options from
> completion.  Great.
>
> I also see that you want to invoke git in a subshell every time the user
> attempts to complete an --option.  Not so great, at least for Windows
> users.  That older thread contains a few ideas about how to do it only
> once by lazy-initializing a variable for each command to hold its
> options.

Noted.

I see you also pointed out the problem with running commands like
"git-status" without a repository. I'll try to address this too if
possible (I'm thinking about making struct options[] available outside
cmd_*(); then we could handle it more like "git --version" which
always works)
--=20
Duy
