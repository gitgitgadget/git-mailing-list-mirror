Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55267C25B06
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 00:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbiHLAba (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 20:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiHLAb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 20:31:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BE441D20
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 17:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660264285;
        bh=JKCvhPtLZIbmMCjnuTQeQ6RccKZtptTdy51v7iNslfI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=BOYCkJ7q9hqb7Zdk0PHjteo+DgDN1izpR60ePmL6WhlUaq7e4rRHvQLU4FidczqX1
         UriQAP2qcTenxtVxamEnkOm8r6MY+Re3YBYy8dl02ECQMZWQMGTGU+PTcJ0KoXZ8Lz
         JSEbOIzUW7FS9ttHOy/e+i67roZDMu0MFibc0nrw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az48-342.y11my21s2nfuzmiq0sccgy5und.cx.internal.cloudapp.net
 ([20.7.67.237]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1M8hZJ-1oHbcD3SRl-004h2n; Fri, 12 Aug 2022 02:31:25 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.37.2(2)
Date:   Fri, 12 Aug 2022 00:31:22 +0000
Message-Id: <20220812003122.4378-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:DngZ7K8fmopIknBjkS4f8Nfi/ds6KwJGMHhI08iQqmPxoDs8yBe
 soxLI7bwoY4TNuDQE8ApsQIGm7/+0S6BNB6zH7PO6QjWmbUDa6jGh81BpdxN68O6YrDD9NK
 pcTftumogQUJnWYMefa7itGHPSFAWjJO0oYEjnI0G2o9lYaJ4+e2ItewK6DaZmqL/lw5fwL
 YvE/99A+VMy2F3b8IH1bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4+20fzNOTZk=:3Mkx2OVO1LVb4P4XAk1A76
 +crd5DkDr/Cpg4qLva/mCYL0UUCV3U59ZNW9vmcYzd7wAIIvYzIdb7E/6N7pUgn1qKTbCcUpB
 pbpIsUNy7K3No0dFYEerxSxnLuXRT/AoYQ50eC8TGRFUvra+fvxC6ASclP53nxeYmucb8uPK4
 ra4r9+/d5uYd93iuyEf02rYbKUdkMWzYlF/J+Xeff39Mrx5+GVGsHGz4Rv+HlrNXvhwDe0xYG
 PXENRMjUR0HE1nj5fg6rtVW5vyqozREIASQrBilePKCCCpL+HOonAi60vYxsA2+MLCjUT3cv/
 zinhr0lFns0aezF0PxHbVbTsSYXG2dxYUG0af/dk/Z7qYJ/3Ikupv4pAtAI1vgSX7tGoirXqJ
 htBwW/TmmL2zL+YfOB75H4sDBceV0Yc+77548K4+5gn3GHm3Xw0HlLPBcRtll1GS9OC2FNVbw
 ZmDgU6lj/bfJhkkyeY4zDunn4g9aVC01Qb++0MU/xCXv+OXdEwqlnbYYNYTzlbns5uOsVPgLK
 TD4rUDt8qh1BPclEmelb5smUzyzMq7be1kw5jufq/IhYMuPUQNwgRXahRS1z3Iq0UvhCeBrpq
 JllUZ5CxKdG+gumcumr0lYOWJP4cgbjJnxBXyK7Pohazk6AjFW29ajyn0ZRCLBilrd39wgeTj
 UN4OSXeV5IO/R+Gb2LobUrgHaJjKp54ZS3ksvPeEgjjrN9mU2gkCRq7FUUU3u7M1a8sdwVjhZ
 xiOJ/N4gJS8NadBdCHJIBOxsHgzfzeTzVW7vo623boklz4Wzl8Gk/6MRseQx8eHbGpmjqdQqm
 JA+pqd0Nw5farAGhNlbzcjLK6ar94KmptYr+gCxPxfxvsy4ZIrj91VqzsVgQq5Syfh8LHHl2a
 K2+t+pEVXCSKGQxOA1LAH0j4Cmkh8gsDK5l8lBylsVQFXL7JQc2SLW/897dVW09cmi4D2uRMK
 XRUuyXVCxaI/Dn7+8JV9qHb+gYJqmMvTlMTttE+riwBTtdvWdXv7YsNfEe16mGW5y3rNio79K
 IEoljOhakwxl/BGeIBGon9f3RiLATq1UbjTTHpJTfxWebhMclUyozxxRXaHBPNpc+TlDOvZZ4
 0SwUxUooMMCb+uOgtw/UCymz2AoQBCLRPr1L/BfwKEl30Sd1gK/NRuH4w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.37.2(2) is available from:

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

Git-2.37.2.2-64-bit.exe | 6f91f1bb28b222f30c13f905a5e9b0ad491e67c28a37a238000def19f86e0a2f
Git-2.37.2.2-32-bit.exe | 672569b7041024b1fdb5c29cc9a775658be78f7d3afea025973e07954f5070fa
PortableGit-2.37.2.2-64-bit.7z.exe | 20d9b7e8e8b8b4f27d16420597772e19e7cb1f396b355473867942ed86d0d931
PortableGit-2.37.2.2-32-bit.7z.exe | 36e24698b3cf5270d8276c80a1f7c14ff5d140ee2ac37e8e28a935d0a0ab3418
MinGit-2.37.2.2-64-bit.zip | 12b7c2c8cb9db03fd8c81e618aab196a366d919b2dc0dcd5a062738a07960a05
MinGit-2.37.2.2-32-bit.zip | d3bf1f155872cc431f3ebe898906d6b52988802ff7c3597d9bc16d0937f81209
MinGit-2.37.2.2-busybox-64-bit.zip | 0a299ae5621ef69424d80b27b7a3b177f7299b124139d20afadfed9226648c47
MinGit-2.37.2.2-busybox-32-bit.zip | 69cdd838c924eb4c989652191d77bd9a7ef069e4e059eced69cfeb1e92bfe343
Git-2.37.2.2-64-bit.tar.bz2 | 96b564cfbd99e355e340e1ba5350674fa7c0a04b5390ccca078a1a37637eba6b
Git-2.37.2.2-32-bit.tar.bz2 | 153defc4bed02814a772d473ae74a380e68a2377331ee8ad51ac6d21ed35cbbe

Ciao,
Johannes
