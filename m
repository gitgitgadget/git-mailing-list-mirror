Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E330CC76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 15:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjDCPKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjDCPKL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 11:10:11 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A12E62
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680534603; i=johannes.schindelin@gmx.de;
        bh=5eQGoIpTXyPLHanMThVzoSPbObk59ynMdEgarsP+gPg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NgPb0sQ8FNIylNI1sH/Z4Bkg9apd5uv8PcEVM5TNv0+8nJZhRVCXWRLd9sxKm0Cu6
         KL1HUOa5PhGx7x7wx4ruz24dQqmm9wTWQZRRwKtWSLdLaMEiH82lX9T1c729GAHn1i
         CZN7BwMiQGOJT8criOXLGKogRtlJiD4Kze2w/vOPloS48YPUWa3ERCjy/OsMIFL04k
         UQiOWqgMe+NjUmGLlUF0jWuRfu2yW5+DTVAElHYty+vKRk2QRLuUv3STAGx0vB7uTr
         Ivcjmq3X7jfFHZglyQfyIr90M87p049VCJeI3c3ESR+ma9IqO7eLY/6sva1FlIIkCR
         fafGA6joeSVSQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsUC-1paW8B018i-008qQ5; Mon, 03
 Apr 2023 17:10:03 +0200
Date:   Mon, 3 Apr 2023 17:10:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Richard Spano <richard.spano@live.com>
cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: System Environmental Variables being wiped on update
In-Reply-To: <AS2PR03MB919368C4FB4C7F94255D2CEA89869@AS2PR03MB9193.eurprd03.prod.outlook.com>
Message-ID: <7aeccfbc-a6d1-8fc4-339f-562c53d1c133@gmx.de>
References: <AS2PR03MB919368C4FB4C7F94255D2CEA89869@AS2PR03MB9193.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-436107597-1680534603=:26978"
X-Provags-ID: V03:K1:C11qfSvG6cdYm3kxCeFH9JbbPyttHIJHx4wqzBetrw/R/UKLNcM
 EgPW29eAEXzmypZGIifXJu22RyaEqSkn0H75A8tacOMiJ0h1dtFxEizvuiYWZTkTo+b/SUD
 ayevuhkq9aSHJiQcez/CD/CDhtnP/Yc9DCYYhZi0pAEoMKiJHUfUZHGhvWJvvq3vm+/Hq2M
 ngIbq135BvdJoty6VN9EQ==
UI-OutboundReport: notjunk:1;M01:P0:LodovEqnRZI=;7wOifMzzZrroqfEfCGW+fgSM9w0
 pAC27YRwVZWg9ooZnbSmbmeT04pM3+lpp9XWRPmsxRVmGIK1vMaPsz8k3iMEpjuql4hvq48ql
 avVW92H9UooYTQ8WeKESIj/139bK7QQaCwK6+8VXGKk0mj4xOVb73LN4/4x3fddo+nhFzp8MR
 vei8N4cgPYuPWI3cSzE3wJdnKaFg6R0efWZrHUrXJM7aFOmOLJskbO4+2Y5eZO93kI7gUhj0B
 rGUlba/y4TtQsXWgn0K/VMGPC3b3E9abBGevq04pm8EjmdDvyM1o9ZHT0K3hqqHFNcVFApd3J
 88wSEB+TE4QloMz25Wzcgnm2HE5NczoJ4ZTgRDvXmzPXE0kvkq5XbHxaY/6I82QxpwOsF3lgU
 /ZiSJMsAwMmM4qfyaIOSY4kYGD+TA16pNIqzWvDiXWV+jkWo4Vhj3/r+/3HYuichCyc5dTDWY
 jC4aPwQDSue50hTOTXfCR4b36/KogC5Jagjeb7jZD3oHpXX/vxndW1av2Z1Zs3DWGgPj4W3gb
 RzF5RJNv8X6U1qc98cmOG3XNMC89NLpAxpuYAesM13585XqoRGdOaP+m2W4+57ShJnpVfEDzz
 ocQdqYHv4S4pkWPnF8F23g6QCxxH0BWwywlAljA3meUWd72b9hV0S/kpAmHel3WXxW3AJnu5A
 +2XZ1dhXsQostaLz0QHzic3TM9+/p1DSkKKXI2/mWVM0XNpDSb71pJwMA8CP8KRbjbmjF9KIQ
 XHGD9a0zyDNJ5a7Sprc0Xo4Eip2b3tTXzijcf7HThYO+FhcoPq+MKiL/BZTciMT7Q2KEki+mQ
 s/H6vRNTWXXT4IXEhchICulEMfO6ls82GpMzsnNaEsJD368IZlJ7ITJYIUVTI0mv8KOL61xp4
 usUkN9XJ4pgFxgcX64kMCG3LQ7TXJ2U90smaO/s2StEzJqRIBGhzTeNQSeJA/0pkMaWIjjQPu
 YZjoW8mJu5T0kkjxZeZ49oL66CM=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-436107597-1680534603=:26978
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On Wed, 22 Mar 2023, Richard Spano wrote:

> We have GIT installed on machine and we have =E2=80=9CC:\Program
> Files\Git\usr\bin\=E2=80=9D added to the PATH system variable (windows).=
 When
> updating GIT this addition to the PATH variable is wiped. If this is not
> noticed then we have issues with GIT until we manually re-add this in.
>
> Is there a way to stop these variables being removed during a GIT update=
?

The Git for Windows-specific part of the `PATH` is considered to be
"owned" by Git for Windows. This is required to allow for future changes
similar to the ones when we moved Git for Windows from MSys to MSYS2,
where the paths changed that needed to be added.

However, I have good news for you: if you _want_ `usr\bin` to be added to
the `PATH`, you only need to select the 3rd option on the "Adjusting your
PATH environment" page of the installer.

You might want to review the implications, though.

Ciao,
Johannes

--8323328-436107597-1680534603=:26978--
