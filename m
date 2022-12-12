Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96D3C4167B
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 17:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiLLRAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 12:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiLLRAt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 12:00:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594541009
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 09:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670864446; bh=Qmhh7YBw+5nc3L0NqMt+046hVNEEy003vTBBJjVa19E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RrTIP/CXX6BchWjR0MrV3oeEoQO3ZjscAc1CiUvKS7rQw5KQthun3IHUz2HcddxfG
         pJJfyNIojvjnzatXLJ9rJtnmHWn1+tQdxljE9wxf96ub8SXzjbOd0Q/81yWL+wD+l5
         eEgkPTgfL78D3cgaukPZ0ESXbKv9R6DDNnOjcgPd28FykyGGj0TkkNTSAGcwovAVkq
         qw+Gh0ffic4R3WBFtn+ISvevGgGk09OUBsn+WKKrB2AFhNqRBErMalX1ckltTH46GY
         lE6S6mwIUf9nphDCg4n+StTKf1/SLqZ0t2053DtIUyeRSTs3Lr9q0a+L1nHRWBIvvG
         aaSs23RloJlQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az707-246.5ebwkcozesnerefgb3rqjixrkh.gx.internal.cloudapp.net
 ([13.67.174.152]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1M5QJJ-1p3Oiu25On-001U0P; Mon, 12 Dec 2022 18:00:45 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.39.0
Date:   Mon, 12 Dec 2022 17:00:42 +0000
Message-Id: <20221212170042.3340-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.38.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:yZgxuB7uWK5KWrzobnPHfkthKhRq3YXmJa0NCVSAWkdF1STuiww
 9Z7bTwNdubhq13GJxcZsJgJn9Jb1xxHVjQzDKGehmwDOEubJh9E5OzzZvGteRep+HVea5hp
 Sb4NFT7ctX2MB1IPlWdRxmMSXS4b1GU+3MPWXdlZE8vmnVOLwRTazbocDZf/OyN/BYx2TSw
 XnXCmp8fwV8L99Do8CcbA==
UI-OutboundReport: notjunk:1;M01:P0:vrSq2vMJg+4=;w84LZg0K5dLUjYutqeK5C85XokB
 Ssiehy088pw8r3GRRBPafNVL5InjjNv1tIElr4/Wtax3B6SPCc7+qvh5dKjvQHgyNb4xJIc/I
 C9uo3YDraDOcbM1QleKrADhaeZ+6f9sP5U2ZXs49O6LJZZ+JKeCipPCvsRrAzPWEXG1mstwbL
 XuxZqY1ht3Gm9O0FxwKo/9ZGBIRJVPqh0Xef8z10J6hrMWnOvBPJ+E8+wEwPsdkrD8HAuJJqS
 Ue4xnfU2z6q9P8kFSK644/LmmzAOYdoOVocg3SenXDCoH2KkXNuUTbxuq9O9M2bEmGN7Sxs1i
 7GWUct/1/P8dg792LAs2JCnJd784Jho3aPY74L2G2vPp7aHPtJi2Fbz7LsG+Cb+o87z2EhS03
 Ei9m6tb5N5yWhr8aClb3R0CIdNsbkoT0EZbXbgHXD0ED0uzlfIBSLac/q3kk1uxszS+U8lR1k
 ONW6NObtoSzAm4F8oJauJZGa40tMm/QjB/DIrBmidbwPL+e0t6Uylt3/8fzCyXSuTCgYM7Sma
 i7Y74OwKiZGwirAwIsqgDv5gWO44UJW6dVVD1xs4fCWunN1nHJH1sp5nF0lAqnpzRYot3BjG3
 /F8iZ7snTL6MSGcDtJ0Y7u2woURRRq+14Dv2Kr9MWmitW+lTTSwjRprTstJ2q7rQX11A9HE+5
 nfLCxaBRgcAZhIZsme4VTOETi2mHTFSW4jjfzflT4GhOhrhk3oqGpKYINqr/3Ksge6wDu6S/r
 M98NiyK6qMZtJ5kSS4Wfvhg2W2ajqoTefatrPZJfjaH0Txxx+cHQ1d798OG22n7FxWD2NI7Sl
 DiGJhwsOlWkGPMTD0pPtq39Dw63NqRLwDFvYUla3MzeJdjIlamK9iWzjE2ISx9ongBjZoLqdK
 W10itEgbXTOf25nDjL/y4QcF+eB+iT4jSDTJmPhppF6YD+yR1dKA8KA8hC8OBwK3AB+aEahe/
 1gpdGA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.39.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.38.1 (October 18th 2022)

New Features

  * Comes with Git v2.39.0.
  * Comes with OpenSSL v1.1.1s.
  * Comes with cURL v7.86.0.
  * The Portable Git edition (which comes as a self-extracting 7-Zip
    archive) now uses the latest 7-Zip version to self-extract.
  * Comes with OpenSSH v9.1p1.
  * It is now possible to generate and use SSH keys protected by
    security keys (AKA FIDO devices) via Windows Hello, e.g. via
    ssh-keygen.exe -t ecdsa-sk.
  * Portable Git no longer configures color.diff, color.status and
    color.branch individually, but configures color.ui instead, which
    makes it easier to override the default.
  * Comes with GNU TLS v3.7.8.
  * Comes with Git Credential Manager Core v2.0.877.
  * Comes with MinTTY v3.6.2.
  * Comes with Bash v5.2 patchlevel 12.
  * Comes with Git LFS v3.3.0.
  * Comes with PCRE2 v10.41.

Bug Fixes

  * The Git executables (e.g. git.exe itself) used to have incomplete
    version information recorded in their resources, which has been
    fixed.
  * A regression introduced in Git for Windows v2.38.0 that prevented
    git.exe from running in Windows Nano Server containers was fixed.

Git-2.39.0-64-bit.exe | 2eaba567e17784654be77ba997329742d87845c6f15e33c9620f9a331c69a976
Git-2.39.0-32-bit.exe | 5b01ddb342a07e74e723fe93bc84c275a19236e853c406b4496478e64a7f8add
PortableGit-2.39.0-64-bit.7z.exe | 8ca31e8474048b48b813ebdf95f288d58f253717d071d11785cc23f37dc6a396
PortableGit-2.39.0-32-bit.7z.exe | b8332fc12bcb1343d57c785d7ec140e2fd89f9d7f70309a00e79f9822c2cc855
MinGit-2.39.0-64-bit.zip | ae6863d7b7641ecf73f61edadbc7d1ff8259d08eccb4b9f006bb443d90910c25
MinGit-2.39.0-32-bit.zip | ad20467cf6a4c215b2c71f9bee192fb8ea1696fa3dda8e35e89544cdabdc1c7a
MinGit-2.39.0-busybox-64-bit.zip | a5d177bceeddfecc97c2340f0c8bc97d55ba113c4cd5b6b7d58e513dccb3d74f
MinGit-2.39.0-busybox-32-bit.zip | cb8371cbba56562f7af1d54281afb24bfa23395a57a0868398f644a79c2fea2a
Git-2.39.0-64-bit.tar.bz2 | ed78c21d89281d91fb1282043c3b618350e8ff721947ad01678356126b0447f3
Git-2.39.0-32-bit.tar.bz2 | 09126077d63b3e3e19c90599f86c037eb57edddf255e75acc31720428d03d78b

Ciao,
Johannes
