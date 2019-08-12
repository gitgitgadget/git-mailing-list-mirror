Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E82EF1F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 13:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfHLN6z (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 09:58:55 -0400
Received: from ltwemail.bankofamerica.com ([171.161.41.178]:31420 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726515AbfHLN6z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 09:58:55 -0400
X-Greylist: delayed 690 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Aug 2019 09:58:54 EDT
Received: from lltwa05mxepmx03.bankofamerica.com ([171.180.36.246])
        by lltwa05hxepmx02.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7CDlNSi031251;
        Mon, 12 Aug 2019 13:47:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1565617643;
        bh=qldulWVcXeICZSHh5+lw9giy+zbYNOj/dqwuEHyNnjc=;
        h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
         Content-type:Content-transfer-encoding:References;
        b=FJ5lcxDJf4UWrqqWfH1NWQMozNDZ0aMz9Uk7SIjufkBVC7xDovnV6o0zmlCLWs2Gt
         JzfNs8/4EKQexCaaTk8zB8FTqJ1N8MsUJfypAPrUM/wI4Yop+EXToCDGKZ/NFGEbh1
         lOxCEv2zt00ehnqAgTTGrdrsbSLGt4gN/Moknmeg=
Received: from lltwa05bxepmx12.bankofamerica.com (lltwa05bxepmx12.bankofamerica.com [171.206.12.27])
        by lltwa05mxepmx03.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7CDlFMC002745;
        Mon, 12 Aug 2019 13:47:22 GMT
Date:   Mon, 12 Aug 2019 13:47:18 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: RE: suggestion for improved docs on autocrlf
In-reply-to: <20190811121004.guygurnopwwggvsp@tb-raspi4>
X-Originating-IP: [30.245.13.45]
To:     =?iso-8859-1?Q?=27Torsten_B=F6gershausen=27?= <tboegi@web.de>
Cc:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-id: <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Content-language: en-US
Content-transfer-encoding: 7BIT
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-topic: suggestion for improved docs on autocrlf
Thread-index:  AdVNISlxEEknYFEsRQ6Yj1wK7ruvjABLB7eAAAekNtAADVdLsP//xzkA//9/qwCABDUnAP/+mJWQ
X-MS-TNEF-Correlator: 
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com> <20190808205631.e2647kxq74thotjb@tb-raspi4>
 <3269668c03a8482d8d854ec19dd43907@bofa.com> <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
 <20190809033406.5t5ag3qmh36ideec@tb-raspi4> <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
 <20190811121004.guygurnopwwggvsp@tb-raspi4>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_06:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wait a second... suppose a file is committed with CRLF line endings.
You're saying that even if I have autocrlf set to "input" or "auto", the file will never get "converted" to LF format unless I explicitly renormalize?
That sounds like a fairly sensible behavior, but it's not what I've observed in the past at all!
There have been plenty of times when I had "autocrlf" set to input which resulted in me changing line endings on commit I had no intention of changing!
Indeed, the whole reason I was looking at the git docs recently is that this happened again and I was trying to make it stop happening!
Or is that not what you meant?

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at http://www.bankofamerica.com/emaildisclaimer.   If you are not the intended recipient, please delete this message.
