Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3820C43217
	for <git@archiver.kernel.org>; Sun, 27 Nov 2022 18:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiK0SiU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 27 Nov 2022 13:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiK0SiT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2022 13:38:19 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E259F9FFF
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 10:38:18 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2ARIcGYW043856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 27 Nov 2022 13:38:17 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Kirill Frolov'" <frolovkirill7@gmail.com>, <git@vger.kernel.org>
References: <16587f28-bd73-39ba-04da-bd0e2240f48c@gmail.com>
In-Reply-To: <16587f28-bd73-39ba-04da-bd0e2240f48c@gmail.com>
Subject: RE: git ls-remote windows issue.
Date:   Sun, 27 Nov 2022 13:38:10 -0500
Organization: Nexbridge Inc.
Message-ID: <01c001d9028f$69c86560$3d593020$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKuwefa2lfxGxBajP418g9QMPRb96ynmoRg
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On November 27, 2022 1:26 PM, Kirill Frolov wrote:
>When i run  "git ls-remote `origin` HEAD" on windows machine i get
>"fatal: ''origin'' does not appear to be a git repository"
>
>When i run the same command on same repository on linux machine i get
>"b7efcb7055a6d45f53c05270a2420aaedaba4d02        HEAD"

Try removing the quote characters around origin under Windows. I can reproduce this on Linux using "'origin'", so it appears that the single quotes in your Windows command prompt are being passed in with origin instead of removed as in Linux.

-Randall

