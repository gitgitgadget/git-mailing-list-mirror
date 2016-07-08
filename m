Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8D02070D
	for <e@80x24.org>; Fri,  8 Jul 2016 18:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818AbcGHSox (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 14:44:53 -0400
Received: from mout.web.de ([217.72.192.78]:50504 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755AbcGHSow (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 14:44:52 -0400
Received: from [192.168.178.36] ([79.213.115.114]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MPpE6-1bGcwk048I-0051ky; Fri, 08 Jul 2016 20:44:32
 +0200
Subject: Re: [PATCH 0/8] write_file cleanups
To:	Jeff King <peff@peff.net>
References: <577EB546.1090007@web.de>
 <20160707203157.GA11804@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607080834340.6426@virtualbox>
 <20160708065650.GA10664@sigill.intra.peff.net>
 <20160708090400.GA26594@sigill.intra.peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <577FF48E.4060905@web.de>
Date:	Fri, 8 Jul 2016 20:44:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160708090400.GA26594@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:EHpe+cRnse641Jvx4mVVuyPkfybAC5V/1gDG9U7DkxEW3PtI0zk
 GTKI/VYFbB+JzL7NNzQ6WkL7I/JMVeFeM+PEcRMBXJnWg81tKPnTui/Nr0WoSRmO3N4faEd
 FvcrI3f+Nhou0MQHzlP4yECtKK3XNU9sUVKPe5/+ihRpWH2e50KGjAcYhUAvy5CYNi8hRJg
 8iau4+nLjT2bT6me2pFPA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:XQW6vNW8XpM=:7Om+vpgGCtglELAHWd+/SN
 XIAcsZV6MtRCaqDr5xuygkCMwAFPR4I+CdivXUxuzv/ZzGi/ug+4eAkJ64zrf6Au5TjJrc4F9
 9GrqTzd1vH95Cq+GLt7J1VWqzUrb6lf9THWmLZyABatWtpmKeYERsvqNg43vlpfdX1jLjT+Vo
 jIH8W+bCQ+POjRpeeg+BI2D7xEXFJmMQomF7VtYM4U0c5eW7TNmPqerdDeJHKwj7Oo+OtPj/i
 XN7OuPWVLjp/FLPRZZgCUYllignoaKj5YLfTohuiq/u4M/QBDLE6IzObHXIPM5Xvmu7H406EV
 wSRGo4DgVQFHYQkFAtPr2GthS8SfTlasitVhoOtJ0sOJ67R9F9MALh15G42GoniS9z4Vj/PXS
 4Z0x2PLb04giJaWjarby5zOhypoIGJm05zqzp9xCJz9Y0jdqZD/IpQcNsznj2PG5u/m7vzV/f
 yDHcIbl4D3Ts5RO0duX1T7DytuGKwvrnL5iRO1gwmxp64/CqSvo4T4J+0q71suiWG2JkY6smL
 4HpPavHMfrnrJaXhm8xmAWsIQeojYSiX6QbsnqEnJ/K3qlCKaulxyXbOAZ9uMPKd0ITXOg6g1
 itLElomsqiTiv5gD30F2jsXwVNdK+Wbeu60hFhebNkQATJumc6LD4a/fVqGZbSUkT+F4YZrMV
 n+KMyEyc2lnQ0IeNQgqUpkdWt5llW6vuNy/d5gigfUJA3C3WNx/uP8ow92hTlOblWONcKEtOO
 uJiJnSnJI+60sTuLUHsGuqH267oAGkzkSGrIrg0DknFchcqV4bUhfx5dxrJVuuSoTQV7YwLLt
 titBXWG
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 08.07.2016 um 11:04 schrieb Jeff King:
> Here it is. There actually weren't that many spots to clean up, as quite
> a few of them have a "twist" where they want to do something clever,
> like open the file and feed the descriptor to a sub-function, or open
> with funny things like O_EXCL.
>
> But still, the diffstat is pleasing:
>
>   builtin/am.c     | 25 +++++++----------
>   builtin/branch.c |  5 +---
>   builtin/config.c |  2 +-
>   builtin/merge.c  | 45 ++++--------------------------
>   cache.h          | 17 ++++++++++--
>   wrapper.c        | 52 ++++++++---------------------------
>   6 files changed, 44 insertions(+), 102 deletions(-)
>
> and that even includes adding some function documentation.

Haha, feels like Candy Crush. :)

(Sent a single small patch, lots of places get patched as if by magic.)

Thanks,
René
