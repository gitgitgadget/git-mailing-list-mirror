Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57521F404
	for <e@80x24.org>; Fri, 29 Dec 2017 16:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751186AbdL2Q4B (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 11:56:01 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33142 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbdL2Q4A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 11:56:00 -0500
Received: by mail-wr0-f196.google.com with SMTP id v21so31338872wrc.0
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 08:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DqPh5nKlQjjzXL/FIWyXnWsvld2f+IqO/Y/IkuiZdKc=;
        b=jFjV4u4CmWP5buDaUn/CT0niPyfLvvjBmsFTKvH329LW0+9RnLZFALRkUMIc35SFRz
         fXCB32STy8p7RldT+VoCUfy2wv9jVu2w3FRKLJp01lwqJIDfxjgZIdDuZDobKwXmGJ4I
         5Pfqfhlrzt+ugB7yg9ETBDxXEyomyshsmaxPzDuQKVjdV9jUNx8H5r81qPlJsQLkHQnH
         XVNSRGE03G75+/3v9Myzb1SxmtN1Za9+SqBQQ/Og61wXv5W+RBQVzOlQ/wkwdnKp58JR
         MQmhpvmfKYOdzB1XZdOtgsRKm5DIQiJC6Xl3Ir9yQcR1Sa/ctALa47hriwrJZi460vGA
         fnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DqPh5nKlQjjzXL/FIWyXnWsvld2f+IqO/Y/IkuiZdKc=;
        b=WoPsd+6lHLhNxgZM2lskgzlj9P7L/wjByjyOWiB1A1nZhqjoumAHAsQWFkyZICYMja
         ftWq7+HsJznx0pncfB6XUQR/PhnfFWxU4eaHuaGzVl8TDR4p3n9LKVnQ6Jul8n/afqaV
         pBRyrxtuUvRq4yYv5wauaHjJtLEjTB6sDaNAYx4k1xcyOa+EQkXzozLI7SWIss1gb2bT
         hhsbDG6aoVIESvnlKeNENsVRTB0UnjKib78fIqIjQ6BCP4LrZhGF/x/ssMESh3w4Lln8
         3dTugXFll/At8HAaB3K3bODhN2yGrrXPS5MEcJU4cOza7MLH/WQIS9E6cIJ6E+/Fivqy
         2s1A==
X-Gm-Message-State: AKGB3mKi2gnrGFm1gSK9Y8pFv7zN14JNlgPeQ1Twe1lQqX1CnZ7qVo7p
        QVKlInOXg3kY1pP7dD7eSqE=
X-Google-Smtp-Source: ACJfBosPg7d7cbYqi94g+IaLrD0M3QJWxaWUkvMW9yq2y148ScUaW2w9jhqS8U3ihBVhMaUIFQuQcw==
X-Received: by 10.223.172.146 with SMTP id o18mr8609853wrc.127.1514566559631;
        Fri, 29 Dec 2017 08:55:59 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5403.dip0.t-ipconnect.de. [93.219.84.3])
        by smtp.gmail.com with ESMTPSA id 47sm61753499wru.27.2017.12.29.08.55.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Dec 2017 08:55:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 1/5] strbuf: add xstrdup_toupper()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171229155642.GA23935@tor.lan>
Date:   Fri, 29 Dec 2017 17:55:57 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, j6t@kdbg.org, sunshine@sunshineco.com,
        peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D8114C4-BC45-43D3-AA33-8954AEC9EA10@gmail.com>
References: <20171229152222.39680-1-lars.schneider@autodesk.com> <20171229152222.39680-2-lars.schneider@autodesk.com> <20171229155642.GA23935@tor.lan>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 29 Dec 2017, at 16:56, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On Fri, Dec 29, 2017 at 04:22:18PM +0100, lars.schneider@autodesk.com =
wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Create a copy of an existing string and make all characters upper =
case.
>> Similar xstrdup_tolower().
>>=20
>> This function is used in a subsequent commit.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> strbuf.c | 13 +++++++++++++
>> strbuf.h |  1 +
>> 2 files changed, 14 insertions(+)
>>=20
>> diff --git a/strbuf.c b/strbuf.c
>> index 323c49ceb3..54276e96e7 100644
>> --- a/strbuf.c
>> +++ b/strbuf.c
>> @@ -760,6 +760,19 @@ char *xstrdup_tolower(const char *string)
>> 	return result;
>> }
>>=20
>> +char *xstrdup_toupper(const char *string)
>> +{
>> +	char *result;
>> +	size_t len, i;
>> +
>> +	len =3D strlen(string);
>> +	result =3D xmallocz(len);
>> +	for (i =3D 0; i < len; i++)
>> +		result[i] =3D toupper(string[i]);
>> +	result[i] =3D '\0';
>        ^^^^^^^^^^^^^^^^
> 	Isn't this already done by xmallocz()

I copied that code from xstrdup_tolower().

The original implementation [1] and its refactored version [2]
used xmalloc(). Later on xmallocz [3] was introduced.

[3] states "we can stop manually placing NUL at the end of the
allocated buffer. But that's only safe if it's clear that
the contents will always fill the buffer."

As far as I understand it, the content should always fill the
buffer in the upper/lower case conversion. Therefore, I agree=20
with you that the assignment is not necessary.

- Lars


[1] d4770964d5 (config: "git config --get-urlmatch" parses =
section.<url>.key, 2013-07-31)
[2] 88d5a6f6cd (daemon/config: factor out duplicate xstrdup_tolower, =
2014-05-22)
[3] 3733e69464 (use xmallocz to avoid size arithmetic, 2016-02-22)

