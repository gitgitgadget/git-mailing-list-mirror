Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F72DC04FF3
	for <git@archiver.kernel.org>; Mon, 24 May 2021 22:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC43C613EC
	for <git@archiver.kernel.org>; Mon, 24 May 2021 22:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhEXWjJ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 24 May 2021 18:39:09 -0400
Received: from elephants.elehost.com ([216.66.27.132]:12823 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEXWjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 18:39:09 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 14OMbY3O017348
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 May 2021 18:37:35 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'Jean-No=C3=ABl_AVILA'?=" <jn.avila@free.fr>
Cc:     <git@vger.kernel.org>
Subject: RE: [ANNOUNCE] Git v2.32.0-rc1 - Defect in t0301.3, t1092.6, t5300
Date:   Mon, 24 May 2021 18:37:29 -0400
Message-ID: <036b01d750ed$642b75c0$2c826140$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AddQ7QavkgediSQSS1Oul9eJj2/89w==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>Subject: Re: [ANNOUNCE] Git v2.32.0-rc1

On running the test suite on NonStop, t1092 fails in subtest 6 - but not when run with --verbose and -x, so I can't supply a log. This may be timing related. I wanted to report this in case anyone had any insight on whether there are any possible transient vulnerabilities. t0301.3 often has transient failures - which has been experienced for a while. Most importantly, t5300 continues to fail completely on the x86 platform, but not ia64, which I previously reported.

-Randall


