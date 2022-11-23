Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB8DC433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 12:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237078AbiKWM3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 07:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiKWM3F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 07:29:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8F83FB86
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 04:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669206476; bh=BEvBBjErmNw6ff6f7LAd+ZFhABzgLTM/F2cOwf8EUs0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=aaY5OymWRPr7akNEPdKo0YHEPIfdvZwzRr0PUkhZ9Tqh0IDHkeRCBfTB4y0YG9J99
         HZkAsb5TlPuQCD2ye8E9do+nWr+RnQxPEyQ9I9oHa0SPNI7HquNpV/lYzqXDVe3lx1
         Ekvi+6jFgziCZkYo/Bg7V3B6PZilAyYrm21OCRio8rVZpU3uMZUK9i4gmy7DGCJIfz
         HRyuYUk4BhNP+8kFcObiH9jPcEWfonhUaIg9C3dqpQ8guTurrOfweJp6F5vEyn/7PS
         ZMqw/QZfguEBz9Zfl5Uua4DTKKWHFEn+mxhYFmHZ4Jokj9j4RiPgOtn3x14lBydeMI
         25Fi+3bW3RhwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from fv-az703-26.qjxmrcqukxzejbqhl0udth3dcc.gx.internal.cloudapp.net
 ([20.9.35.107]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MbRfl-1pVEjC3d8L-00bw4J; Wed, 23 Nov 2022 13:27:56 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.39.0-rc0
Date:   Wed, 23 Nov 2022 12:27:53 +0000
Message-Id: <20221123122753.3132-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:Bg1kLz5zef4Vhc4Qi7xesomaLcuAGlJZ7e0cKit4hY/NFDtQ6ti
 bss5MAYdjDQ1OPxMN2O7OO9esnMlar3XX2mpOdNveEZaNeIZPpqKLyO1ly6aqrj0AU0CIS1
 ztSS47Xr7VfrPQqBwwNgL+z0uIHyNZDqT92Vp4QGN15BtbieN8v+g5ooLhC54y+x9yxuJ9N
 xlazmWhrzlJUU1XExtbCw==
UI-OutboundReport: notjunk:1;M01:P0:AT1+41gPvpY=;XN95W0sL5Lc9qZ0bWFt8LMBOFFN
 vBqWQeLWEjGGd31p3nzu4HFiLtc7NQ+Po5ag9RgZT5JZkrV8QgoCLUh4cNrpAMb4GjZdqMTTU
 IdwSGPhzrTOUpxCOPJmG3e4msvfMggAz2eN76RMKUAzNKISc/62vG57OvcbSASPs9+u/3Ia23
 JMY8a0DqFvnMw9+BC9DW0W56ggWJuk1Q5qLOBReEs4i1QrAuTaNZd0seD3zuSZHYLY/KiT5eg
 GmHaFS8WJZgiVN6tcG0SC31RvGa2FfNkiFVGAmiEabUsOy8O8BfbbjZceMHbUXqoDPKeLNzGf
 0LD8RTerYY71YpHYaNW7MeVcEXOZYyqmtv4ahVBn/b2b19ahN9VaRfDsPsbYa2J1+iDfJtM0r
 wHeNoB/NCAlmJ1wDtAPRGBtGRZ5CwUJ2XmqZx+5NPARA701lWC0Ds6hq5UgQp8CePf3Fv4YiA
 ZjHcwLHjIatdmyPRs5Q8lzg0IVGxim4wsPPZjFt7223QpEJJcEM/3tps3EcWO97TH39tfCTkH
 kq+Um58d8otdu6ODX5YBMsU7dhIPSPFQvTVbrzz5VKXS/CaVa3qbwpM30o5L0PF9R5X4BhQZP
 4AtmxtueONJR4FAzESy+Z1E94O0cS07tIi8DWT0YxqfI942fGhqgZtuirenKMMsW12cMEZVgS
 LtjvEKjhRTH8IVvKwwnGIrGsoxipgEAxvJtUwbtuISUy/LnB9h1nAKCaOeinem9s4G8wpqo8P
 ioiWmP16qFKjqVr03I75kPfghhyv2h6dLIbjzkTNC/UXFgnxuSSmMHKvOAwfcKXKuW3WL4AnY
 9uVuU1ek/WSVF/HwOHFjhsS8R8vmCHLrP28llZMFN86Hs9pZhBSTaF0PJ0h1G+kD93sRfD2HH
 kHE70K8vIm1dU5SIquUEvWN4IUr62bu8XMUQw28qE6l9qLqxlkpS8JgsAhiATzbRIyfdnPNjS
 1HTNwg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.39.0-rc0 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.39.0-rc0.windows.1

Changes since Git for Windows v2.38.1 (October 18th 2022)

  * Comes with OpenSSL v1.1.1q.

New Features

  * Comes with Git v2.39.0-rc0.
  * Comes with OpenSSL v1.1.1s.
  * Comes with cURL v7.86.0.
  * The Portable Git edition (which comes as a self-extracting 7-Zip
    archive) now uses the latest 7-Zip version to self-extract.
  * Comes with OpenSSH v9.1p1.
  * It is now possible to generate and use SSH keys protected by
    security keys (AKA FIDO devices) via Windows Hello, e.g. via
    ssh-keygen.exe -t ecdsa-sk.
  * Comes with Bash v5.2 patchlevel 009 .
  * Portable Git no longer configures color.diff, color.status and
    color.branch individually, but configures color.ui instead, which
    makes it easier to override the default.
  * Comes with GNU TLS v3.7.8.
  * Comes with Git Credential Manager Core v2.0.877.

Bug Fixes

  * The Git executables (e.g. git.exe itself) used to have incomplete
    version information recorded in their resources, which has been
    fixed.
  * A regression introduced in Git for Windows v2.38.0 that prevented
    git.exe from running in Windows Nano Server containers was fixed.

Git-2.39.0-rc0-64-bit.exe | 74ba237e120c4528102001551f2b2c08a9643a6cad8d7a397b134e4dde5498ef
Git-2.39.0-rc0-32-bit.exe | 0c14e81e0746a151ca8937c3736160720b4cfecf9bc826f681de7f275978ab51
PortableGit-2.39.0-rc0-64-bit.7z.exe | 02e73e5f584df658a709f373b0e0b8dc7ff72a754052bd76cd0af67fa23a9701
PortableGit-2.39.0-rc0-32-bit.7z.exe | 2c6acc55ea0df14be2b1695445ec6ac9061eb6e5a0f50ee8d9a1054899e522c2
MinGit-2.39.0-rc0-64-bit.zip | 638acc223365fc761655926b2cd86d9f4e2b6618a7ddee183a31c26dd3a63714
MinGit-2.39.0-rc0-32-bit.zip | bc3c16ba093821ffb254a6c2eb44a9f84de163543f657e03ca1b797a826ab80c
MinGit-2.39.0-rc0-busybox-64-bit.zip | f898d769d717c85f380f65687b10734aa5cfb28b636805b7bf434b5c24dbc593
MinGit-2.39.0-rc0-busybox-32-bit.zip | bd79b74dac8b69a8eba4c5324b5190dd85c71b74ffb8e2ca20358d94e244ec00
Git-2.39.0-rc0-64-bit.tar.bz2 | 48f2855ec77fb608f3831b1aaab725ca599e42a8fb27c6aa6c872c4d3f2f9efd
Git-2.39.0-rc0-32-bit.tar.bz2 | 036afe5dda8cb98e70bbcbce92570dfe0bc6d6f82f2fb7e0129faf17b62eeb4f

Ciao,
Johannes
