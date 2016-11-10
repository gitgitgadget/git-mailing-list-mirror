Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD8B2035F
	for <e@80x24.org>; Thu, 10 Nov 2016 09:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754693AbcKJJUA (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 04:20:00 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36588 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754671AbcKJJT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 04:19:58 -0500
Received: by mail-yw0-f194.google.com with SMTP id r204so9517303ywb.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2016 01:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=WWumy+p93g4nLS/qiJ/zCpt9iCjw4JsYdSnfawHpNNg=;
        b=Sh0+H/mGrC5sjw6tIjF4XsOrokaV0rH+Z4z3exCoNkdH70vd9Cz3vha9MIQuJlTLo4
         ZoLVppEL4G7l4ANOJW5AUePBrjreCMq2ytZfWHNiPSLtzdhnfJ+CNeN1xNMV0Ul/84/o
         BVV99Bm9aRR2yehINbmZFOyv4qqneSKR204V53PLJp3esOnMM4DrT/KdijRf6R1O4pDG
         RQiAwojATaeLaHJZ2j7xIprqd4dJaB9hHC/pJBFGBxWFbt9leV0mZ7r7dDy5NWxfdT3i
         clDPmBRIi01zO5vjsjwYhokc3HWqY6/UgIPevanqh92GzNRlWdgUKeLqLtJ4f2rEucis
         17RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=WWumy+p93g4nLS/qiJ/zCpt9iCjw4JsYdSnfawHpNNg=;
        b=DPTYLFmxo4F1qDbe8UmVMYP792/OzPRIvgADyM62piWLt5qXl7OyRzSEVnvdk9BePf
         Wr7Ma25mxclh/BFr7TwLnEXMl9rKrY1PiHqAd3efu9tbOh04sOGQUE8WteEf1RNv4HNU
         P4krjhSYIb7Lr7z3FfOmbnDdYxLJZH6Z35sHtuFgneLEju7UXMEAV3kVbpXPXqh18hCG
         raI9On34uyvhLBx03qD5L/aBEqICXIkTuwVmXmBMAmV/5oIQYcIIDdpYtRXbeaOJqB0n
         a1Rd3W2DqrCaZe3G9tLqP2HLpB+DAY8phj6XQBRlQuszP/RqPq0wLWQfzFNtzEdEbLYG
         HyKA==
X-Gm-Message-State: ABUngvdqQwdexJ0uuPc/5RbRcu8+dKuOzysjRkWnyNxK57VmFBzeFhnDkdp8gDAzJX8FxOjGg5dDcqd6pn9f0g==
X-Received: by 10.13.246.134 with SMTP id g128mr4405939ywf.319.1478769597923;
 Thu, 10 Nov 2016 01:19:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.193.71 with HTTP; Thu, 10 Nov 2016 01:19:57 -0800 (PST)
In-Reply-To: <CALbGNxUahc0b151niqS3Qd6N8wapY5RWJs1w0ZSf6ZW1=id6vA@mail.gmail.com>
References: <CALbGNxUahc0b151niqS3Qd6N8wapY5RWJs1w0ZSf6ZW1=id6vA@mail.gmail.com>
From:   John Szakmeister <john@szakmeister.net>
Date:   Thu, 10 Nov 2016 04:19:57 -0500
X-Google-Sender-Auth: nt23v_iNRnGHGRq-_CYURufhDbg
Message-ID: <CAEBDL5VWpnoQdD6TJgdLBgFbb9HZzwYyLDbVz1O3s5As5otLQg@mail.gmail.com>
Subject: Re: Cleaning ignored files
To:     Roman Terekhov <roman.terekhov@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 9, 2016 at 1:23 PM, Roman Terekhov <roman.terekhov@gmail.com> w=
rote:
> Hi,
>
> I want to ask about git clean -dXf command behaviour.
>
> I do the following:
>
> $ mkdir gitignore_test
> $ cd gitignore_test/
> $ git init
> Initialized empty Git repository in ~/gitignore_test/.git/
>
> $ echo *.sln > .gitignore
> $ git add .gitignore
> $ git commit -m "add gitignore"
> [master (root-commit) ef78a3c] add gitignore
>  1 file changed, 1 insertion(+)
>  create mode 100644 .gitignore
>
> $ mkdir src
> $ touch test.sln
> $ touch src/test.sln
> $ tree
> .
> =E2=94=9C=E2=94=80=E2=94=80 src
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 test.sln
> =E2=94=94=E2=94=80=E2=94=80 test.sln
>
> 1 directory, 2 files
>
> $ git clean -dXf
> Removing test.sln
>
> $ tree
> .
> =E2=94=94=E2=94=80=E2=94=80 src
>     =E2=94=94=E2=94=80=E2=94=80 test.sln
>
> 1 directory, 1 file
>
>
> Why git clean -dXf does not remove all my test.sln files, but just one of=
 them?

src/ is not under version control, and currently git does not descend
into unknown folders to remove ignored files.  If you had a tracked or
staged file in src/, then git would descend into src/ and remove
test.sln as expected.  In your example, try doing:

$ touch src/foo.c
$ git add src/foo.c
$ git clean -dXf
Removing src/test.sln
Removing test.sln

Hope that helps!

-John
