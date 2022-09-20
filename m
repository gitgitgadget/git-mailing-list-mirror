Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C51C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 02:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiITCJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 22:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiITCJy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 22:09:54 -0400
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 19 Sep 2022 19:09:52 PDT
Received: from cu-gy11p00im-quki08142302.gy.silu.net (cu-gy11p00im-quki08142302.gy.silu.net [157.255.1.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E88E646E
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 19:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1ca1ba; t=1663639444;
        bh=diYoOCM7OW2tiAuhcmQMHsRlc4hkgw3NjCPUtbXe2TY=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=sgwln3Gfx96EjnpONBIT2Sti+LXEAjC+xy/xgF8juC2CcIjjsiMiyHmtiQihTFcU6
         nq+ABgeP2sINeeNQAsjJJspYj2oOdXB3tu9aoulhRHIJsZyBZkCvLXSqnPueksoUB1
         wJkL5HPojJLDBGiaG+FBORnI/k6gO/samEi3AuQd2HZV0Udo9dcpUyUZ34/vih2aMx
         uf1ihlyYvsKds2qaqXDGJm6mqyBX7CTDpvDp82ugMXQm9mUscrnEDmZEWjs+K72Vyr
         KI2Ve3s5MiWO26+LdRy34IgFIGatLBrR1gdLZjA2NM9LoS3hZRjc6QSFkxyYzW7bY/
         w9sT35RSzn2hg==
Received: from smtpclient.apple (unknown [42.120.75.124])
        by gy11p00im-quki08142302.gy.silu.net (Postfix) with ESMTPS id 60ECF18C0132;
        Tue, 20 Sep 2022 02:04:03 +0000 (UTC)
From:   =?utf-8?B?5p2O5Y2a5paH?= <charlieio@icloud.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH] unicode: update the width tables to Unicode 15
Message-Id: <A502C1AE-CD49-46FB-B5ED-0513BABF7AD1@icloud.com>
Date:   Tue, 20 Sep 2022 10:04:01 +0800
Cc:     charlieio@outlook.com, git@vger.kernel.org, gitgitgadget@gmail.com
To:     gitster@pobox.com
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Proofpoint-GUID: dqOU95wCp8UVVramICRQmwU9MEtsnFYn
X-Proofpoint-ORIG-GUID: dqOU95wCp8UVVramICRQmwU9MEtsnFYn
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.528,18.0.895,17.11.122.1.0000000_definitions=3D?=
 =?UTF-8?Q?2022-09-19=5F04:2022-09-14=5F04,2022-09-19=5F04,2022-06-22=5F01?=
 =?UTF-8?Q?_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=537 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2209200011
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Indeed, I used this script to regenerate unicode-width.h
