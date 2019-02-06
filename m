Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B269B1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 11:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfBFLd2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 06:33:28 -0500
Received: from mout.gmx.net ([212.227.17.20]:58951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfBFLd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 06:33:28 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2Glc-1h9pmJ1wSS-00s2vJ; Wed, 06
 Feb 2019 12:33:23 +0100
Date:   Wed, 6 Feb 2019 12:33:22 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: make the OSX build jobs' 'brew update' more
 quiet
In-Reply-To: <xmqq4l9it946.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902061233030.41@tvgsbejvaqbjf.bet>
References: <20190202163421.19686-1-szeder.dev@gmail.com> <xmqqk1ifv296.fsf@gitster-ct.c.googlers.com> <20190204193823.GA4511@szeder.dev> <nycvar.QRO.7.76.6.1902051240080.41@tvgsbejvaqbjf.bet> <xmqq4l9it946.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1970004203-1549452803=:41"
X-Provags-ID: V03:K1:O6rfMFlJJazACKOYlaOWMsnOBBQkGFNF8Xv5D9nlnieEkJwyUGX
 i3Y7HC8rjEW8ZaAugx5DeRDZbXFwC4LxOSK0nUYuHHMMVunfEktWPzOaJuGTKGYq9VvCx/R
 a5bB7VLRosmwRUBeD5k2ty0Sp+YurLKRL/XM5tbdOB/h6MzsNPHRAUJqhOHvHeyhn0wZ4oP
 cyfgK7+fHEzOByMYBQdlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2dN0cMgfMss=:gYisb6k/Q7Vjh6lDKwPgvM
 6RFfh6uvc4ehLUgzht/d9ojyleHtKBoP7rkgFBTD8jSd0mm6LKSwU22itzQrbALD7cs+eZyb0
 iB2oodyK3gXEg0gP3xUScpGuc22rPfFxnJCAyvucn1wy6yMnyGRiuA1EBM9gXkxiE4lXB9qQJ
 7mEQeQAPlyqm+XS0jC1qZFnMnZwhul7upAVOAS4lfIwiy+06WZu9NGm0wdt44SEyA7G004tTS
 6S/2nZ4g1LNA1EH7I1646c06UL6FawHFaqhcNLCSKikEjTV2SDO7FjqHsF8qV/kGPP31ljRHs
 cgcC++Q7Kh/SJUJrmRzohlJ5vaD1QHlkEOkqbu0SzduE2vX4isR5HQBvO96vQ8Wn3MFis+O1t
 a2N/4eo/vyAHw3ZMLCHu6SPKuk8FBVt5rYH9pDruOf+U76Th5EDWC1ZFJqPvn+617cCdzokXO
 UdiFQ3P+VpZVaeYhDml+CSwoTg9GUsApSBVcZ5c1X2LyGuKGx7zPsrMDP28/hyJOI//+cXG1L
 Hb6R3aILjNB1U8oRMUJDRHv0mtxM4Q9gWqoEKCX33jyoNbokYoOpSZvrNWGDUyi3EbH6BoRjx
 rvlKG5ObbVkNTP1SpdkRGIEWGqu1eFfvcg3InbrKDgoYgc+sXA/w3wGjhF0OyrFi6egNNVDIt
 DurzGUAA3gS+Y+dzqC2hT7KPlBZWiKRvjZ2Vr0D/9GsO1ngunNZuf1+NEVvdbsn8DcQHEvAvn
 k2K7gUUuizOIiBXPefPW6D5cGtUZkG6SjTpucyE5jF+PApvx88M/bS9PqSUH7fR/NquKTDtiQ
 ZdcdMHs8kVMg5ipkm0VO6Z8JUtXxVWNEl/x66ScSjPB5nVu+eMs4NBToZ3WEbQ5/lmzQUSmqg
 czKKF8heAL6aWVgahYQoI9fCRzeXKPl4xTc2OINiLm8W0VZpVtRQMTgC/QMOmrUs5IHhAW2cY
 MQ7JlqoNJGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1970004203-1549452803=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Junio,

On Tue, 5 Feb 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 4 Feb 2019, SZEDER Gábor wrote:
> >
> >> Under Dscho's bugreport it looks like they already merged a one-liner
> >> fix, but how long will it take to tickle down to Travis CI, I have no
> >> idea.
> >
> > Since the fix affected a Homebrew package, it was not so much about
> > trickling down to Travis, but about trickling down into the public
> > Homebrew repositories. And it seems that that trickling is complete now.
> 
> Good news.  Thanks both for reporting and monitoring.
> 
> I still think the >/dev/null thing is a good idea, so unless I hear
> otherwise, let's merge it down to 'next', etc.

Yes, it is a very good idea.

Ciao,
Dscho
--8323328-1970004203-1549452803=:41--
