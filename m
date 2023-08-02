Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FC8C0015E
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 00:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHBAbO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 20:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHBAbN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 20:31:13 -0400
Received: from pv50p00im-hyfv10011601.me.com (pv50p00im-hyfv10011601.me.com [17.58.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9ED2710
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 17:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1690935690;
        bh=7OkADUZNEZiduNy+aSAeSVIpg3iMnY6fyIjrs2mSWvY=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=IkNUHElNS0s4c4pkZ/f6NErZ7cqQCIQ3hBKSuZ5z/5DSNjk/vZU7WvbpaSx7j1FjE
         vjb9FmwC4Kkfg3We6BlN1xBG8Si35yFmFrR5uCZ2ZM5zGxI0TbD9+nz6Ee1hBNxqeA
         G8SqIcBhUQ6jsYoKtgTFl7jG8DbELVG82ZEqUpYVVrthUMgXjuYSpMfTqTHAvUdXgo
         Zef8Dq82PxGCLzKNrzA4ZmTvxVaMDG06FMgNj0UOgOh0O2RcR1qSA40xc7/r/M3TBo
         fPg7g6hsMtyiZGGXxzAFnrt30eMPGBZZ53l0CRDQ2ctrUmbO8+rMle/VBp5WpoZGlX
         uYhEE6ESPHWqQ==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 520ADC800E5;
        Wed,  2 Aug 2023 00:21:29 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From:   =?utf-8?B?4LiB4Lix4Lih4Lib4LiZ4Liy4LiXIOC4l+C4uOC4oeC4p+C4hw==?=
         =?utf-8?B?4Lio4LmM?= <kongpc10@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Wed, 2 Aug 2023 07:21:16 +0700
Subject: Re: [PATCH] fsck: remove redundant parse_tree() invocation
Message-Id: <E4124FFA-9E84-4D5A-BA66-FA7DC262AE1B@icloud.com>
Cc:     git@vger.kernel.org
To:     jonathantanmy@google.com
X-Mailer: iPhone Mail (20G75)
X-Proofpoint-GUID: ZarfLLiKVV3upfoIdH6Z2-uiAKfEf45V
X-Proofpoint-ORIG-GUID: ZarfLLiKVV3upfoIdH6Z2-uiAKfEf45V
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=674 spamscore=0
 adultscore=0 mlxscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2308020001
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCuC4quC5iOC4h+C4iOC4suC4gSBpUGhvbmUg4LiC4Lit4LiH4LiJ4Lix4LiZ
