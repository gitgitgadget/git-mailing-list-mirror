Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100751F731
	for <e@80x24.org>; Thu,  1 Aug 2019 14:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfHAO0p (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 10:26:45 -0400
Received: from mout.web.de ([212.227.15.3]:44179 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731665AbfHAO0p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 10:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564669601;
        bh=UPt1ju75o5ZvRCpwwflhSzlAWxkoH7GBkXMvgatEEOw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=IxOEmWEfEaFQ4OjV+wovH0B61o2KRrDgt+fyV2xXhKZPUUcIc8vKre0CJCda+bMM+
         erprWK1oszOSlef3h/9SeRofte9desAUhELbDTcZ5eIQKEixLXnJeN0S6jFcx8nNFy
         yodr6CdcXKnDEpGu8/nGZIwIPTDOe3+Xf8LWz7hI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbZpT-1icwyg032Z-00lCdE; Thu, 01
 Aug 2019 16:26:41 +0200
Subject: Re: Support for --stdin-paths in commit, add, etc
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        git@vger.kernel.org
References: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <066cfd61-9700-e154-042f-fc9cffbd6346@web.de>
Date:   Thu, 1 Aug 2019 16:26:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GUzEV1PktBMLsM5/usiSRXLDs+wc3y0obMXh0rchdOcDpn+HW3u
 BTDrWoecmL1PJEDmsY5oh63l36ji/SlC2CwNIX3x4aiftokshFkw2vAcfghhpyrKZrqdTHC
 KjhsUFM5cFlwBMNWXVTBnK4B7uQ4VyKceofMXhlsiTqBTksmsZRd0nB0fGaju3kwqe6Wlxz
 Anu/do+AfhzXXGYGRd2Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:afWK7yTn+0c=:n/5X+wyJaIDppHjrIJUC3a
 bItcSWu1cJF6eUvN81pvnKoHoNeOsRWmu+0gQxHzxbUNu+w7190pzyrBeR3y+inK2qv2N+83i
 L/dRyYT0r7TdBrsEE4+nk+AmAe5vdDqCR5qgXzGH3gQ9bxvZG5K4l3Hy6tFfZcrVkKdm9WKch
 1TB/cF/w28VJRBHAp23bzWBoTF24DNnO+LA1RGEfiiAYVx9aHscF2S4P7J4WVU8e6oRj4Y+oh
 x0YyK4jAUfAEUPabWWFk7/M5OGOizBmhuSzYQy2DIMB54XLhYiLoN6fs1Wshc3xlNWuIm6heP
 92RuYe8TwL0jYoAZ1hjVS4vBuXzSkA/k7uFjDLrDxbd+IEmCVzHkfjXtdcITL6+5Zy9iXp6xZ
 xjPQ9HNWRQ/fV80+1VT4qTwoG4z4e7U1J/TyunCPVrSMUoANjtEdRi8sJvVjt29sdNNvgeB3/
 X/FRtYlQUEqUIXu7vmW3SWR/yh8QLVhHg+XqEQqC4gG5Oqc10Q5OKXNL+HEMcWTNvku04n2Dl
 xYmoj/+NZLHklAM52B0rj3PFN/CN0eSXzktC/ehQenlYoUk5kSKclFezFLMPrGuRtnkkvQBWr
 kPraGvvBGUjomQh20PohOiqufOaGxkRd+ApbIhP7K77IWRsy519EILKIbaPoCNSCm66jZG0Mt
 fnyjB6Oqc0u471IJ63DlTBEkPN6+9YjAVKl27ywcSn0d+WUXm635vgdRfoplKV+gDpJLA3WPN
 WV1RS6Cx3Bur49jsIYfP4yHC0y3jeAp/LORxF7eYeuUFL99o+Topxtn+XuPKx20XJmfY2yAIn
 0gJDSO9WiPAwEXk0W/7qk62cgOOp6/XdA8DLk49+xg3OkfCRZj3X9IbmmXatpkptTEd9Njzhy
 AeSoPOP4Y2ww5UqVPWDGsvG/LYFUQ1a7GkJYVL4p0WSd8d324iaLwSaODGsymTuNl+dNYg5EW
 dUQv/3FCkadl7Gr5iBs/LdHTWM62DByB0COLG7LEFNmC2sDIwZppocWwdsGniu3AX5/n03feO
 ybw1xeVc+NN6sVB0Di3SDy3PeDqlgtIJldQVU/ygbkGEEqzTm4j5z+CT9zzlZcHvEu8BixFH3
 G67dtGo8yMZpBcpOTvGmVIiOBUxnxbeAQGdsLU9vqFWqa9SIYmtxvAsJLspgu1RrDCv/XRTdv
 n0vWI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.07.19 um 17:45 schrieb Alexandr Miloslavskiy:
> Our suggestion is to change commands such as 'commit', 'add', etc to
> also work with --stdin-paths. If a command already supports stdin for
> any purpose, then trying to use both options will return an error.

Would it make sense to have a --paths-file parameter instead that allows
reading paths from a given file and honors the convention of reading
from stdin with the special argument "-"?  Reading from stdin would
still only work for one parameter at a time, but paths could also be
passed via a regular file or named pipe, allowing for more flexibility.

Ren=C3=A9
