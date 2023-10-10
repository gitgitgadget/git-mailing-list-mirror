Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCB4CD68E4
	for <git@archiver.kernel.org>; Tue, 10 Oct 2023 03:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442080AbjJJDzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 23:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442013AbjJJDzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 23:55:36 -0400
X-Greylist: delayed 495 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 20:55:35 PDT
Received: from ci74p00im-qukt09082702.me.com (ci74p00im-qukt09082702.me.com [17.57.156.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6FC92
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 20:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1696909639;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=QBJx1NfYtVlF6ZcvVJEn2lDVgN5zecOYqKd4oB82y2VIX91ZrBNNIr8PtEE6OOpQk
         sGecODjbmYCGma9iL5BCI+sa8oX8yEcpvxQfSztBrny33sow49ekjGTDZHVLUq1ZdH
         z1dl79/MxyQBL15O14RfeEXm5otNNfPELzw2eaF/it62b5ygckf5G5ms7FqRmgPdoJ
         u/2awZxIcqNEsA1djW3nFZVUA6tFvg9T0ZwJ5sRY419BIJ59ejAbHhzEA+ozftwW/0
         FOLvOLqGJFWV3ULEbv+hTK4HE8KAOUL0xYIqwNDM9rs5wxAbWorDyrVleL/AL51JlR
         QKInslE1MWoPQ==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
        by ci74p00im-qukt09082702.me.com (Postfix) with ESMTPSA id 306D41540239;
        Tue, 10 Oct 2023 03:47:18 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Russell Nelson <hdrdistributions@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Date:   Mon, 9 Oct 2023 22:46:57 -0500
Message-Id: <4FA1C740-7ABE-450D-A176-0E6ACDB3937C@icloud.com>
Cc:     ae@op5.se, git@vger.kernel.org
To:     junkio@cox.net
X-Mailer: iPhone Mail (20G81)
X-Proofpoint-ORIG-GUID: M2yIr1lxmE-SrqvYvX3tDvusY_t27rXs
X-Proofpoint-GUID: M2yIr1lxmE-SrqvYvX3tDvusY_t27rXs
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=672 phishscore=0 mlxscore=0 clxscore=1011 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2310100025
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
