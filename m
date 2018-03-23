Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B6361F42D
	for <e@80x24.org>; Fri, 23 Mar 2018 09:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeCWJjX (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 05:39:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:47889 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752384AbeCWJjW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 05:39:22 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LmbZb-1eQnMO0y6V-00aDGZ; Fri, 23
 Mar 2018 10:39:15 +0100
Date:   Fri, 23 Mar 2018 10:39:15 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Joseph Strauss <josephst@bhphoto.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Bug With git rebase -p
In-Reply-To: <e1f49e12af544f4c9ece2794f7be4d9a@EXMBX02B.bhphotovideo.local>
Message-ID: <nycvar.QRO.7.76.6.1803231038560.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <9a1c2c55ff7f412f8830dbdc4bc033bc@EXMBX02B.bhphotovideo.local> <xmqqlgenu6qj.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803201551480.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <44d0049acaf24e409849f929d7ae4888@EXMBX02B.bhphotovideo.local>
 <nycvar.QRO.7.76.6.1803212332320.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <xmqqd0zwm5fd.fsf@gitster-ct.c.googlers.com> <e1f49e12af544f4c9ece2794f7be4d9a@EXMBX02B.bhphotovideo.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WwZbgRnqZiY/XsJNb2x9cX1b554n7jW8gHFeF8q/x4a7iBAQrAp
 KmPPmbquWJNCX0FDyvr0lhDHkneOW3gu2LC0gbVtsx/NIvfmVCTZsZH3yTaiXRielhcfxRt
 nMy5KX2I78GBP0Tw6Hb62OiQXyb8PmA80MfEfnpPUxvUAqd8DYFO1DrJc7bcVrj25Kp90Xi
 nLJWCjCGjtBI+S78eAOug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hY4FzBaej5E=:zqOwyRoLVsfT/dh8E2l4sq
 R1UEtBlwf4FmhIdOW+/ZD3JoZ3nrxng7MK/4rg9XoZmTQ/29PBOJ9TXJMKiplbT8/YxAn8xHQ
 ElLwW9VeXFBjuVKw1PU394rKDtr8XUIEg88tZY05xUnSCyhK0a7MXgHs2QbNtDJ09f2ogmQXB
 D7yJoF7PlxNkRq2S1Nec/en+u5Q5mu3qC2V3JoKRaIcfYxQvgVWT8D7bEEnSbUcaoBgraXw4N
 AKOcaV2dseLreLXNCSRw5lc/8GLxLIl8zlw5Qp7l//+nbeayPS7lpVkBBZv6AjTUkcC9jr0u9
 5b0xRG17mbNkpWdVKBUDeOPtUEUK5+QbwMJwgsXiLrPe/IirTeYdgTC+d6hkECjWGBeYnJZ5e
 lsGgUeqqTz7wSdUQeXZTnAEYeZs0HWtgamBRz/AM251lcw2BF2Ruur1SYoY68lhTyvb4E9Z+y
 tp6CE+pD2C3AHJBsN/JW5839nuWYAkdB82yswEJpU3CVcvUayTNuMXaxSUBDAtwttLcf0ElJ4
 sY1uEdFDJmU2FgvoBEN4uAgqQNK5YE2oX/2O+jMuEsDp6kSxG+6Rqwctf8913IYIeBj7Z95Ti
 QyxyEJHS2NEVC+XQVixfOX8Wmzy/9TCDuNzUTI3RcHme7Wm7FBOQHSTIyeA11ECMh6QvqN8lc
 8uO4A2ZTsJhcR3vOdU5be+2VIsQxpj9ok3H6/SpbCTWZfmZUpdyjwYH6jUYcn8kXKamLHanIX
 AYnMzj/tnarRbmGZz8DT+yT242WjDu7HfzCBxzWMEmP/BP+trrmRkLvLZWil9vWAn3srB+rk8
 E2rn6BH3b6a6E8EMWz0/IocLoSZ/AbpT+4/+NnPHMDsyMW8IFY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Joseph,

On Thu, 22 Mar 2018, Joseph Strauss wrote:

> I meant to say that I installed 2.17.0-rc0, and it worked perfectly.

Thank you for testing.

Ciao,
Johannes
