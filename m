Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFF201F731
	for <e@80x24.org>; Wed,  7 Aug 2019 13:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbfHGNUP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 09:20:15 -0400
Received: from rchemail.bankofamerica.com ([171.159.227.167]:52332 "EHLO
        bankofamerica.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387957AbfHGNUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 09:20:14 -0400
X-Greylist: delayed 705 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Aug 2019 09:20:14 EDT
Received: from vadmzmailmx07.bankofamerica.com ([171.182.203.234])
        by lrcha0mzxepmx02.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x77D8Sb2017032
        for <git@vger.kernel.org>; Wed, 7 Aug 2019 13:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bofa.com;
        s=corp1903; t=1565183308;
        bh=VbgyRwdQoxNpB98AS8eXEuix2cQbZtAeL7ry38E4nwg=;
        h=Date:From:Subject:To:Message-id:MIME-version:Content-type:
         Content-transfer-encoding;
        b=CZ1wnGjeF1T1vh50EpgbwrGDHIw9Hs+zgdQRgMIdj4N6hFnoovNTspLGQU4maY6k8
         oxr/OCGNkfRJ0aK51guELLFSnoCTbIwbKMlcSjjGFG+VliDKgvlHi3kJGap32aKP1R
         rWAT2OXi/IhLXbkUSYTNYvCUDNN5+EgTeDiyF69A=
Received: from lrcha0n5xepmx12.bankofamerica.com (lrcha0n5xepmx12.bankofamerica.com [171.205.12.15])
        by vadmzmailmx07.bankofamerica.com (8.15.2/8.15.2) with ESMTP id x77D8DHc028786
        for <git@vger.kernel.org>; Wed, 7 Aug 2019 13:08:27 GMT
Date:   Wed, 07 Aug 2019 13:08:22 +0000
From:   "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Subject: suggestion for improved docs on autocrlf
X-Originating-IP: [30.245.13.45]
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Message-id: <9c79d35e48df4d28baf995ad3f5b0153@bofa.com>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Content-language: en-US
Content-transfer-encoding: 7BIT
X-MS-Has-Attach: 
Accept-Language: en-US
Thread-topic: suggestion for improved docs on autocrlf
Thread-index: AdVNISlxEEknYFEsRQ6Yj1wK7ruvjA==
X-MS-TNEF-Correlator: 
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_03:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I hope this is the right mailing list, hope someone will redirect me if not...
The git documentation (git help config) for core.autocrlf doesn't mention that false is a valid option; it only mentions true and input.
Further, the docs for "input" are misleading, in that they lead the reader to assume it behaves like "false".

Would probably be nice if this were fixed :)
Mark.

----------------------------------------------------------------------
This message, and any attachments, is for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at http://www.bankofamerica.com/emaildisclaimer.   If you are not the intended recipient, please delete this message.
