Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28780C433EF
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 12:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiGMMLS convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 13 Jul 2022 08:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiGMMLS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 08:11:18 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ADCF5D74
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 05:11:17 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.96.21] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 26DCBBLY017963
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jul 2022 08:11:12 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <xmqqv8s2fefi.fsf@gitster.g>
In-Reply-To: <xmqqv8s2fefi.fsf@gitster.g>
Subject: [Test Failures] Git v2.37.1 (was RE: [ANNOUNCE] Git v2.37.1 and others)
Date:   Wed, 13 Jul 2022 08:11:06 -0400
Organization: Nexbridge Inc.
Message-ID: <01af01d896b1$a48e32f0$edaa98d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdiWsJ8ex3E0UdAaTz+Wp3V9O1UT0A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 12, 2022 1:07 PM, Junio C Hamano wrote:
>Git v2.37.1, together with v2.30.5, v2.31.4, v2.32.3, v2.33.4, v2.34.4, v2.35.4, and
>v2.36.2 for older maintenance tracks, are now available at the usual places.
>
>These are to address CVE-2022-29187, where the fixes in v2.36.1 and below to
>address CVE-2022-24765 released earlier may not have been complete.

Following are net new test failures with 2.37.1 compared with 2.37.0 are as follows on NonStop ia64 and x86 platforms:

t5516-fetch-push subtests 53, 113

t5545-push-options subtest 9

t5601-clone subtest 8

t7502-commit-porcelain subtests 20-26, 29-33, 42-47

t7528-signed-commit-ssh subtests 4, 5

I am investigating, but as it stands, we cannot package this release for our platform at this time.

Sincerely,
Randall

