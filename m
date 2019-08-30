Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 942BC1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 20:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfH3UM4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 16:12:56 -0400
Received: from mout.gmx.net ([212.227.15.15]:32929 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbfH3UM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 16:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567195964;
        bh=hH/crYdIijDMotQG48Oa/ZgpJ2e1T768onVYxjyFUR0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=R+lmjUJFHtOGmjiRIROHXtks398JRKQicP2RTYQxtahSY8WTRX8hyS7ey05PM2kEK
         BU+cVv1NOUvmMrbLe6U9Wtj4HMrAMq6f/cDZBCPmV4jOEKuvAU638MFOmUa/wiGSA1
         Fy/ruZPSFJasjpfPWzUvAuaNqc2BjieLWLa/tl0E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybGh-1iONVe3Ldl-00z2SK; Fri, 30
 Aug 2019 22:12:43 +0200
Date:   Fri, 30 Aug 2019 22:12:41 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>,
        Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH] [PoC] A simpler find_unique_prefixes() implementation
In-Reply-To: <20190828163419.30620-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908302209220.46@tvgsbejvaqbjf.bet>
References: <20190828163045.GF8571@szeder.dev> <20190828163419.30620-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-699572846-1567195963=:46"
X-Provags-ID: V03:K1:lyqUDenSn1w60+6zEpNaC079AOWFvLOqxhkmM/H39tLdlDxfVRi
 pXMJAIeWM4gHA04eXL0hF4Mj29LlbA7Fb++vTDDmSrQXi5I07mugfSZPgOcgDPcMtFLWw34
 j4Pwn9MPRtU6XIOICQMAhye+fi8WRb2FOKozMWiBdhXHlHr4jJpukbG0Q0y7/b88XPVlR5v
 F8rOIP2vmY+ZVT0i/UhDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U4O6wREIreM=:he/VWkigiE6QeLbntZt2j4
 npYs3PKfFuqxTLKd7/n4cS7VXDxfGMMXdIP5IHqIURYF0/HyzMMgR2B79oXHd8zrvS2Wp5jUU
 4jnFaDWbQta9T8XY+3wqyXtr9TwE/mOWIT6JWW18dulMFu5ww2ORUlVatkr0T0D05V76azj3D
 8MH5cXDkqw0+acg4v6L8zzY3xcQaHkYobncDcEt51UmWN+gO1YOPP4wwoMC9p80kWfAxPWlvo
 NDOxu1jA51UKIgEkFfezyvh5jj1Ze4wGV7+EAnERnKaJ4sPfEWC4EL/gGiltqmYdaB1ezTUdv
 dIdth8trjBKWJFRPS5LZyd9cJk/FTIC6bWw+oosEr9jJxOlH9t9eZ2va8vo2rZvwsq6ZcquJ1
 RSEGuTtBubsmXDQC3HuWIHdkpdlwc3G40IP2SeKKKtkuKfhomlTKlKh5yK88udYyweqCPwWYd
 vlJ9azZgUkZKyW4HV36VIwE1L2q/F4mx7EL7ew6AAKCBbLOi5NSKMJQbPAiKEwqJBbbIHIxRG
 5aEBi589h26qoZxtAXWkEl6Lbto2WIz7rFuu5UCnWnEeHD2eWug15M84W5nlZgd/+EzjplQ9R
 /DPbu0ZaqlbMrgilyfqMQF2Hi4l5q6hQenCM0mrK98jJ0IfmBGkHl6qYfriz+GGS74h51/S2x
 PSFDDGjQ0eFOEj4S8cdRqIRT5U65t8hP+dwLMpOQh2y/EbaLQ55BfI863nEvF5V/sIx4rjYBF
 4ZCgSW2D8voNUaRIZTC9tnIK2aW7zAuuQ/60jQGS4Yqy531JJf0HN1KlE424aU7UmTay5osbh
 cfED2AeGFdaJOcM4KwioJLWY9YNonZJA3paDUOqKgmhQ75C9emOF4Yt7KHNkckyUFf89gji5d
 1+RbRbphQkP8ON/A5NyWZVNRJYZvfbs4eoj7OoZ0EmT+MJY/Yg96dCFmJYUWxryYCLJxOa7cf
 mXQevdgfec1sGx7av2K/13IFQTlNDqxLz8V9o/EgagzpHqOaou1Tl1SY41I/1yxjz0Cps5oIe
 Wv3db7T0SDsPYhgqddqbJCqRUvb6AsC7WdwZw62TMMctcO6Z7KRU2UKbu/AjE5LKTv3JfbYdp
 FEPcoRhRD2wMrf7nR3u+LqHnB8dHz4nSbcXlvPA3cAYw4nSPbr/FlgiUfNfZu/uDwdFo14BAg
 R3Isadn9y7nnOdy8vuF62FH/FB2KOGQ9S8rP60uA8ooxiGsCJ9bT3iDVeOuDTmiCfZon4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-699572846-1567195963=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Wed, 28 Aug 2019, SZEDER G=C3=A1bor wrote:

> Implement find_unique_prefixes() by sorting the prefix items
> lexicographically and then looking for unique prefixes in adjacent
> pairs.  It's definitely shorter than the current hashmap-based
> implementation (101 vs 149 lines), subjectively easier to follow, and
> hopefully less buggy (some of the new elements in the test trigger
> failure with the hashmap).
>
> TODO: deal multi-byte caracter sequences, make the test tool more
>       developer-friendly

Sorry for my late response, I am still trying to catch up with an
ever-growing inbox after trying to pretend to be on vacation.

Your argument is a strong one, and I will try to re-roll, folding the
functionality to find the unique prefixes into `add-interactive.c` while
trying to reuse the already-sorted list for the lookup by prefix.

As to the multi-byte UTF-8 characters: you're right, that code has a
bug. The intention was to require only single-byte characters in the
prefix, for simplicity.

Thanks,
Dscho

--8323328-699572846-1567195963=:46--
