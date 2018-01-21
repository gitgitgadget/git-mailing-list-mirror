Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90F371F576
	for <e@80x24.org>; Sun, 21 Jan 2018 16:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751402AbeAUQ1Z (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 11:27:25 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:44408 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeAUQ1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 11:27:24 -0500
Received: by mail-io0-f195.google.com with SMTP id z6so6952870iob.11
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ArVjDH3TZXzJn6T/unTptPOIOWf3Q6FX3puqhcHovH0=;
        b=WPc5Rc3QHn9xplZmsHJdHSDkS9zZaKlUAKbOZJgoQ9dVc79TtuQwWzVvOse8BAeo8i
         9vMo10WTVZfQj4DW2uWLHUTIybFFppmf2lI7G9wroL2hiM5SGDcROgcnjmP/yDLv+7PN
         Xcwza4omfK5IR+6Cjwo2kZ/8rUK6OCYKSqeetuptG199UBb1la0FXJ5CeF0jBXXKSFem
         xwekKtsi1/Vm+p15UKLBZUQ2j9ZVbkFJ34HxhHR6cK2KZt3hFaTQcZhd2Vr7VA4GyIbb
         u4jrj3NUhKfN7ZFYY5E9Y/ksSpVORq00rtkKeLBk+mncYhETrTHcvjlBuJnqa30rSl/a
         c8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:content-transfer-encoding;
        bh=ArVjDH3TZXzJn6T/unTptPOIOWf3Q6FX3puqhcHovH0=;
        b=S5wBNfHZvmJsZWNqpwjJqBsZf2Yoj/sSsD5kN7Qtu4ttp4R7yz7+Jnox1BMTuWXQkT
         O37vm7hw0cpaoRENIoU2ybWWAmY3Y9+ts06h5MdSpkYMGrsyFLNjpyxaGLLz0GR907kx
         pYEm/5O8HVGgVy8ohbjvA97t1tc7ZtuJEPthQb3SsPv+6IN7uyCSdFUS7W9QZ4GCudLd
         4GbTSNe84/+JwZPf7hSaVL86uGVOC5mTiHyCKM3ODiZfQKKfD/fJrClxyY6UICUnFIbl
         CFMj+46FNBCgAAAPhF7CZURx6ZJJHUNA5SbKljP+kFjym27SOUYgvbr/jrxz3E+pWRyG
         wJaQ==
X-Gm-Message-State: AKwxytfiKGTD8NHDYWNo5hf3os8fNriJNXdJABqd3Xtc0PRjkqL32kRP
        Ot9x+gKHNy20ZVjnuQA5tVWeCgfFdoaNZUOvlb8=
X-Google-Smtp-Source: AH8x2259DQmkbDiqVkKs0wtFyQyslvwVzpJIVEqIRHGJo6DW98AsTm/xdAZRrbEF+D4MbBIj6RQ0jAuGMGW2uNaULcc=
X-Received: by 10.107.78.16 with SMTP id c16mr5435702iob.105.1516552043476;
 Sun, 21 Jan 2018 08:27:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.206.140 with HTTP; Sun, 21 Jan 2018 08:26:53 -0800 (PST)
In-Reply-To: <20180120204456.GB8965@genre.crustytoothpaste.net>
References: <cover.1516282880.git.patryk.obara@gmail.com> <0d554b5efb35b7570fc1e762c9035556423d3da3.1516282880.git.patryk.obara@gmail.com>
 <20180120204456.GB8965@genre.crustytoothpaste.net>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Sun, 21 Jan 2018 17:26:53 +0100
X-Google-Sender-Auth: 1kRHhVsU0PgYenWl-yzuaqcj_WM
Message-ID: <CAJfL8+SPCvCLMkXxjHrVkeHXt3t14Dj2x5nde7S17mcRomKB5g@mail.gmail.com>
Subject: Re: [PATCH 11/11] sha1_file: convert write_sha1_file to object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patryk Obara <patryk.obara@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 January 2018 at 21:44, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Thu, Jan 18, 2018 at 03:51:03PM +0100, Patryk Obara wrote:
>> diff --git a/sha1_file.c b/sha1_file.c
>> index 88b960316c..b7baf69041 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -1420,8 +1420,8 @@ void *read_object_with_reference(const unsigned ch=
ar *sha1,
>>  }
>>
>>  static void write_sha1_file_prepare(const void *buf, unsigned long len,
>> -                                    const char *type, unsigned char *sh=
a1,
>> -                                    char *hdr, int *hdrlen)
>> +                                 const char *type, struct object_id *oi=
d,
>> +                                 char *hdr, int *hdrlen)
>
> It looks like the indentation has changed here.  Was that intentional?

Yes. After every commit, I am running clang-format on lines, that I
touch to verify formatting and
decide if I want to include formatting fixes or not. In this case,
function parameters were
aligned using spaces only (which is arguably hard to see in the mail)
- now they are aligned to first
parameter (at least in my editor and in gitk :)).

--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
