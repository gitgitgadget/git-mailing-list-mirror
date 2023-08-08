Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C3C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbjHHTUp convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Aug 2023 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjHHTUX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:20:23 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F7C16561
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:43:36 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 378DQ8eC118611
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 8 Aug 2023 13:26:08 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
References:  <MW2PR12MB25558D1886C4AA2A95A5FC618709A@MW2PR12MB2555.namprd12.prod.outlook.com> <015101d9c6f9$218ceb20$64a6c160$@nexbridge.com>  <MW2PR12MB2555BB4CEE6BA6B38F4381428709A@MW2PR12MB2555.namprd12.prod.outlook.com> <015901d9c6ff$43606050$ca2120f0$@nexbridge.com> <MW2PR12MB25557AAF161A92E862AE5EE2870CA@MW2PR12MB2555.namprd12.prod.outlook.com>  <MW2PR12MB2555240C4E2A9EB6332A8CAD870DA@MW2PR12MB2555.namprd12.prod.outlook.com>
In-Reply-To:  <MW2PR12MB2555240C4E2A9EB6332A8CAD870DA@MW2PR12MB2555.namprd12.prod.outlook.com>
Subject: RE: [EXTERNAL] RE: git bug report
Date:   Tue, 8 Aug 2023 09:28:13 -0400
Organization: Nexbridge Inc.
Message-ID: <064501d9c9fc$31e45750$95ad05f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHVPeJBGZLMc5nAv9V18HhdmYtcngIBTFUtAnxDwA4Bb/RQXwJhgQPDAX8KJpOvmwvMEA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, August 8, 2023 9:08 AM, Paul Watson wrote:
>>From: rsbecker@nexbridge.com <rsbecker@nexbridge.com>
>>
>>> I am not convinced this is a defect. The result of --shortstat is to
>>> report that there are differences, so it is possible that 0 is
>>> correct here. Others might have a different opinion. I can recreate
>>> without including any other options.
>>
>> The code has already done the work to identify if there are differences. > Why
>would it not return a meaningful exit code?
>
>Also, since the --exit-code switch has been specified, it should set the exit code
>accordingly.

I think this is a decision for the maintainers, whether I agree or disagree. I have to defer to others.

--Randall

