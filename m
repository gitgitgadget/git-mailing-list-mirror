Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F35209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 19:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbdFFT0c (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 15:26:32 -0400
Received: from forward2o.cmail.yandex.net ([37.9.109.243]:43558 "EHLO
        forward2o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751523AbdFFT0b (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Jun 2017 15:26:31 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Jun 2017 15:26:31 EDT
Received: from mxback7g.mail.yandex.net (mxback7g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:168])
        by forward2o.cmail.yandex.net (Yandex) with ESMTP id F183E20F31;
        Tue,  6 Jun 2017 22:16:35 +0300 (MSK)
Received: from web26j.yandex.ru (web26j.yandex.ru [5.45.198.67])
        by mxback7g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id sbXY1wcMIE-GZEi0lks;
        Tue, 06 Jun 2017 22:16:35 +0300
Received: by web26j.yandex.ru with HTTP;
        Tue, 06 Jun 2017 22:16:35 +0300
From:   Konstantin Podsvirov <konstantin@podsvirov.pro>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAGZ79kbAwqb87nOm2sG7=uOO2jE6Rkgqofy5iYuZQrg1Jc2okw@mail.gmail.com>
References: <227151496770459@web10m.yandex.ru> <CAGZ79kbAwqb87nOm2sG7=uOO2jE6Rkgqofy5iYuZQrg1Jc2okw@mail.gmail.com>
Subject: Re: [BUG] Help > About Git Gui = crash
MIME-Version: 1.0
Message-Id: <463191496776595@web26j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 06 Jun 2017 22:16:35 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

06.06.2017, 21:25, "Stefan Beller" <sbeller@google.com>:
> On Tue, Jun 6, 2017 at 10:34 AM, Konstantin Podsvirov
> <konstantin@podsvirov.pro> wrote:
>>  Reproduction:
>>  - Start git gui
>>  - Go to menu panel: Help > About Git Gui
>>
>>  Output:
>>  error: git-gui died of signal 11
>>
>>  Environment:
>>  Debian 8 jessie amd64 KDE
>
> Care to also share the output of
>
>   $ git gui --version

git-gui version 0.19.0.2.g3decb8e

>   $ git --version

git version 2.1.4

>
> as I suspect this to come from git and git-gui not working well together.

--
Regards,
Konstantin Podsvirov
