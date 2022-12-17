Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9F1C4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 21:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiLQV5Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 16:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLQV5P (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 16:57:15 -0500
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Dec 2022 13:57:14 PST
Received: from qs51p00im-qukt01072101.me.com (qs51p00im-qukt01072101.me.com [17.57.155.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EF7B481
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 13:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1671313706;
        bh=Gedmsx6y+DP6F3pyJP0dxK8ZJwyzMxxxRsgl/+nODco=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=NBeyMmDBGhfYKdzKwH47PMl2uQfPs4IFaBSYySg1kHf199eEpls0FWFFAxHLPTvOd
         A9K+Pb+MA2NTIrOXELp5xxLPej/+n3/UfyuUkPCiV5gtFaJ25exYyfEeYo6/MYhDWc
         8+nfsmikA0e72hqQL0Yf8jstSm/t+DKmbJr4QupX1+YlZWgN9oOTlgRpFbX9Clxp62
         1Q46h3b2u5TReUt5XD3mXYIH/U96af5Y38ZaEgputgjDbKncI2iYFFtzInQrssyufN
         mew0UEfnl5YrT3awamh64w5WJuOYmzb0wOShsG88d46PMI0uFllrWMdJiLD4TJJeGp
         JAKMnFpA4HSrg==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01072101.me.com (Postfix) with ESMTPSA id A9FFD40465;
        Sat, 17 Dec 2022 21:48:25 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Bob Swift <robinsonhenry2009@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Sat, 17 Dec 2022 16:48:14 -0500
Subject: Re: [PATCH] git-diff: Introduce --index and deprecate --cached.
Message-Id: <8D6179AC-75EC-41D3-B6BE-A22ABE7AE128@icloud.com>
Cc:     ae@op5.se, git@vger.kernel.org
To:     junkio@cox.net
X-Mailer: iPad Mail (20C65)
X-Proofpoint-GUID: GSweuTwcdBzjQE1GLE4wncS5H1XY5Z0R
X-Proofpoint-ORIG-GUID: GSweuTwcdBzjQE1GLE4wncS5H1XY5Z0R
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 clxscore=1011
 spamscore=0 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxlogscore=444 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2212170203
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Abraham Lincoln
