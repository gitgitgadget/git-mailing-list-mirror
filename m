Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41409C001DF
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 17:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjHDR2z convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 4 Aug 2023 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjHDR2w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 13:28:52 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A0049C1
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 10:28:51 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 374HQeNY3635390
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 17:26:41 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Paul Watson'" <pwatson2@wellmed.net>, <git@vger.kernel.org>
References:  <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
In-Reply-To:  <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com>
Subject: RE: git bug report
Date:   Fri, 4 Aug 2023 13:28:43 -0400
Organization: Nexbridge Inc.
Message-ID: <015101d9c6f9$218ceb20$64a6c160$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHVPeJBGZLMc5nAv9V18HhdmYtcnq/jdUGQ
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, August 4, 2023 12:46 PM, Paul Watson wrote:
>Thank you for filling out a Git bug report!
>Please answer the following questions to help us understand your issue.
>
>What did you do before the bug happened? (Steps to reproduce your issue)
>
>9:43:55.45 2023-08-04  C:\src\t\scripts>TYPE .\t1.txt this is t1.txt
>
>9:43:57.92 2023-08-04  C:\src\t\scripts>TYPE .\t2.txt this is t2.txt
>
>9:43:58.04 2023-08-04  C:\src\t\scripts>"C:\Program Files\Git\cmd\git.exe" diff --exit-
>code --no-index  --ignore-all-space  --shortstat  .\t1.txt .\t2.txt
>1 file changed, 1 insertion(+), 1 deletion(-)

Can you retry this without --shortstat so we can see what git is reporting as a difference.

Thanks,
Randall

