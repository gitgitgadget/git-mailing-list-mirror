Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE2BC77B7C
	for <git@archiver.kernel.org>; Thu, 25 May 2023 00:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjEYALh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 20:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEYALg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 20:11:36 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D07A99
        for <git@vger.kernel.org>; Wed, 24 May 2023 17:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684973492; i=johannes.schindelin@gmx.de;
        bh=xulFOXpQmFStOtiCDBrhwByCJ6EIgIJ+04InZSx8sbw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=UFdFCLifap2zXMG1ImMehDVGG1YwXcDCk/FwGB8ZWUg+i6iEGxh3+HDvKTtlMAval
         ypkVUoIn6K3iuqfnId/WFl/ZBQF1rE+vFSzcITZc4sW00rMU++p20DcP6khFJx+Fta
         kguo6f06L7Q7fd9V0vB1Fy9zH3xuIBP02zH0dVPPIR4gvNafrmCrqefP1VJ5kIUTe9
         fwHk14WHqPPQANOuQ0SR12gB+/dUkV9zpNEUcx7aw+Dr/INtWmXlF7Kz78wVFY7lnD
         4aTuA6aNY0o4Gm+eKQzBsH+nfOYT2otVrG1m9d9iPXYPynIq2uP+6WU8glhLX0pqBh
         y3lJ/yObADE0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az453-848.2vhfbungzw1e3oo2z3acampsgb.dx.internal.cloudapp.net
 ([13.64.13.80]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MY6Cl-1pd0Ws2wZh-00YQmV; Thu, 25 May 2023 02:11:32 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.41.0-rc2
Date:   Thu, 25 May 2023 00:11:28 +0000
Message-Id: <20230525001128.3658-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:x57XXyGGQal9FcPQ6rVh6rwumgGs3GXahWDwOkQbQWZIfJxHvrb
 uyoQU5SU3jKPwQntwXPaY/ZOoTHwwgk74togT2/vStsciyoKxoqh+xV5t6BjQLH27PX1bZ3
 sb+xw2z94+jjuYHQq8vkYbNH308skXtpWsCUr3a4tTgMxqPROgsWu1O6Hc2OzYwypohD4hx
 sPi/eKG6v/mGO2X/Suibg==
UI-OutboundReport: notjunk:1;M01:P0:SwlT8uzhk1c=;vxuVZUt2gmLyz51ppUg0m9C+5wU
 yaymBL3YCPEbn6TuWuMEj+URlpcSO12d1ONdN/AJ7J4UfAS5BfCYIsYFDewB7c8rW6yZsKvWI
 32HPXdrmwc7RfQMFIjEPkS0WgyLbZfOiAqzcXtbhDwEiHjf7u1m3axYe0lclWUlXYJgwZbptR
 PHfQXLq7Y3rw3iTqtPZpg+BZgrYO7WKdCkmn4ymsrJaGQW/7ZUvnIwHKCBJYeNrHW+qY8W6SK
 WfU01kiCJNMUw/vDErEyT1HWm7ebyvrXK8VjpRTy9jsO2tMGrCY5qhnjJrnz777oDwHgHc1wp
 rFjyvnenA/uUTIO7R32MY8ufmL3dfNCYiIX9zHpitI2xsDhuk3tzAd4gb9xBhE7KBHB0P3nyy
 A4n9qkpgbAMyvp1idNr+1Td1CLmmmG3wf60cof3AhCUCNBVKz7DSmWyIv9h1RQC7QCNkA77mT
 2TmiNMzBXgwbmmsx3SmbWtJEtge+x1XRnO0B3UKwqK9VF9wQ0mDwX0ZneXi9iZUzyIcVlhbk/
 S3KSB0QRMXH7T1+1E3vPninOPp/rFs6A6kKlmp15wkbqo8pawfNeVEivFJ5TsDczdLFg1fPAg
 e/oU5WHGn+9QZPb7A6Qn/SHWHw0FknwKPihrm4wFpaq3DkQ9oYGhFe6mbMeakqKEAAM1YaSzZ
 CUZHmigwIHDbFlV+oy2Xmvr9Ds97xCy2eI6oKybyA+mzto9TbycelCDHXrjIIqCvYUkhwYYHE
 3sLrJo/VmUWezTOcjQodUwZ18DER+SpxqMPDL3VhMf8CgyL2iowVDBpS/IXn+oe2bdrIFAZmn
 prvqpSRrbik51L0bvJ8UP+E9qw1qo2bV3bZOdySzwUf3SuSh5ebh8PB5D44cBRy8dXxoFk1fN
 HPMXjRFp1ML07q71YOpS/sBGRe1z0PybReAXFYeu3ZrdY0r3AR1veSqTOU5yYdDaJ+9BdSSbt
 MlO6RA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.41.0-rc2 is available from:

    https://github.com/git-for-windows/git/releases/tag/v2.41.0-rc2.windows.1

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

  * Comes with Git v2.41.0-rc2.
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
  * Comes with cURL v8.1.1.

Bug Fixes

  * Git GUI's Repository>Explore Working Copy was broken since v2.39.1,
    which has been fixed.
  * The MSYS2 runtime was adjusted to prepare for an upcoming Windows
    version.

Git-2.41.0-rc2-64-bit.exe | eba7c453fad2460eaff0204c9ac5e0815fe7544959cb773a1b2f4bf5b6c296f6
Git-2.41.0-rc2-32-bit.exe | 8220abf44e107912619fb426fae6de3381a3360e7b856eab0e5723d4db0ac9d4
PortableGit-2.41.0-rc2-64-bit.7z.exe | afaabc1b560192664e06d03e7c05ccfd484f0d1f55c40b91928ae4cc2f74df9f
PortableGit-2.41.0-rc2-32-bit.7z.exe | 9d94489aacb2f68718d15d47b3688c6d4ef7200614ac2a4700a32a1a14bbbfb5
MinGit-2.41.0-rc2-64-bit.zip | a02fb613b047511b01f90052b863f7330b2dced1455c549a08cc83d1c544ae69
MinGit-2.41.0-rc2-32-bit.zip | 5c1bbfdee6778f7a8a1627af5a8fa60eae917366b783cc50d4da47f2f57c2373
MinGit-2.41.0-rc2-busybox-64-bit.zip | 6780e08d7e8fe963c670fc792b5ca46e5a94800cf7797161ff22324622d152b7
MinGit-2.41.0-rc2-busybox-32-bit.zip | f0df7f98e35db5b361952c5740e682c1572392ff0ea6ce1d0c3ac84b374ebd15
Git-2.41.0-rc2-64-bit.tar.bz2 | 91163ae50b684ced95bb6c83bce7565fd86e3e67bb604cdbd5dbe3ea45dc6f53
Git-2.41.0-rc2-32-bit.tar.bz2 | aa00daaa9d136d03a3f98d85f8643ec781dc7eca2f6310f6e4e648a65478ec46

Ciao,
Johannes
