Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D0C91F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 15:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbfHMPbv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 11:31:51 -0400
Received: from ltwemail.bankofamerica.com ([171.161.41.178]:36317 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728738AbfHMPbv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 11:31:51 -0400
Received: from lltwa05lxepmx01.bankofamerica.com ([171.180.36.243])
        by lltwa05ixepmx04.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7DFVk13031833;
        Tue, 13 Aug 2019 15:31:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1565710306;
        bh=O8cjT3t0kDnQa81+6LZYUaI7QqyN99uhlvuzgZYsE80=;
        h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
         Content-type:Content-transfer-encoding:References;
        b=KaP/woAv5idPYwWoU2vMZK9H1lWx+7nxnU0IUngnDmQ/9NS6qWq89JkedM1uhisxR
         CHgvcNxRcMgOG51hN2IEWHDyeSEMlJOVooIlSSFB1l6CI4coVrUTj4i/yZDFUXWDYZ
         omAsUeyYWthZTDgrV+fgH3ykZB0GQwEP1gpwq6C4=
Received: from lltwa05cxepmx13.bankofamerica.com (lltwa05cxepmx13.bankofamerica.com [171.206.12.29])
        by lltwa05lxepmx01.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7DFVjtF023520;
        Tue, 13 Aug 2019 15:31:46 GMT
Date:   Tue, 13 Aug 2019 15:31:43 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: RE: suggestion for improved docs on autocrlf
In-reply-to: <20190813032452.qg2ufgljm4bjeznr@tb-raspi4>
X-Originating-IP: [30.245.13.45]
To:     =?iso-8859-1?Q?=27Torsten_B=F6gershausen=27?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-id: <a5b84e2b8184414bb416f3aa83361a1c@bofa.com>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Content-language: en-US
Content-transfer-encoding: 7BIT
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-topic: suggestion for improved docs on autocrlf
Thread-index: AdVNISlxEEknYFEsRQ6Yj1wK7ruvjABLB7eAAAekNtAADVdLsP//xzkA//9/qwCABDUnAP/+mJWQgANNx4CAADsrQP//18WAABMUKAD//38MoA==
X-MS-TNEF-Correlator: 
References: <20190808205631.e2647kxq74thotjb@tb-raspi4> <3269668c03a8482d8d854ec19dd43907@bofa.com>
 <577a66e0c26545aaa4795de3c5189c9d@bofa.com> <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
 <0c1b48c9fad641689ead69fdd9f72d63@bofa.com> <20190811121004.guygurnopwwggvsp@tb-raspi4>
 <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com> <20190812171049.ydec3nsmkt2xplhd@tb-raspi4>
 <aae529ce1b084b7bbcca3977e6909417@bofa.com> <xmqqo90u9ric.fsf@gitster-ct.c.googlers.com>
 <20190813032452.qg2ufgljm4bjeznr@tb-raspi4>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_05:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you once more.  Finally, I believe I understood everything you said.
I was about to say that this contradicts my own experience.
But then I remembered that I normally use my IDE rather than the command line.
And I just checked that indeed that the behavior of my IDE is totally different!
It renormalizes line endings of existing files whenever autocrlf is set to input.
Sigh.  Okay, great, life makes sense again.  I want to yell at my IDE now.

I now feel brave enough to attempt to come up with better wording for autocrlf docs, if you think that's worth trying.

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at http://www.bankofamerica.com/emaildisclaimer.   If you are not the intended recipient, please delete this message.
