Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7BBC4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 17:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJRRKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 13:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJRRKR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 13:10:17 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B856293B
        for <git@vger.kernel.org>; Tue, 18 Oct 2022 10:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1666113012;
        bh=OP7Wd5xKFp+nSh8RHIVhLH+uUbPBp9hCrtzWH7Ozt3k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=MDst/OYMuO2PJ+jDCJ648t3QQOWp/E+T8EGhOjgFHdpgg4kKHZbZn2Ug1o5/Qz9Xq
         /qoh22oDzE+LF1W3bQOEuABKIuymI1xnPj898IVWkhxK5lNj7XcGgyWS43feNDsKdf
         HsD2iwZuM9rvefujScjCmpNqwDLudLZfdJR7G9Y0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az80-310.x3uy1q3lbwyuxmoobr5vjueqqh.dx.internal.cloudapp.net
 ([20.245.94.12]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MHXFx-1oyKUH0von-00DTeY; Tue, 18 Oct 2022 19:10:12 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.38.1
Date:   Tue, 18 Oct 2022 17:10:08 +0000
Message-Id: <20221018171008.6117-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.38.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:0ZgaVvoKuoRKFlE/NhP/UA/xYhQZevhYScz8df0PgVusjFvwxBt
 hKzeG6ivp6qvYfK6Z7oaafmaUAJIKzGhm1b9vMtiZcYcbn+2o73QYqnj1yELNTPN54V/JK1
 0SoZP61pemrS9Rd2yNMswuTRqhrU7Pkw8ItCA3mIu3viZxF/vi0xZfBNBfpBSdXdTQqCnC7
 9pMYTtq5o3bUYuRk6AuQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uox+c/73rJM=:3sjp0orxuKez41sYr5PF0L
 YBwTF3zw/9MrHuSp2KSB7Ok3dt/epzRihKgojJcI/LE58XpCpuJESJhyZ/z7cHnGuxWeviZBa
 fKgRny6vrG8EPI/MLGR1TsZR3SW0tmMmv3PEW9Sotd8uZkcyvWF3cd3p8yfkp+7etON7QK99n
 HgkLVu1WTrIfGmbaEtr+aqTQgpA5Ez6E2DnbyEdV9zCcHtVhtflH+2y1WkCLJNKOZLDRTiMQa
 s1LOcC1LRLMbOd540C8USJIi/f1mohOoMbBgtISWVn/qFHfgY66PZIzYX5MAkANlhrCo10ODc
 Nxe83euUj6ShuojcCMa9pVvcQQec+2R0DpTDO5yMLpIU+GxioiD6GSXDoIGMzYddYTJF7jaJV
 z31vb0FjQ52XD25XrreTveLa/Yjfu85c/uyXrM5aoanY1BnmGtgMiYkAqYh/iwwXmQGIZMKr3
 NA5jWMGRnn4hm1ovu6QEzqwAhtY7vHYHqVl1EHI84m9lQpHtKSS1WUNC5MGva/C4MP3vChZDH
 USYDPJBE6IMLhNngYUuB6cdv347A/Ew9W4daMTIMBfnC3PJLQgOI+cQF1Tba9rlrzz6o4Zuwl
 KeUOygb9qZ36XYvR9EXExdTv+shilrxVP1XvOAaBDeAcqUWKCG6qTCr9Ues6132SKQjC8K0By
 MMQ3i+1MYaGQzXS2UpM1/BPtLl0y/jXpOKmAJde4kM+lhAa5dQVOYrCXhLn2D/bBVelnhN1M7
 sFgjmH/p/IrwT+04/QStFV7qkuf1zrT6obPiMevznGesg+egx6nem/i5OP7rh4OI6YXPCXBWA
 c5++od9cPJLqc29akQaUhGVv5vnuj/zPjmS2p6ORy3nDyFMLvHWOdKvSXKGhjvrifxvvtu4s+
 kEkfB1WwGIPpIcmzXlDA+RP/7XiivVVCJKixzPFUZjPOUklPjF2zgerLqulbxL+JrFBkfjFbN
 aBgsaIQKNtPBzWkEbCldHZmkkuJrPaFcyBIvQoGYkk13WVWzwRBcVL95ptytEwFAL49KJW5q7
 ruuNqtM7eff/nrGG+eEV2gG7+ylTz1mhmUzl75TDu6nfkE24vvJi/Yh2b0CXgov6XrQH411nW
 RXrAVBXNG+mnmrCrHIeywbrxyY268c6+ZByxEWqyxjiRP1fqQgQEYJBJltN2D3AbCOSTef4xl
 IgwRHsdW2Iq7gsAfFGjGEEpC+34LN1RyPb53OGVG/ChAYgm2whjO3fLF+M/ee0QX7umF8iBoI
 ISCapTXXQxsq+FKTXuE3+QXR7whL/c6it95oD9W9XekwEOOL6iuZvVX9UpxZBTWr8ft0jutFW
 p+BxGoHGga/uRvMJIM9s73ZIWBOQix5wBoB7TQhvIqaHnXjGuNor5G+REX2BWLmuAww7Rtjvf
 UESfCoVO/RJS+8/SHBc21oMc45veiEunPnYPnKvd6oC9LzyiX9a3qcjBExkWzMpn2K9qKmjMQ
 HMrkJ2Czqhh+tC/VnW+0NvYUZPZ6ODG++3ywE5TDbB1vWR8LDWuxVfGOIkKCxKA/sHOY7oqqz
 xWMGACIXnDIdkIlFW32K96+LrSB8ygqlwbCZbpeMwQBIb
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.38.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.38.0 (October 3rd 2022)

New Features

  * Comes with Git v2.38.1.

Git-2.38.1-64-bit.exe | f3fe05e65cd7e9a9126784d4ad57fdf979d30d5987fe849af4348dbe3e284df6
Git-2.38.1-32-bit.exe | 2b607570ef03a51a3fed89c30dd461d73660cbf7686e41deaaa5ba2e719a9e7e
PortableGit-2.38.1-64-bit.7z.exe | cdcdb268aaed1dd2ac33d1dfdaf105369e3d7bd8d84d641d26d30b34e706b843
PortableGit-2.38.1-32-bit.7z.exe | d434ad45bd9060a99c1d58e9b2b09597c52035a6a3ebeb6a0fdc694092b298b5
MinGit-2.38.1-64-bit.zip | 77b14610d92e717ac025e5409e2e713553435bfad224753baf6858ebd0f7d96d
MinGit-2.38.1-32-bit.zip | cbd7c8cce55f4c1d9d858f7137f46eff44018fa9b0e646200b80ef9d1975288f
MinGit-2.38.1-busybox-64-bit.zip | 8a0c3c3a5c63f182ef52e6736187998aa4751e09e828750dfe4d4854a27172fc
MinGit-2.38.1-busybox-32-bit.zip | 9fbb8530e103c736afadc9c0df3c69a2cd7719e8c9ab1d1785c85f1519778835
Git-2.38.1-64-bit.tar.bz2 | 09246e1bbe9f7e5d2874e25ce0d05d555a059a709883b5afecf3e3aeb9b0ac2b
Git-2.38.1-32-bit.tar.bz2 | 43651cc1d0c723acce2d7e018c0e86a7d57b1aa2395516d521787d2a539fb6d2

Ciao,
Johannes
