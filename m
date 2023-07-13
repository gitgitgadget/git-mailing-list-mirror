Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660BDC001B0
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 23:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjGMXHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 19:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjGMXHH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 19:07:07 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F310F2127
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689289605; x=1689894405; i=johannes.schindelin@gmx.de;
 bh=1HiT3+w14roSbcCceQgHFhdZYRBCMqWtWAIkxTFNmFc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=qBdrJOhYZ8lV/GYBV+JrtoRG2kymL3ChLpJtUbXkWwnzRY5nC3LURf4mR68jxmYwLS4wEqX
 tUpUa5KSNBsV9Btzcm/VTscz1E0CQHow68VaNI3q0jg7UEN41bgsO/TSNhco5pnHB8ZNhMKw+
 ClarVEi3+bY3VfGejmRO/QqaCmhG9LxE5WKHbMn39tpeUo4nb0RgSu9fZXmyzN0gJVWb/pzvv
 18h2AyQeqOh2spjnUxV18gDVZNIk1I16R0y518B704kV1IBNb2ax5XA73l044VjiEszyrvSMS
 R92O8nNgC+hjH1wITwTish9mDkLc/tRbUZPfwEUl5CoRTWEy+tkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from
 fv-az1028-964.atwrdzpjfxuexoqyq1q1ta0xqe.cx.internal.cloudapp.net
 ([20.44.102.46]) by mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MAwbp-1qDnsS1r1V-00BOko; Fri, 14 Jul 2023 01:06:45 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.41.0(3)
Date:   Thu, 13 Jul 2023 23:06:43 +0000
Message-ID: <20230713230643.4131-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:HhA1CLtiBXlh7foO3cbzO1dC6FDz47XYRfcqSrKbxcHSuLKzsKl
 zl32iNHNAJZn9CAToktC+/5sLaMEfrsbdW8SuNsFrfFuJwT3MR7I0rHUGlywXEpVYwd2NWY
 c9kKEa0FUrRXiwP070+qXIZN2T4PCaWUO1KrR+xDqRLAlBc+I0JD66kI6m+Z/vim0JoXz0j
 4m0wfFzxVSDUznQBdjanQ==
UI-OutboundReport: notjunk:1;M01:P0:0Vayhi7CETs=;yUUsZjxxdM7wfL0M4bzuZYE26P1
 MEj0HodM+OsOXsQPh4B8eAS5zflO8fx37/xNGaFUMLukDUZ2fmjurBj4OyHCxknKkaALX3LMi
 8MQNxBAjhrAwPOZ1aKjfc7+Vm6DSXA5TS1aVVIz9407wbE8uQS6ow2emi1bjf0NP9EVubE2UO
 b2H2ECOudqCnhPwbNqYNxKM3cBeoHXOR8A0MImcPgSWrt6oqvUfwPTM/lSmDujk/N+T1whj1U
 Eu6Oj0hqqWfgWhYJ7W9D5jPf335SYqZCgr5i6ZISMd/Jxx7XeYCxq49bDd98YKaKZGHRvdFgP
 bTg3eR+GfHnG0eqEP+RlohRu90rUbwxJHQXFK5wxKH//l3TGjgxK61m+kk1/7eugKCHAvIdVs
 cAD/km0fH/O/Ivw1AEaxmq0dyf/U9/Ztzoam+CxmhcFYKU+Fx44IVcIoMEMnqlkNjbAlEaoqu
 Ou6m/oIkH0W9YsJ6/5Rs1QCq3StObxa1Zth039SnhlPRq4uRMmnJ+DAM2xTFRh4qg4CVxHe3e
 ibSN2DDHBBnLTVZ9m1odZO7HAc+C7oBng3Su9IvGA78miLw3VEsnd6ZAh/s+88qjvac8jeE39
 DYFZbUzSgrdVZaH5zxu7RpC7XWpIq3uUi9Tg3DTvC7ZL0mnd/a7Z+Aq34GIwBnSsRgWr7Z1sD
 2mPyH9HHWTKviiciNvuJG+ZOspdXWCuag/WCYfJ6o0vvSJXeLiybmHnNJEOXZIWiuRlDtIFy7
 LFlqJ2Ew9OkMAS1oG9RTNe3ieH+QU08YiGReoGYz8gCbIuIa3T4l/9y39/6nx6ZvUXWyU9K1B
 y1+kalfaCieM/psWAAyzh2CZ8dqSUH64TBvrtkLzOdkNVMdJvwuasixOlTHoEudzF66RNQSxK
 OFF6LeUTPkslDTyD89pCU3Rt8F/IRGfCZMuwMQry/I9vXtLYs3o8hrhwqPmlwfkaRse+fuSzI
 2+FOs/An10x3br3aSRYazjKqjCc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.41.0(3) is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.41.0(2) (July 7th 2023)

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

This release is a hot-fix release to incorporate a new Git Credential
Manager version that addresses several issues present in the previous
verison. There are no other changes.

New Features

  * Comes with Git Credential Manager v2.2.2.

Git-2.41.0.3-64-bit.exe | d7059a66b4598384ccd7df4556ad59a516ee99a722c0d38e5de75c1bad39ba6c
Git-2.41.0.3-32-bit.exe | 61125fb15afa854fda3ab14a714635dde22ce46887fefba195fdc6f3aaa2ec7b
PortableGit-2.41.0.3-64-bit.7z.exe | 61c62a2590799bc37d88b51871abb13ff4057b2626b89d6bc11afd58888d11c6
PortableGit-2.41.0.3-32-bit.7z.exe | 49578dd063951c3c8848365461a1da473c7849ac720e681aa10e2ba499e8a64e
MinGit-2.41.0.3-64-bit.zip | b7487724fbd85dd345e7deb4c37c1d3958b139904a6981fb80ec5b31728cd0f2
MinGit-2.41.0.3-32-bit.zip | a9d7c3ae343676c57f9b55828c0137829611a4d125c042129c02b46044cf7a9b
MinGit-2.41.0.3-busybox-64-bit.zip | 5234d856484b5b945a47b28753ef8df3985df37d04d13acc6bb442187915993e
MinGit-2.41.0.3-busybox-32-bit.zip | 959e972410bdfd11500d517a19e39b1c70c18402a20251cf197d9f06d63971fc
Git-2.41.0.3-64-bit.tar.bz2 | dc8d8773d80dfe904d74a555c77de4a09124f1dfde7a1c6ec6320afa193425df
Git-2.41.0.3-32-bit.tar.bz2 | 04ef81e2201fee72e7f606622dfa888173b5e6ee15abb3c1eb68e43bd973d63a

Ciao,
Johannes
