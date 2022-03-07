Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA65C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 15:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiCGPwN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 10:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiCGPwI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 10:52:08 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE5A92D26
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 07:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646668268;
        bh=fcZoZbiohSTpYBwbbglBt7VsDCjqlfxU2Pllinhxkw8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BZ0m2Foe6tSfFhwOEiEtGflDSdO0G5g9Y0J4djrCQCNpvtBYfXoxh6J0JGvkaHlNt
         F/PMsh3bTDlD6418ax43dTIUv6XsuYjSkoDsOIpfWc+lq2uRGwF7rEtjw0uFl+QGEW
         5LthfKfV2twA4cnQDf6Lf80zOGivHdlqjRpj7rXw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGyxN-1nMYnv2s9z-00E2he; Mon, 07
 Mar 2022 16:51:08 +0100
Date:   Mon, 7 Mar 2022 16:51:07 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: win+VS environment has "cut" but not "paste"?
In-Reply-To: <220304.86mti6f4ny.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203071649100.11118@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet> <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet> <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com> <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet> <xmqqv8x2dd7j.fsf@gitster.g> <xmqqee3i2mlw.fsf_-_@gitster.g> <220304.86mti6f4ny.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-841954124-1646668268=:11118"
X-Provags-ID: V03:K1:Lu20OToQ5/Qy4qH1oWlqwIDEkMYSsG8+9YTqoMi1OYStqWNheg5
 nAo8KCFzbnpCgS+ti8Rq6BLmJcAfxuDgCG5EqLbESkkblXOrrDy6CoHY5olbQMzuNSaZHop
 gnPohKKDrXhgxcyFSXRvqCyDEy5LRF5S32k4/lIZHBvBBttcSvggAgByp706kUPRfzzMl29
 +VR5suJoReXKEiXCN+S+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CS4sU9/xdFM=:qpVzqxa8pWdUWavP1YKPWm
 BY2t95BrvbRGSdPd+4ny7gsrBAxvOFKUxE1EB6KbMryALlYhFdMEMcltfAuggKuPY9bctYXAg
 DqEE8oZUetMho268E603PgsTTaiK2/8i9ZqZEbS0iJJsvTA4EtRDuxrIR1QaqnUb4bWLr1LNQ
 GP3g0KY+clvoFvD1tTwUMqvZUfWxth2e377Xu8Q7de78X75oSC9H1if7eedcRcIr/1H77TK98
 d1naDbD539zeUHAgALQmCHQjbIJ4QLgMOowTpnKfTci+g0OxgWWQnHkBT1ojnpX262qcOGhm2
 HiK7o4q+qpY4NxkSlO1VovfQ1jQcswdyXxL3OuVCc5csEbobmnJ5Whm4h6TMzaRqYS/4R4gcy
 4C2vpWAGzIRXlyatxoJMwl4rwFPa65VrY6BctM1fHrj8+2p/4WT0k4RRLvw10VLj0/X3YP1AV
 U3irRsqTXqEz3kH020QYkvmrKC/cCMcDEE9iwtl143M6Mokec6xH/4re5XMjJn32ioDSW4Z9M
 ukJgEWjP7Xh9nZRNJoS3ZjIs0iFK+WuBrwSooV8/3xOsIMdAdJaaxzBgy14WosWzyFZ/XARj+
 E7Jv9n5fdi2TDzawGrtKZrMjjIV62Bg/DuDFC7oNbz5WqMm2n/zW4BZ8Iw19TQAa/x4cOSvti
 nxZvK6CYzdZQnk/oLarlVXk+xWsfj9ny86NafKyY3XKozks/8wn8QVQ4m/xGbW8w+jU96Dw6i
 IQXZcakYAs4LObmKhQR1pBIorfzo5v3hVaBA9+RxkjpIucSl5CJTLZxFVpK3ZPWcf4mBBIFm2
 b6t+GtZ5k+DT6QdHRoCOq/DSQulW3Wu/7ukNNzZr2FKglWssGg5i5JcbK8Eb6xRJxUALc+OR9
 ngcX5bLWGPcKKPUuh5iWP0CU8Xs8/J72cS8qJQhEKcwBQ03Q7z64DISIuIka9Puc/dvs0HndM
 JIz8d2KsvYDBejRlkyO2jVvzNm1Nw/kY7ZLdEDJKnUARGdxwrwSpJIwj8xxzVYQ2u8CutefaY
 U5TJ09VZsiR4mGljlDt6zSt2a0XqQu21kNu7MNE9XNdi4cdNtEY4+QKDNwl8CId8vsIf7SQYc
 uoTJqpGhiBONeI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-841954124-1646668268=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 4 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I really don't think it's a reasonable claim to say that only "veterans"
> of git development[3] are likely to find the workflow of seeing a CI
> failure right away useful, or wanting to browse through the N different
> "job" failures without having to pre-open them, go find something else
> to do, then come back to it etc.

I said that the current output is only useful to veterans. The output that
hides the detailed log, under a separate job that is marked as
non-failing.

That's still as true as when I said it. :-)

Ciao,
Johannes

--8323328-841954124-1646668268=:11118--
