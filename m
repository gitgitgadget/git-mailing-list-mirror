Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0290D1F4C1
	for <e@80x24.org>; Thu, 31 Oct 2019 11:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfJaL2S (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 07:28:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:36727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbfJaL2R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 07:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572521290;
        bh=GyUuD0YTj9mgThpMMcrIHDTWgcN7XjtmMG6Dhv0mxq4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XZB+JiSDHiHbmDQ2p36mmtUAu2oWZ9VmQySDPYKRGhh0jZoWjaM9O3YptC+nFV3p8
         OLqHfU1raQHLlzG0vy94uMwhutfUu2HGhUzxRKrtia5FjgwLpSIuewGagT/m08CiV1
         3mvvdZPO05ugpK4nEr/+FfAnPG3Rd5EYxbrX0jvU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCOE-1ieNgs2FHA-00N9pC; Thu, 31
 Oct 2019 12:28:10 +0100
Date:   Thu, 31 Oct 2019 12:27:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
cc:     Junio C Hamano <gitster@pobox.com>,
        git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: Git for Windows v2.24.0-rc2, was Re: [ANNOUNCE] Git
 v2.24.0-rc2
In-Reply-To: <1223720779.572910.1572520655053@ox.hosteurope.de>
Message-ID: <nycvar.QRO.7.76.6.1910311225380.46@tvgsbejvaqbjf.bet>
References: <xmqqblty3dtx.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910302317430.46@tvgsbejvaqbjf.bet> <1223720779.572910.1572520655053@ox.hosteurope.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XLT9XKedy/xr6NT5H9I9ALHLef+IX7ysMuLgQNJuBF9kdqX4R55
 XryInW4XrPI+Q4Oj16sQA+GYrk6Lp4FfzzW+EhrPP7jahSsMY6Y7LTxJ5292z6jxfVIEcIO
 EXQHYKTMD7Wi+uAZrV+/q8zJ6BCdGEGY5czqQlpMNIJ4C+A5b8e+PziUdpxmSzM/9pCHKAU
 W4ktgRJ9WO64EAsIJ1lFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EHUkaJ9zBos=:qXHYajrkEC26mATz9Ng6KJ
 zcF8BSVILvDBpDKcg+JC1pSVeWWncHpC17gs6JNPU7tVxVDT/G6Us8wXp0sK2PGnyXJ4weTym
 kOGVdKEIQnU7MAPr6ETD7R4WJhBOYCtoiENMq75lQThC+Y65LZaZjFLk5mUf4yN6thiwEmTs0
 2uUOo3N3V1i2rR4XX8/yEUKLUNFIL8J24sfrjK0RSggT9HyyvoU6gLztQUVc8KkMU/HjsU75e
 YX89idce0eIaqdmHlBMX5P0/gEatzfA7oeDIF8qMAYVFHHdcG2u49Cc9v44sD2QwcbmjYDet+
 w+hrKX3iFc89vfiv2ewdLTVz+jLhEnNGYcqszVbmOsAjC3Jqx5WwHIPOpJnk47dm0pSdQwzfv
 +9JmJSYMiPIJt/r1+Ytbwn6YaEZY2Pj3M0Kmzm2esH6kvnHrxNwciItAdR+3odXXH3YlGR3n3
 53uwl8fOXyaRT0z4M676SmAd4SznaZiXJULxRZYWgHC7tjZ0lxPSSKxVSjPe4vIdVuwyX24ye
 qsmsGM3jbbB9BepH8SdVKW8uQVqJdjoriPP4EOykUWCGfRdvXJ7UYt2RqOG0qAc4eJ1oEWtgz
 liikY/leQGwBOAT6HKs6/TqeK00uofcpupUrMFv1T3omC9gSlzC6ColOOCrtB9nM46Nkh/PQ1
 bzu/AEm6uiCHMptt+KuDUrvzp1a/P7rQAlpanh82bU3qrVz8bnkc7hOChnKrL1Lm/Pih/QY+5
 NlvXtHRU12GyRWTE/K9n8I6aUNkqEHGV94uzZv18xwoKiZsFKCGu190sl1okNEi3up+O5pVtZ
 uhJ8UJ1vP+dZv7w3uv8hcidSCD+LNHYJVEl8M4j24Gq8nP6Zc5hp2DUXEL78jGasIFShM74Fw
 fdFEhL0eadsYYM+G5U//ejQ9CvaJVKLoXdpQGTuvSSnIqof6UdTgd7hD5WcHblRnkqc8XVdt0
 adsRWZIisfd1AScCVts+wq0DDnIkQo5kMT5+jXgtxr20gyq4jOkWB4FFuZbrSQZfnwIT90y7F
 4WgD4Mh41gOsWWFsrkEOJFaz4lCsDD7ylwIQwzPiba/q+F8Vv2JV78pJJztJpsTgEKH17fqJ9
 8t26fgOowrwJ1KYeUZ/+nOqF+YCbhIOsKPUVKVm1MtMOtp+Jb/GwQqlDRz7YLu2bH1C8QJ19T
 iZ8crEurLqzpedxitB8Ra8Rvqaok03e50pnUorkTTf1jpgRozm6NLezekqyp+YXWIOEzAfRK1
 UKOR5o4+iG3d1JNXY0McDQRvlipGh47LDc9r7j4ox0vGZnjjydC3efznbcQg=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Thu, 31 Oct 2019, Thomas Braun wrote:

> > Johannes Schindelin <Johannes.Schindelin@gmx.de> hat am 30. Oktober 20=
19 um 23:23 geschrieben:
>
> > - The `sendpack.sideband` config setting was re-introduced (I had
> >   dropped this by mistake, thinking that it was no longer necessary
> >   because the commit message failed to mention that this config settin=
g
> >   is necessary to work around issues when pushing via `git://`).
>
> I do realize that my understanding of git is now much better than it
> was 5 years ago when I submitted that patch. The commit message says
> "dump git protocol" but actually wanted to say "git://".
>
> Thanks for reintroducing it.

Thank you for your original contribution, and thanks to Oliver Schneider
for reintroducing it!

Now, if we only could make those `git daemon` tests to run on Windows...
it should not be _all_ that hard, see
https://github.com/git-for-windows/git/pull/2375#issuecomment-546744192...

Ciao,
Dscho
