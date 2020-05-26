Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A4FC433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 20:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FCA20888
	for <git@archiver.kernel.org>; Tue, 26 May 2020 20:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Mzilf0h0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403919AbgEZUpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 16:45:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:46031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403895AbgEZUpn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 16:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590525941;
        bh=ONMtxzBJjDQcJMmNVConcfd+y9orUhtslZKQ1sHPQYU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Mzilf0h013UWm0JSDbyCzpPbf/VWA2yIhim2RGNkTQBg56eyJYyFNCfJkhu/wPCzu
         9Y8kkyDGoyuLIIsmqpeGGkclbk+EgghH5Bx1CbefaHDVuFcOx2isgq8obZL08REX+N
         LutkZLvXlZKAx21NWzMOzZyKu0HVM0+bAnm5Hxmo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az773.okiqhce2e5nuzak4zx0woeelqg.bx.internal.cloudapp.net
 ([52.234.148.96]) by mail.gmx.com (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MG9kC-1jnWCv0fAi-00GcEz; Tue, 26 May 2020 22:45:41 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.27.0-rc2
Date:   Tue, 26 May 2020 20:45:39 +0000
Message-Id: <20200526204539.6181-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:6573Jks9OlJnwPjNQN8phGe6JO+7FU7iavtlwHyOkEc6VC85G0S
 u3Ko2w6GiXxAKtOLI7hqvvtDZjErTsjCJ8fOXCfv0zaFL7UJySrj5TSIvrAB9fmjySAa5pw
 bSK0wjFRZt2OMA4yVnOY8aH432Qp9H4cnzl0t5hQOUXW5+p1TQMuQ1sjvSfNjiDczFGL3c3
 acbXLoIvg+J/uw/of1ugA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xB50/L/boRI=:2RRqm4CKaMF/bUBpwmGOiI
 WTyQLBf5vJx+23IvhWT0imimjlHGnXJOBYrhDJR7OHOLw5dLqblNaeMulF0atYTfVuFqztqZT
 gysVMU+iR+OACr2I0IuBxpnTwOQBSwwiVC4OIPRZRQmW7PtOMKp/uM1kGYiIUZUXGVpVjmGUN
 awgyJdvVUNe7A2gv2zhyr4YKkQUwbvqOH3kDINtX642KTl9aUzPiP/5SClHc3+qK5DERwQmDz
 lzKPOhk5T0Uy+S4uufaoPGZu3jaAPaBl881eWgYl8o55ytJjKs5FA/uT0S5rxotIT+HDnU2l/
 MRnW1K75mINXq62NiTyk23nSAQv3rL6oFatLDO+EH9LeOG6a+dou2Rx5P4RkEG2Z4v/FkNScl
 M36HrKO+oARAxtFieuVL/M1hFyVYW6og2Bn9V0vGETk3/zcvCG7x8YHnJVJm16bRSwD85t7le
 aM/bblddCuUGYzmjx3e97G70+i6yqvsbE2EM+xCIslLrwQDGXmt4xyyzziJWz95OOszLxa30c
 Z7t2jV48puLOwhFfRQLb6feL3scFptOcgbijvpKp/1/Hi4fFirVfQIZl5bVHeZAd07+R6L5Tg
 md7VSnN2CEdmfbNIDAClNQMpPgH+cKqSXTN3W6/CSKm2zcTqFvlayAOA5Og97wKtHGJ6X2p3R
 oDMWkSbcY3oQtmSMOOkyeJOMvKwzlA3xCxq6PeyeeVprg520ilwSmpDZWkGDYPz56CEoJxJNT
 zQTK3KEokBOmPRgxaKkNds7mI3juxsOLB+Gt6bfqeTJza8KnVUi9skdFUaDF8IyPQBNvbbHI4
 cftJ0xHthBETkCmPqDAUm+FVIpJM8r+SGqMTSOzQu04H7uHCfxg9iaCHKmZpaThJnfH1aoP+5
 rY7o5s7mDI6xnBaGxA6suzswMIxakAHD0tslzloaRVu7FEZro+ynO2Jky1ZXUiHT4RyAREyBh
 VwCYElga7YqkWfQtIwPvKsxzyLon8BSWZX1tZj6u8IqWxfUx49jkRihtOzOrRnk9AW54r5RFT
 HbUsG3lPxG4sH0nS+N23OEZ5hxNxB9yfS0gsphl8sFRIdyo4Afcf63aLjmeo0FWoFyAj2ofe8
 P0u2+Xobim9jFn99LHFx6X7TkqAHe9NUYeebNoXr4logLFGYrrOZwJIb6bP8r90Z3G97cLH2M
 0QgJUzmdVAmkAbrykFRqc9rCYqYyFCNhe77EN91fqRQTERCPjAcFHwnNZ9rv0tdsakUPWItdF
 cmZX5Fp4Egcp4bpVd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.27.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.27.0-rc2.windows.1

Changes since Git for Windows v2.26.2 (April 20th 2020)

This release comes with a Git Bash that optionally uses Windows-native
pseudo consoles. Meaning: finally, Git Bash can accommodate console
programs like node.exe, Python or PHP, without using the winpty helper
(see Known Issues above). Note that this is still a very new feature
and is therefore known to have some corner-case bugs.

New Features

  * Comes with Git v2.27.0-rc2.
  * Comes with OpenSSL v1.1.1g.
  * Comes with cURL v7.70.0.
  * Comes with subversion v1.13.0.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.1.4.
  * The release notes have been made a bit more readable and are now
    linked from the Start Menu group.
  * The Frequently Asked Questions (FAQ) are now linked in a Start Menu
    item.
  * Comes with Git LFS v2.11.0.

Bug Fixes

  * Some Perl packages (e.g. Net::SSLeay) that had been broken recently
    have been fixed.

Git-2.27.0-rc2-64-bit.exe | 5fff39a4563d9bcfdf77946adef06781ae77433ca09ff6afaae5f9398ec071cb
Git-2.27.0-rc2-32-bit.exe | 5a9ddc85a99c048cd89a329e9353ef31ac36532d0fd274f7413bf0ee7710f81d
PortableGit-2.27.0-rc2-64-bit.7z.exe | ac0665a5739d939eecd37d475091b38ed6e0535cbda92f1a53385cd46bed8904
PortableGit-2.27.0-rc2-32-bit.7z.exe | f2151bb3804aadeb44e2e1047113b38540305ad3bd5e7f2598c8db004b0bf834
MinGit-2.27.0-rc2-64-bit.zip | 7948a5ec291fb73ad3af1fbacaeebb234fb1926915a69e2e927aabb436b51f8b
MinGit-2.27.0-rc2-32-bit.zip | f47b9b3869cb072518c7e971a2709b3c5659d4bc35867fab0a117c392f395eaf
MinGit-2.27.0-rc2-busybox-64-bit.zip | af7b9e1da84ed21bff6d4dac3fdf4ca9dfd5788d7238ac6fda759bbe5fb7f875
MinGit-2.27.0-rc2-busybox-32-bit.zip | 16f3f8b90bfeed191db11c18995169380db0d34a45ff5a3004d5434acef98d58
Git-2.27.0-rc2-64-bit.tar.bz2 | b1275d236ff7c4de3d713deefc326120b07ba9a4d32761bf2216364be10a8867
Git-2.27.0-rc2-32-bit.tar.bz2 | 24993d2abbe7c75d3bb0557550366f919ee10750733c0fd9e05b6ff7c8180c7a

Ciao,
Johannes
