Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC692C4332F
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 14:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJSOsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJSOrj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 10:47:39 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9E273336
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 07:34:38 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 29JEYaiw050374
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 10:34:36 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: 2.38.1 Build Version Confusion 
Date:   Wed, 19 Oct 2022 10:34:30 -0400
Organization: Nexbridge Inc.
Message-ID: <01cd01d8e3c7$e93bff50$bbb3fdf0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Adjjx8g+3vPRDBaoQVCXmpqK2r2rzw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Team,

When I build 2.38.1, I'm ending up with GIT-VERSION-FILE as follows:

$ cat GIT-VERSION-FILE
GIT_VERSION = 2.38.GIT

$ ./git version
git version 2.38.GIT

This seems a bit different from past patches. Is this intended?

Thanks,
Randall

--
Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)
NonStop(211288444200000000)
-- In real life, I talk too much.



