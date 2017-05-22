Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D63F2023D
	for <e@80x24.org>; Mon, 22 May 2017 13:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759737AbdEVNj6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 09:39:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:50714 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759385AbdEVNj6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 09:39:58 -0400
Received: from virtualbox ([95.208.58.16]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MXUmw-1dQSpK0RbK-00WZRX; Mon, 22
 May 2017 15:39:52 +0200
Date:   Mon, 22 May 2017 15:39:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] name-rev: change a "long" variable to timestamp_t
In-Reply-To: <xmqqa868t6yu.fsf_-_@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705221539330.3610@virtualbox>
References: <cover.1493042239.git.johannes.schindelin@gmx.de> <cover.1493234408.git.johannes.schindelin@gmx.de> <5a17f0ed846b1b894ac023bc8694b6f5c428ff15.1493234408.git.johannes.schindelin@gmx.de> <xmqqa868t6yu.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4w5jAKcZXS4WCCusceiFYaBwnDNRxitCJuWFjgSf5rT3J0Sky6z
 MxLFBytO6NyAC3A/dQrXQQq3NZQooh9dSVgDqlmIssI/2s1ORHrmZErugge80bRcc1ZHahd
 MvJwLsYE+JWqXTw2iU32ZT72gCeQHrJfcmmW3tBSbdKvXPij4p4agHZVHehRFoqRZSrISVg
 RK7oJhiD+edfMiE6AF4Qw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:D5ln/uapYKM=:Io91nARW0boCleAuab1C5d
 Af3EH43m8h2/D9DtOUuxOrpUMEj1LqCviKKyxormz/9S8e026FQTces5MdSRq9tBnb6Uq2hZb
 XEzNVlFpVskN0NOk56zhXh8tNJppsMqeiql/m/WwYYMeCyBq3tMzCDakWjzJ1fJmehrLmIYRE
 yKHhb+FEp/ojmFLZKr7+bWZsOWewVekM/d80QrPdPmflb1uCVs95m3240KnEv1c+T01qEBbAC
 gWhVel71A2u1ny3+Qf3vEVbz5npAd26f7r5WIJBGWNsFYGTxGC8pWLJbUiASg0ZaskwWskWvz
 OrBEaSk+QrYmCrLq92JqEhY8RtfdtwP6TRmV7GUAuHzQiqLEVm6COAO692JTyZ8aLbCdKs+i6
 xsbLQxo4C6kMJUyOuPm7LhwN3Sgyr94uVMK7PeFmZzkkkF/IermEoqHwk58tckAoAE8pj7gHN
 QiO6TOghCTbrEr6F4NW+Ix2V1xRaVgJAN45XaTnaIeCRKZrZiD2XSIoxSHFXh46eVD1/6yhxr
 ux2snLW/84NDsGAiagd/5WP8T+HeR5irRa9qRsDTMSbui0no5v2DrtYVomEkpvk5PwBImzsfg
 AFyHeb4Oezb12/krh3OtJntNBIPGvvFSEOLmmMKcInUVEWgTdOtDbdPv9ztkk4+MVSGiQx9a9
 g0ZlBWW3K/trJZaXt7DXbljP/hHGUL1iBbNIQhAXIYBkJZHDZnfwnGubpcYuwdwr2aQ70MdY8
 DXKiRuC47EjnlHti/k4WWVj2kNunVeMjFOEgXQupNCWbUElKtzj+ZpXsQkWCg5pUUGqycQdPo
 cMQXyWF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 20 May 2017, Junio C Hamano wrote:

> Earlier dddbad72 ("timestamp_t: a new data type for timestamps",
> 2017-04-26) updated all in-core variables, fields and function
> return values that are used to store "seconds since epoch" to a new
> type timestamp_t.  Unfortunately one variable "cutoff", which is
> used to keep track of the oldest timestamp of commit we saw on the
> command line, was "long", and left behind.
> 
> Update it to timestamp_t as well.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Obviously correct. Thanks.

Ciao,
Dscho
