Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8376C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 18:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiI1SSt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 28 Sep 2022 14:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbiI1SSZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 14:18:25 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53887108099
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 11:17:42 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 28SIH4lV091250
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Sep 2022 14:17:04 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: <xmqqzgek1q1p.fsf@gitster.g>
In-Reply-To: <xmqqzgek1q1p.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.38.0-rc2
Date:   Wed, 28 Sep 2022 14:16:58 -0400
Organization: Nexbridge Inc.
Message-ID: <003401d8d366$828ccc60$87a66520$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQM1RZ4x/U93cM2W9TAIx9ZSI5Lu76s8QVmg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 27, 2022 5:11 PM, Junio C Hamano wrote:
>A release candidate Git v2.38.0-rc2 is now available for testing at
>the usual places.  It is comprised of 673 non-merge commits since
>v2.37.0, contributed by 81 people, 23 of which are new faces [*].

The release looks good on NonStop but does not contain the patch I sent for t1800-hook.sh. The test fails because the text message is different (wrapped in ' and says exec instead of run or spawn).

Regards,
Randall

