Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1097C4332B
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C0A65228
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhCISX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 13:23:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:42097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhCISXU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 13:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615314198;
        bh=UTbyUKBx5V9BNLim0hOq7+2NPyDnAPhpq3dNuSKiQj8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Bf54RwM3wmZVMdZb9zGQrZ592OWeSBb+SkuaEI1J3PhTgN+yaF13OGsIS+3kcMJFn
         Ag1Bb1i4UO4DMyGgT+ycet5OgttjEFBZg8q055lePqhPG5AqsjK8cYvxZE7k6qMeEB
         7I/o+fXVtRQtX8jcV0KCq7XzHiqFz70H/WW9GvRo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from
 fv-az233-655.fxmiapahjilutpxrh32bf2mnna.fx.internal.cloudapp.net
 ([13.79.231.156]) by mail.gmx.net (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MnakR-1m08e31X0f-00jVz2; Tue, 09 Mar 2021 19:23:18 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.30.2
Date:   Tue,  9 Mar 2021 18:23:17 +0000
Message-Id: <20210309182317.7070-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.30.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:RcLIl+93nne/WKwVYVhvdfPjBkDh5Qkqggx/T6lJmlSofEhOYv5
 koHT/Uh2vEu0/uZG0vhpHFJ5JE2VWgVihd6Y1JzCTtlRzfx538OF912KVhV2xfeNwxwuYiS
 ZM+XKWj6nlcwZdg9Ne+ktfIuwIWU9PrIJoUjrXiNTE4ljWH4GrrmOHgpTi+byle8Pl5Ffsn
 z/B73xdn9aG6sP9roxTbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0liydglivfc=:wlJCNd2yiEMRU6TiQNHTwI
 SX+B0Lcq9Tg8W9yD/wuookxJ/MzX45v2QBrwRSlUMZVNrJfLnvv3BL5F5Va5HSnjti3SJG1to
 4c1BLUx+mxhrXo0UpIcHST8ZETY8wSq/LrM/+KTOJW5h2rz9W50gMV4OaV/E3b5PIQSH0lA7d
 4Aer32fgn3SraKCiX79r4O2Gogdd07KEb6IrQRT0CTknhchtM0PknoqcyqMXdyyC9Cu2nsXdb
 tRTrvAwgG677jJzG0uOwMdS6xvG1YCQnuMfnC7xqXpYDryCzxgcC5XqDv3yM9y4HjeHLCG94h
 KdSeQVYDQUDdKP8KF/+1o3tpsl+FXjTLN9C1P0oxXTRmcHRppo53bG9dQEIsgIT0z420sxsiz
 vKdREBZFtTWziUYoy20Iz7uWGxRV81/Nh57ONdhxJRQq4olqij2EhgJJZVW/FVEdvlxh4HIqB
 Z7RhDkesp22BmuHjpauV6+ed7M5hJxpuHJXIXceVe6Au904xbUgVr3psf6E7B6N9vZcjUDqo0
 EXgM4X3nYXi3LD1sIYNM0QcCDlczD+uer4g1S/OeqyMEaHgsbd7lIt5AcWsru3OvKxnH1htFd
 SyqFtD+o6/K7cwIlFkFGdOEGQaaatAG3cgg8apeFfoVjoRfstbzXPIdsgVtiTP62NiRwUmXcZ
 lh3/2atsAJbUUELprBj1ZKnkwF+tDMpB9lYeA9WMx36/RG8C0wywjC1N3GGR30UxW1NU0G/Vo
 mwhGzk8AZtp08QZmtDbAvp76GoTS6ydm72CkBVs89zfiYj7Ph+ecseg26s0lXcUkJT7743spv
 cNN66aTP8Wpsuqtly8BUv3K1We4uvqnVMlIaLZ23+DOjCw8LFDPSecDDUAV7aPlZuILldqDqD
 khz65u8pflbcbqGvs0sQywty0N3mv2cwuHCAB2UII=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.30.2 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.30.1 (February 9th 2021)

This version addresses CVE-2021-21300 (a bug that allows code injection
during a clone from an untrusted source).

New Features

  * Comes with Git v2.30.2.
  * Comes with PCRE2 v10.36.
  * Comes with tig v2.5.2.
  * Comes with OpenSSL v1.1.1j.

Git-2.30.2-64-bit.exe | ae84c1965034527158fb0faca3e32430f51a34140a929135180e4dc0eddf3c30
Git-2.30.2-32-bit.exe | 5129a8073c74fdd42a47cab0e0c421c4d51f36648b7ebd1e4e5771631d0ae1f7
PortableGit-2.30.2-64-bit.7z.exe | f719f248de3dd7ef234331f8da95762594a388f6aa62f4c0260df18068e5a447
PortableGit-2.30.2-32-bit.7z.exe | 8b203531c91d3f9075aa3ef1e89b0d6e5d18aa289c3bc485e093c9bfb860a116
MinGit-2.30.2-64-bit.zip | 168fdc5021f77ad51269a7fd778c9254a87418352bdc039723c078da693a3ac6
MinGit-2.30.2-32-bit.zip | 0a7a23350190c611e80312f6a88183d307c15c4a58b1dbf9b3e95ffdaaaed1f1
MinGit-2.30.2-busybox-64-bit.zip | 6d89013fea45f802b8c9b06740fd214c404bd1826ea46a4cc6139803c1976feb
MinGit-2.30.2-busybox-32-bit.zip | c6a68b06ccce316781161b8c4d4ffb71676bb37715f348e2ef4a266576e9c16b
Git-2.30.2-64-bit.tar.bz2 | caddc921b899eea5b2f159fc0918413d706748070265b93c2832cfb73be7b313
Git-2.30.2-32-bit.tar.bz2 | 7b073c7364fa16102d4c25010c416e28e16cd17c8bd10a71050d5abe569d678c

Ciao,
Johannes
