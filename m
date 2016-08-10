Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4D71FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933891AbcHJSTq (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:19:46 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:63367 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933883AbcHJSTo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Aug 2016 14:19:44 -0400
X-AuditID: 12074411-a1bff70000000932-3d-57ab6162dbe6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 26.F1.02354.2616BA75; Wed, 10 Aug 2016 13:16:18 -0400 (EDT)
Received: from [192.168.69.130] (p5B104255.dip0.t-ipconnect.de [91.16.66.85])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u7AHGGvs006052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Aug 2016 13:16:17 -0400
Subject: Re: [PATCH 6/8] xdl_change_compact(): keep track of the earliest end
To:	Junio C Hamano <gitster@pobox.com>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <b0413b20e3b8de1dedb91460a9f05534166f6afa.1470259583.git.mhagger@alum.mit.edu>
 <xmqqoa582wyp.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
From:	Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <85602359-b1a1-39e4-b56b-081aa4014609@alum.mit.edu>
Date:	Wed, 10 Aug 2016 19:16:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqoa582wyp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1E1KXB1u8LZXxKLrSjeTRUPvFWaL
	3Yv7mS1WXJ3DbPGjpYfZYvPmdhYHNo+ds+6yeyzYVOrxrHcPo8fFS8oenzfJBbBGcdmkpOZk
	lqUW6dslcGX8PL+aqWAZS8XMafNZGxjXMHcxcnJICJhI/GzdxtrFyMUhJLCVUeLxg0VMEM5Z
	Jol9HXvBqoQFfCUap81hBLFFBNQkJrYdYoEo2skosf3zFzaQBLPAOUaJ71O0QWw2AV2JRT3N
	TCA2r4C9xJQl11lBbBYBVYmGJx1gQ0UFQiS23Wxgg6gRlDg58wkLiM0pYC3xbOc7doiZehI7
	rv9ihbDlJba/ncM8gZF/FpKWWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11Qv
	N7NELzWldBMjJKgFdzDOOCl3iFGAg1GJh3cD06pwIdbEsuLK3EOMkhxMSqK8wjGrw4X4kvJT
	KjMSizPii0pzUosPMUpwMCuJ8LZFAOV4UxIrq1KL8mFS0hwsSuK8fEvU/YQE0hNLUrNTUwtS
	i2CyMhwcShK87+KBGgWLUtNTK9Iyc0oQ0kwcnCDDeYCG2yWADC8uSMwtzkyHyJ9i1OVY8OP2
	WiYhlrz8vFQpcV53kEECIEUZpXlwc2DJ6BWjONBbwrxOIKN4gIkMbtIroCVMQEuSVFeALClJ
	REhJNTB2/mTj+/XK1Ux6A0vifolIX6/fZVNm1SjE2z340DXjTufWXnulc+tuvzmT1PL2nF3r
	5S2bjzWxVheLOE9xbXWrNU78Lp4x6/hejeO7rLStz39+7Bq/3JmvIGwq/561K2LernmZW9s8
	49NXvfdLeSR+RKXN9y570qO67+ZUlc07+pmjjnLJLFZWYinOSDTUYi4qTgQAl5CJSCEDAAA=
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 08/04/2016 08:46 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> This makes it easier to detect whether shifting is possible, and will
>> also make the next change easier.
> 
> I can see the code keeping track of earliest_end but the above does
> not make it clear what the new "continue" is about.
> 
> ... easier to detect whether shifting is possible (in which case we
> can skip the shifting), and will also make ...
> 
> perhaps.

Thanks. I will make the change that you suggest.

Michael

