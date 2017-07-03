Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4305201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 14:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755915AbdGCOOT (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 10:14:19 -0400
Received: from mout.web.de ([212.227.15.3]:57350 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755853AbdGCOOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 10:14:16 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LlJzS-1e1vQh0i7a-00b4Pb; Mon, 03
 Jul 2017 16:14:13 +0200
Subject: Re: Help needed for solving a few issues with building git
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org
References: <1499087898.4156.6.camel@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <8f7d8990-6915-9cb6-1867-524318bf7529@web.de>
Date:   Mon, 3 Jul 2017 16:14:11 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1499087898.4156.6.camel@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:vJ4JGxT7C+RI4j0wNEUDebMPCH7CDPbo/9STiqdoH6YsiNbzmae
 s/yCo7jMTMsmxslhT0/l//89/JmVrkoF1rH6MjuI3FLzkHFdNX+/KMgF7TX+2usEJfOK2Zz
 9fWI4PcoXjlgKF5RiVAh8ssR317ewDDk4EIDIiVy9FvEehaLrIcT42gyWJD6qt6Hmt9rRU2
 zGD2zQIyP1lXo4RqoHffQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Zj0IIBb0iAI=:9Cig8N9C7U6J6wPQaqh0S3
 PxMgIFFsLjgNHt+jgQltPG2EQz59K8Qeprdc++ZIOCTG9lyWhKPjgQkvVGJgAdHpOK5XfDJCZ
 TBgzzR3gUANcbcM59ERhxWBRBytOfN5DXMCtzhqzjzdhBe7XlMgk0WP5KY/Wem+egfGH9znBE
 WAl7nWfrhB+4kDFYpjvQpDfivb9TV2AoPRSLcUI1p1su8Ozik83NJunhXVeJOonBbNGyIX4VD
 qXLcEYVXaooujXgi9rFd+u8VTKj6BVkrn9pgLGftOrrCRN8bz/qLqiT3At4zT63LSsbHi7OkF
 Vt5bGp6+5wBwk81lGna4f/nwR81aBej6gbMLbYUsRV6+dpUu+GVXtm0o0y+uvybkebcXv/FNl
 Lsx3GoXnCwKh1V1EufeyEzb2uMryMranaxgd3WXyHGPMSOgwRio5yrfGWy0fNbNeE7wgWQXdb
 3B/w0BMXwBn3zcfImqXkju/srXzYzbRJ5TPQIPew8B5VjF+W9TFElb9i0LeGgxc/vHQ0XhLLI
 WRnRaY0KE5wrYpfQhfJtKhrp8FiU5v/5f7FNuBajoT22LfqfAbKAw7XXuSt3TnH+6p4am2u3U
 LRnT3rYr+EdL48cqq0FxkV/rYzkV9YKQu5x2/a+dAWJMA5tBwHEO9QByU7+Vn3+yeugFQdMZt
 KiSAqXgJyhV0PVVNwi47ZVyQ8zis2bJfBcd5zdogFa51jc9u3l3/g/GRLlJ9y7fELtXdrMDOy
 lKJZ3bW3sz9MbdPD4sxUYKpn+Q7LqYMxPti0iwR+8GZX8rgbwe6Y+6rWxoWJQxn8Ygsg8JbfB
 qnjDCWa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-07-03 15:18, Kaartic Sivaraam wrote:
> Hello all,
> 
> Building without localization support
> ------------------------------------
> I tried to build git from source without localization support by adding
> the following line to the Makefile,
> 
>     NO_GETTEXT=1
> 

May be

make NO_GETTEXT=yes
