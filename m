Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE6321F576
	for <e@80x24.org>; Sat, 10 Feb 2018 10:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750993AbeBJKJi (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 05:09:38 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:36834 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeBJKJh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 05:09:37 -0500
Received: by mail-ot0-f179.google.com with SMTP id m20so10033892otf.3
        for <git@vger.kernel.org>; Sat, 10 Feb 2018 02:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lE16qgg7shHOH1vG96choNJ+6LR8NoQVRLk7n0Kp7s8=;
        b=IbukP8TLEOQ0gNPLpZWsLtZ4jLImXeea8sbvxfhJavsaXuPeu4D5d4mjEmlzCp/KMT
         QyWaLdmXLDbwpGEgLXXG3F1cV1hWbCXNhuiqpXZtx1kquc4MPeqM5DBMBKONExQG9ctW
         nl4C8Dss2kBANm/Z7eebOwTDu7hdZ0XttdSga1BAXx0SLMu1GsLN+z+H4Xir49k6d7an
         MjCKhmRfe/LNpbp7pcDJ3qbvk97Jz+1QIahdSF4ptU7cbhVIJmQNiX+UOt7qFtgjxTIb
         F66kSriP8OsF8Gi8sT70q1cYLF3z99Amay7roN1+9sKG8qH+eSywFdrXfipflFqDRWR+
         PX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lE16qgg7shHOH1vG96choNJ+6LR8NoQVRLk7n0Kp7s8=;
        b=gLKTzXGIbr06I8ctXchE1M+gkai629FSdjA30E65Ubx9i/ygzdIVQkN6f9tirUXYrr
         6+HA2QfoCgRmfJ68zhfMn0as2aRLOgg8OL6tefT9gUPXaSOECDPjyxvVbWckn9gtHGNK
         mrhUNPOZC8XEoIaHtCf5KxNI+q1zFTB9yg+iCwoCoraT24Jpdu8w8E7xLOZzPUBnNsDq
         cNbnhMf4qHQ8irV2eNM6NmR14AaIslWAg9s/x/u9T0bT02t9fkryZpEFUV+pERIJv8wV
         frgbSGgXUwJRvdodH3kTV3QJR4pLmj3bnRrCvv/8P65tSYQAswQX7TAipdnVpJGW0FUW
         dC9w==
X-Gm-Message-State: APf1xPCWgEClfmlW1X5YPhrJgBliXB6hMsq8gXBa2lnXvIxvboFe2Pqs
        vSkQII+4ujeLeRlUkQsALcO9HkIkt2+6xdU94FE=
X-Google-Smtp-Source: AH8x225FFfbqJjBoaITtt2SKEkDddfQ6ByNRshzqZDneY2MHomhdhIVWi+QnsfpClUzGI+3CHdPF73thFVq74DDTwsw=
X-Received: by 10.157.12.142 with SMTP id b14mr4787503otb.226.1518257376467;
 Sat, 10 Feb 2018 02:09:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Sat, 10 Feb 2018 02:09:06 -0800 (PST)
In-Reply-To: <87372am2ls.fsf@evledraar.gmail.com>
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com> <87372am2ls.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 10 Feb 2018 17:09:06 +0700
Message-ID: <CACsJy8BeQ3mD9pReUZKi+=qio5z8an5RyVd=auxPnMZ3uCRhdQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 10, 2018 at 1:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Thu, Feb 01 2018, Junio C. Hamano jotted:
>
>> * nd/fix-untracked-cache-invalidation (2018-01-24) 5 commits
>>  - dir.c: stop ignoring opendir() error in open_cached_dir()
>>  - update-index doc: note a fixed bug in the untracked cache
>>  - dir.c: fix missing dir invalidation in untracked code
>>  - dir.c: avoid stat() in valid_cached_dir()
>>  - status: add a failing test showing a core.untrackedCache bug
>>
>>  Some bugs around "untracked cache" feature have been fixed.
>>
>>  Will merge to 'next'.
>
> I think you / Nguy=E1=BB=85n may not have seen my
> <87d11omi2o.fsf@evledraar.gmail.com>
> (https://public-inbox.org/git/87d11omi2o.fsf@evledraar.gmail.com/)

I have. But since you wrote "I haven't found... yet", I assumed you
were still on it. You didn't give me much info to follow anyway.

> As noted there I think it's best to proceed without the "dir.c: stop
> ignoring opendir[...]" patch.
>
> It's going to be a bad regression in 2.17 if it ends up spewing pagefuls
> of warnings in previously working repos if the UC is on.

"previously working" is a strong word when opendir() starts to
complain. Sure we can suppress/ignore the error messages but I don't
think it's a healthy attitude. Unreported bugs can't be fixed.

We could perhaps stop reporting after we have printed like ... 5 lines
or so? That keeps the noise level down a bit and probably still give
enough indicator to at least repair the cache.
--=20
Duy
