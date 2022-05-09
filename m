Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF693C433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 18:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbiEISZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 14:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiEISZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 14:25:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F41D318
        for <git@vger.kernel.org>; Mon,  9 May 2022 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652120465;
        bh=rAGFC1mSpZ4DkdscCNdjDaFKpxgHb5dDarQWJuEMmZk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Zkgr0zcILNSuHLgoWzCrP6Prs5EW765kZmFHqZbzyQEl5Y97Bt+FWAHMHWq51MoBL
         go/eMDJPdSzyUHceKIPrgUGankFuTl9kAHNsqOj5k2yxtVnWnK9kI3P9DbqkwXGlZA
         Tp5W2v9h4wluzmru9yajuNToYOJJm/Mrki0b6/MU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az95-651.pq21ngt4mckezax5v03dvw0kka.ex.internal.cloudapp.net
 ([20.236.115.157]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1M42jQ-1no80H0YMa-0007GC; Mon, 09 May 2022 20:21:05 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.36.1
Date:   Mon,  9 May 2022 18:21:02 +0000
Message-Id: <20220509182102.4867-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.36.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:CR50feOMxdmsBDSisR6TMHScHPwtTfj3pgWmuwcc4UmvYq8fUkH
 VUE0p09ESJsiKZ9yBPtBiMK0Hsw8Xx0AqmUqsHsy+EVSr7A81VOuPN5tv7qiwv4gb80lDd9
 s7jf1+kJerXE+zFsvSX4X4XYgG1mpWw+3xcm0bhr3PmyiwKPx3wyPS0I0dCyWbQWcUTx/Xa
 EG/cHBH8pP9EBr15lQKAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1fRhXEeR0So=:/Cq7mbKgUNF+3rRMKL4SZ3
 5wQ7xouSs+WAeZeVD2hbG0kem47TptKrON4lVmFG+KDngcS6thPj+cIhn8FjGVia18buS719S
 QB0hdj0Dja4RsJteZfJjMuWgKHytWIQ2FsFChrfBMR/buX7c7EUr8bCiZvYn3jE7bBAouvSUL
 SpG2t2CpSUY16BNMY2baCBsCS7tvCBr750Vcg+3N1NFS3/lrzBlpHqd+4McOYoOaXPd9wvHN9
 xbndVkt1mzsQET8baWQ7UKMZ5hEOi9LJo5tK3UBayoVL4wB2Zn9Wf4pGGapVQcKqPTN1m0CLA
 eATi0Jss0KQ9luYkPXnqf5FvapMVbJNVABjlULOSKwwx2EhNUrtE8Ouin3+r3WVqgiFAYlbk/
 vL0xBlQJbA0fvFKRW3Ondw/OxHQN9fE9dCxXfU3eZbd2/4Vs/zshEPw15KO7I8yt5nZ3YpC2f
 sLIKgrgAnM7604t4zpCMdlHV17mNNnbE0tacwwOG5/j0fPSm7Wc80b/JJ3/s64T1w+ELlBby9
 CPiVkR2yseDSz4+92RyCil/uRKYzRmze3R+J3vC0BAlJ7ekGms9Ba+nLPdMai+OBmnbnpxavd
 yzlLvIVsfxIzG5a8wsE1+c0nZUZijTmyXJ9xu7r3ejCqD7wW5U3mRLaq+Ionbp+NGLZVL3gQ8
 gx8SuY/7LDZ8zPGGyHreT7BiIGTl8LWKXLFdvG+624NezNbTOIjU8xuQtSXp5L/EIJVUliYPu
 x13Ts4GvPa0jwlarRGfU84Hn6Hw101ngzOd9ACMa+d7+KUM11vGzCUEHlTfAohx1Toz6qed7h
 W/9EQ0kMqfYVbuyiJEzAloqTNstxQ8Svt1SIUKEWdK1i7VvVDpxgyOBl0hr3k8o3kKCKCYlD3
 gEV7D/EQhwnHhDQTGbReSHqxhQy1IyLBquH/wM9bhe41C3N8bw98MV7DuK4fMRI4mpLzpqf7a
 jE5pcPudhCAovKDxYQqW13zFcjXQgVG+A+KggfhSWRyveFEmJfbn7UyLwTaazI6cvGGJiE1eR
 ye3OT+zyQtGE3XrtynmVrTLaTZQBI+ToNy4aUeQQXHH1CD17jhZW7r6/2i7yG9wu+iJlQnU9Z
 HFw0ndfE1k/mMU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.36.1 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.36.0 (April 20th 2022)

Upcoming breaking changes

We plan to update the included bash to version 5.1 (currently 4.4) soon
after Git for Windows 2.36.0 is released. Please check your shell
scripts for potential compatibility issues.

Git for Windows will also stop supporting Windows Vista soon after Git
for Windows 2.36.0 is released. Around the beginning of 2023, Git for
Windows will drop support for Windows 7 and for Windows 8, following
Cygwin's and MSYS2's lead (Git for Windows relies on MSYS2 for
components such as Bash and Perl).

New Features

  * Comes with Git v2.36.1.
  * On newer Windows versions, Git now assumes a Win32 Console with
    full color capabilities. This helps e.g. when NeoVIM is configured
    as Git's editor.
  * Comes with OpenSSH v9.0p1.
  * When git clean fails due to long paths, Git now advises the user to
    set core.longPaths.
  * Comes with cURL v7.83.0.
  * Git Credential Manager's binaries are no longer installed in the
    same location as core Git's own dashed programs. This separates
    more clearly the core Git executables from the Git executables
    provided by third-parties.
  * Comes with Git Credential Manager Core v2.0.696.
  * Comes with OpenSSL v1.1.1o.
  * Comes with patch level 4 of the MSYS2 runtime (Git for Windows
    flavor) based on Cygwin 3.3.4.

Bug Fixes

  * A regression introduced in Git for Windows v2.36.0 where GPG in
    32-bit versions simply would not work was fixed.
  * The proxy-lookup helper only reported the first letter of the proxy
    , which was fixed.
  * The installer now verifies that .NET Framework 4.7.2 is available
    before offering Git Credential Manager (GCM) as an option (because
    it is required for GCM to work).
  * A bug introduced into v2.36.0 where shell scripts failed to run on
    some network shares with the error "Too many levels of symbolic
    links" was fixed.

Git-2.36.1-64-bit.exe | 08a0c20374d13d1b448d2c5713222ff55dd1f4bffa15093b85772cc0fc5f30e7
Git-2.36.1-32-bit.exe | 0a50735bd088698e6015265d9373cb0cc859f46a0689d3073f91da0dc0fe66aa
PortableGit-2.36.1-64-bit.7z.exe | af17a2803c5c6406b9b60dfef2d34f72f218975f9d78df21005a44f6e2f0caf9
PortableGit-2.36.1-32-bit.7z.exe | 71ad967137a4da096f3e3406bd8a761f59c3a1edbf32e81e69e1f75efb9a44c4
MinGit-2.36.1-64-bit.zip | a7a78c306dea018cc7ca3efe6a0d87c1dd7a43762705ccb0c5e31e3e44349207
MinGit-2.36.1-32-bit.zip | dbd24baed2bbc0a5bb784cf3cb877bf9a66ff3fb029e95231f46db5e5b4bc4f5
MinGit-2.36.1-busybox-64-bit.zip | 5c7a819187dbcb0d8941c6a71bc384b01a942a6c2b5385202bb79a0fcc52d8a5
MinGit-2.36.1-busybox-32-bit.zip | 42dfaec1999393ba8b8e472fecc6b9435fed59415e404eedbe847c975c1840c2
Git-2.36.1-64-bit.tar.bz2 | 38f4888db497ebe11f67c42a88ac1708fb5c68d53a398b4030b51a6116cce0e5
Git-2.36.1-32-bit.tar.bz2 | 7b7cce2d1a29bb18b661720c692b39a27b406cd4916d75cc62d5fe1bfd9a57ea

Ciao,
Johannes
