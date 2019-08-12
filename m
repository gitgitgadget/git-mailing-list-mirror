Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713421F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 15:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfHLPwv (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 11:52:51 -0400
Received: from ltwemail.bankofamerica.com ([171.161.41.178]:34715 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726219AbfHLPwv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 11:52:51 -0400
Received: from lltwa05lxepmx01.bankofamerica.com ([171.180.36.243])
        by lltwa05ixepmx04.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7CFqkcX014309;
        Mon, 12 Aug 2019 15:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1565625166;
        bh=g1ppzYa74AK7IGHsPxf1Z3H1KzN1xKR/O5TkdqbduYo=;
        h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
         Content-type:Content-transfer-encoding:References;
        b=FPVpkZ83L5+7ULRsv+jFYPuwK7PxS6qZLJDhYukeSNeDXA2UT6yTOnIBtp2ylod2M
         qt6hKR8FoGMe6h+32IjPvk6zbEILgjCFkfUm83flPc2rxPLAHVfueKa7F1cikGWpZb
         iuoFG1h8U/hSTB/cjx4kVaV21I+zvIUorCKIb6qk=
Received: from lltwa05bxepmx12.bankofamerica.com (lltwa05bxepmx12.bankofamerica.com [171.206.12.27])
        by lltwa05lxepmx01.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7CFqjPa006570;
        Mon, 12 Aug 2019 15:52:45 GMT
Date:   Mon, 12 Aug 2019 15:52:40 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: RE: suggestion for improved docs on autocrlf
In-reply-to: <xmqqo90ubd3g.fsf@gitster-ct.c.googlers.com>
X-Originating-IP: [30.245.13.45]
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=27Torsten_B=F6gershausen=27?= <tboegi@web.de>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-id: <c68955b3196a458ca9b502ee8690af8e@bofa.com>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Content-language: en-US
Content-transfer-encoding: 7BIT
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-topic: suggestion for improved docs on autocrlf
Thread-index:  AdVNISlxEEknYFEsRQ6Yj1wK7ruvjABLB7eAAAekNtAADVdLsP//xzkA//9/qwCABDUnAP/+mJWQgAM2W4CAAEKQMA==
X-MS-TNEF-Correlator: 
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com> <20190808205631.e2647kxq74thotjb@tb-raspi4>
 <3269668c03a8482d8d854ec19dd43907@bofa.com> <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
 <20190809033406.5t5ag3qmh36ideec@tb-raspi4> <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
 <20190811121004.guygurnopwwggvsp@tb-raspi4> <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
 <xmqqo90ubd3g.fsf@gitster-ct.c.googlers.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_06:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

But I don't even have a git attributes file!  There's no attribute flipping going on, I think.
The CRLF'd file was committed by someone else on my team, who probably has git configured differently than I do.
Or am I missing the point?

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at http://www.bankofamerica.com/emaildisclaimer.   If you are not the intended recipient, please delete this message.
