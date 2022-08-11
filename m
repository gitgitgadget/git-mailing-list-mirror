Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B10C19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 21:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiHKVnE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 17:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiHKVnD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 17:43:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D869F0ED
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 14:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660254179;
        bh=p7qwgrCtMZrA+4HBQ6hsjgWqHZYz5GKLIZLcpSSI2pk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KKEMm5l27DxX7LoWvXFydtcuM9VByMcqkADluRs+lW0MfK/layIcaLShhoPOMMbMj
         Dv9V0U2f1wL8lXoICLz3fPUW6ZFUYGIwVQKabVShsjA3TdskzlxhAhTJ6JE47js6Py
         xmwNy6QMxK3hRUQ+EF5GaCKyMyyqsBIb64O2fRGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az31-897.b1uo4dmaffwenkazr3a2h2ovdb.jx.internal.cloudapp.net
 ([13.65.147.15]) by mail.gmx.net (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MStCY-1nxPGm2fio-00UJl2; Thu, 11 Aug 2022 23:42:59 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.37.2
Date:   Thu, 11 Aug 2022 21:42:52 +0000
Message-Id: <20220811214252.4351-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:ZVyVmEwSFrbILuGwVxbbsUv0V7VV0qHNnltDXdFlahzIbOy+t0L
 d5P5js7dNsH5VLB3R1ylp2QUY114XwpSexOnf76eKS2JMT8PVJEcJ38ooKMCZaoHpZoR5NT
 amrebSBE4Y0WRmjmVQMoisqIycakOmknrJpDSYzfTkmOlFFS7tVXbK9bAi+irlZpxM+DQeB
 rNBLPykc1Tz2zsvrOyKIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:atVRz1W5Li0=:YRbz6mKLXvOovST9/rLHJS
 /ogw9veRBXtIR+W22vIa+wa2PZlJPSM7R4vZ62zVROzzifnpj9zxaRGR3u5mGSbgJg2ZGRsH4
 kh50r4gpNJLAPIaOwNPO7WWmk61DkWmWFNjOKvMiL/1dvXC5WiThzF7VD59ScXaPHjy8dWwkc
 Esjhb9rzTa/QJU8X3gKQtXYfQHTXv5C5jtyAvmESx9pVC9MnOZSYM7ys9OsT6b198PG0s4Y8n
 JIvBB7stE8rVKWm2MUK6rSUXpVaM+3KVa7DwAUxA/+bydBAt6O1Qvm5mE6bKZrG2Q5bLx8RRo
 wXFy2DJetFNz98EkOC7ZzcXZCsxDI80CNB6BwCiokWaE/o/j7rK1YsCV8oU1jh/lrSR1+TGYn
 oEXSHflJxFxaXcXTKWSonhsG2xUtiH/2d9lSlG6GjE52yJW4JFCXMWHd2m6vrqLhhg5Lkc80v
 dXn0VPh2zHv6OBOJ+t2M/ImpuC2Xp5N/4ZWthoz0qg7uaxSycDzd6MLggqlxHBYhkwaHxnk0e
 me04E0Ilcyt4wQ3fH5ftpaWNi3TBPYKRm9zopDGddQjuyGZysCUsPW9HgwwlTjWvBwJRp9hW6
 A0FQFEUKguiKS62QzUTPjRCyDlmQBeSUoSqQuI1zUkl6+RQENxXDkePCbJXIA5nCR79yPoMCC
 SeUiR18HqJOhtfIQYaVl/AQ2y8x0TZbfFDoMLyQtTdTGohF9rPBLzHW4+IHTg8jM3UJLF37id
 TY33tK0sfAFCg32hYgnHtOBtc0y6kj58dsFrIzZuF3AefoBOkZM7Ue1oqDFJ4+OYkyzELQ0Mh
 0xEA9yrreCicMUnkw7fYIpQH/uH7Cz4UYdHa3pgnrRoHOMI6duERrwR92UgW2uPi7/cK0cwVY
 hQToHVritVROuCUWwEf87heYgC6tqIxKTWlMGlQfmH48r99s70gq8cy9y9HQSyWlaoRh7to9I
 Ndrwv8x32euNf0OFfzt9n3pZTkWVhmJG/YpnBf3FHq+jcw9rhHzCWDBOPryUAFKAgF4K0MxNI
 YcY5cfmcgOjcKruaL3LJWYXMs4wxkrZn1RVYOKqKNsc72jcMjUGlXI2e5T61DSVdk1rsy+NpW
 /QZA4OiK3plt+/ACPS+XswE1T8G6XYGcI/RNzPBGQuTj31+8XKPOv6jFQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.37.2 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.37.1 (July 12th 2022)

(Upcoming) breaking changes

We updated the included Bash to version 5.1 (previously 4.4). Please
check your shell scripts for potential compatibility issues.

Also, as previously announced, Git for Windows dropped support for
Windows Vista.

Around the beginning of 2023, Git for Windows will drop support for
Windows 7 and for Windows 8, following Cygwin's and MSYS2's lead (Git
for Windows relies on MSYS2 for components such as Bash and Perl).

New Features

  * Comes with Git v2.37.2.
  * Comes with tig v2.5.6.
  * Comes with Bash v5.1 patchlevel 016 .
  * Comes with Perl v5.36.0.
  * Git's executables are now marked Terminal Server-aware, meaning:
    Git will be slightly faster when being run using Remote Desktop
    Services.
  * git svn is now based on subversion v1.14.2.
  * Comes with GNU TLS v3.7.7.

Bug Fixes

  * Git for Windows now ships without the zmore and bzmore utilities
    (which were broken and included only inadvertently).
  * A regression in the vimdiff mode of git mergetool has been fixed.
  * With certain network drives, it was reported that some attributes
    associated with caching confused Git for Windows. This was fixed.

Git-2.37.2-64-bit.exe | 9020623e95e8f250a6298aa98d4bce395adc121998a65bef143556c3fbd2462c
Git-2.37.2-32-bit.exe | 3f1110d855a934194b8de1e032d8edcb622804a0b4223cccb9379f7d37a52915
PortableGit-2.37.2-64-bit.7z.exe | 71294d3008d6da6bd25527498ff726d09d55c2cbd1af32d8e99200d5339d7817
PortableGit-2.37.2-32-bit.7z.exe | 005253af6f96fc86a2ccec97dfd68c56f5b91f72c5cd953e5d1d240c35235390
MinGit-2.37.2-64-bit.zip | 197422464897cfc8f6ebd73007c798658d21310a4c32d43888c9e8f92720ffec
MinGit-2.37.2-32-bit.zip | 77b39507cc4b06cad754137e08465c14532b3fc4b0bc4cfc3c91dfeaa6badbe8
MinGit-2.37.2-busybox-64-bit.zip | bfe43199e74d3d80ed7490b7f0aa09a92f907ecbe9ad80719a9bdf6a8ec4ae70
MinGit-2.37.2-busybox-32-bit.zip | a752814318a5cc0c00902d5fafffb97c7201ac2e837e0718eaeaddd3fdf3bb07
Git-2.37.2-64-bit.tar.bz2 | 0508cba06cc52b0e4e733cdd6ee19ad17cc67d31b69c34212f120c94f1806a98
Git-2.37.2-32-bit.tar.bz2 | f2612e4ff5d63d922673b1c6437b8c292ecdcfd950a2f0bdf4704d6eedc42def

Ciao,
Johannes
