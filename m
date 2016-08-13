Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2AFD1F859
	for <e@80x24.org>; Sat, 13 Aug 2016 00:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398AbcHMALQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 20:11:16 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48603 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752371AbcHMALP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2016 20:11:15 -0400
X-AuditID: 1207440d-be3ff700000008af-08-57ae65478e1c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 91.00.02223.7456EA75; Fri, 12 Aug 2016 20:09:46 -0400 (EDT)
Received: from [192.168.69.130] (p5B10575C.dip0.t-ipconnect.de [91.16.87.92])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7D09fvY032471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 12 Aug 2016 20:09:42 -0400
Subject: Re: [PATCH 8/8] diff: improve positioning of add/delete blocks in
 diffs
To:	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <7b0680ed7a10fc13acd8d7816a75ed05a5f9e28c.1470259583.git.mhagger@alum.mit.edu>
 <20160804075631.jakbi5dbsbxsqcpr@sigill.intra.peff.net>
 <CAGZ79kYCwoo6sYefu++KyCdgHfKvRsUp98ZAur+E7E4o_FLtEw@mail.gmail.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <2ceda4e1-c927-598b-ee29-598bced21978@alum.mit.edu>
Date:	Sat, 13 Aug 2016 02:09:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYCwoo6sYefu++KyCdgHfKvRsUp98ZAur+E7E4o_FLtEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42IRYndR1PVKXRduMOmGpEXXlW4mi4beK8wW
	uxf3M1usuDqH2eJHSw+zxebN7SwObB47Z91l91iwqdTjWe8eRo+Ll5Q9Pm+SC2CN4rJJSc3J
	LEst0rdL4MqY0sZXMI214s+ZrWwNjNeZuxg5OSQETCSOrFvI1MXIxSEksJVR4t3eRSwQzlkm
	iQMXFrCDVAkLBEns3rSfEcQWEXCUePFsIVhcSKCTSWL2E34Qm1ngNKPE/pXmIDabgK7Eop5m
	oKkcHLwC9hL/FimDhFkEVCWe/XgINkZUIERi280GNhCbV0BQ4uTMJywgNqdAoMSfA5PZIEaq
	S/yZd4kZwpaX2P52DvMERv5ZSFpmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJd
	I73czBK91JTSTYyQcObdwfh/ncwhRgEORiUeXg+edeFCrIllxZW5hxglOZiURHl1zIFCfEn5
	KZUZicUZ8UWlOanFhxglOJiVRHjZEoFyvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakF
	qUUwWRkODiUJ3tPJQI2CRanpqRVpmTklCGkmDk6Q4TxAw01TQIYXFyTmFmemQ+RPMepyLPhx
	ey2TEEtefl6qlDivM0iRAEhRRmke3BxYGnrFKA70ljCvPEgVDzCFwU16BbSECWjJCbM1IEtK
	EhFSUg2MRUtkU6RfhLydcmFlz+ONH6LPKp/Pa+wMs9HTr1netKk0vML1d9M85c7YiraFy3pu
	Bm/aLS+szrFoisq8GQ/XnGR3VT44xazHqaJf5opyfrFiXGwGm1Da9oS9DhFa5Z9+Oi837Pqz
	8rz2Ro6+6CkiDhvzz1VMXP73Zun2buv7iWW/v4sYzwxQYinOSDTUYi4qTgQAkKQnbx4DAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 06:55 PM, Stefan Beller wrote:
> [...]
> I have just reread the scoring function and I think you could pull out the
> `score=indent` assignment (it is always assigned except for indent <0)
> 
>         if (indent == -1)
>                score = 0;
>         else
>                score = indent;
>         ... lots of bonus computation below, which in its current implementation
>         have lots of "score = indent;" lines as well.

Yes. An earlier version of the heuristic used different indent values in
different situations, but that's gone away so the code can be made
simpler now. I'll make the change.

Thanks,
Michael

