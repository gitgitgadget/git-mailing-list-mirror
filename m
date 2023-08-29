Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6464C71153
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 17:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbjH2R0e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 13:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238070AbjH2R0C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 13:26:02 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4688E66
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 10:25:29 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 37THLPCQ398185
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 17:21:25 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <rsbecker@nexbridge.com>, <git@vger.kernel.org>
References: <079601d9da8c$8768cfd0$963a6f70$@nexbridge.com>
In-Reply-To: <079601d9da8c$8768cfd0$963a6f70$@nexbridge.com>
Subject: RE: Need help on building git with static libz.a
Date:   Tue, 29 Aug 2023 13:23:44 -0400
Organization: Nexbridge Inc.
Message-ID: <07af01d9da9d$9355e1a0$ba01a4e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGt8+K0w19dZNZuWB3rxiwU9+dJfrBZUaqA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, August 29, 2023 11:22 AM, I wrote:
>To: git@vger.kernel.org
>Sorry if I seem clueless on this within the git make infrastructure, but
someone set up
>my new build environment with an incompatible libz.so that I cannot seem to
bypass.
>How can I link git using libz.a instead?

Simple solution is to put the full path to libz.a before any -L in LDFLAGS.

