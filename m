Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A277DC33C99
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 06:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679222072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 06:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tHKR8yvI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgAJG3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:29:09 -0500
Received: from pv50p00im-ztbu10021601.me.com ([17.58.6.57]:39751 "EHLO
        pv50p00im-ztbu10021601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731520AbgAJG3J (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Jan 2020 01:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1578637748;
        bh=YUEodzewJvJfP3loZ52EKOhGYB5FDSCkNcJ4d4jLuwU=;
        h=From:To:Subject:Date:Message-ID:Content-Type;
        b=tHKR8yvISS8ueAMHycjN8bi9c9wI4ii/GrVHf77d6ZFV3ZDn5TTV73dod/7vDdjO2
         JW1KvDM9mrFUyGnOKq58FlmrLw3oDN13IYvf9BGaCdaW1zI/mEsPQRMdrI1r+IIO5C
         zo3UPhSsAEm+KPi5pDmwFq0eYSbf/0K946F95aNVz/8Y5DfEDo/BrxCqBSqf9ELyMm
         +vL8C9JGb7Z5AC3NaBPK4X24Vp17QLZS6Kd1TePJrnYUzHsQjyNl5hyPTlLwFXyWz7
         1dm88npA/jLc3NTx+EEAKH3Yomkuh9YPSXleVyBsI08HXWVp150389owHUJvdPXSL+
         9Hf1aMUQyAL9g==
Received: from DESKTOPII84LO5 (unknown [114.216.84.200])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id E29576E0B21
        for <git@vger.kernel.org>; Fri, 10 Jan 2020 06:29:07 +0000 (UTC)
From:   =?gb2312?B?s8LN+8rm?= <object_oriented@icloud.com>
To:     <git@vger.kernel.org>
Subject: How to use git to add the modification of each commit to the existing folder in a patch way, because the project is large, using clone or pull is very time-consuming and network dependent?
Date:   Fri, 10 Jan 2020 14:29:03 +0800
Message-ID: <002201d5c77f$437f06f0$ca7d14d0$@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdXHfxpx2IsbG7ERSp+h//YeJptyrw==
Content-Language: zh-cn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2020-01-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=13 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=558 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-2001100054
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your attention.

How to use git to add the modification of each commit to the existing folder
in a patch way, because the project is large, using clone or pull is very
time-consuming and network dependent?

Now,there is a linux kernel in my pc, and a branch of linux kernel in
github, I want to synchronize changes from remote repositories to my local
linux kernel.
And the local linux kernel is downloaded in zip format not in git mode. So,
Is there exists some method to do that.

