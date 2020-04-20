Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD559C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C5620672
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 19:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fGB4E8Cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgDTTIm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:08:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:35193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgDTTIm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 15:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587409720;
        bh=h8na02Kz4l1+TrvxPc7Ng0oJUToLLmSI/pRKnx0f9mc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fGB4E8CjSvkrRW7KUQcd9DhpWL+20pacqiSzIuql7cE+EEzJKek9N4MzXq+5wPK86
         kovRzX9NbNSO5ODB8rBOBkClfOVSgkc+ffdqVFl7K03MvT2xkS3jeQP9zKu2WJhtqD
         T/75FxaOhzSmcarKHMBUL1ccZrOi98Aaj4OgA/IM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az722.zh1rlp1g2pfu1fs5rtqzlakola.parx.internal.cloudapp.net
 ([52.143.159.47]) by mail.gmx.com (mrgmx005 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 1MO9zH-1jbFq51aif-00OVUP; Mon, 20 Apr 2020 21:08:40 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [ANNOUNCE] Git for Windows 2.26.2
Date:   Mon, 20 Apr 2020 19:08:39 +0000
Message-Id: <20200420190839.9624-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.26.1
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
X-Provags-ID: V03:K1:Z+KjdqgU6oZRuyblhq1WgyguF8RSIEDR3iJZWV4b8cm1iNxZkDL
 X2wSzetz7sXmVqK8ZtPurFLcXv3Ggbx87NnqyRVGKENHcK7L+pikaCXLczu1H/tR4JpCeI/
 LovcYo8C+5ZM4lyevV1Naso/pKCDDBbhOKkvW/kFnj0m6EYSl5L8rrL+UrP8jUmfZCCDyzx
 bXwLMgvFNw6rVLyZbXjYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LPyzZrex4yY=:AYOyTgnVmfuSKqE8MxjKR5
 fEkxn++EIli/l8IRt4MoDtc3ZCdyb/grQ21GzznGhZK4LUD7ndu35EERFt3M7n5EJUg0iv5QV
 zXnZZxCpE6UU7RVCCwKP62+g/ah41z4lhO6XMlpjNc/aSR9bgz1xYoYcpM5rj2g+jMTVL/l/A
 AF7kWOFIcwQpB6z0rGADcVhmuA2Usv7ZinvDJdneuMM6uNVcwD7EI//Zv0HxaHCgEXiCipUDy
 Oe/zUhcUGqIO+TIR9zdXuGfA3VEZCnNNnTvI1KzZ5rifPJ/CH5yyYNbE2Jdm7sV86ZpIwcuxN
 USMurRKAbqFKom8lx9rOqthfHMjnapOZEYfIco2r54HvzCt9Eqba1pKPlfvx4J5MQGcGcmJ8W
 l6pgt8mFDGYtVK8COCyJudHm+rw9QkEUG+MPDvRvdzLVcf+s503Kks69v9btj13k6eyCPzzWE
 5Q2cqu93XbK6CW9R6a7fbZ/fgs6cBZcUapg6tQbl5sRHELAota/VHYOQDGGQK44lH4o9MDSHr
 NG70ajppNR/TZkqKxU3CaoCpwycx3/6yHBVssjIAzZBARVgLEt3l6XRHX5/XK5XKWyp0CMviy
 dHo0qnklMJBD2vrkMQCh/cjU2jDM7+rXR/6U/KmSoOvRjsGc4gEScYHhyNTfzKavL/VVzIhVR
 7wRDdr9aJ8j65JqwFYb+FP5YuG4UQF50t8cSiaDYwQ5r5dEJvRQpparMb4kVc9gFvDdxp0jSs
 SKZTKALyoFA+zj0NLK5gEoat3kI6+oMSktmBIaJ2Lr3TfeHgqwZ6jFIWzxoHG+ugIYKr6S/3e
 CvU8DchgFFSH3WU8cnrQrFGssJjs1a41IIpIuPlNonokI1gCE67buzidDeWK1jZEViWpreO5G
 kOJJc8Fije5f/s4g6MLe8Gp4DWuyP2lylt+Q0Y9FaHleW0yFVi9oD0ZwKxSJ91dq4vMBa+22e
 rkhMxDhoFLLEnZUGvWyxLF7/v31l79nyeucDyKuQQlvSxHxV4zMw1U5Psmo4daqlIIRAtL35X
 d5NRIOWn0N5uJP/NwUxy9SrkvzfrVybLLBmaf9gqDjjIL0rh51S8Us4tnp+Haq5wqxErJBaqW
 jP2frRZHLzPRMenmLr4nw6EYD8K3aJXYkXrrP0B2b5T8V9HFEVcZgp+SNcJY10oTOZU/5CBht
 3attbdLeT+O3U5tgvUUhxp8dKMH4hI8di7V9IXVuE3chwvvufECTTdZFFVzu66rzalRYgNPU7
 HuSup2AgWzRO9L4bC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git users,

I hereby announce that Git for Windows 2.26.2 is available from:

    https://gitforwindows.org/

Changes since Git for Windows v2.26.1 (April 9th 2020)

Yet another security fix release: With a crafted URL that contains a
newline or empty host, or lacks a scheme, the credential helper
machinery can be fooled into providing credential information that is
not appropriate for the protocol in use and host being contacted
(CVE-2020-11008).

New Features

  * Comes with Git v2.26.2.
  * Comes with tig v2.5.1.
  * Worktree updates (e.g. git checkout, git reset --hard) got a
    performance boost in sparse checkouts.

Bug Fixes

  * A recent regression in gitk that prevented it from running in bare
    repositories has been fixed.

Git-2.26.2-64-bit.exe | cdf76510979dace4d3f5368e2f55d4289c405e249399e7ed09049765489da6e8
Git-2.26.2-32-bit.exe | a7e470e7267d7ceaa94f8c5b0beafc86abf3c7fea66673e961ea48668b8e0b6c
PortableGit-2.26.2-64-bit.7z.exe | dd36f76a815b993165e67ad3cbc8f5b2976e5757a0c808a4a92fb72d1000e1c8
PortableGit-2.26.2-32-bit.7z.exe | e18f75db932ab314263c5f7fca7a9d638df3539629dbf5248a4089beb4e03685
MinGit-2.26.2-64-bit.zip | 2dfbb1c46547c70179442a92b8593d592292b8bce2fd02ac4e0051a8072dde8f
MinGit-2.26.2-32-bit.zip | d4953a8144eec84d210de48128cda4de4dd359e4112ab3086dda971b85aefb8e
MinGit-2.26.2-busybox-64-bit.zip | e834ea73fe093fb180dc45f67a1f2a7a566dab53d1d45bc3cd150106f5c40520
MinGit-2.26.2-busybox-32-bit.zip | 09856289d5dbd445e1e109fea8be85b3bac01ae31f79bef182568061ca880120
Git-2.26.2-64-bit.tar.bz2 | 7fdc729a332981857a97092ee4b248c69ec9e1728f5b6c432afe79466adfd7da
Git-2.26.2-32-bit.tar.bz2 | b48020961ba580d6f9a484f79d5e7e33ad532474fbf3ff69ac9b2be41f69105e

Ciao,
Johannes
