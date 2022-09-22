Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C6FECAAD8
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 19:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiIVTDO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 15:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiIVTDN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 15:03:13 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B225F963F
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 12:03:12 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 28MJ33kT071942
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Sep 2022 15:03:04 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <rsbecker@nexbridge.com>, <git@vger.kernel.org>
References: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com>
In-Reply-To: <022e01d8ceb5$c2da52c0$488ef840$@nexbridge.com>
Subject: RE: [BUG] Git 2.38.0-rc1 t1800 message text comparison
Date:   Thu, 22 Sep 2022 15:02:59 -0400
Organization: Nexbridge Inc.
Message-ID: <023101d8ceb5$f1c28850$d54798f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdjOtdo9mObKgbHpRkyfW3iShvKnNA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 22, 2022 3:02 PM, I wrote:
>Rc1 is looking good except for this test.
>
>We get a diff as follows:
>
>-fatal: cannot run bad-hooks/test-hook: ...
>+fatal: cannot exec 'bad-hooks/test-hook': Permission denied
>
>It looks like the pattern
>sed -e s/test-hook: .*/test-hook: .../
>
>needs to be a bit extended. Adding
>
>sed -e s/exec/run/ | send -e s/["']//g
>
>might help clear off the other noise.

The subject should have been 2.38.0, not 2.28.0.

