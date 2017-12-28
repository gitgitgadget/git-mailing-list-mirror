Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630861F404
	for <e@80x24.org>; Thu, 28 Dec 2017 11:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbdL1LMy (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 06:12:54 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36640 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753279AbdL1LMx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 06:12:53 -0500
Received: by mail-wm0-f42.google.com with SMTP id b76so43510280wmg.1
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 03:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=29gOVdWABIFOlXcxhU2gt0ZlTk41BX+KjjFMKyiIMVM=;
        b=m28wzzx9mpLc+kMOZ2jBWHvlm/t/bm+2ugtER/u2UIq62BGRxFJkvsij/e3O+Shg56
         JRjKyPNwSipNoGOXAiQfJf1cv2agRlIlcP7NsK2zVJD+eVophlbYzLbdMOwDvBYrzx+T
         D35VTdLZdA7RVEdPVj8ViVWTFI524jyKYoe/sXW0bIxliN6FP3VS/BE3EZKKM5qY1fj+
         IZEqEwPc0vnIJ2RzOV5gomXcfHP30qu4S4ZghT6qVL7qsfmqtmElCF25d57djHnwwnnm
         t64IYxSJZ0IXngCTXsXgJXNBADn0FAEYsv87RG4dRu2fQOREKnqwrboSOPEu45WPQDXA
         Zo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=29gOVdWABIFOlXcxhU2gt0ZlTk41BX+KjjFMKyiIMVM=;
        b=k/T6DgZiUviacKSC/Mfv797FvSeym1D1ub95XMpNGvSjOb5v0u0hyI5IlTfl8PLSGJ
         Hnx5BO26r+uGWUiiDvLj9B2NamySOQDfJZZGBibUIgBFlozfDyo/O6uVs1x6FliQOkku
         AAa4NQ5KEiajdtQ9tOkrYPmqSTKnpq7+Ikl3Ga0B8Fd7Wk6c9WOqe7yhoBXB7Ydi/3Ut
         tQsxqKz4yjS+7CIixwAktgUEtcQbuS0wswua4NZwMOi3t+UV81+ht3tp6wDCrtB5yn+9
         AAm2HQdDngBWTOZXvz6X4cgqPndj/OF4a881xKY3A9v4OQibLJ2+yP0YxKw7EDYKkhyk
         mkSA==
X-Gm-Message-State: AKGB3mKc5XILyTI5sMDZ0bB/WrsLxtX1TMXrf6vSvqky79bXajoI5qoT
        EBWxCWBu3wzdeYfrPxOxA6E=
X-Google-Smtp-Source: ACJfBouRkCGO3CwFSGzay2Lc2UQ9u1G7VgURxfZt7jNYaQCs892oDsGhcnuRCjtxA2QdSH3LJ5HigA==
X-Received: by 10.28.208.198 with SMTP id h189mr22847325wmg.25.1514459572359;
        Thu, 28 Dec 2017 03:12:52 -0800 (PST)
Received: from [10.32.248.174] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id o12sm5531728wrf.14.2017.12.28.03.12.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Dec 2017 03:12:51 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] travis-ci: record and skip successfully built trees
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAM0VKjmCodQgmTa8bjEc02N99cPjrFdp4rFGF3yQOA-VMer4hw@mail.gmail.com>
Date:   Thu, 28 Dec 2017 12:12:50 +0100
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2523A364-25A1-4E4C-B3EC-7F90D810D5DF@gmail.com>
References: <20171227164905.13872-1-szeder.dev@gmail.com> <20171227164905.13872-3-szeder.dev@gmail.com> <332E6163-C09C-426F-80BE-084D6D6D5AD0@gmail.com> <CAM0VKjmCodQgmTa8bjEc02N99cPjrFdp4rFGF3yQOA-VMer4hw@mail.gmail.com>
To:     =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 28 Dec 2017, at 11:31, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
> On Wed, Dec 27, 2017 at 8:35 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>>=20
>>> On 27 Dec 2017, at 17:49, SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
>=20
>>> Using an ever-growing flat text file might seem like asking for
>>> trouble on the long run, but it's perfectly adequate for this =
purpose.
>>> Contributors' topic branches are short-lived in general, so this =
file
>>> won't grow large enough to cause any issues.  Grepping through =
several
>>> tens of thousands such lines is sufficiently fast, so not even
>>> git/git's forever living integration branches will cause scalability
>>> issues with the current rate of ~1 push/day for a couple of decades.
>>> And even if we reach the point that this file grows too big, the
>>> caches can be deleted on Travis CI's web interface.
>>=20
>> One more thing:
>> Maybe we could delete "$HOME/travis-cache/good-trees" if the file
>> has more than 1000 lines *before* we add a new tree?
>>=20
>> Or we use something like this to cap the file:
>>=20
>>  echo "$(tail -1000 $HOME/travis-cache/good-trees)" > =
$HOME/travis-cache/good-trees
>=20
> Well, there is always something new to learn.
> I was aware that things like 'cmd file >file' don't work, because the
> shell opens and truncates 'file' before executing the command, so =
'cmd'
> will open the already empty file, but I didn't know that 'echo "$(cmd
> file)" >file' works.  Thanks for letting me know.
>=20
> However, this is subject to the portability issues of the shell's
> 'echo', i.e. try
>=20
>  echo "$(cat git.c)" >git.c
>=20
> with Bash and Dash.  Bash produces the exact same contents, but Dash
> turns all '\n' in help and error strings to real newline characters.
>=20
> Now, Git's object names will never contain such characters, and most
> likely $TRAVIS_JOB_{NUMBER,ID} won't ever do that, either, so this is
> not an issue for this 'good-trees' file.  Still, I think it'd be =
better
> to stick to using a good old temporary file:
>=20
>  tail -1000 good-trees >tmp
>  mv tmp good-trees

Agreed!

- Lars
