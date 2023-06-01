Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A13C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 17:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjFARfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFARfi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 13:35:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA17AF2
        for <git@vger.kernel.org>; Thu,  1 Jun 2023 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1685640934; x=1686245734; i=johannes.schindelin@gmx.de;
 bh=o6tdw0iqJBPQW491tt/52yy9fe4SVqbIr/2dJutyZLM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=TMpopUFBL/PAb5v1LLP1o/QtRWXNb8CVIN78Zf0mG7w9lebHKipRa85gQMhXwQKXmgv8icr
 WeE0atHHRT2+G9BfAlbQnJJYCRPt8c4Z5uMbf6LLtYn1XjNFA6JOsaOCLL2oNbWea09XXxeVX
 9aiYxgnK8cWGNGNFKr4lGaAqeaDAm2YQWE0f8C6m0NWiVXHiWv2YWLU0boLNdfuqmrcRZz/pb
 fL4Nsr8LS10wAoSNC0Z+tLMJZwjrcg9pzd6NsrThN17gH8YtQevRw/zOvbqQb4gsL71BNMwHa
 yo4r0VA2JM0lmHzYk93/Rlkn4EtfqEUdRf28luNhKEfRa30onvnQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az574-199.esnmgxn14wlejbqjnvhsbsbtxa.dx.internal.cloudapp.net
 ([13.88.61.225]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MFKGZ-1ppgBI465B-00FheJ; Thu, 01 Jun 2023 19:35:34 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.41.0
Date:   Thu,  1 Jun 2023 17:35:30 +0000
Message-Id: <20230601173530.3592-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:LM/6g8WRsExd/NBnrS56wLISFqVDHegT5/qjUK11UmUbg1z8Mlv
 K6A077t+EuIfELsqj3WdnWILFU5tNpnPrw4wVJeai0sQ2A0+dATJrfkWkDlAXICCfJqeVMZ
 IlROHRGoELVi8MS4vTe+KWg/WcqbTs6tHFEwn6+65lTzzCXi704iMyQJlDsMs/ePDaco9Jl
 m7xD5G+VWaWHdjbd+Y/tg==
UI-OutboundReport: notjunk:1;M01:P0:h96QZej0AHI=;w9IXm50hCsvwUSjjkF1NMtFc2zi
 MJLloQunrNqD0oV0WyAIabdJMniER3Q8tqMll/UnFMuAlAgEYQaKjH/r535OnnyudORQdgJGw
 3QFuZEakTbYVpa7G0GF71RDd/1nkJmLHuA8pYb7jRfzhVtoGD2ZUZXdwwjIcZ1emVdxfSPbrT
 BuE60dzIoLPopOq7+tk88yiXDDI3W4ZGFR0LizIEhY6qSoxR4omxCrfTBSKWrX8+b2l184Tfb
 Jso2B31JyhG5F1XJZjSCODTx4nj+QWrdOkIGkPuxb2+r25+nhaWPqpg9ta17EVzy0J7IUca4w
 AxeQ7NYIEKomfFV7kXmtGyc4a1qP2rUHPu8X3yTafnskmssVfHLwzg6jC0rU+aijds0i2XKQw
 LceOcaIgLL2JEoFpphAxQ1I0Njj/k/zGkXNPxbk01LriIdLLvfIKg4HTMWyhRhoirWnMRfcns
 iaQ00CVkQ/dHpfFNof6f/rDQyKfiKATKoucROnYWYnshcR7PkdtpWOxgs4Ra6FFLAIxl+xTe8
 Yhan4Q88NrH3gtPsjN9LuaJrW16Tdq9uJeeEiQN/AayBoBE8PkOHX3dkzGhpSYwz0CKs9vZ/3
 J4yE6+Pr63W7VQ1QqXXfvqMhzMiwyJceN8TQHkblriWCZ3W0icxTgjHLW4IXEK23uZj4oNTfG
 ftmxDL3VV5z2I3hsLRCdGB2jbWcz9i2yic6zc+NoXnpsPtDDLnSRKtKiYOLoNJjmzH37v5f0y
 +qzsZxvH7FGBgfSe4OeFOB1a2iXUlDwNxNPftQqvgt6w++7u08coaayVcrx9gw1QJx3vsv/3J
 kj77dD7XI/6YDtcEr9auDt9JbxLuD+y/WFgQjfQNuUgTujJnbPVajDgzPn9FJBQplntlImlbc
 J917gGslZBoFwKThZ7ptzofIpCOwQuWywOt0nMX0CQi1qsViqV3DXPo4YoyznVuuwz/BGGOct
 MQxnwQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.41.0 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.40.1 (April 25th 2023)

As announced previously, Git for Windows will drop support for Windows
7 and for Windows 8 in one of the next versions, following Cygwin's and
MSYS2's lead (Git for Windows relies on MSYS2 for components such as
Bash and Perl).

Following the footsteps of the MSYS2 and Cygwin projects on which Git
for Windows depends, the 32-bit variant of Git for Windows is being
phased out. As of Git for Windows v2.41.0, the 32-bit variant of the
POSIX emulation layer (known as "MSYS2 runtime", powering Git Bash
among other components shipped with Git for Windows) is in maintenance
mode and will only see security bug fixes (if any). Users relying on
32-bit Git for Windows are highly encouraged to switch to the 64-bit
version whenever possible.

Please also note that the code-signing certificate used to sign Git for
Windows' executables was renewed and may cause Smart Screen to show a
warning until the certificate has gained a certain minimum reputation.

New Features

  * Comes with Git v2.41.0.
  * Comes with OpenSSH v9.3p1
  * Comes with MinTTY v3.6.4.
  * The Git for Windows installer now also includes the Git LFS
    documentation (i.e. git help git-lfs now works).
  * Comes with Perl v5.36.1.
  * Comes with GNU Privacy Guard v2.2.41.
  * Comes with Git Credential Manager v2.1.2.
  * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
    3.4.6. (This does not extend to 32-bit Git for Windows, which is
    stuck with v3.3.* of the MSYS2 runtime forever.)
  * To help with Git for Windows' release mechanics, Git for Windows
    now ships with two variants of libcurl.
  * Comes with cURL v8.1.2.
  * Comes with OpenSSL v1.1.1u.

Bug Fixes

  * Git GUI's Repository>Explore Working Copy was broken since v2.39.1,
    which has been fixed.
  * The MSYS2 runtime was adjusted to prepare for an upcoming Windows
    version.

Git-2.41.0-64-bit.exe | 45dc30410916b8ec5501be39d01d5b60535731c04fa68283b4f9df4920877d4e
Git-2.41.0-32-bit.exe | 25c9077aa60aca41fa8a7b89a8581492e04155786799653ef3010d165e11000e
PortableGit-2.41.0-64-bit.7z.exe | fcbaeffd24fdf435a1f7844825253509136377915e6720aa66aa256ec1f83c30
PortableGit-2.41.0-32-bit.7z.exe | 12190f5bec59a187ec0368f39dba55a7802706076b91fe400ef5da4247999467
MinGit-2.41.0-64-bit.zip | c9cffc25e2ef81f51029138678b7bfc538a56095ec0538125dc790a01e20d77a
MinGit-2.41.0-32-bit.zip | 2643d9b1c663258bc5ec966f2b8493884ba3e247a41edc5a1496068a0a0a6ef4
MinGit-2.41.0-busybox-64-bit.zip | 6ca0a62dea4440a9564b93a85f0dd0b3db27e53782b5ade5a82382d7abc1453c
MinGit-2.41.0-busybox-32-bit.zip | 9e069bffb19da682fb80ef1c3d6c98417dd604cc0e2e1c1c7f23c0edd704aec6
Git-2.41.0-64-bit.tar.bz2 | 4f213f90ff3ef3e9c1bc4184b3cd8e9735f7108be0e4bf846158b9f8c4d5130d
Git-2.41.0-32-bit.tar.bz2 | 9cc7c2a9450b82ec6bb93ba15a192bbab52907ceff018366a189ce66d63b4b06

Ciao,
Johannes
