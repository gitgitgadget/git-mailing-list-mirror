Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E20C54EBC
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 12:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjALMIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 07:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjALMHa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 07:07:30 -0500
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Jan 2023 04:02:36 PST
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B011CE33
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 04:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1673524491;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=QgAFum2pccoSBQhCSd7EP4NouE2DstshIF+lNRARjZ+hbjrhjSLEjPR/CHUqpzLQ5
         xIAiyAMnvCL/wOpKlLInlNVkH78F0flCVLa1eJOW3sNX513c6DqZjh8Ex0frzv4fMd
         KK63IcyafCbaRfaBx+pRP2zmwvwZtBI9wS4yEskQ4yj2CvO7jWCx/WneXCHC7zfvB1
         Tx3iMfnPfshV7Ym5oib737s+uvyzBwWyicIXniF1raLnB5FvW3VbMfQF/xghZjg3j6
         r3+Wu/IngL5Dm/RiilmJV/n675a9x7xACUdlQ6f3NWzfBc6NIcR84xp74lGPC8yB9s
         kdgYrB/L072Fg==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id B2D7DDC06C2;
        Thu, 12 Jan 2023 11:54:49 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Mohammed Al-Mahmeed <m.mahmeed911@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Thu, 12 Jan 2023 14:54:31 +0300
Subject: Re: A few usability question about git diff --cached
Message-Id: <85443F05-6EF2-4EE2-B90B-6113D8D4B195@icloud.com>
Cc:     git@vger.kernel.org, paolo.ciarrocchi@gmail.com,
        vmiklos@frugalware.org
To:     gitster@pobox.com
X-Mailer: iPhone Mail (20C65)
X-Proofpoint-ORIG-GUID: 3sWi39-_K1OiCYE5VkHUtVdt-zrzM7Rd
X-Proofpoint-GUID: 3sWi39-_K1OiCYE5VkHUtVdt-zrzM7Rd
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=626 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2301120083
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
