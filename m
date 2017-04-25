Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E701FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 17:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1432471AbdDYRm5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 13:42:57 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:33906 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971153AbdDYRmz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 13:42:55 -0400
Received: by mail-wr0-f181.google.com with SMTP id l9so10763586wre.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 10:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=48BqU39K4KsvYBRbEk+vv5TiK/yAM1Zzo88VlpuPjEI=;
        b=dcH3fX9nIdcMiv6wnxcplg4Zlr2wG1B8ulh7Lzc8ZliRU/tlw5GMWwrIUcqHALMb9n
         zkJtnXYwqXF3MrWa2PsE8+HzbRawDqDkdn06VN2WxkKcAwO/NMYqnDT9JN8Dg1ZStzLv
         77NU1XY9M/u+4XHtaRaSh84ReYRk1079BciJyrdCRTyN+oQuCaAUXcfFdd2hB7LMU7hk
         qbyUNlBhB1VSwTkoA5Rl617kPz3wOh8Kluv9CWH1kBkQDd8bV3igzanmbIpXXBp3bHiz
         6cC7E2AZyma8MwmUW0hp+gMi78dMPNxKPwmvPrbDqTKesf8rgPWAbIu3rKnYhLvG0ews
         X3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=48BqU39K4KsvYBRbEk+vv5TiK/yAM1Zzo88VlpuPjEI=;
        b=DUOmClImGB0crfBJYsB0/gWu5rN+BUQrEe32tX+coyEV2K7V8rx3Q0+0bSSeb5a+qx
         t7psuBhViha8d7zKu0NUY9JZsHGl1Cm7MujGEeuSOweBtsvqCQNNVPM0bo1GJmvRyw0e
         CzQD0VvOFuZ54PrqXIpB+8q09eyGjW/ercsy5zU7ZiayNFAp1eqvqsh0jThaxUR6/pG9
         jcycrbk3yNSL9PvjtT27DSJwT447ca62gAsrxXaBKOI4e0OcXi6PIKymTfe7tTQnpX8a
         sOPfUjaKAjVxj87eni4+A2FHsMNwjcS6ly2hmZjlfZc4V16+PjUHgU2mMELXGccK7+Z3
         zsUg==
X-Gm-Message-State: AN3rC/7PxlZ5QXoxV2BfWs025XmZdIbhZHGh5kKrjjbQfW0KjuUp20Dp
        I2vkrLmxOPOOIw==
X-Received: by 10.223.133.152 with SMTP id 24mr11116734wrt.86.1493142173758;
        Tue, 25 Apr 2017 10:42:53 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id v14sm3886420wmv.24.2017.04.25.10.42.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 10:42:52 -0700 (PDT)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: t0025 flaky on OSX
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
Date:   Tue, 25 Apr 2017 19:42:52 +0200
Cc:     eyvind.bernhardsen@gmail.com,
        Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D9AE52B-6A2D-408B-855E-3988514AAC45@gmail.com>
References: <461E433C-DC8E-42FE-9B23-4A76BEFE0D11@gmail.com> <e6343f94-3fad-e323-cb38-8ea1148cec3f@web.de> <11da00e8-a62c-bf07-d97e-ab755647082b@web.de>
To:     =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Apr 2017, at 21:48, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
>=20
> On 2017-04-24 19:00, Torsten B=F6gershausen wrote:
>> On 2017-04-24 18:45, Lars Schneider wrote:
>>> Hi,
>>>=20
>>> "t0025.3 - crlf=3Dtrue causes a CRLF file to be normalized" failed=20=

>>> sporadically on next and master recently:=20
>>> https://travis-ci.org/git/git/jobs/225084459#L2382
>>> https://travis-ci.org/git/git/jobs/223830505#L2342
>>>=20
>>> Are you aware of a race condition in the code
>>> or in the test?
>> Not yet - I'll have a look
>>=20
>=20
> So,
> The test failed under Linux & pu of the day, using Peff's
> stress script.
>=20
> not ok 3 - crlf=3Dtrue causes a CRLF file to be normalized
>=20
> The good case (simplified):
> $ git status
>   modified:   CRLFonly
>=20
> Untracked files:
>        .gitattributes
>=20
>=20
> $ git diff | tr "\015" Q
> warning: CRLF will be replaced by LF in CRLFonly.
> The file will have its original line endings in your working =
directory.
> diff --git a/CRLFonly b/CRLFonly
> index 44fc21c..666dbf4 100644
> --- a/CRLFonly
> +++ b/CRLFonly
> @@ -1,7 +1,7 @@
> -IQ
> -amQ
> -veryQ
> -veryQ
> -fineQ
> -thankQ
> -youQ
> +I
> +am
> +very
> +very
> +fine
> +thank
> +you
>=20
> --------------------
> The failed case:
> $ git status
> Untracked files:
>        .gitattributes
>=20
> -----------------------
> $ ls -al -i
> total 28
> 3430195 drwxr-xr-x 3 tb tb 4096 Apr 24 21:19 .
> 3427617 drwxr-xr-x 3 tb tb 4096 Apr 24 21:19 ..
> 3429958 -rw-r--r-- 1 tb tb   37 Apr 24 21:19 CRLFonly
> 3432574 drwxr-xr-x 8 tb tb 4096 Apr 24 21:27 .git
> 3425599 -rw-r--r-- 1 tb tb   14 Apr 24 21:19 .gitattributes
> 3430089 -rw-r--r-- 1 tb tb   24 Apr 24 21:19 LFonly
> 3430174 -rw-r--r-- 1 tb tb   36 Apr 24 21:19 LFwithNUL
>=20
> -----------------
> #After
> $ mv CRLFonly tmp
> $ cp tmp CRLFonly
> $ ls -al -i
> 3430195 drwxr-xr-x 3 tb tb 4096 Apr 24 21:36 .
> 3427617 drwxr-xr-x 3 tb tb 4096 Apr 24 21:19 ..
> 3401599 -rw-r--r-- 1 tb tb   37 Apr 24 21:36 CRLFonly
> 3432574 drwxr-xr-x 8 tb tb 4096 Apr 24 21:36 .git
> 3425599 -rw-r--r-- 1 tb tb   14 Apr 24 21:19 .gitattributes
> 3430089 -rw-r--r-- 1 tb tb   24 Apr 24 21:19 LFonly
> 3430174 -rw-r--r-- 1 tb tb   36 Apr 24 21:19 LFwithNUL
> 3429958 -rw-r--r-- 1 tb tb   37 Apr 24 21:19 tmp
>=20
> $ git status
> 	modified:   CRLFonly
> Untracked files:
>        .gitattributes
>        tmp
>=20
>=20
> So all in all it seams as if there is a very old race condition here,
> which we "never" have seen yet.
> Moving the file to a different inode number fixes the test case,
> Git doesn't treat it as unchanged any more.

Thanks a lot for investigating this! Would you mind posting the
fix as patch?

Thanks,
Lars=
