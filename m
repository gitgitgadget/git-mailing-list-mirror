Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4404C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 08:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbiFOIFs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 04:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237955AbiFOIFr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 04:05:47 -0400
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Jun 2022 01:05:46 PDT
Received: from st43p00im-zteg10062001.me.com (st43p00im-zteg10062001.me.com [17.58.63.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B088C4705C
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 01:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1655279924;
        bh=Iw2Sz+7ab4j8EfQ2HRy5Y/deHoPXqRtYIYWvoxj1bAI=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=dqeZ2A1hWPgc+67XaozW0Cm7F6iSIhgbPPkjR6sgG8DmL+O90gaq+C1LGLiugYc5+
         yyVh2CzZdMJ8emHKXetQmodeMbIZh+LV3y6nSHNU7g6geraD6EVDWQmMMj5/V1+/Ya
         B4WzWq/KoddKb9EaBP01+IUp36jykYqNqrdD/eg2WvHnbm8rtO7ZtBoOMlhmzIYn8Y
         dRdH8vnnqfoXVvuONpLHjFWtMl2O+cc2UZPF28F20yZWypQsd6WX2llMmX/DrRyDPH
         v4TxxN7zowPuCc+Sj2mSS9fSlrhkiwG70MkkIGwFIfbs/riwy6UTdYllTMAgpqHCMj
         QZGfjl5oTi4fQ==
Received: from smtpclient.apple (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-zteg10062001.me.com (Postfix) with ESMTPSA id 8F129800641;
        Wed, 15 Jun 2022 07:58:43 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From:   Ali Almrhbi <alialmrhbi0@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Wed, 15 Jun 2022 10:58:37 +0300
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Message-Id: <96A237BC-9E68-4DD1-A015-988944ACE1F8@icloud.com>
Cc:     ae@op5.se, git@vger.kernel.org, jakesteward0916@gmail.com,
        junkio@cox.net
To:     nnn2271989@icloud.com
X-Mailer: iPhone Mail (19D52)
X-Proofpoint-GUID: srD1zyHP4kDGgiKpr_XIziIUFxZ_wAEr
X-Proofpoint-ORIG-GUID: srD1zyHP4kDGgiKpr_XIziIUFxZ_wAEr
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 clxscore=1011 mlxlogscore=531 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2206150029
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCuKAq9ij2Y/Ysdiz2YTYqiDZhdmGINin2YTZgCBpUGhvbmXigKw=
