Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1758C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 15:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244154AbjD0Pgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 11:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjD0Pgi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 11:36:38 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10977FF
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 08:36:37 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 33RFZWI82078462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 15:35:32 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Guillaume Noailhac'" <guillaume.noailhac@sysgo.com>,
        <git@vger.kernel.org>
References: <235af3bc-57e3-283f-6d4d-177ccf273909@sysgo.com>
In-Reply-To: <235af3bc-57e3-283f-6d4d-177ccf273909@sysgo.com>
Subject: RE: difftool does not support --submodule=diff
Date:   Thu, 27 Apr 2023 11:36:28 -0400
Organization: Nexbridge Inc.
Message-ID: <045301d9791e$0c0a6d50$241f47f0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG7s8/IlV4I1+f3lz4KC60r8NNpY6961CPw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, April 27, 2023 11:29 AM, Guillaume Noailhac wrote:
>I would like to see the complete directories diff of my git project
>using the command difftool.
>
>Today the command difftool does not support --submodule=diff.

Would git submodule foreach git diff ... work for you?
--Randall

