Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E281F454
	for <e@80x24.org>; Mon,  4 Nov 2019 16:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfKDQ5E (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 11:57:04 -0500
Received: from mout.gmx.net ([212.227.15.19]:50855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfKDQ5E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 11:57:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572886613;
        bh=URAUHp1K50uBO3Tq27pvhlKSqC6auFAHhi+ZrVI9dFQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gVuuJtg6m1dmLmQGfcqK17sacuuwi3l3rtZL+Xb0x0OrLjmigNXoyiw68GCwUy7o4
         n3aMrvHSTwnfxxbBe2oTkx1asfoOVzngCoWgREUvXxl6a4kUCieY/xhQeqUmfwRbQR
         umvkQcpmql9nT2U3TE+bydIG1rfvtZihAF+Krbi8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.3.68] ([89.14.244.142]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFbRs-1iijd43huQ-00HASw; Mon, 04
 Nov 2019 17:56:52 +0100
Subject: Re: Windows Git Status doesn't see files on WebDav, everything else
 do
To:     "Kerry, Richard" <richard.kerry@atos.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>,
        git-for-windows <git-for-windows@googlegroups.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <6c355683-726d-c497-d5df-bb7f8ea770d2@gmx.de>
 <20191027175850.b6le5r3jf3cxtnah@camp.crustytoothpaste.net>
 <fb194341-f7b6-d036-95f1-441c0cb59ed0@gmx.de>
 <nycvar.QRO.7.76.6.1911041326480.46@tvgsbejvaqbjf.bet>
 <2883e199-bb7d-e323-d3eb-ed8da85cc54a@gmx.de>
 <AM0PR02MB3715C3E485FD1FB0F0FD9E7B9C7F0@AM0PR02MB3715.eurprd02.prod.outlook.com>
From:   Ingo Wolf <ingo.wolf@gmx.de>
Message-ID: <4496fcd9-1324-b296-4ba4-ee9fea941f58@gmx.de>
Date:   Mon, 4 Nov 2019 17:56:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <AM0PR02MB3715C3E485FD1FB0F0FD9E7B9C7F0@AM0PR02MB3715.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: de-DE
X-Provags-ID: V03:K1:4sCxo6NoBgnJCYxrtoYfIZdRqJFusyPyxY5lZ5rQF8CmBcVEIN+
 XT1YTC5qe6I6F5uX/h+lmsJgnDS9uNSzytz14OZWyyPb02MptvqCRY64YRUr1nZdSHrtuj/
 /6QuBX5difuTSVcXM39rL5Sr+eDWEVcAZW4zokeDs+RSEenipcRtAhR5S9gm0p/8N+eAU6k
 DY/eMt5DFJ2XyWwCEQn4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9jRcl54mnTs=:boOlTo1nPpcVZ0JHwG+Qtj
 yFAMn2BHAzOYSXFBQQq8JORzSTTbVksLQaN3QtAYwD3Rv0CtzQoiBUNFR/k82GeHkuM7bJ+El
 ELyoWxC3f42MuCNKhhJ/07KiW46EvP5tv+vYGiIhtnzXJJqpE8WRGUY0xZUt/3ybQjK/FyVbM
 NTiI73C6i0On+KLFJRTJOIKn3by8Wqoa9oH1+lCr4WqzgtqiYZ9ftOYZgB/5SSrtDaKt0XL2O
 zjo8sEq8a8wg6FORpbyTLyOSvyUyFjPK0N6Fy0kkdSSTEKI509lxKgayXzb+BZ8fQlR8vwkQY
 tGjnNyq7pfrgq2YUYs/lwVjfYX1hwyj5ib1lRRRbgfb6vneI9iCVwn4pXXxa1w/AiskV9sL5E
 S33ixkexKMNzihsmGp7Et/T8ubG7kuwrsg2Y20SxIvhDJWIYxNd1ujXVuZ6dTBU9YtRHMiJMx
 VEqjfNtXvVdyC2ljHLXjL4/jhR5NmT1uazLn/SrPyqob/yBtTChf+ohZNRrrllz1lbqTny8Cf
 W0gYt/W/RjrK/r2HReSoTAW904WlMFw0gYsJT4L1aaLckvCQNaXNuWi5KZVJ0u7kl+5jYQ51p
 iwK4tmBNlol4e852hNmodvznKMmK31Uw1dQlNKoKVQGxyvhVhh0YsKEWWt1b6Ce6N1WnNk5ls
 WdWJudkqKZ8nCBKYUnzgG7jncaAFvnhsXlPximJdj6lNE03uAYItuTBwNvGOoRPcu0MIDHd+o
 0Ucwz59N2N/hDUKZABLRfR3w1ibKv4jsKAoVhmBDoXf9JcMPINeJlZ5CvLA6q5S+p1KOvCSfg
 VZ2/k04EQq/GkG4NdusZne7ehc7vcL+rmDz+Xhw50LXk0CG4t9b+I3MBVYkYvnADFXnBikTS/
 DaqhTjMjHKHKu9ZkEaSLLtPf9WAKZ/KNLl3CkOXIpKTp0oxu/bU+JKHEQL70fa+l4ty4MMOFu
 4DXtYV0sc7M8BomoQKU9Q825pNh7R0BQkcXCjFo4UPiLvrL7P2e/6BwK/l8mXgZh4uATQW1Iu
 fTXwBYts61/HqZ0nfYq31KCMmH4/BLXmE6VL9Jc4xF1LYBa2m81616lFR+Uwk5VF2jiDVE1/u
 gI9uTZEsT+hom2MZrWF9NBd23zzPkMWNkOmOGdocgFeOVJ48w8jrwZQWPj82L9HtZe0O5kjIr
 azIC5R5UpW3HrzQ+heRyH3rFSSmUj+P/qHpOiT9cXPryXqmLGkBZ5DDHv6Wkad5nnnbe8VIIy
 v/u4Gvl0KaNJCLrlL3l0JVpC8LOMZhyTFV7OgN26NOPjhl1OKei9E9KjCKus=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.11.2019 um 16:23 schrieb Kerry, Richard:
> [RK>] It's not that your answer was awful, the problem was that it was
> terse - Too terse for anyone to give any advice on.
> I think the request is actually that you should send to the list the com=
mands/settings that you've tried and the results that have been returned t=
o you.
>
My post again Johannes refered to:
1 I asked for more ideas about settings to try,
2 I told the ones of brian haven't helped yet,
3 I quoted them at the end:

 >Hi,


 >>>>1>>>Are there any more ideas what git configs I can try to make

 >Git Windows Status see the files in a WebDav workdir (and not as deleted=
)

 >[...]

 >>>>2>>>Settings recommended by brian haven't helped yet.

 >Am 27.10.2019 um 18:58 wrote brian m. carlson:

 >[...]

 >Knowing how WebDAV works under the hood, I'm not entirely surprised that
 >you're having this problem.=C2=A0 You can set
 >>>>3>>>>> core.trustctime to "false" and core.checkStat to "minimal",
which may
