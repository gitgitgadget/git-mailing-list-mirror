Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951F5C77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 14:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjEQONP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjEQONO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 10:13:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34308E8
        for <git@vger.kernel.org>; Wed, 17 May 2023 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1684332788; i=johannes.schindelin@gmx.de;
        bh=WcMvu59N5NllobpEmaQ5MSkBAC4vQyZ1UNiCtWCDb1w=;
        h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
        b=by75aDq4VfblLqlRse3RHN4sQ8iE1bbQz9dBIbA0Ouf8sdOaoLNmWVRA0uGW7poI9
         MD3Q19xAqcWe2meV2rXv0OJJ1Cx8A86997IIfRCccti2JePoSo4wGdgYwfjIoXTlHs
         3CHo2Qd4lYAWukJG7e8N+e2xr4q0yjYok9/5NdI2an74lNPPlSLRrDOwFQ5tkfF1my
         NUSNCcwxcoCV4RgLm3Diq1QHNIfNOEerFYbv/OAM+bM+wtNLPOl0taginYayENUtXA
         aavzM+IIv1zgQfY7C/LByCZ/esGtamkyyDycK/gxkPdBHezaYJ3Un0NWVc7vNwV+dw
         w/+9f499uAbyA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.249]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0Fxf-1qKpSF2J2V-00xOYx; Wed, 17
 May 2023 16:13:08 +0200
Date:   Wed, 17 May 2023 16:13:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.41.0-rc0
In-Reply-To: <20230517135216.3546-1-johannes.schindelin@gmx.de>
Message-ID: <9a1c44a7-e1c9-1ab7-0950-c128fb75490c@gmx.de>
References: <20230517135216.3546-1-johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cSE++3ebJa06s6BAchCbZ/IKQCcE5CApOEBt/nQqnN+SJAcyT7W
 vVl2H225WOMY0saSe79B3UkQmPKL3DDtiQ8qPzpBFHeRsIT0lopUjhWZN0nRpJ8sydBGQbh
 l/UFoeX9VyQdTqEWDX0vs3UI9A8m6xDTWZyIlAWFKPR3fCgKN4FZQ89mr0+e733zyabA5fw
 YXMsKcc2w3NJczZkHkOfg==
UI-OutboundReport: notjunk:1;M01:P0:hUJ+dpr0KrU=;dJP0t0PwHGSZTSdD9BXXDd9sa+d
 Ccv8b57l7E5Tle8K5omOwp9WZTFoJmQsEenaFP4C9HoUdZYUnY+nbuUwxVWqptuDXfBJzBwug
 ifyPg/m3bjN9QK8LfQS8I3hZR1hdyCO5on7JMkdepcZKym1E1lqe71wtXHVnRXQ2pbgYYSERg
 euVO4QwfDK1zNoYDEmcxhNVespfq5/rMccnYJjSZCW8SQBp8bMlJKncZZxubwglfwC3icVnMN
 xGAb4bhWRZRigMUB3HBxdb+4FwkFkyTSnyB4JjxjSBT611OVGpXoOWVWW9rEdgcmziS6uGnQv
 S76Ivi/7PFNYymuqlOu4OtHQ65AM4n6ykUN2hz704O1ok2VPYc1D6+M4ojQDZYsYW60jFUx6v
 v/JzV9g/coLIIOY+lTDSJqVnIjmEpIcGb0XP30lpEcBO87+XBKW4pU2tymMghjDH4n+mGfzTc
 G51tOtD6WwHVib/q8d+34XDrEN3ytFlMuc3zf8R8sxFuO+8xe+daU2TD2fJTWKD7cB5n2eLqZ
 SQzk1j5Jv+mVtpyPAXfH9tvmzEceobIX1DHN/sj2VK1mVfmC7EDSRzj0kED3+2wlX4xV2akrl
 kOeCT5ODRo64lEN886vFo1TAQqTL6IpEyclQkLVvhVMzXl3VaDJpvYeqo3dDSs9FdS+3yT6ak
 cyL1jMLsvIji81OZQCgT/kPk0eDfKbXMqNKOp+jf64suEu1t/+HBI90iY0ZhsFeHfemRhwwaS
 mPdLro6uHhJs4Zsj/VuSI63uaFIhaSNtm1FYYl1ilIOLsUh1jniSqCRR4uTF1OuAV/F3MM9FI
 tVGeRjjnbxfBR5kgfsPIJU8jIXkLNOCDH2shwzl5xgAOAS4IbnTDvPLxCjMIizeE7Y+dKwxUf
 xaOLvn6gWTnp4Jzzdwytxk9KZHA3yTW4M1HAWhjpcKsv9sEUfBUtIes61IYMZ8MfUN0BLXZbK
 ytnNNJdI2Yxziew2by54Oc9dV4g=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addendum:

Please also note that the code-signing certificate used to sign Git for
Windows' executables was renewed and may cause Smart Screen to show a
warning until the certificate has gained a certain minimum reputation.

This is nothing to worry about, it is just the regular code-signing
certificate renewal mechanics. If you want to make extra certain that you
got the correct file, please just compare the SHA-256 checksum against the
one listed below.

Oh, and please test! This is _the_ chance we have to hammer out a solid,
robust Git for Windows v2.41.0.

Thank you,
Johannes

On Wed, 17 May 2023, Johannes Schindelin wrote:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.41.0-rc0 is available from:
>
>     https://github.com/git-for-windows/git/releases/tag/v2.41.0-rc0.wind=
ows.1
>
> Changes since Git for Windows v2.40.1 (April 25th 2023)
>
> As announced previously, Git for Windows will drop support for Windows
> 7 and for Windows 8 in one of the next versions, following Cygwin's and
> MSYS2's lead (Git for Windows relies on MSYS2 for components such as
> Bash and Perl).
>
> Following the footsteps of the MSYS2 and Cygwin projects on which Git
> for Windows depends, the 32-bit variant of Git for Windows is being
> phased out. As of Git for Windows v2.41.0, the 32-bit variant of the
> POSIX emulation layer (known as "MSYS2 runtime", powering Git Bash
> among other components shipped with Git for Windows) is in maintenance
> mode and will only see security bug fixes (if any). Users relying on
> 32-bit Git for Windows are highly encouraged to switch to the 64-bit
> version whenever possible.
>
> New Features
>
>   * Comes with Git v2.41.0-rc0.
>   * Comes with OpenSSH v9.3p1
>   * Comes with cURL v8.0.1.
>   * Comes with MinTTY v3.6.4.
>   * The Git for Windows installer now also includes the Git LFS
>     documentation (i.e. git help git-lfs now works).
>   * Comes with Perl v5.36.1.
>   * Comes with GNU Privacy Guard v2.2.41.
>   * Comes with Git Credential Manager v2.1.2.
>   * Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
>     3.4.6. (This does not extend to 32-bit Git for Windows, which is
>     stuck with v3.3.* of the MSYS2 runtime forever.)
>   * To help with Git for Windows' release mechanics, Git for Windows
>     now ships with two variants of libcurl.
>
> Bug Fixes
>
>   * Git GUI's Repository>Explore Working Copy was broken since v2.39.1,
>     which has been fixed.
>
> Git-2.41.0-rc0-64-bit.exe | 7b0bfa1e1e059f7bc5e5a5a172f3da0fac8e1f5b6011=
366527ed6afcc50a82aa
> Git-2.41.0-rc0-32-bit.exe | 2048117413bdda01eaa358f9451973876e0e06b7011f=
e0636f8df794b6b5ad8f
> PortableGit-2.41.0-rc0-64-bit.7z.exe | 09085f5414f97e406b13a023482684d27=
28bb9788eca687dbf19434ab157ef96
> PortableGit-2.41.0-rc0-32-bit.7z.exe | cff7a350d6b312112b1cf4eb33344f37a=
6c85bdca8dc07ce90a23752b01abd47
> MinGit-2.41.0-rc0-64-bit.zip | 7b45fc53600f19008d322848305551fbc5600136c=
aae0769ee6d10774c3688a4
> MinGit-2.41.0-rc0-32-bit.zip | c49966732c4ba4b8c76057c2ebc13981f39be728c=
454aaf5849db3833ce049a9
> MinGit-2.41.0-rc0-busybox-64-bit.zip | 8792014287b6327bccec16f1ad7d970b1=
0f0566b667f40c57462e6e27b98e0fd
> MinGit-2.41.0-rc0-busybox-32-bit.zip | 67030d81d36caf0febab51d0fd1e3f20d=
2441197b3ca306d41f5f7658c3399a1
> Git-2.41.0-rc0-64-bit.tar.bz2 | e741dc0cc7211e974d588f624fa566a4b92e5031=
7e3f735894b443583c8e5d0e
> Git-2.41.0-rc0-32-bit.tar.bz2 | 0c0a97258b36b1054c97379b59ad5fe674e539d3=
66618e7df1bc2e20e5666c5d
>
> Ciao,
> Johannes
>
