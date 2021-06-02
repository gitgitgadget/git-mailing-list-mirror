Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A510C4708F
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 10:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E81613B1
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 10:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhFBKHw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:07:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:37533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231560AbhFBKHv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 06:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622628366;
        bh=dAT8O06dXcOt+5yHsdu/vzV2URFA1fDdWr3yKx+s3z8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=X2NOVoEvGmzsdGSr1DE6xRCe9X1ZIjAKJZ+xcogUbQwq171/6DNLXLeNKzPEgP7t+
         YlWcmaztvfWaoEgJuzOO2FCzfQ1hjKDLVEmYuvX2EU7R1hYHgcWLJKflMOTwlpwPgn
         5wdXhsgChbwoW7ojq5FSQ9rL1eaRRApPOQOryZjU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az101-819.d2y14e5gm03e1mn3lsjpzbljib.bx.internal.cloudapp.net
 ([40.88.11.195]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MAONd-1lgzFG3Vql-00BvwC; Wed, 02 Jun 2021 12:06:06 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.32.0-rc3
Date:   Wed,  2 Jun 2021 10:06:03 +0000
Message-Id: <20210602100603.5436-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:/bF2XEITGdRbivo4PekdqZhj+TLGju5e0MDBc4JpU0A8Nck717+
 snPJE0K4GOEQwuxrQoJPWgidQSDeFRe8F55XdJ/FmfIkTtk7Y1USyAx+O1b4Ob52+4JAt48
 5y5h1/0cTVbY74fzDphzaTA9xnNaip0q7WN7C5RyyzjhYCjO7An1IyeXCYfzd9EYQbNTOId
 FMuMAHWwDIQrMunC8tKuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aMTPrKmm8y8=:ph2Nu4ooxyrJSg0xVUqitz
 1yBQYzOVLtNxUa94BS2uXYawdOr4DFssTpZZ4yqHj3KM2K3FAAWwSVhwJopghlwkZN9kBXnAt
 6pMiBE0rrVGM0oiW/D8KwStAOyBkNPN2r/8+Fn+ewsVyOlTSU++4ZSS4cuEj7n+4xq14qyl4D
 dtm1QFp0OJUjmHoQHAwZnhia2LCM7JjOGse5y0Pn0svj6p8Go+PVsF9+aSXQBFwQJycIpR/iO
 nfVss4iSCoakKGoPD1l73uYBDcwrvZ3BsXdPVOpgK/HDqxFir/XjHTbF26L3xLllFnauLK467
 9DF/EsphA4VOJTKQVGHYHIgvS73wNyZ9cwvCp6UFOBJgXSZ3FxDTdqG/+ZimifS30RPu2UAXk
 a/GFltX3k29DY95J3aOn5SGFAaQAxoKq+P0zYz1mwwyOR5pWjaggWH5r1+3O1DmPEucaBfGqP
 IvRhHLHdSrUA3bk/gltsGgUQAtOVmjEPOGVY124fE1vrh3wfm3wXcHoyINOKYd47ktEgFuuRf
 gBlMIg6pDYTyUl8ubMVyKP+hooDoS7ASjVKPYQnDLxz2mu5enCcUp6KamoLtZ+wq6QKwhaRMy
 tVtCaXDgPnVp894oaLeDU6n7b4HOKmmML+8uD3478BZc3s7kLgLw/3GI9LDs/zxDxk5uHtWCf
 NwXp3T2XrPuBH8WWjmbtflO9s1d706iL6/epUkQV2jKsgE7rWk6k2OE9dCIGFylpiIUN3Y8ty
 GDOUMezJ0Q8hHX3rFWiPKBE5LEJdG6RNxLcpkuW8iXb8yqqiBTuLjly32/VSHYDyF9XI99y08
 BTepQsnjFvpAeckbBEeStBqPxyK9ERmfQaPOhKQGY+TgqwKSeWoNp/TLCkg6bxKXn67WJyv5O
 4kvBbQVxpIB4uokPFzKA9RMym8rHSUwdREpvIlymazQnqU2WGE5MbXQnbMcYLbj6vulW50ZSZ
 Nc+tooBzduRYSqkqKPlfMjh7zguGe+Pmbi0WKU+Gkn/V0ChK9yIpmbCH3VxsA4PY/4Wwgg0uA
 0GdDgiLcIKHoa5bDwW0P2asJGPANl/tEbYJq1I99ZS8GzDJ2+Ax6KiHDSm7NMDwPXNgDJwzPf
 2sHH5Z8xXA3HtMrJ5UJz3Z9llT5ccW5dLBeuBoqhR+sptLP2BC44vWbPA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.32.0-rc3 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.32.0-rc3.windows.1

Changes since Git for Windows v2.31.1 (March 27th 2021)

New Features

  * Comes with Git v2.32.0-rc3.
  * Comes with Git Credential Manager Core v2.0.452.3248.
  * The installer now offers to install a Windows Terminal profile.
  * Comes with cURL v7.77.0.
  * Comes with PCRE2 v10.37.
  * The experimental, built-in file system monitor is now featured as
    an experimental option in the installer.

Bug Fixes

  * When testing a custom editor in the installer, we now spawn it in
    non-elevated mode, fixing e.g. Atom when an instance is already
    running.
  * The meta credential-helper used by the Portable Git edition of Git
    for Windows sometimes crashed, which has been fixed.
  * The auto-updater no longer suggests to downgrade from -rc0 versions
    .

Git-2.32.0-rc3-64-bit.exe | ae5abecab7dc607c944bfb3125c275042906b29755b3d0075aa312035b781e57
Git-2.32.0-rc3-32-bit.exe | ba7eaca66c146ee3c508c1b8769c9356e45af3cccb194dd8769df71633c00bc7
PortableGit-2.32.0-rc3-64-bit.7z.exe | 25d71a05f44cd595349d2a21dfdc2cc985f1e2fcffe8c982823b7060523478b8
PortableGit-2.32.0-rc3-32-bit.7z.exe | b0893f1c126d64bbde51eebfb09b7ab7ca54173a6bd6714d1c68c4a15f756b61
MinGit-2.32.0-rc3-64-bit.zip | a5931244f18ed5277f005efb2f0d05bd1e64a87a3cd0cd78b45d15daea6bcd7b
MinGit-2.32.0-rc3-32-bit.zip | 4a5fe1dc42f26111246f60d43efc82f2a29e189efa160af4ff0b0f683b45c45b
MinGit-2.32.0-rc3-busybox-64-bit.zip | 8865eeb08cadc8f3b8057b88828d441e708fcee2068875cbdbb39c2cdc779858
MinGit-2.32.0-rc3-busybox-32-bit.zip | 665ff2f9d51860d52090d18b1b76761a0c2f53e2e2a589a5ecc8a514b9c0d287
Git-2.32.0-rc3-64-bit.tar.bz2 | d6f4807e5bf6cfbc36506e232d6f6a42f227210a77fc111d39cf4fea45296875
Git-2.32.0-rc3-32-bit.tar.bz2 | df2896700d936901dd92b7602dbbd110bbba23844e5cc46c853865b357d668ec

Ciao,
Johannes
