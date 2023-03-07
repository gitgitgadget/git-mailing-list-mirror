Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62028C6FA99
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 23:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjCGXcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 18:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCGXcT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 18:32:19 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396433D084
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 15:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678231936; i=johannes.schindelin@gmx.de;
        bh=9GY83F3t7f4VpY7vWn72Og2jsHpT6E4EeesISycdUkw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=JyyPnvmisQmeNbfsoHW5m5p0B8SDe13PDkAEwlvFLKlIm2eGFgyorzgRai2pQxuHn
         USYGIGty2XJjqVFt6GklGJT03ZtvTBONx2whfqX+CXam5jqq8MOycLeKURT6FqpKYb
         vU+N/FWus07H0rXVC0cpLNcHUGsgR6JTb9RgwaEKx2a2irT6gamx+YIb2Je6bI0+e9
         Vc8ITD4wnJi8LPbiioAeGWHcdO3jUNTYe0WV/E23Y+APiTvLjaL4KGXCxNwEU6RwCL
         HHdAKqiUk+etTCUK14sYwTVZv+zXiTCLBkge6n9JzNXADVh62yhltBo69/8ObbHR51
         N4JhrsOwmM7Yw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az470-779.2lj04l1n53ee5ipyphnrpo3qcc.dx.internal.cloudapp.net
 ([13.83.14.132]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MKKUp-1prUUC1y9v-00LmEk; Wed, 08 Mar 2023 00:32:15 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.40.0-rc2
Date:   Tue,  7 Mar 2023 23:32:11 +0000
Message-Id: <20230307233212.3529-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:1XLMXH3yT36zuCIVdMnudE7M5xJ3vXXBfU3Ex6vjD7rLqNQcB9+
 bpws8vYYxByuVrAGNOviNJmWZ1AnlDUy4ryNNj0wpfD6g1NZv5Re0+Pa5yDbmmpsbdvxuGr
 3PIkRIiaBywgCFUKVTZStc5ASp5SQCAFC0jFj53Lre+AHedFVeivpV/RjRPVc5ZSiX4fn6A
 3pUN6Zqzt6WPxCr6uNlOQ==
UI-OutboundReport: notjunk:1;M01:P0:S952+KhLDV8=;BpOmgH/78BPJH7/IMwU8E8amhpY
 i024MRKF2PYels90aurfqKaTiD1ib75Uq21ot0QMCyKDDce74E7POzXaRZPLRZstg8TmtDuFZ
 xUVJyO3j9Df4chcosM/EexNAKZOnTdJPWgOeMHBK5w2PTx4aO8y4xSprHm7UHVzyzQz8qV7XC
 kbu6FuhxXRqBhZbTBpYExM0y0uLAgX411l6ZgZOZQm1YtLNeoDm0leUPp+5fZ4iPRi7QMkDF9
 g7fYIYgy5yrnR/pcxzM4abkLXRxjN1gKVsZv0sdml4xYupqFxETC8m31b3NnM8M5ewbii8rKb
 MJFrAhAkwJcFxvLmWHa23mjrLJgORW36+XDQRQ0EyBcFP51/idFlPg0+ksAoexQ1TupmnsxSA
 r+YEN5lizGFhK9prPwzurIdBZwxfx9ZrWsfZ9V3oCrBiG0TholtGf0FESIvJx/3jSiTZI6PjL
 YhVQ0WCes02ESfX91whfQuMoSiL6y+OZ9iXfFuyiZjlLg8lV7y1H5AWj2lORRB1/VU3K1DsHr
 SMJ9Ss4iLL+7aU7WbsaFD+Z5bJ6TcXxFUDg4VHwcn1ouGlAn5uFNR1v1BAzhOtzEXp7Bdr4K6
 vv5wIBqJrR8Lht//ek8LCvq5Pq0GYt9Am1u9sMhRBpYkPiwI7o+kE3bi5AT56Z1H+yLB1dj69
 QaOvQS/Oc2y8ZbohWmLnFI3MlB3jQHvUiFUdNCF7V3vWEL/dVnhNmQU4/nCfNVhh+9AAQiCTl
 i0Dch5zoDiVZzduTPMnWYvHmrXiFMJ48I6P0PBYY8A28AEgA9HebNhphidVuPWcQVxBtflpD5
 lxgDVIzi8CVtb11jqWL4rgwZ8XaTSm1Zdqtv5PRsoyZFf4Q73vrjQLPfQnxc8gMkTGbYWnfQk
 da81Fm8DhYucjXHQva9ZZch/f1tWJhFhkjNl2pinQtFQM4x+mX8zIQv6Qi+sGytHVILM48/Aq
 1wEOdUu33bcBAIexynrNEvMUHKE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.40.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.40.0-rc2.windows.1

Changes since Git for Windows v2.39.2 (February 14th 2023)

As announced previously, Git for Windows will drop support for Windows
7 and for Windows 8 in one of the next versions, following Cygwin's and
MSYS2's lead (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Also following the footsteps of the MSYS2 and Cygwin projects on which
Git for Windows depends, the 32-bit variant of Git for Windows is
nearing its end of support.

New Features

  * Comes with Git v2.40.0-rc2.
  * In the olden Git days, there were "dashed" Git commands (e.g.
    git-commit instead of git commit). These haven't been supported for
    interactive use in a really, really long time. But they still
    worked in Git aliases and hooks ("scripts"). Since Git v1.5.4
    (released on February 2nd, 2008), it was discouraged/deprecated to
    use dashed Git commands even in scripts. As of this version, Git
    for Windows no longer supports these dashed commands.
  * Comes with tig v2.5.8.
  * Comes with Bash v5.2 patchlevel 15.
  * Comes with OpenSSL v1.1.1t.
  * Comes with GNU TLS v3.8.0.
  * Comes with cURL v7.88.1.
  * Comes with libfido2 v1.13.0.
  * Comes with Git Credential Manager v2.0.935.

Bug Fixes

  * Some commands mishandled absolute paths near the drive root (e.g.
    scalar unregister C:/foo), which has been fixed.
  * When trying to call Cygwin (or for that matter, MSYS2) programs
    from Git Bash, users would frequently be greeted with cryptic error
    messages about a "cygheap" or even just an even more puzzling exit
    code 127. Many of these calls now succeed, allowing basic
    interactions. While it is still not possible for, say, Cygwin's
    vim.exe to interact with the Git Bash's terminal window, it is now
    possible for Cygwin's zstd.exe in conjuction with Git for Windows'
    tar.exe to handle .tar.zst archives.

Git-2.40.0-rc2-64-bit.exe | a9854cbbb47c826f5d0aec45d96c113dcf88c94ce70a9bf0749a2b04f1fb6b09
Git-2.40.0-rc2-32-bit.exe | 2a4b040f7aa20d9ec996159dfc7cb566e783d4fc6722c3916b0fd61e869e8f60
PortableGit-2.40.0-rc2-64-bit.7z.exe | 0c40e61a96ddd624b8125e3b542b8a26b6d86ff2204f8645d43782190e2f74ae
PortableGit-2.40.0-rc2-32-bit.7z.exe | d771f24ffc9f4d960986a132bef2045af406ffc4abf78d54e3f8ac56c19668ff
MinGit-2.40.0-rc2-64-bit.zip | de257f4ac5872a5864eca7476201a00f5b827a329933f7a7339bc67026d0bd5c
MinGit-2.40.0-rc2-32-bit.zip | fc02caeb1502a27575ff1bbd8dcae49a76793944be451e639821b4c8bd25f954
MinGit-2.40.0-rc2-busybox-64-bit.zip | 9cb55ff1fbb03ce81acf69408db00a103b32c54009fd4b9515d70b50bb56cc51
MinGit-2.40.0-rc2-busybox-32-bit.zip | af2fb84fc9f0104f02bb310a44a448da9b0a85b42cd0daba67e1641d0a85bba0
Git-2.40.0-rc2-64-bit.tar.bz2 | ee3f3a9a79eb862eeedcc06a35c2ca5e4f0903a476d0ae2d0c55add4b20065be
Git-2.40.0-rc2-32-bit.tar.bz2 | ddd8d7654b394cc7cc2ff825f73ab086bb3e43bea38ec5996e9ab4a7405ae58a

Ciao,
Johannes
