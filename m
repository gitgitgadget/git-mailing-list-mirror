Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D73AEB64DD
	for <git@archiver.kernel.org>; Wed,  2 Aug 2023 00:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjHBA27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 20:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHBA26 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 20:28:58 -0400
X-Greylist: delayed 446 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Aug 2023 17:28:57 PDT
Received: from pv50p00im-tydg10021701.me.com (pv50p00im-tydg10021701.me.com [17.58.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAD92701
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 17:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1690936137;
        bh=7OkADUZNEZiduNy+aSAeSVIpg3iMnY6fyIjrs2mSWvY=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=h/fbA35upWTv+C3MSeWfSlUgsA3l9sT2+HjroC8mdLvS+naRUJqiqOaceCvaznDWc
         qbRE0XJQgLQBXwN/O8UImRJ32enpC2WeJ9q9boD3IxYWKlHrdfsbjgdbZSXhcsRb7z
         /vyQqgb2rWrcLlgsiyxsILkO/3tze5vk2S/jlKFd3JYVZgD4dnv+DVicp8ER0DsdKE
         5pws9isglBxB90uCct6PdNA/VZGOQZFcdaTFGSI9xLmMtokCSaWPBIa2mGuDkJuU4r
         bpAaB6Ixpc2GFvtXxMTVwzbG0vDJNoBMQ8lheK0fEvuUEyPZvhVJ7lBfQEUhZnnycy
         PK139S4OoCw+Q==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-tydg10021701.me.com (Postfix) with ESMTPSA id 123DC3A0A46;
        Wed,  2 Aug 2023 00:28:55 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From:   =?utf-8?B?4LiB4Lix4Lih4Lib4LiZ4Liy4LiXIOC4l+C4uOC4oeC4p+C4hw==?=
         =?utf-8?B?4Lio4LmM?= <kongpc10@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Wed, 2 Aug 2023 07:28:43 +0700
Subject: Re: [PATCH] fsck: remove redundant parse_tree() invocation
Message-Id: <9373EE0B-B835-43DB-AFA8-E57F1EBF9BB4@icloud.com>
Cc:     git@vger.kernel.org
To:     jonathantanmy@google.com
X-Mailer: iPhone Mail (20G75)
X-Proofpoint-ORIG-GUID: l7azYgealGHl0YOlz90PB9RiiTCTYzBe
X-Proofpoint-GUID: l7azYgealGHl0YOlz90PB9RiiTCTYzBe
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=674 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2308020002
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCuC4quC5iOC4h+C4iOC4suC4gSBpUGhvbmUg4LiC4Lit4LiH4LiJ4Lix4LiZ
