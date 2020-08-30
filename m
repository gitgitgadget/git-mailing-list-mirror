Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2655C433E6
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 10:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1205207BB
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 10:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="f6uuh9GH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgH3KbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 06:31:23 -0400
Received: from mr85p00im-ztdg06021201.me.com ([17.58.23.189]:34233 "EHLO
        mr85p00im-ztdg06021201.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbgH3KbR (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Aug 2020 06:31:17 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Sun, 30 Aug 2020 06:31:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1598782907;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=f6uuh9GHGp6JRtN/BaJIVApyJzH1xjfAWCmvoXvqDWeJgWmKmvE/wqRo6IZxW7F4o
         V+CiiiuBRlHJzpVAuq+7rJ9ITJKFUvSSRGRFqJ/OxEaJxJUDpUhDD5cRMWp+8ah6pN
         yjc3XvIs8H8rbt4rfUeL4D7oGm7VNX2oYMUdDEZInzEnK/LwKVp5QoLI+W2llQDpMc
         vUwWsbNLWZRXxLHECobNGcd4AMwdIGm1YzpOp0Ehx0nsltJ9ppkL+NZMuFv8pLzoRx
         fLKeB5AlPJ1U4j/IbzuZ/TufHU57y2h9haYAqXsS/g1SonXdS0CNo0C/P4EdReksy0
         M0yI6Bxttg9Qw==
Received: from [192.168.1.109] (162-232-134-150.lightspeed.irvnca.sbcglobal.net [162.232.134.150])
        by mr85p00im-ztdg06021201.me.com (Postfix) with ESMTPSA id AE2801201D2;
        Sun, 30 Aug 2020 10:21:47 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Danielle Akers <deroc3@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Sun, 30 Aug 2020 03:21:46 -0700
Subject: Re: [PATCH] gitdiff: Introduce --index and deprecate --cached.
Message-Id: <B13534C3-F89A-4D8E-8472-10FE98351050@icloud.com>
Cc:     ae@op5.se, git@vger.kernel.org
To:     junkio@cox.net
X-Mailer: iPhone Mail (17G80)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-30_03:2020-08-28,2020-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=281 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2008300084
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


