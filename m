Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B136E1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 13:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932670AbeGINkj (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 09:40:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:41773 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932278AbeGINki (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 09:40:38 -0400
Received: from MININT-6BKU6QN ([89.204.153.232]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MRjd7-1fVYF212E5-00SxJG; Mon, 09
 Jul 2018 15:40:29 +0200
Date:   Mon, 9 Jul 2018 15:40:28 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Beat Bolli <dev+git@drbeat.li>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH 0/6] Compile cleanly in pedantic mode
In-Reply-To: <20180708144342.11922-1-dev+git@drbeat.li>
Message-ID: <nycvar.QRO.7.76.6.1807091539540.75@tvgsbejvaqbjf.bet>
References: <20180708144342.11922-1-dev+git@drbeat.li>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oYsZGMYzfR6zv1/eafH7xwUKiS/txc+KJhzOWMSM6gsAqFqBg+a
 pthGoVErrY9Ds/AT9EjIhe6dJzldZmGnfxhnlQQOx8s3+TxWH1RL+snosr77fum8cwKpOoV
 3Fu8gMvkTHUT5mjVOQk5DiDxYeKbrgdeyHtvAC8uKl8CZHiZinfCzGbO8idxmpsu3oiaV7e
 d2FvkDKjgInbTqGM+fT9g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0dklFMqyMjA=:X8/YZ/9qIwX0xeNzKOQXAE
 qxB3M/LqkECufpNmprlVh8ay3AfTzegOtx3GqehP6RTRs0DUy0T62wLu6NHFWpoGyyUR+egoA
 6NFcx8D81524vfpH8QoYyIYfid3tVi5bKPvoOxPHdmcJduqFnS0pDb/h1Dy8iENMMho/RvdDL
 CHe+of2bJHTofHqm/GHDCvUvNPVIKtyGn+RTh3ob4G5mTquqsZE5gAoFv7XH+AQquWF39yAkU
 E8/XhWYeKiNyD9aFw7Kw0JOYLs9E5Rn4OyDA6V/h+yz8uk1uYyihZ4i38/XAG+ocHncz1RyDx
 +JLrzrbI4uP1LG5sKnHFu9wkLIGZ+21klBTZ28dsuO48gQkQ2eJOTs9rzD/nK7nhPm+ld4/wE
 aNdWdm2z+fBDmOdhNBXKV7vq1mcTBeR0SDzvxe5tHihQfD7PMe5RnvwroDTQXDIfFSTxiYsqZ
 12BHVuznUcI01tcvTFfRzAds8upPiNxbhSmbK6sEAvqhNBTLTKFoZBNTIZngw7Uf0si8jkAw+
 KPYStcjzdv+/+aTEdANkOXPY/mVSzrgEc1e8uXc62zR091lpNQJFKLYPyfpWIfzhaI7vc1T//
 Bdrufq/o+OB4N8iqv/URqqgkfHXM8eJIfJD7RUuN05njHutMQKGGqxxP76cwYqO+IkqXCqiUM
 +3vb9wFa42p8tNgYLQLzE0t5/5t9BI+GuQkRfqGj0TiY5ASAUa7/qqgNxfBd7PFjrwsDiMaPL
 ZFKOQJyNcJezc5+hnnEtyLdb3WIkcgNs4Uke1wCSRTVQF35bfZNRZL1yYblwvi4v6t8m2WAQB
 JiG6/le
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Beat,

On Sun, 8 Jul 2018, Beat Bolli wrote:

> While developing 6aaded550 ("builtin/config: work around an unsized
> array forward declaration", 2018-07-05), I have compiled Git with
> CFLAGS="-std=c99 -pedantic".
> 
> This is an RFC patch series that fixes a few compiler warnings when
> compiling with these options, always assuming that this is a worthwile
> goal.

Thank you, I think it is safe to remove the RFC label: this is really good
to have, in order to make it as portable C as possible.

Ciao,
Dscho
