Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89C6D1F45F
	for <e@80x24.org>; Fri, 10 May 2019 13:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfEJNuE (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 09:50:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:58831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfEJNuE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 09:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557496196;
        bh=ApzuMYqPEdmuziZ6q7WWlCJcCT5HkGrepGy3ZR/QCOI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LRpVZyfYDn2n7E7P+gjNzQNd4PvjY0s8ZaBb+rVWJYbum7g0tynRPhBdgQimk9OEy
         /dS6KyG3I5OFNDRiuBodGCtlABuz1LAWtUCE9aeksrHcoBmZSaqKngZmQ/MK0JySUR
         7+BDhbsZKNBG7SRtbHKZfjCUTFoAbsJaigIZyUMA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmlTC-1gy3620Xfq-00jtPJ; Fri, 10
 May 2019 15:49:56 +0200
Date:   Fri, 10 May 2019 15:49:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2019, #01; Thu, 9)
In-Reply-To: <6726f99a-ec27-b72f-39d7-03eecb555197@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905101549180.44@tvgsbejvaqbjf.bet>
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com> <6726f99a-ec27-b72f-39d7-03eecb555197@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Uz6qmB8hBXdeGT3Il4FjC+N96gmzDSa725XsQchNN05a71CDxNP
 mP9QrwEmNP36UJPfNsttJTAhrOcKNBnkxgHK1xOQTbPePQve6KEVftux384O4iTeQvDvxet
 9BE9qotgdUr8SjHXY4F2A/xO4zE8hFXXg+ONazxhiWLFmV+POVUWJBE9vf5xHSg+ZjfTavv
 ee7dgT4SrhDPLPzdqIUog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hKie7Z86PUc=:+rap7uNPRw0y1gD5I6N48L
 hThTyCcpTtNZ4pkJdN0fTcz0EdaQOkT9oc190WdnjUQ+CzfBr1jlhyNXSJejjUSKnUHShkgf3
 ByszxT72DAQ5Nd3oz4gNmV3CVmGnJjYXWxPP807YLDnA4CjscxQjCR07Kun1mCY5klpPr6u5R
 iWJsLkmBTOzQEuIt1B2EvifPc0D21ZuKXkRMWQRy5qxScLoPCaaIJy06mP+kZ3+iA6/Oy30T0
 7S1alsZLqRf2bhV/d3DBDO2D5HaSsWVHaGoTVs+cRVxCGDpHrah5Fry6tNlRV5Y8/vCcMrSct
 XDOUPSWO0jRDJbE1U0//s0Kyp/tc6dkEhg0X2w+Lde6HRnlR8tZ249XwI1p1+P/biCCjjad9D
 Zb7GI2kXQd/RHZbQk5UP0FMB0mcYEqE4nNOkb26uJ5k8PxsuuzOol6PF7kxyX/CnfFBZE7MvP
 fYA3ZI1Fn/91cu56q1XVkBMnyOf8Lo21I6Gb3saWVW8zyddTuxkc1o04Vq51ZV7t3gWExQ+qf
 VDdEW8OBavnK7/E1cHy/qSgcE16ZAdKfqDNpxYdUlKBpZS2mt7IlazAQiwgzEOa3DadOw2bZ0
 hb8DuCNDBXEnZkpjpHwTLz13HyQ3NJjBzUsNY+SqLn1lX43b8NqC43gd2zozQWmNTmQpq5NOB
 fmviik9m1OSGM7CTz/gxfKlDxEJCAJH+lBuCdW4wpC8qHg0KIaOPMzja8l82qATkwF+cHh5ZX
 VrUYzAOiiZrhskQT3DuFx9m7UJ/pWsZ9Ln7+iedHIce8K1u63Kym+zy2CDPuD3N2/EztM5mSY
 +nIp68NFtDnMCdi5OiXAoI0KNHgn5ZWbttKG3T1iC88enxO64pXWLHF6n5Gmu5CXmpMxFw8vm
 V51F3PPFxrnY7DY0zbldVOW8htd6OYwJv27z9Zo40XadirRuHZqQRZrN5oP/O5c1ZFVitmR+v
 OVJWnibYrCg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 9 May 2019, Phillip Wood wrote:

> On 08/05/2019 18:23, Junio C Hamano wrote:
> > * pw/rebase-abort-clean-rewritten (2019-05-08) 1 commit
> >   - rebase --abort: cleanup refs/rewritten
> >   (this branch uses pw/rebase-i-internal.)
> >
> >   "git rebase --abort" used to leave refs/rewritten/ when concluding
> >   "git rebase -r", which has been corrected.
> >
> >   Will merge to 'next'.
>
> Can you hold off on this one please, I think we should clean up
> refs/rewritten/ on --quit as well (I'm not sure I've convinced dscho abo=
ut
> that yet though [1])

You have convinced me ;-)

Thanks for your consideration,
Dscho

> Thanks
>
> Phillip
>
> [1]
> https://public-inbox.org/git/4d486504-7f64-95fb-b7eb-51d424f3e6cc@gmail.=
com/#t
>
>
