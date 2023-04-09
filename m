Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F1AC77B61
	for <git@archiver.kernel.org>; Sun,  9 Apr 2023 04:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjDIEoM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Apr 2023 00:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDIEoL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Apr 2023 00:44:11 -0400
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 08 Apr 2023 21:44:10 PDT
Received: from ci74p00im-qukt09081501.me.com (ci74p00im-qukt09081501.me.com [17.57.156.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EABE5B89
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 21:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1681014922;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=gcs+ySM0qj+YiFmIeXTbY7AGVFVEwWpmsYeECgdlgW+LsW2klQFe9uGFVIGht/lDB
         NXWihViTftEVo5X0rcsmPxkKrIR8iaKfGiPfWF3AIdyZEPSXs/qlUIc67Oo8GrpeN4
         J/xgOXF11yUIdKP0pa5ZhtrbXCXctRiafRwhtwW3s62HAaZiOZG+Shc27hHjgq76a7
         JHVbksr8pFC3NQVSbPH2ZSd6iqkJgmM1SozWEjorQ2noewbn4PfzZPhi1AdSRZaDOF
         4TnpnhRj+lPP2jCdK+8fdjEN9BANosPAPS6mHqI+pWUxMwa6ppYB+C/KyGLz1xXtbD
         81QIzWOYT41JA==
Received: from smtpclient.apple (ci77p00im-dlb-asmtp-mailmevip.me.com [17.57.156.26])
        by ci74p00im-qukt09081501.me.com (Postfix) with ESMTPSA id D6F7A25C0196;
        Sun,  9 Apr 2023 04:35:21 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Myles Headley <uniballthegreat89@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Sun, 9 Apr 2023 00:35:18 -0400
Subject: Re: What's cooking in git.git (Mar 2023, #05; Wed, 22)
Message-Id: <CCE7D732-F004-456D-AB90-0B910B6CBA9D@icloud.com>
Cc:     git@vger.kernel.org
To:     gitster@pobox.com
X-Mailer: iPhone Mail (20D67)
X-Proofpoint-ORIG-GUID: mvCYs5l_EyKSdpbd-deec1mQH1zIoqns
X-Proofpoint-GUID: mvCYs5l_EyKSdpbd-deec1mQH1zIoqns
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=562 adultscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304090040
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
