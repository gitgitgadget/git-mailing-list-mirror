Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E70BC64EC7
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 19:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBYTVw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 25 Feb 2023 14:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjBYTVv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 14:21:51 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F366A27D
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 11:21:50 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 31PJLKcr592139
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Feb 2023 19:21:21 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
Cc:     <git-packagers@googlegroups.com>
References: <xmqq7cw6yfpt.fsf@gitster.g>
In-Reply-To: <xmqq7cw6yfpt.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.40.0-rc0
Date:   Sat, 25 Feb 2023 14:21:39 -0500
Organization: Nexbridge Inc.
Message-ID: <03ae01d9494e$66427b50$32c771f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHvpZQeb5rjigNEfrlIhkHyCCcQD66zT8nQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, February 24, 2023 3:24 PM, Junio C Hamano wrote:
>An early preview release Git v2.40.0-rc0 is now available for testing at the usual
>places.  It is comprised of 417 non-merge commits since v2.39.0, contributed by 71
>people, 24 of which are new faces [*].

Report of NonStop build/test:
* t1800.16 still fails because of text comparison of error messages - reported back around 2.36/2.38 timeframe. It would be similar to the !MINGW special case to correct, which I previously submitted as a fix, but did not get adopted. Issue is only in the test not code, so we let this one get through. This happens on all three NonStop variants.
* t9001.33,86,131-133,160 fails as usual because we have no working send-mail on the platform (this always happens so we ignore this test).

Summary: 2.40.0-rc0 looks fine.

Regards,
Randall


