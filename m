Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6628EC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 17:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1398F21D91
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 17:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="pvG6i3X+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgKBRfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 12:35:24 -0500
Received: from st43p00im-ztdg10061801.me.com ([17.58.63.170]:51914 "EHLO
        st43p00im-ztdg10061801.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727936AbgKBRfX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Nov 2020 12:35:23 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2020 12:35:23 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1604338183; bh=mtUGE592PtslQSkFpr00n9j4iWnGSFaEC86OTmmCBMU=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=pvG6i3X+360K8aPMZeXDz923E+2TnFcnKHuS4wPw22lxgkx2h9tUXjb6moj/fSSAn
         i5m5mOws3uQxnsPCWgS1c5dHWTqPylTfQBbwNPOABLB8Y1Ma3Ss3zmbNvkQjP1R4Ry
         1AYXG23JIs0ohjJ7f0eh5ZWwtZaqFJzuuXYKrqKcj5ou4cqj3DEW5k4F+ctnXFYFEY
         MFxuT/wYYGplbM3Ku96K9fgR5d86Um0PQMvcyPGych74g+RkqENnj1gr9MnDm3cm0D
         SQh9jfSRIOKtFQ7k5//NHILjIJqqWcAlIAn1J4YW4DNJ1Un85pVSCXvLLZTX4lxCaK
         loPVcxXjZMoIw==
Received: from [192.168.0.120] (ip98-169-36-218.dc.dc.cox.net [98.169.36.218])
        by st43p00im-ztdg10061801.me.com (Postfix) with ESMTPSA id 562B98C084A
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 17:29:42 +0000 (UTC)
From:   Joe Fabre <joefabre@me.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Git Help
Message-Id: <46BA69FB-B082-4575-ACF1-DC959527558E@me.com>
Date:   Mon, 2 Nov 2020 12:29:42 -0500
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_12:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=561 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2011020134
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git!

I need some serious assistance.  I have a local repository on my primary =
laptop, and that repo folder is shared on the local network. The primary =
laptop died (grrr); and I want to create a repo on my back up laptop =
which has access to the shared folder, but no .git file.  Also, I=E2=80=99=
d like to link it to my GitHub account.

Any ideas?

Thanks,
Joe=
