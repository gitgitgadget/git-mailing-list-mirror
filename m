Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160501FAD6
	for <e@80x24.org>; Sun, 10 Sep 2017 06:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751041AbdIJG1h (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Sep 2017 02:27:37 -0400
Received: from mout.web.de ([212.227.17.12]:51940 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbdIJG1g (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Sep 2017 02:27:36 -0400
Received: from [192.168.178.36] ([91.20.62.83]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LnB1F-1dEY1e2EUn-00hLcl; Sun, 10
 Sep 2017 08:27:31 +0200
Subject: Re: [PATCH 34/34] wt-status: release strbuf after use in
 wt_longstatus_print_tracking()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830182018.21390-1-l.s.r@web.de>
 <xmqqmv6761xk.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <33aecb28-e930-f500-3452-3899d1116d9f@web.de>
Date:   Sun, 10 Sep 2017 08:27:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqmv6761xk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:iUYwPkBXciAHaEe7cdr79joIrK8vZQ7GNUQSy9hah1xC3WKQQRb
 gkG1mok6gteYc/lXPcqhw4HIgCAD488U33/rVbJLpKLbKAKtjVURDKMIwdVFLhbELYV+vDy
 VlpC89GIQ552uHZ1dAXMbv4aaoxfZRHFDhCpcB9Q/1H1o0m5/rEzsqeS1KsrhwLWyto2+N1
 A8ygVZ6l8a+8A1M+g7C8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wwF5sRkZFPM=:v1PxKV6zhf7Ax2YKUEVJ/z
 VCwri/UEnaHqPgGZF+Lus7WIq58jl+R4P4XD7pSX0QGI8pRNNOctLAGW6rZlvr4yUiXQZ+ltc
 27Qfcbioo3c+9g7mB5hRrY4W8Pc/RMDOlCZbz+zuSWzGZMehvMDa1RBKM3M9P3DJKVB8ot8uJ
 i/bxnHiU7LEiIXoOJiK+ST+dD2dKw8vDARrVVSv1aAzz/lDj/RtIY//RjwBgq8iIvScdAiFF8
 0ojkJVeQyMXbim/k1XD35WdrqmxIIsctpzl87463J1sFCMKJmMKVVhEZbbSc5MTRqJ7wLPv/O
 G6WoWl8/6drSgyE7BXQ67cUzyflhvex0dgqtw/jj0D8L+ytF+G+aBftuZjHA+siZS/A0pA86E
 KDzjIAqt7Vk7Ny8c0pQlBMV4303XHU1bW4xMEvoNPSao+u/4xchiKlt+dOyNz3kMygE6S88B7
 b+yEEOEoBuj8AhSUv3fU03faCwFjoBrAhqDh8I2fs6yHut+e85zYTpciFy5YOq0Yxl+z9q4wr
 bKohKrpzZrERON09GPNVg1/pfehNt/+lMWD19voU9KmY7ZjAt93e+n5RvSisAyUs58nhw0ZjE
 m6JlJntBGzesDbUiH0acthLi82PpwrnETyw2bbWrSOrXWQVIZ+w4yruCkzeUCN0nSl7WK6p1Q
 mKr+2O1FTSwtlbGF/8pC89i2+ThEO7xBGyKdzgDSBU5YTQH+TFKVtB35nvCAGe3AV9NPDsvY3
 czPTTgiupQ0cAkXsQLJSbXWW/kx3E5zC1pX2sVEq9WcPM1KcdrIiTO+OeMpRPbWrAaXiCft3f
 L2IjPCaezfGyfbvo+VvhH2SphZ8Heq/zGp2TZoOmyWT8PWFrxY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.09.2017 um 21:51 schrieb Junio C Hamano:
> Rene Scharfe <l.s.r@web.de> writes:
> 
>> If format_tracking_info() returns 0 only if it didn't touch its strbuf
>> parameter, so it's OK to exit early in that case.  Clean up sb in the
>> other case.
> 
> These two "if"s confuse me; perhaps the first one is not needed?

Yes, removing it looks like the best way to make that sentence clearer.
Another would be to replace "only if" with "then".

René
