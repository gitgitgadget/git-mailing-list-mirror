Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28CF31F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 16:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHNQ25 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 12:28:57 -0400
Received: from ltwemail.bankofamerica.com ([171.161.41.178]:27323 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726047AbfHNQ24 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 12:28:56 -0400
Received: from lltwa05mxepmx03.bankofamerica.com ([171.180.36.246])
        by lltwa05ixepmx04.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7EGSqYu006471;
        Wed, 14 Aug 2019 16:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1565800132;
        bh=ereOUGYchXNqzocNolbJtDoCQX0g73ZURq0kkDzCGQs=;
        h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
         Content-type:Content-transfer-encoding:References;
        b=P8pfKsQk7tfQj4/SOvI+ev7ZnQcYxeDerLy7Q95lyfsob5CBL5bi9YcfeKgEJIpYc
         148W7RBgWIxW1vMKSOYY5j5joImGqPwUViIy3ON30/2bKnIVwX6z1HabHP2XqbsFNQ
         QSvLGb5yMII7f2l0rN+8d0lDFOU5O/Te4lZktVW8=
Received: from lltwa05cxepmx13.bankofamerica.com (lltwa05cxepmx13.bankofamerica.com [171.206.12.29])
        by lltwa05mxepmx03.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7EGSdCI028050;
        Wed, 14 Aug 2019 16:28:51 GMT
Date:   Wed, 14 Aug 2019 16:28:47 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: RE: suggestion for improved docs on autocrlf
In-reply-to: <d4a0500d5f5e4706aef481a33096465a@bofa.com>
X-Originating-IP: [30.245.13.45]
To:     =?iso-8859-1?Q?=27Torsten_B=F6gershausen=27?= <tboegi@web.de>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-id: <0244daea3faa4d4aa899cff0dcc62917@bofa.com>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Content-language: en-US
Content-transfer-encoding: 7BIT
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-topic: suggestion for improved docs on autocrlf
Thread-index: AdVNISlxEEknYFEsRQ6Yj1wK7ruvjABLB7eAAAekNtAADVdLsP//xzkA//9/qwCABDUnAP/+mJWQgANNx4CAADsrQP//18WAABMUKAD//38MoP/+sX+A//2l2mD/+aztkA==
X-MS-TNEF-Correlator: 
References: <577a66e0c26545aaa4795de3c5189c9d@bofa.com> <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
 <0c1b48c9fad641689ead69fdd9f72d63@bofa.com> <20190811121004.guygurnopwwggvsp@tb-raspi4>
 <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com> <20190812171049.ydec3nsmkt2xplhd@tb-raspi4>
 <aae529ce1b084b7bbcca3977e6909417@bofa.com> <xmqqo90u9ric.fsf@gitster-ct.c.googlers.com>
 <20190813032452.qg2ufgljm4bjeznr@tb-raspi4> <a5b84e2b8184414bb416f3aa83361a1c@bofa.com>
 <20190813154033.uhi7w5jgwcj4xan7@tb-raspi4> <d4a0500d5f5e4706aef481a33096465a@bofa.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_06:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Turns out that this is not intentional behavior of IntelliJ but an unfortunate interaction with a bug in git.
Had I been using a more recent version of git, it wouldn't be happening.
https://youtrack.jetbrains.com/issue/IDEA-205601

Patched docs on the way eventually.  Hopefully it's okay if my syntax is a bit off, I don't know AsciiDoc.

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at http://www.bankofamerica.com/emaildisclaimer.   If you are not the intended recipient, please delete this message.
