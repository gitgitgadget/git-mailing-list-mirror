Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F02C678D4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 09:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjCGJo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 04:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCGJon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 04:44:43 -0500
X-Greylist: delayed 545 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Mar 2023 01:44:32 PST
Received: from pv50p00im-zteg10021301.me.com (pv50p00im-zteg10021301.me.com [17.58.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E7E5BCA3
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 01:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1678181726;
        bh=cY9O6oZZ0on/ZGAv6XbPGvCwYoD1Kz6uaPu1N+peaFw=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=ARAr+BL0gJu/nWAtJRLYp83VWyeT/4qbMMDbPeZHAIj/ivcAs3ZmKCvahad/4DGtT
         tdAxY8aI1CdDrmrMC4HOKALb2tDW/zBFHLQKXgbht6WqJjrcilhHTEphcnODceVrJD
         /bT/UYf6+MWAKj1/t+o9tCjG0Ehcc0ZKvNHYl/4JPydIiRkp+s+k3/2C5YhmlPxsWT
         fPCJXpvsZoI/mTshOOrLP3yA4e8ZfO7IpH14VRiXFM04gySHxRqghlC0VEqoEMJIUm
         MZnv1U2XjsaZQTynX/2z38mzkgDquJdKtUBDIpwTakGmrLWs5e/LrzSlJpqXGWoqyd
         1RvjRICwwq1jg==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id EB1D7500468;
        Tue,  7 Mar 2023 09:35:25 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Dannywp Wong <dannywpwong@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 7 Mar 2023 01:35:14 -0800
Subject: Re: [RFC][PATCH] t1092: add tests for `git diff-files`
Message-Id: <6781AB79-A0CC-43CD-AA7F-EFF629616D8F@icloud.com>
Cc:     cheskaqiqi@gmail.com, git@vger.kernel.org, vdye@github.com
To:     derrickstolee@github.com
X-Mailer: iPhone Mail (20D67)
X-Proofpoint-GUID: AMvrM6MAmPDm4yze2-k-j25g7IKCjeFO
X-Proofpoint-ORIG-GUID: AMvrM6MAmPDm4yze2-k-j25g7IKCjeFO
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=779 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2303070086
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pls sent me any fix it tools thanks 

Regards Danny


Sent from my iPhone
