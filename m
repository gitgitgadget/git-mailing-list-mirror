Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F8161F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 18:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfHLSaO (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 14:30:14 -0400
Received: from rchemail.bankofamerica.com ([171.159.227.167]:50389 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbfHLSaO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 14:30:14 -0400
Received: from vadmzmailmx07.bankofamerica.com ([171.182.203.234])
        by lrcha0n0xepmx04.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7CIUBaR015638;
        Mon, 12 Aug 2019 18:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1565634611;
        bh=xVp/VFT3X2JKdCyVOyatSeyT5YrgLYChfObLey+CDK0=;
        h=Date:From:Subject:In-reply-to:To:Cc:Message-id:MIME-version:
         Content-type:Content-transfer-encoding:References;
        b=O+L6CZq/6S6TWQ8dOixmFqLRahPxTNjrgsKXFRlYXZj6DQp/KIUSTscUzXf+dKYfw
         bUVYPXOSvrjIb74Vuxq4MY/wCwqcARIXQmJY6RcMArz0/u4NFLZgLsHOa/nsy2oL3T
         p/RNpTVTCdfvbyn7A0Da4ovWVBrH3pg8A3a3A8IA=
Received: from lrcha0n6xepmx13.bankofamerica.com (lrcha0n6xepmx13.bankofamerica.com [171.205.12.14])
        by vadmzmailmx07.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x7CIU2YX029726;
        Mon, 12 Aug 2019 18:30:11 GMT
Date:   Mon, 12 Aug 2019 18:30:08 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: RE: suggestion for improved docs on autocrlf
In-reply-to: <xmqqo90u9ric.fsf@gitster-ct.c.googlers.com>
X-Originating-IP: [30.245.13.45]
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=27Torsten_B=F6gershausen=27?= <tboegi@web.de>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-id: <e47edd8a079d40c8a4151d4d73060b31@bofa.com>
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
Content-language: en-US
Content-transfer-encoding: quoted-printable
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-topic: suggestion for improved docs on autocrlf
Thread-index: AdVNISlxEEknYFEsRQ6Yj1wK7ruvjABLB7eAAAekNtAADVdLsP//xzkA//9/qwCABDUnAP/+mJWQgANNx4CAADsrQP//18WAAAgEaMA=
X-MS-TNEF-Correlator: 
References: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com> <20190808205631.e2647kxq74thotjb@tb-raspi4>
 <3269668c03a8482d8d854ec19dd43907@bofa.com> <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
 <20190809033406.5t5ag3qmh36ideec@tb-raspi4> <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
 <20190811121004.guygurnopwwggvsp@tb-raspi4> <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
 <20190812171049.ydec3nsmkt2xplhd@tb-raspi4> <aae529ce1b084b7bbcca3977e6909417@bofa.com>
 <xmqqo90u9ric.fsf@gitster-ct.c.googlers.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_07:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Okay, let me be more explicit :)
Suppose "git check-attr -a ." produces no output.
Now, is predictable?

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behal=
f Of Junio C Hamano
Sent: Monday, August 12, 2019 2:19 PM
To: Yagnatinsky, Mark <mark.yagnatinsky@bofa.com>
Cc: 'Torsten B=F6gershausen' <tboegi@web.de>; 'git@vger.kernel.org' <git@vg=
er.kernel.org>
Subject: Re: suggestion for improved docs on autocrlf

"Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com> writes:

> ...  Assuming the repo has no .gitattributes,
> is it possible to predict what line endings sample.txt will end up with i=
n my repo?
> Or does it depend on more information than what I've just written?

Binary packagers can ship custom attributes and config that applies
globally to the installation, which may affect operations in all of
your repositories, can't they?

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, m=
ay contain information that is privileged, confidential and/or proprietary =
and subject to important terms and conditions available at http://www.banko=
famerica.com/emaildisclaimer.   If you are not the intended recipient, plea=
se delete this message.
