Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0DDECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 22:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiH3WLO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 18:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiH3WLI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 18:11:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B429E578BA
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 15:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661897462;
        bh=h6tTP+2xOWmoRhxJlHm+xzgjHKsBI3GuJT7Z57IaVq0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Bv2C37H78ucOHlkRoSsOn3Si52lO36nKjguuOZod0djMZ1hWV2pOl2gojCUnB7kMe
         dfLXjj6bqqOsP7TovXOM3jLKh9tjvoJb5XkEXozpRyBfKEAcij8GHRsPs0gp1c9aZm
         HKtrPAJazZa885o1JgB+Q6/X4WsxJVwIxztFG4mE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az80-686.x3uy1q3lbwyuxmoobr5vjueqqh.dx.internal.cloudapp.net
 ([20.66.26.76]) by mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MiJV6-1p4ypc0i3i-00fU4k; Wed, 31 Aug 2022 00:11:02 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.37.3
Date:   Tue, 30 Aug 2022 22:10:58 +0000
Message-Id: <20220830221058.4307-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.37.2
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:YPMfHXB19VWeQx78ofRxj7GEcq3taRs3g7ujXZFq2tZV0FsWxx0
 Rl6lztnpgESHS1ITqcjulV2YVjYZ9w8t9sKH4Kq/JtwAk5GCQ5a7uNSJ5SHrE1mno47DTqj
 WwPP7bxkEPSXmNpa9gZe10tNLrhKIZiZzC+Q4dYVoR5H3YSFk3CDx1KLeRigOpJE316mihZ
 4Z/VvSBXtdbUuc5Oh+7bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3K/iM1lTP9Q=:DP+kR6OONkDN0/tWZOQhhZ
 l57dl4VDGFodho+6fmh/BSTChgZDrl70xR7qu9fUJ3rYbwUXbFPQKNms9Fxxossw+r06T18yp
 B3oSiESVf98PVC0aDYhqLUsiasNur/YaSgcvAMkdpeXs7Vf7OLqBguDJUq/HiF6yhdqlZ45fA
 KhFxO2eTafwk3GZs9r8ujXnU5fS2RIa9V8Mozq9OFAGulmMXF+NST5KtUksQtEvYndoL19g8T
 VFNn4CSXR1hlB5bKiEopd+wzTJZuqKEmFEna0WwM2iR/r81MJYfhmb/GEzcmNCMq6Xn8Jq7gJ
 C2lxRZa6gKfo/48+I+ICSj0EC043WCEbIhjKnfCVENCSy14VUdj8FHyxhCdI7CYXhwlEexKXt
 HV3610+Rk34AalZIJ40E38Od5Fc2no9jRCLpzfnB3hV4fRhvicjF8dgspyq8SWfjSnweKay5E
 qqQiGeHBnPMYtXU3uDZX9+ZE+sSG4/0WjRu93thDzInL7ZnqCpRo515lRVa6E+sQ+qY1XqS4+
 p8dnNAy40mn+IaFPULUbKy0ov1KasMUF9Cxo1iRevnq7/HlwlHJGKVspONs2VrhJ4TGI/uAAl
 smvEvA+GxFbMl7QsAX2+4EYfykpLPNe72a1pQPeDqDJMyRb9+2chWuff7qrMQ4XHiOHfRYGgy
 9ve0vGu0NmanV2DN3YuFll9lnlRaWCSKreFzqsmRv+YFR8JPV1YyqrP4O6YIW8xFdo1Tq85Ys
 LCDE5c9M0jie+YGpTvjpaffHA6HWi5dG9Hilz4cLnp4YWdZ9wW0YIghXfNeYVvQrO65tqnk9T
 laD6oQc7XFRTP+Zilfm3ThQYKvU6fOT/RyK32/EQjBa4Di7LLZa4fHooTmZKY4tuHPLUjihOg
 cphwTLryS154QILpneiRLbGgftEoLjBKmngdsB7+hF/IXElkAgNne36oaUUh04Vo1ozExE61M
 1DHVEx+lLBFgAvrvZQ30MS8nKe4KQ73VG05Q88AACWabjY0143UJ5TxxrNtbRK3n8XW2oD2W2
 iiuyOnz6lkQk3D0iz/iDrBe1yhvLmQKo4h82Xmb9+zRhDk+ArDXNKgs7ZDz7Jr6qZRTBMmIJh
 pQ8Tftax7q3XZfhgyjvfACTfdjIYHp0XAoxuOGGj29FcinGLYU4HQyGFQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.37.3 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.37.2(2) (August 11th 2022)

New Features

  * Comes with Git v2.37.3.
  * Comes with tig v2.5.7.

Bug Fixes

  * Git for Windows now correctly handles .doc files that are not Word
    Documents.

Git-2.37.3-64-bit.exe | b0442f1b8ea40b6f94ef9a611121d2c204f6aa7f29c54315d2ce59876c3d134e
Git-2.37.3-32-bit.exe | 5cc8e503989f0a3b3a5529c19074b07d83d7a6bc163532efa577bddbddfe3da3
PortableGit-2.37.3-64-bit.7z.exe | ecd013c3aecdde0ffb363d5058d379a9c4037ff9ffbc004218632e288490f35c
PortableGit-2.37.3-32-bit.7z.exe | fbb50b45117ee1ca559e353f19b9a903f08febba50bd88fb4c3c3ddf533f024c
MinGit-2.37.3-64-bit.zip | cec8d038fadbdd82e269a5c458fd2a62711c1bb9a76c85f07c46de3bff6cdf32
MinGit-2.37.3-32-bit.zip | cac833cce9d71b96520418551c03e9dd377293da64a146f1603efb71ddc7771a
MinGit-2.37.3-busybox-64-bit.zip | fca6336cb65687464869212606b1afa603b405af055521de3eb35cd414691a31
MinGit-2.37.3-busybox-32-bit.zip | 4553b4e93b9daf8903d52561f00afb740da7bad47504a0777bcd8ac0a741a85e
Git-2.37.3-64-bit.tar.bz2 | 414d77223eaec06fe814df4973ef3af345c04fb04646b889eb7a2df4ea602e63
Git-2.37.3-32-bit.tar.bz2 | 4c3f5d2976d3c1804f32d2331ca26c6af30616babb2480baeb8856305ec2ec34

Ciao,
Johannes
