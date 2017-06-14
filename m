Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B544120282
	for <e@80x24.org>; Wed, 14 Jun 2017 20:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbdFNUgE (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 16:36:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:61435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbdFNUgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 16:36:03 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjdS8-1dwUe33IYS-00bezj; Wed, 14
 Jun 2017 22:35:48 +0200
Date:   Wed, 14 Jun 2017 22:35:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/3] Add regression tests for rectent rebase -i
 fixes
In-Reply-To: <20170614102427.5220-1-phillip.wood@talktalk.net>
Message-ID: <alpine.DEB.2.21.1.1706142235260.171564@virtualbox>
References: <20170531104213.16944-1-phillip.wood@talktalk.net> <20170614102427.5220-1-phillip.wood@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QzopCv0koQNNi+wr1R1LRyqT23M6BE/3R0qWgFS2EqPXvFXVr1K
 WSpsYB5DE7IPnFUiyabi+nYExFDu99VB9Lv0haJ5qpM8CXfDYdbg1bcBjdvco5kaERk/yXO
 ZIFg5U3QIy6IfL8d1lzN1+u+/1QFd5hM/afw9tqiP3UgrIpjrYZaqTQcoXmo0zoWMKES2e9
 RhxA7reAdypCfeFMka7UA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JOzcia+2rrs=:XeWxpLZSb8PjZjxCOtc2Ac
 dvEYUECybBlA8zgza4hA1ncTy9k3b52FX+9y6l/WmqzBGM91nSPxk0eFilRuPVz22Py2k+02H
 LiihQwSQLzhYaXH9kI4QfkIyIHiksJw0UZqc4JS0d7sq+s/KTBzy6lxdV7gD+prMbsNr5EBFc
 nt/GTWN3ley/8cvS2LpHA6PCPLhZF3gfAJYuS/280kRxiZCIB7sZ+WRHiraw3LV5keBkkqM8n
 B/rZg62h/8O/CZCj+VCJF/lSXzJgd7p2JcBiJTfzUSgaHrRtZn7EvzLqLJPh1hqOmrNchCO7J
 CWm8VevXlYC9EsgMKdbuZrEF8uRiikCrSXeTEHotBv5MD9t5ktTLhIeSlZNRPuRYUpfq4zhtv
 dcl1Iczau45ED5+f+ZK7S8l4zrq/v+nmq0K05nCXgU/fU6GHldcSeDixfeSyvUu0NUtg7yEqi
 wPubklG7uGIsFEgVAjnAnzR3NsuEMNpQmGREmzTxh0JX8/JiPdsoIlG4m1PugzRNDTvgtbfTA
 /j85Ab69PCM12LFktc+JMplf6130F6GmJPFEGB13GDuroyyIjHbBsyKYpDEqJMhXQk4eMSjEf
 d2EUs0nTAd9Xd5dxPWi9ox0slWrSmTFuWNLRBe0ONGIMToB/YXbEWGmZm6xYs5M3AZi+gHIkL
 tljgQ27/Pm61nc7xf+W3T7yI+vtehkUxSIsGyT2iiKpHHug/cjoswxMgSgQXocg5kt198FYsf
 RuTs2H0P18BCV3jXbLJ5npGjKXeW1PVm+OJ4w7sukX21oECI+h53hO/2bMEM+Aik2kTvrS/F/
 vkWqILP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 14 Jun 2017, Phillip Wood wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> I've revised the second two tests as Johannes suggested to drop the
> sed script. The first one is unchanged.

This iteration looks pretty good to me!

Ciao,
Johannes
