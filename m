Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54874C07E96
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 17:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D3F61874
	for <git@archiver.kernel.org>; Thu,  8 Jul 2021 17:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhGHR2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jul 2021 13:28:49 -0400
Received: from elephants.elehost.com ([216.66.27.132]:25497 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhGHR2t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jul 2021 13:28:49 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 168HQ51f019100
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 8 Jul 2021 13:26:05 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Question] worktree vs. gitdir in [includeIf]
Date:   Thu, 8 Jul 2021 13:25:59 -0400
Message-ID: <003701d7741e$550b6510$ff222f30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: Add0HfgVm2ZC5kEDR+i28x6tkxCQVw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git Team,

I am wondering whether there is, or are plans for, something analogous to [includeIf "worktree:path"] with a similar semantic to
[includeIf "gitdir:path"]. 

Thanks,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.



