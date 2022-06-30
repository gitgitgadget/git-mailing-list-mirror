Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAFCC43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 16:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiF3QdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbiF3QdG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 12:33:06 -0400
X-Greylist: delayed 425 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Jun 2022 09:33:06 PDT
Received: from pv50p00im-zteg10011501.me.com (pv50p00im-zteg10011501.me.com [17.58.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05472BBF
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1656606359;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
        b=L9vUen9i+gIJovZD4QkHt1j/+Wb89X+y3h8uFF5M+4Bruk2xXlt0lQ8flcstBrTia
         7cmRvCoBCrnej+VcVuqWPx6UwUYfOxVVxrWwTQDzgAnXG2k2qj6VSkgWeATjhPgTU7
         W5g5+0xzFy3OV8o/Ax42NczNsaHkr25wwB9MHjn65KsHMgXcegS8EMqFCI+DoJ4yDO
         VOo5AueemsXZDPWo2g/+LbRXU5BLQBL5+PG9oqAm28aNGWYUdms/EDvEBE6pc5BK/7
         2j9yZ0XT0Xdc/xmOhv6owPPIJxMzSb6R7DePU/avhdGLnirZKip7kmbqtMaDJjVCOc
         xT9csoYMXAQzw==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id C7B792E0270;
        Thu, 30 Jun 2022 16:25:57 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   =?utf-8?Q?Nam_H=E1=BB=93?= <honamluxurychef@icloud.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/3] cat-file: add mailmap support
Date:   Thu, 30 Jun 2022 23:25:54 +0700
Message-Id: <C0FE09FC-18D3-4EC5-B5BD-0E7976602AFB@icloud.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org,
        johncai86@gmail.com, phillip.wood@dunelm.org.uk,
        siddharthasthana31@gmail.com
To:     phillip.wood123@gmail.com
X-Mailer: iPhone Mail (19F77)
X-Proofpoint-GUID: nq-qbe_USuFmi9kfawXtIvDB8z_XkZmy
X-Proofpoint-ORIG-GUID: nq-qbe_USuFmi9kfawXtIvDB8z_XkZmy
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011 adultscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=581 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2206300065
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Sent from my iPhone
