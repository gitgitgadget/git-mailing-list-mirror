Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8399D1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCWRkz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:40:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:54823 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbeCWRky (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:40:54 -0400
Received: from localhost.localdomain ([65.55.188.218]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0Lkwc9-1eOzXK38dB-00aoG0; Fri, 23 Mar 2018 18:40:52 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.16.3
Date:   Fri, 23 Mar 2018 17:40:44 +0000
Message-Id: <20180323174044.14612-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.16.3.windows.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:5b+4NwiWB1emLW4tWNd29rnMbJzuP+LFE2bGvhU9OFVyLab40JV
 3/HvLN0q0XQKqr77NJqe9PXoB8eIBo8TQlrcQzvYgsUV8xCG1vtVUl93bmnKAskBDdCZuXc
 wPHUUET0L7FVPrIsH/D6C7yquwQzMFDuYZDnuS6HCSHnsP7iDt/W7M2lnJy3X3xLvoiI3xp
 HuQOQqEwFdJMyr3aKNDbg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hGFQHa5B2T4=:Inqz8jqgZ+pcMKtgDQ6Oub
 u5mH19ih5Q6S3tXeIdPQaDXS/cDLRIFu66dIcthpNEdtCAHobETlbtD+gc+B7LjDEDdDc5SVZ
 Lu5t/ArjdOnyJLREeJSkd4HvQDQSuwTiq2jAkT3RSBrrGgqf0XYyDYhIWO/wEk39M9Uz1z5I9
 JZF55LgeAWyNoIdQAesuMsz+0wq6TMPUYGlpenBvNxPKvLWimoAsOfwXlX5djN7emXVtKeoU/
 o0VyricxsEGs7fPm5M4g1edXfEb0AFcNo/zwbDYKWRdaU2gI+5vjiSda0nL84JhZFlxk3w67D
 6k6B6dH4j5YRg3uNGvlmDMl3KaCV6GhyfisjxbAcVko6KnuyN2HFm1FmeT/8/yTXkCWANJXAT
 PKn2n04aY7SumLvwymEGAsWhS1qH30p5IxDqNQAPlDuktE2ZcFpZPTEkyXog7lvEgaX8GJ2PD
 Nv32AF0FC/cm7FA2bndMraWmXBL6xLoExjTSsd8AtdmUnjWcl4lLRu4BJZ0qgmMCQ9gp4Am7B
 lbZt1I7qky5NdicpwHsokkJZjG9MWhhZ93w3rsNlL/QKNkNLh6M0amK2b+LBLa19yO/P0OZ1c
 iPaEbkgKqQiI0M7t22EtK4AKEB1R//yOaH1rpNVEmuKx2Bym3nqcfsN9shIfQgMeyJS+zBw7u
 l+YRx1ttYlynx8fJLBwBxTBmCosz7CmaooQXvYcNOWPXDxT/M31WGqZsPkUlXMyvRDA5tE2Pn
 pjbP56xDzctpaZrPhftng1wMmuHFeUK4cDRAyWJNa7Dc4e1gKA4jrhhTRrKzrL50y+pzb2V2n
 KG9JHbbFBauc8W3n6NQOc9IoE+OfPIYmWtFTMga6/yZlJ5Bx0E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

It is my pleasure to announce that Git for Windows 2.16.3 is available from:

	https://gitforwindows.org/

Changes since Git for Windows v2.16.2 (February 20th 2018)

New Features

  * Comes with Git v2.16.3.
  * When choosing to "Use Git from the Windows Command Prompt" (i.e.
    add only the minimal set of Git executables to the PATH), and when
    choosing the Git LFS component, Git LFS is now included in that
    minimal set. This makes it possible to reuse Git for Windows' Git
    LFS, say, from Visual Studio.
  * Comes with gawk v4.2.1.
  * In conjunction with the FSCache feature, git checkout is now a lot
    faster when checking out a lot of files.
  * Comes with Git LFS v2.4.0.
  * Comes with Git Credential Manager v1.15.0.
  * Comes with cURL v7.59.0.
  * The Git for Windows SDK can now be "installed" via git clone
    --depth=1 https://github.com/git-for-windows/git-sdk-64.
  * The tar utility (included as a courtesy, not because Git needs it)
    can now unpack .tar.xz archives.

Bug Fixes

  * When a TERM is configured that Git for Windows does not know about,
    Bash no longer crashes.
  * The regression where gawk stopped treating Carriage Returns as part
    of the line endings was fixed.
  * When Git asks for credentials via the terminal in a Powershell
    window, it no longer fails to do so.
  * The installer is now more robust when encountering files that are
    in use (and can therefore not be overwritten right away).
  * The included find and rm utilities no longer have problems with
    deeply nested directories on FAT drives.
  * The cygpath utility included in Git for Windows now strips trailing
    slashes when normalizing paths (just like the Cygwin version of the
    utility; this is different from how MSYS2 chooses to do things).
  * The certificates of HTTPS proxies configured via http.proxy are now
    validated against the ca-bundle.crt correctly.

Filename | SHA-256
-------- | -------
Git-2.16.3-64-bit.exe | 848f8ac7dd59817512a89a753f90ab2ff170032faf5a566badd671d65f0fb4ca
Git-2.16.3-32-bit.exe | 9eec6c4c81e707f00adcad16cf9c005ee5df647cee5251fb854b202c321a0cf4
PortableGit-2.16.3-64-bit.7z.exe | b8f321d4bb9c350a9b5e58e4330d592410ac6b39df60c5c25ca2020c6e6b273e
PortableGit-2.16.3-32-bit.7z.exe | a8211cbe833c6eb9676ebb43cf43375484a1f9a5524009e5bf31c5df320f23c7
MinGit-2.16.3-64-bit.zip | 74724a54a456be73df94a4ea44a62bee9b2ff00baafda2936bf5b4e61c79209d
MinGit-2.16.3-32-bit.zip | 90d5df65004bea53e660e1d20cb374d4b3bae593bb3525c7e079c1946278f670
MinGit-2.16.3-busybox-64-bit.zip | 436e96898e2e0bef31a0d16607d013fefcaabd5ef7f0a581a787ae0b4e8e321a
MinGit-2.16.3-busybox-32-bit.zip | fe12cc014cedd964d4fdd99f7fc04f941bbeee5cc4e526da0ea494c79c50e41a
Git-2.16.3-64-bit.tar.bz2 | 8800822af28af198fc9676bf8a793193ca579252b1df2faa5dc8525cb799b95f
Git-2.16.3-32-bit.tar.bz2 | 6c088bb0b69086932acfb05a03d2ba3781eb02217e45fed8628c2ac4e1a7be9c
pdbs-for-git-64-bit-2.16.3.1.5d726e05e4-1.zip | 81cd1ba6c4bd76e575d9eb2c6352e207647fdad9bf44fcdf4026630d9dd2a098
pdbs-for-git-32-bit-2.16.3.1.5d726e05e4-1.zip | d63e97911a34d7ef3a181c3fa62366548df459dbf1b3b11fc8e424c87d80045b

Ciao,
Johannes
