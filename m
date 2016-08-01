Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D5B1F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 09:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbcHAJyV (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 05:54:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:49789 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbcHAJyP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 05:54:15 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MBFUT-1bbcAH1oE1-00AE2C; Mon, 01 Aug 2016 11:54:00
 +0200
Date:	Mon, 1 Aug 2016 11:53:58 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 13/16] merge-recursive: write the commit title in one
 go
In-Reply-To: <xmqqzip2u2sb.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608011153310.149069@virtualbox>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de> <882273dd0067de30fe4b672050457708d56f317e.1469547160.git.johannes.schindelin@gmx.de> <xmqqzip2u2sb.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Cq5F1bfQKbYBqbsLG7aXrigc5cwwz9M8XBy6sCa94QIBoFWeLAb
 /ytPWkIJgPBzqWJzG9yG6k3yi/tFPUYwTlJLGUdWM0UtdBXiq9VdaB8CHNSx1uU6+WyAcDP
 40lXo3A7l3jSYGMHK74JtaJDBDPCmSQG8LW5mmjYe8wDeuyzq6xCv6xkkO3Qoq604nzpuqa
 OVVTj5L14i3MGZeFb1jCQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:kKzebXJQChY=:JbgR8Y+uK1R26sT5gvnykA
 TmbWG4PezTaFaeuFfzKvthcIBj09POHSozlQCRcwWH44EcPyQAOQPTMomnyZ5s9/vBhU/Ec9E
 IMwtfX+bRkZLLVuHecIhseY+jn3MS+X98Z3vl64EP9+CuCmtQ2muU1bfxBrowWHB2GAsWf1SS
 C2bdUQNzveQbpQYVJxbb3QwkaH5VPiFDi9lbHFfnxEjjmvfGEeDcQCa7GnCchcX8IOmG4C8yJ
 pxC05v12h/AWaOh6X5Ym/7p+RCB3SqFOw83qyy6sMztxm1Oat/R2lhhW3jx7CKU9ezy5ro9d0
 DhNzCQMrkLhF5r1x6ZZDC+mjzK26aTkwyqOTSV2XPISa5Y/bPEnCCqtWTcN4z2hpdKGTxEU6w
 cDquTFnKcxAvKImSAH6KiXnPceUXUgc0BbhyZLxoP3iD1s8CLLnsJ+OvB39+yxigacCn3s7gj
 1uRJHJ4RCZ3YTj/4WrMQxLFa8I/VAHjfqz9Vv6fZZDNcrFYKhSbwy4eRy7Cz2I0nvritwMxJO
 PsLrtVeOrNir1U1PPveWOIeeGACOCAx8UxUJ6wAgxrDn43J5ijtiJiVJsik7ztGx4jEJRStR/
 37g8TXZUOBIVng1gX3jbhfDvea6ZoN3YA+TA9nSfVJvBtj09P2aQn5fV0ohku/Sz9TIrzYS0W
 Xeli8jGjZmR1L6QA6wfOq7szbTh119HpJ2BVM3PuuyM0roK3dgwzuFEgQRo/rnvRNtyEeOKnD
 s2/UzkweFc6NKlntQOhZI0rRi9tSQL3H6kC6b5kJnKrpv5n3MZ3VQgfZW3eG15xzzFzj18AQe
 Ve4EHKP
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 27 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Let's make sure that the same holds true when outputting the commit
> > title: previously, we used several printf() statements to stdout and
> > speculated that stdout's buffer is large enough to hold the entire
> > commit title.
> 
> s/speculate/assume/; other than that looks very sensible.

Fixed.

Thanks,
Dscho
