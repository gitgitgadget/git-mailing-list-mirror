Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463C0C71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 15:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbjH2PWD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 11:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbjH2PVz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 11:21:55 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C141B4
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 08:21:53 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37TFJNA0364428
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 15:19:24 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: Need help on building git with static libz.a
Date:   Tue, 29 Aug 2023 11:21:41 -0400
Organization: Nexbridge Inc.
Message-ID: <079601d9da8c$8768cfd0$963a6f70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdnajEboDkF/WTCmTB+KJJyNeLtqWw==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All,

Sorry if I seem clueless on this within the git make infrastructure, but
someone set up my new build environment with an incompatible libz.so that I
cannot seem to bypass. How can I link git using libz.a instead?

Thanks,
Randall


