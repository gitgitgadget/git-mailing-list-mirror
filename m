Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10B4C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 15:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiJSPJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 11:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiJSPJH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 11:09:07 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAFFB495
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 08:01:39 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 29JF1UAC051325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 19 Oct 2022 11:01:31 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <rsbecker@nexbridge.com>, <git@vger.kernel.org>
References: <01cd01d8e3c7$e93bff50$bbb3fdf0$@nexbridge.com>
In-Reply-To: <01cd01d8e3c7$e93bff50$bbb3fdf0$@nexbridge.com>
Subject: RE: 2.38.1 Build Version Confusion 
Date:   Wed, 19 Oct 2022 11:01:24 -0400
Organization: Nexbridge Inc.
Message-ID: <01d101d8e3cb$ab9d7940$02d86bc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFw3wsZA0PwGatLtaORLvCEJEEHM67l2Org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 19, 2022 10:35 AM, I wrote:	
>When I build 2.38.1, I'm ending up with GIT-VERSION-FILE as follows:
>
>$ cat GIT-VERSION-FILE
>GIT_VERSION = 2.38.GIT
>
>$ ./git version
>git version 2.38.GIT
>
>This seems a bit different from past patches. Is this intended?

I should point out that I used the 'main' branch for this build.
-R

