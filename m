Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A34551F576
	for <e@80x24.org>; Tue,  6 Mar 2018 09:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeCFJrN (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 04:47:13 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:46071 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeCFJrL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 04:47:11 -0500
Received: by mail-qk0-f182.google.com with SMTP id g2so24128165qkd.12
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KY1D1tBx9hN2iBXKAx37VpGW+It6DkMJ9BZ3nDlJDxA=;
        b=Y1txqrdtFy5KWWTdybBbn9Ild+7u6xoUcup/Og3zRy0lzaZom7UNqX4oeBI8gEflVQ
         SyefLFYe/YXqo9gB9w92rP+Fw44KBSYVDk93N2mSIv8Af3DaDKQ/5fMflE1S4fYX4axZ
         0qp2TFXoZ582K0SNjF3lNHwrnj5VbpxSIFj/pESMW3B1nhSn3rAJU5zpk1NZccuUeI1l
         9yPvTgb4YzJyrK7a2X1QOQBm/UL579gbJvg5XLU3ywttpHz3TFcjy3ifa03N6yXVYNeV
         QZYGscwbLf546r8vweT5ZQcCGZp6Dd3LBJOr/pZY7q7XMCdJnvjR8p0zxMnbBaj+nh8i
         43Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KY1D1tBx9hN2iBXKAx37VpGW+It6DkMJ9BZ3nDlJDxA=;
        b=OE3+dnbVnAdhNl8OtfcMfqsIYDjZ8mY/b6hQBnxd2rAgnMkUSliQ8cO+DP5nBCmrBq
         A+VZUKayGUyIdKH6pBjnT+rS87S3wVFlKd+rWAW4RNKRi5BsqPgZjHS3CMp4aQKGyT8J
         xrIOp03BYkA/sbEiGIrRKIoXMTfg42S2Rb2KbvzpJMPmaVhg95q65T/Snr5itOO3ygi/
         ArZdzgExKPanQUA+170VW+ATQy+PlfgTYLBJege0YY1BiorF4I55yfiCIWQvZFuRocho
         Uxn3cbaPOUN+VU8QPJGLkOQ5aBz3dL7jMAZ5oGA5QqjMYeGU18qCuQDWkrDu6glY63GB
         2sHg==
X-Gm-Message-State: AElRT7GjE6XFLvh+eOeZGcJwhLvHXgtFrmTfYKu9WsQIrN7prdAzYa8a
        Z0hyoKBcxrfnIch5D1ohk6kN7n6g+Kk5Z+DRIXHa2Cpj
X-Google-Smtp-Source: AG47ELs3BWPf8xz2Lfz0LwdcenbVyBof5XxdbNeKRNWtV1nh/pJOzMXiWlRtQT+s3GisgRq+OP6iXjDF14OoehSUNv4=
X-Received: by 10.55.2.140 with SMTP id v12mr26068624qkg.251.1520329630755;
 Tue, 06 Mar 2018 01:47:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.67.84 with HTTP; Tue, 6 Mar 2018 01:47:10 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1803051457570.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAL+2DvQZ2V9c5Tmn8KCoDOuioOiBsGJspSTVin4qw1oFO2QAwA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1803051457570.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Larry Hunter <larhun.it@gmail.com>
Date:   Tue, 6 Mar 2018 10:47:10 +0100
Message-ID: <CAL+2DvR4ZBicrCYSkQ1jDaWaLJHgp8yVkKQZgxVc9txzHbNFkg@mail.gmail.com>
Subject: Re: [Bug] git log --show-signature print extra carriage return ^M
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The same ^M is shown in the output of tutorial

    https://www.geekality.net/2017/08/23/setting-up-gpg-signing-for-gitgithub-on-windows/

at item "4. Verify commit was signed"

I confirm the output is right (no ^M characters) with commands

    git verify-commit HEAD
    git -p verify-commit HEAD
    git verify-commit --v HEAD
    git verify-commit --raw HEAD

and wrong (ending with ^M characters) with

    git  log --show-signature -1 HEAD
    git  -p log --show-signature -1 HEAD

I need gpg version 2.1 or greater to generate a gpg key for my windows
system, as stated by the github documentation:

    https://help.github.com/articles/generating-a-new-gpg-key/

that saves my keys in ~/AppData/Roaming/GnuPG.

2018-03-05 15:29 GMT+01:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi Larry,
>
> On Sun, 4 Mar 2018, Larry Hunter wrote:
>
>> There is bug using "git log --show-signature" in my installation
>>
>>     git 2.16.2.windows.1
>>     gpg (GnuPG) 2.2.4
>>     libgcrypt 1.8.2
>
> The gpg.exe shipped in Git for Windows should say something like this:
>
>         $ gpg --version
>         gpg (GnuPG) 1.4.22
>         Copyright (C) 2015 Free Software Foundation, Inc.
>         License GPLv3+: GNU GPL version 3 or later
>         <http://gnu.org/licenses/gpl.html>
>         This is free software: you are free to change and redistribute it.
>         There is NO WARRANTY, to the extent permitted by law.
>
>         Home: ~/.gnupg
>         Supported algorithms:
>         Pubkey: RSA, RSA-E, RSA-S, ELG-E, DSA
>         Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
>                 CAMELLIA128, CAMELLIA192, CAMELLIA256
>         Hash: MD5, SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
>         Compression: Uncompressed, ZIP, ZLIB, BZIP2
>
> Therefore, the GNU Privacy Guard version you use is not the one shipped
> and supported by the Git for Windows project.
>
>> that prints (with colors) an extra ^M (carriage return?) at the end of
>> the gpg lines. As an example, the output of "git log --show-signature
>> HEAD" looks like:
>>
>>     $ git log --show-signature HEAD
>>     commit 46c490188ebd216f20c454ee61108e51b481844e (HEAD -> master)
>>     gpg: Signature made 03/04/18 16:53:06 ora solare Europa occidentale^M
>>     gpg:                using RSA key ...^M
>>     gpg: Good signature from "..." [ultimate]^M
>>     Author: ... <...>
>>     Date:   Sun Mar 4 16:53:06 2018 +0100
>>     ...
>>
>> To help find a fix, I tested the command "git verify-commit HEAD" that
>> prints (without colors) the same lines without extra ^M characters.
>>
>>     $ git verify-commit HEAD
>>     gpg: Signature made 03/04/18 16:53:06 ora solare Europa occidentale
>>     gpg:                using RSA key ...
>>     gpg: Good signature from "..." [ultimate]
>
> My guess is that the latter command simply does not go through the pager
> while the former does.
>
> Do you see the ^M in the output of `git -p verify-commit HEAD`?
>
> Ciao,
> Johannes
