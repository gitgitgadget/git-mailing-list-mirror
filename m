Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E449A20179
	for <e@80x24.org>; Mon, 20 Jun 2016 07:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbcFTHCN (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 03:02:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:52839 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598AbcFTHCI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 03:02:08 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MNHqL-1bLCs82hdB-006yOa; Mon, 20 Jun 2016 09:01:33
 +0200
Date:	Mon, 20 Jun 2016 09:01:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Johannes Sixt <j6t@kdbg.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 0/8] object_id part 4
In-Reply-To: <20160619092448.GA12221@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1606200853580.22630@virtualbox>
References: <20160618221407.1046188-1-sandals@crustytoothpaste.net> <57665CC6.6070208@kdbg.org> <20160619092448.GA12221@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:cTNK7g/Ayc1dstlCcYXrOrOhwwBUhEGPAJhMC+wSLwztlheneY5
 Y4YlODBDIWQ1QqjMrttt79Rwl0VphlvX9gkmPMI1/8DsDBprY7X7RR7jnWovJztM4HQbB1g
 VgPcb5tnfviV9LfutCoLauJCWYbh46QTf/BBWsi8g52nTXruqsO8KDNuWAPMdDkbC7Qb58G
 IYAo6i+HH7OkOJNLkO8Vw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:oCveWIswJLY=:q8xOpghVyNqZilSn1Xoerp
 DziJ7OZo5xubN1LY45gWic7cwmj0NyLRxHV58KHSzuruyjdEJ/IlY+HM6RUntcQYzO/zKaUeQ
 4zH4ci6mpdc5jUcGbGHgnoL/mYySpXF5E9XE8/fk0TXVxix4TOrmiFo6Mws9kPoUjUb1jF2+k
 4dn5Owkjb7dywZ7vbMnApmlqyd0i3/Dl4Vnxa+vxx7/By83JWyYZFZ4FQ0saSS6/fgrGLxEsN
 j4pcNEHM9qMJvs2HKfdF1wLWB5YkWpgJFEN8SlLNdEI3rof7cI//x6+gVvqfy+lm/61RXz8Zt
 vIyimuVdMraB8W3DLwXk4Y3RyAk5IzgjyRlI+mbwWkjWexuFw4519FYT8W7XRLYbkzFyLjtDH
 z9tDV56aJgKu0E1Jc6z9ZzeizTprQ2dDwKCT4VUkVncjtpDPqHt01gtghMsATDrFffYm4NDm4
 l7ZC5uko8Mgv1zVe4zevMkX3Rz8Z4Q7NYLX+3EPafaV4O8gkBL5aGN8geuKT/aiVmbFYxOg76
 dLyJVGD0bDBlOs3FYzQZWdgos21KlJ9QfyiK9VerXWXtH34L3jPtw19J06t0i2TSwb2S4sD5R
 KOCm5/8ohdyWQNWICTJ7IjqEOa/Xe/B35u/mqlNvcvOhtZ6IxHzaoGjOWLsbEakY3Bi2J1ieE
 R4rHrfwitEa8JKpX/ko92aeFvuBPtApbhKlqjG4u9kGetid6mxBx7MOcG2p/qfHTsP32BlE4k
 HuID/chteCyCZls+cZeifPr+oPi+3K2KxBbimYAVgfd/XYCa+T+z48Fdp4pFBNN2B+I6/fXr/
 9D6wOeV
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Sun, 19 Jun 2016, Jeff King wrote:

> I think traditionally we've avoided struct assignment because some
> ancient compilers didn't do it. But it's in C89, and I suspect it's
> crept into the code base anyway over the years without anyone
> complaining.

I fear that's my fault, at least partially, seeing as merge-recursive.c
even *returns* structs (see 6d297f81; I plan to fix that as part of the
cleaned-up am-3-merge-recursive-direct patch series).

Sorry,
Dscho
