Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA7E71F404
	for <e@80x24.org>; Fri, 29 Dec 2017 13:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbdL2N4V (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 08:56:21 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37589 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbdL2N4U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 08:56:20 -0500
Received: by mail-wm0-f51.google.com with SMTP id f140so48133063wmd.2
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 05:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zfNwHtqQknXj/u0mLqnL4m5TvfumW//xQgKnTgDteEc=;
        b=JCubvGqvkIIkVKtlseLuIKca8yUDUbZ1/HDK+irV6JRoW906PmAG7aIINnYjwZ68H9
         07ZQ980Xu5YdCQ0toJXKDNcFVm+B0BRK8NyLlwxDLwy18TQ4z/GLabX6HlPBfjuvRX3I
         uJctaQ9+mNdVCt3ZOaFGkWia1Z44Wnhc0m2Hmg3mo4FU53peslmvMWWxbv8QQ96BdQ6t
         9RorYB0bppX6W9igo/R2YjNaBrMnkPnz/t7WrECVhiLgTy2uKjTk3qGQpB5cBHuOlPwp
         ga9tEjB+hJ4h2V1H5rnuz0RVpyBrGw3CnFlidYOSbSEd2m9pNvRqNbdNVQNm2ivLNOW/
         r1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zfNwHtqQknXj/u0mLqnL4m5TvfumW//xQgKnTgDteEc=;
        b=scIl266TPKEYc+Fj/WXWFIAzAaM+OdnQL9TCe+IkhE/HY/tRpn6+41QonOE/MK6/EO
         gqS+XdrwOJBcqA+coAskZL2Qyv778FThulz+xwvmCWNpJ4/0q6tUcRzzKGAxbWPMS/wN
         j3UvOovyMiakcd2IwDckrShwFNp9UntBuiYlCMzgpe9Fi5GLHwDGzcxS+6Dfq9E0Zwrj
         qqoWFddnN6VVYf2QRGnzD8rEmxPXG1lQXn3hKMKqih5mCFVoz0vvBg0+s6XmJwqvcU2q
         0dPNN5LXSMb2yJjOF0IJN/yWJWB0l3m3C/RqZsZZOWZjb21MrIc9S2LAfDlIv2U3j1t0
         5UxQ==
X-Gm-Message-State: AKGB3mK1yUA24nN8tpuNn4IgftG0guH5PiPyCp1dNPsaOCVrLN9MnpTQ
        Dhjb3qVk/BrKw9NNg8/8EMpnlc4S
X-Google-Smtp-Source: ACJfBot1N1Djun1pwcOmisfqhQ0lLqMbAQyX0YHlwGv5tIbOxxbkZNuhfP5iHKSiQqwX81H699kGDw==
X-Received: by 10.28.148.195 with SMTP id w186mr31581121wmd.33.1514555779373;
        Fri, 29 Dec 2017 05:56:19 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5403.dip0.t-ipconnect.de. [93.219.84.3])
        by smtp.gmail.com with ESMTPSA id e4sm20825581wmi.14.2017.12.29.05.56.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Dec 2017 05:56:18 -0800 (PST)
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171229125954.GA9772@tor.lan>
Date:   Fri, 29 Dec 2017 14:56:17 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, peff@peff.net,
        patrick@luehne.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <2ADD036C-6714-4DE5-A290-4C76EFACE166@gmail.com>
References: <20171211155023.1405-1-lars.schneider@autodesk.com> <20171217171404.GA18175@tor.lan> <BF5C58AC-C1E6-4AD5-A4F8-C4CC5C9108F7@gmail.com> <20171229125954.GA9772@tor.lan>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Dec 2017, at 13:59, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
>=20
> On 2017-12-28 17:14, Lars Schneider wrote:>=20
>>> On 17 Dec 2017, at 18:14, Torsten B=F6gershausen <tboegi@web.de> =
wrote:
>>>=20
>>> On Mon, Dec 11, 2017 at 04:50:23PM +0100, =
lars.schneider@autodesk.com wrote:
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>>=20
>>=20
>>>> +`encoding`
>>>> +^^^^^^^^^^
>>>> +
>>>> +By default Git assumes UTF-8 encoding for text files.  The =
`encoding`
>>>=20
>>> This is probably "ASCII" and it's supersets like ISO-8859-1 or =
UTF-8.
>>=20
>> I am not sure I understand what you want to tell me here.
>> Do you think UTF-8 encoding is not correct in the sentence above?
>=20
> Git itself was designed to handle source code in ASCII.
> Text files which are encoded in ISO-8859-1, UTF-8 or any
> super-set of ASCII are handled as well, and what exactly to do
> with bytes >0x80 is outside the responsibility of Git.
> E.g. the interpretation and rendering on the screen may be
> dependent on the locale or being guessed.
> All in all, saying that Git expects UTF-8 may be "overdriven".
> Any kind of file that uses an '\n' as an end of line
> and has no NUL bytes '\0' works as a text file in Git.
> (End of BlaBla ;-)
>=20
> We can probably replace:
> "By default Git assumes UTF-8 encoding for text files"
>=20
> with something like
> "Git handles UTF-8 encoded files as text files, but UTF-16 encoded
> files are handled as binary files"

Well, UTF-32 are handled as binary file, too :-)

How about this?

    Git recognizes files encoded with ASCII or one of its supersets
    (e.g. UTF-8 or ISO-8859-1) as text files.  All other...


>=20
>>>=20
>>>> +attribute sets the encoding to be used in the working directory.
>>>> +If the path is added to the index, then Git encodes the content to
>>>> +UTF-8.  On checkout the content is encoded back to the original
>>>> +encoding.  Consequently, you can use all built-in Git text =
processing
>>>> +tools (e.g. git diff, line ending conversions, etc.) with your
>>>> +non-UTF-8 encoded file.
>>>> +
>>>> +Please note that re-encoding content can cause errors and requires
>>>> +resources. Use the `encoding` attribute only if you cannot store
>>>> +a file in UTF-8 encoding and if you want Git to be able to process
>>>> +the text.
>>>> +
>>>> +------------------------
>>>> +*.txt		text encoding=3DUTF-16
>>>> +------------------------
>>>=20
>>> I think that encoding (or worktree-encoding as said elsewhere) must =
imply text.
>>> (That is not done in convert.c, but assuming binary or even auto
>>> does not make much sense to me)
>>=20
>> "text" only means "LF". "-text" means CRLF which would be perfectly =
fine
>> for UTF-16. Therefore I don't think we need to imply text.
>> Does this make sense?
> Yes and now.
>=20
> "text" means convert CRLF at "git add" (or commit) into LF,
> And potentially LF into CRLF at checkout,
> depending on the EOL attribute (if set), core.autocrlf and/or =
core.eol.
>=20
> "-text" means don't touch CRLF or LF at all. Files with CRLF are =
commited
> with CRLF.
> Running a Unix like "diff" tool will often show "^M" to indicate that =
there
> is a CR before the LF, which may be distracting or confusing.
>=20
> If someone ever wants to handle the UTF-16 files on a Linux/Mac/Unix =
system,
> it makes sense to convert the line endings into LF before storing them
> into the index (at least this is my experience).
>=20
> (Not specifying "text" or "-text" at all will trigger the =
auto-handling,
> which is not needed at all).
> So if we want to be sure that line endings are CRLF in the worktree we
> should ask the user to specify things like this:
>=20
> *.ext worktree-encoding=3DUTF-16 text eol=3DCRLF
>=20
> It may be enough to give this example in the documentation.
> and I would rather be over-careful here, to avoid future problems.

Agreed. I'll add that example!


>>>> +
>>>> +All `iconv` encodings with a stable round-trip conversion to and =
from
>>>> +UTF-8 are supported.  You can see a full list with the following =
command:
>>>> +
>>>> +------------------------
>>>> +iconv --list
>>>> +------------------------
>>>> +
>>>> `eol`
>>>> ^^^^^
>>>>=20
>>>> diff --git a/convert.c b/convert.c
>>>> index 20d7ab67bd..ee19c17104 100644
>>>> --- a/convert.c
>>>> +++ b/convert.c
>>>> @@ -7,6 +7,7 @@
>>>> #include "sigchain.h"
>>>> #include "pkt-line.h"
>>>> #include "sub-process.h"
>>>> +#include "utf8.h"
>>>>=20
>>>> /*
>>>> * convert.c - convert a file when checking it out and checking it =
in.
>>>> @@ -256,6 +257,149 @@ static int will_convert_lf_to_crlf(size_t =
len, struct text_stat *stats,
>>>>=20
>>>> }
>>>=20
>>> I would avoid to use these #ifdefs here.
>>> All functions can be in strbuf.c (and may have #ifdefs there), but =
not here.
>>=20
>> I'll try that. But wouldn't it make more sense to move the functions =
to utf.c?
>=20
> May be.
> Originally utf8.c was about encoding and all kind of UTF-8 related =
stuff.
> Especially it didn't know anything about strbuf.
> I don't know why strbuf.h and other functions had been added here,
>=20
> I once moved them into strbuf.c without any problems, but never send =
out
> a patch, because of possible merge conflicts in ongoing patches.
>=20
> In any case, if it is about strbuf, I would try to put it into =
strbuf.c

I think I simplified the code. I reused "reencode_string_len".
I added just two BOM check functions to utf8.c ... I'll send out a new =
series
in a bit.

- Lars

