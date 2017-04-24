Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF286207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 17:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S975225AbdDXRBT (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 13:01:19 -0400
Received: from mout.web.de ([217.72.192.78]:56647 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S975222AbdDXRBS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 13:01:18 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWB4X-1cW17i32V7-00XHco; Mon, 24
 Apr 2017 19:01:15 +0200
Subject: Re: t0025 flaky on OSX
To:     Lars Schneider <larsxschneider@gmail.com>,
        eyvind.bernhardsen@gmail.com,
        Git Mailing List <git@vger.kernel.org>
References: <461E433C-DC8E-42FE-9B23-4A76BEFE0D11@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <e6343f94-3fad-e323-cb38-8ea1148cec3f@web.de>
Date:   Mon, 24 Apr 2017 19:00:59 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <461E433C-DC8E-42FE-9B23-4A76BEFE0D11@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:emJIkFnMbqCsClGqFHg6Aqwc7F/aTZQDGFyvobwB56PV+CblRk8
 m9lX6nIaFBQ/Yz9jz+nVrOkiktTlsDRgWT50sVGFZ79bma/d9q0pYv+TfWR8PeFClQOjw3g
 nD1e9pO80o1dNej2yNBYWNx9fgZ4PMoNxfw92wP0mfiBQujUB+r7waaCXw1NpysY1bsOHRK
 SOhIS9urV4vY0/INXXIKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9LHVZFc6WxU=:mJlE26cT+B7zaFIWlx0xB6
 D5Xafqd0SLCaOwFeT8oczq34sNLyuVobxXeGnCXE7z08knjUoutgpGP5PcWF2pmg6qgxhN82v
 mZhtA+dlS+jShQTVAEAwq3CBn0nl9+hQB4Gcf/FNmqqr2zkmRebPFAeAe5pMZI0efXB721V3B
 Bvv6dQEeVarW8u2ozGXKGBuGbc8jIqXk4I52SoM0lxxvVvbxvGIOtiW9g/e1w4a+OLZSuK8pI
 OU9ZUtYkpZUBUIj7wSHJlS1YvKVpgRLbz8yXZirLfqipiG2nI4k0LZB5vLODvQ80/M5RgFgz7
 lCJKLyDhTgxf6F7iiuSvkI/2BjUG0pklNuNCQ9MCEZ78jmr0Qx5W1exvaLpW08YZJusIYz8Ow
 Q5rd8OlygVQ9O6BQxcPtxzrxpO7B9LB9Ug7WJr/JvTfKVt2yM2cccVsgl+ttXJ2kZPUzMh/sD
 sYxl526GYHK6pvOJY9XRg2Da9exurB8cUyvTi7unBuEyiAauSy0aj9Hx/MHYE3cuUjzdrL1Hn
 ndjJDlpgz9OEd11lIbE0VfC9k1azW7yndksBLRlx2JSjA3+WzUA7Kbp25PL0k2iQa4EYT0KGu
 j5pw36z2NTFQsFZzVEB4tCsp3XSgJuXVpJ11/RW1dbgmP6kiJFznulXoU2t78hALWBfbPI3rs
 /hUypBpiUmPuIQyE6GWSFneX0x5DGDbc46CtS8r0AW2kdvntpmqP/1t/vitDCpXJLYHg8GFR9
 N7l3WgqGwmAkfNk+95OKz6fsZEkc8OREL0I5eReEVNANYo6ILqdPwfvPEA9KHdqGnmeQA8iCc
 nmYggJI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-24 18:45, Lars Schneider wrote:
> Hi,
> 
> "t0025.3 - crlf=true causes a CRLF file to be normalized" failed 
> sporadically on next and master recently: 
> https://travis-ci.org/git/git/jobs/225084459#L2382
> https://travis-ci.org/git/git/jobs/223830505#L2342
> 
> Are you aware of a race condition in the code
> or in the test?
Not yet - I'll have a look


