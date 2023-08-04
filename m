Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F0BC001DE
	for <git@archiver.kernel.org>; Fri,  4 Aug 2023 18:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjHDSNP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 4 Aug 2023 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjHDSMp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2023 14:12:45 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B38349F0
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 11:12:44 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 374IAYof3642851
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 18:10:35 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Paul Watson'" <pwatson2@wellmed.net>, <git@vger.kernel.org>
References:  <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com> <015101d9c6f9$218ceb20$64a6c160$@nexbridge.com>  <MW2PR12MB2555BB4CEE6BA6B38F4381428709A@MW2PR12MB2555.namprd12.prod.outlook.com>
In-Reply-To:  <MW2PR12MB2555BB4CEE6BA6B38F4381428709A@MW2PR12MB2555.namprd12.prod.outlook.com>
Subject: RE: [EXTERNAL] RE: git bug report
Date:   Fri, 4 Aug 2023 14:12:37 -0400
Organization: Nexbridge Inc.
Message-ID: <015901d9c6ff$43606050$ca2120f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHVPeJBGZLMc5nAv9V18HhdmYtcngIBTFUtAnxDwA6vv5WCIA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, August 4, 2023 1:49 PM, Paul Watson wrote:
>From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>
>Sent: Friday, August 4, 2023 12:29
>
>>> Can you retry this without --shortstat so we can see what git is
>>> reporting as a difference.
>
>The problem appears to be the use of --shortstat. When --shortstat is not used, the
>exit code for different files is one (1), as expected.

I am not convinced this is a defect. The result of --shortstat is to report that there are differences, so it is possible that 0 is correct here. Others might have a different opinion. I can recreate without including any other options.

