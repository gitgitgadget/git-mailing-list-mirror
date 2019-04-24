Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE6A1F453
	for <e@80x24.org>; Wed, 24 Apr 2019 10:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfDXK0W (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 06:26:22 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:33279 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfDXK0V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 06:26:21 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 8AA023C00D1;
        Wed, 24 Apr 2019 12:26:19 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id E2ybei36jII0; Wed, 24 Apr 2019 12:26:13 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 15EB43C0034;
        Wed, 24 Apr 2019 12:26:13 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 12:26:12 +0200
Date:   Wed, 24 Apr 2019 12:26:09 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Multi-line 'git log -G<regex>'?
Message-ID: <20190424102609.GA19697@vmlxhi-102.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.72.93.184]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git community,

In the context of [1], I would like to find all Linux commits which
replaced:
	'devm_request_threaded_irq(* IRQF_SHARED *)'
by:
	'devm_request_threaded_irq(* IRQF_ONESHOT *)'

Actually, I would be happy with a much lower degree of precision, e.g.
finding commits which _removed_ IRQF_SHARED and _added_ IRQF_ONESHOT.

I am aware of the difference between `git log -G` and `git log -S`, but
these two options alone don't seem to help me in this particular
scenario. Is there any git built-in way to achieve my goal?

[1] https://patchwork.kernel.org/patch/10914083/
    ("[v4,1/2] thermal: rcar_gen3_thermal: fix interrupt type")

-- 
Best regards,
Eugeniu.
