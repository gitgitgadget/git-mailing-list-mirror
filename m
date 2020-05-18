Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DATE_IN_PAST_12_24,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9DFC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBE6207FB
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OTvhBtdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgERTKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 15:10:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:38891 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgERTKv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 15:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589829040;
        bh=0dETPHcCCnEYmkEhv/KydCG1e/hlu6Da4tQYo+FinjU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OTvhBtdA1LfS3SgJQztCQbi2Ngh0o6SNN6BGqgyldNoxn1O5QbbcIOxJUXo8XVFZa
         U4dTg0kQxco52pvAmB3Rl1iUm/Ehf6A5+q6gWk1msNeEpLgNp4lm78h9kvStHcXkIp
         amCPkytFlyKfPeck/Ugmc2qybpm0bC1acfWSVlNU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.131.160] ([213.196.212.243]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mnps0-1jGHdl3Md8-00pMJP; Mon, 18
 May 2020 21:10:39 +0200
Date:   Mon, 18 May 2020 05:04:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Mark Waite <mark.earl.waite@gmail.com>
cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        git-packagers@googlegroups.com
Subject: Re: [git-for-windows] Re: [ANNOUNCE] Git for Windows 2.27.0-rc0
In-Reply-To: <CAO49JtG16UROGn2yYCTrwdQHfSz819_PMfyEit8Gwzh9G6Oyow@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005180504260.55@tvgsbejvaqbjf.bet>
References: <20200515173242.6154-1-johannes.schindelin@gmx.de> <CAGyf7-HbnCip8WZ9vtc_KW1kXMBUoPZQ8GD7H=1DOAk45Wbjxw@mail.gmail.com> <nycvar.QRO.7.76.6.2005161044580.55@tvgsbejvaqbjf.bet> <CAGyf7-Fkn2uHLCqM-4qfM0YQAXoMgiMwKEaxkGkOtz=pYYKQWg@mail.gmail.com>
 <CAO49JtG16UROGn2yYCTrwdQHfSz819_PMfyEit8Gwzh9G6Oyow@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fYjzVwlncrhOnLHvLXOtFQmthDwzeExmFkwqgAnOu/MqcfDbBeF
 Pq8TAyTmyYgxMR0BNhx4yEevLGe5C8m0uCUlUaLRfHaw3vWjsA0iZvcEYJ/eP4FhJAYLC3G
 nkQS9wTFGz14TSDi3/YFrXijM6tVhEtqr306BIQUmRWk2tMxDSzcrqJPNF7uH2QSlXFxKsD
 gI506k4R+cMHMD3O6Sf3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W2sIVLM9q2U=:cse2mntxZKBLxpTet03dsZ
 mFIoFgGBdHEMNpX6FmKVC9Au+TSaHSNTi2BEMkUtUXkznhsQ5q6+kAZ5bhRglm9fA3jK+4osq
 +2UWwUu2x0/QS/L9rx4+wB2givqXFLzlQ2FXimj2bzK7pNV8G2LEG/LCPn0DxLaf8eBygbAMZ
 Dqof0s2w2vb6ijlgcR/zG1JKxOYItwpdFyYRbW8vOiV6cYwMVgPGqSZDewgF//oDTRicZY5YF
 widfoXhSzsxXAveHWtJbXB2f1qmWBdaowvJSv8p8oJxY+yRRrPzNePnCkt0r2CiAORE4/dMcb
 2f0Pwyrg7DV/6+1IeSU9w9nVCAY3V/oKL+y2M5TWP/ZztBZGAEWEiHTx7GRvuHG79MRvzUneE
 MQbjsoJbkMNoT9PT0sn9Ga5lfzMWRUY+97aTErJq5zdTHvgl2YzamIxdko+x6OTzxKP66njiV
 R6VvQS9chSib7O7gOrz3F8cgtnExaKjMDrUos7mJ34x9ix4HvcDItcOF30ZJZX+P9zZk2/rGI
 nWIgmyIDbVkgqfM0gA7baoIGNoXZJw31/vnAx/H7cVmJgloGcZCs9HXNWMjPVYP2CF9yfAgL5
 nGXz+/qHvxDxBtNm093GehI8aMIDogw8SlYF/It0RT70LXtej0eOU5SMVr9yTBsKdCpFzgWxq
 WECXNiIqjBuMw7+KTVvJ1lgQkpL6q4aLoBVDiwPfnEfgCMKQpmKNR1quJkzk2uqlFBFS/0wn+
 S6ZLFYQ/NYFlC95LA0ux9I85UpDijuK5OsYptDVVWxzV8ftStvpCsginFPL4N/tz7wNZAfX4G
 EKBaz0GWSmsPuh1uX3YiiSXFQaUowCy81Bh2KhckdBIbQ44duTIHY6UITgvbArziXr2jjTGJF
 aFPHDashaxe4ua7+TIqFsBvjdkjDLfGTej/rt7SCPaI7Cn4tmoRAV40SCQrP59bFf06OqOM74
 tojecneYwJMdxgOdDecNlcEGBhQjd7fEQFP+cHsHhp/1GAO5TwNfEZUmRBF/XZOJ7SIh/WSo9
 o5JXboCGg331OJNCRxNsFiUO2Gb2jDUgJK21WGUEUkHUS5UjMnj32B4nza0CGrX2G9j15FY+N
 h1qElq+cIfmCqCqpCoFeAiD0suGjTWzI6ghHbMHEAgtCG0XACP+Hv1D4KzvOeZUQnz4yAr9de
 6o4cgesPmIxn8Zs827g5zVwccRp5TZJtcu+ZKnez5qskYGT7PuBveZao1kqGteOjM1E9ofUuR
 yZBkSSnEaXzOuOTMK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mark,

On Sun, 17 May 2020, Mark Waite wrote:

> I've installed 2.27.0-rc on my full-time Windows computer and have deployed
> it into the Jenkins cluster that I use to test the Jenkins git client
> plugin and Jenkins git plugin.  No issues detected to date.

Wonderful!

Thank you for testing,
Dscho
