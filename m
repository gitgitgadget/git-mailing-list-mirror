Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97391C34056
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647AC2064C
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 18:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jxZaPR4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgBSSxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:53:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:32811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBSSxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 13:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582138412;
        bh=Vx+CduZaYqtsibQfATMEQ4CSFnlK/IEqcGwniy6QzF0=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=jxZaPR4Rzpi7IexrdYxKhzicUrO3I9pCzPLHfgShg7Dc71x1k4VRAtXNWGIv6bECt
         otrzMduRzYyD0u64sYZjHZi6hO8OAtr5OInavuVGSDhoaRzjqbRcLLZohZ/yqU+tcY
         MmuVSPGmnJUCf/96sGYo371oxxaWpKkouM0Ku9vs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from fv-az767.0o1ik3tpy2tupi0xpbgwdxt1ze.bx.internal.cloudapp.net
 ([13.92.211.228]) by mail.gmx.com (mrgmx105 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 1MUXtY-1ivnJM11E0-00QVS6; Wed, 19 Feb 2020 19:53:32 +0100
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git for Windows 2.25.1
Date:   Wed, 19 Feb 2020 18:53:29 +0000
Message-Id: <20200219185329.6640-1-johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.25.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Fcc:    Sent
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m1FQs8OKgsoBIsvN8jjrbDKdZXYlc5jpCOW+7MiDKybq/WaoPj0
 WhwGs9zOFv+xZdL9YyobeaDm+KmhEOWUOebtYOnuK1WnvFFhf4mNgKB32ajLVVgPevlwZcy
 IbFWoBrHoZ8EB3gFB12SOgy0h+NkaYnGjZ6dNsZKvKMcaEsVL5X+fEPAOsrSzVL5LffQqU8
 bYPsxFcCePXLttSJ1VH0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C8xWA4tVvJc=:EMR2drM8eE3nsxsGiKgkV7
 JS4LR+Vd4+T08Ck+m8+aQElsBhTiuV+W71JGb6+XtpGfQD9ka7iPptjrR4ai/0KDQC6E4i0+v
 +fYxwbXa2k8LJYK1/ToLoN0H2p1T74LXD7hgEGK7yhz/qzmDyKSqJy3Mwlsa+ecBwZ4hEpVrG
 LLz/i8zqmoqSZheeTTdV7ybM2sePtw8NBeK2/N99cp9BP9wye9sVvD0eSkT86IMYAdzaNmlCD
 skmqopLisR5kd8JHkavn9pcPCpiVIzun/SGuzfmzH8sUcEyYYhmTE3Wmq8ZNMTkQbQODfqqwp
 bG3USbdgL74PBlPRlIGAyGA0RhU1Suts0Gjhc0jH4qdVjoNqm7cvWUm9xHqnB2zw5effcS+rw
 XiiXN6RscCwdvTt3N2s0rYoAhO4kKEKofj/sHip+Q2i9wfyis2zpO3B6NrWaq52KvZdTNOo+J
 0ET6qN7ME0iZoBsWs5+eYhX2pPBuicTkWsDRCt8SCKgc6xVSA6bCPGqITHsDImU//ieKr5Qon
 yGH14mK/Kfc0r3NTDYaxOqZ7zrXK1oqQqY1KXynFH7ujr6Tk9KObsxLh1/MWveWS3fh5/PZRd
 um4Oh3r23EqT+xqSW2+kT/9V4ZAplrBbz10U2zW8NfBcCm1cjh29N0+muse6mxHXUUEuPjcLb
 AiHyfIunx7D2FL1/Qv8To7QatGFevLfGJxg8s6lVU37c4VtpuwfIgUNCUIwRYUcRY6+bjms8b
 DADf3x4QdEinNT3gjVrJnexAOLmy5Xjpg9MBUiNCzEgEa9VIMZSYeMJbWrfVbcjgyr6Jqo/Cb
 eR0UX2Bt1jlXmsJc6TD2BLYADRSI4AkWLWc95A0N5p/tDRnHh6KZmWZx4u6IS/IwmerINmi02
 aopj/SIrpndl+XZKMnqERdXXPLw8IVACowoDoTKt6UDJaARK/8g4cEGgCeS9iHdwkYjBcnPzZ
 DQOgW+V3y3XYg1lCibQUjzsxtayDForo7ApLE504BXroxkMll9fK52D4fqucrAVKu9GYDYnWO
 +7OyzrEvtazu3lMPi1elDndmNgOpXcaWztafYw2k//zMgTaams7w6tHBKo3JUII6pc4ek2ny4
 qExXQkvTanKytTHwdE2I2c9BD8vdG5d5AJOsoFqeA7tHhn73RBdURMZDS3vNMeVUu6HMvTnPS
 xwx2YxMODdWFW94F4KDzF2awAFNt6X7KPL6pGbMxl+0oUB5rLe4nJRa+8FqgPjoLBWCqf43e/
 wau9OOfjEMnwZ8HYe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From:

Dear Git users,

It is my pleasure to announce that Git for Windows 2.25.1 is available fro=
m:

	https://gitforwindows.org/



Git-2.25.1-64-bit.exe | 9e442131f7dc0de24db1369a4fe02659c2d642bf60ce6d88e3=
1340eedaa18da1
Git-2.25.1-32-bit.exe | 4408525b8b314f2ec8cf8f3c00e8bae27cb4071790af23908e=
6c908a7d48e5e1
PortableGit-2.25.1-64-bit.7z.exe | a3f594440431bddbbc434afc88b8acef286c34d=
caa20c150a884e274e8696b36
PortableGit-2.25.1-32-bit.7z.exe | 9054e283465ca1153043bae4cf515782b3e0a3b=
d95c28bfb20f66de3922da1d0
MinGit-2.25.1-64-bit.zip | f59da958ee779ef1454e4d0cb24cb51278049c578c4e6d0=
1ba9e1b6f61dfcb1a
MinGit-2.25.1-32-bit.zip | 91ae315d7f5ceedbdba5644521c65b9889027877a096589=
1da988707917ad9d5
MinGit-2.25.1-busybox-64-bit.zip | 602389feca195968935c61482e977072f226c7d=
e0b3fac98923622fe706f1175
MinGit-2.25.1-busybox-32-bit.zip | 18888012944e6239783d66db101fad402fd907d=
29980a020bbd32dfa959173ed
Git-2.25.1-64-bit.tar.bz2 | dfab87d6bcaa54e179544d7a343c7e4f5b45604573de31=
203542e87899962c1b
Git-2.25.1-32-bit.tar.bz2 | 6e1a06b5a8d7e47eeaf3228333bf1c1b834ec6dca0fad6=
1434783f2ad2c9da46

Ciao,

