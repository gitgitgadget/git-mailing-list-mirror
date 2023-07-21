Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC3BEB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 15:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjGUPPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 11:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjGUPPf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 11:15:35 -0400
X-Greylist: delayed 575 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 08:15:13 PDT
Received: from pv50p00im-ztdg10012001.me.com (pv50p00im-ztdg10012001.me.com [17.58.6.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B186E3AB8
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1689951936;
        bh=JQH7iAm2GIOc3WO0QA0BSVlviWsJfhz0FeE1x0hriwk=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=bTHF7wac2+J+XtmrRGsY3ESHPIJTR+/HLNNU8fIUFj6mVfWC1XjZW7nYaG3VP0z93
         3iofPmyPnIYbEeGa/NHXozde9DLLWstrHFFv3p9+jekXaGgghXCw+qWJDVxCS7rw8x
         OS4319ZB12QpeyXH6hqCI6yauaAD7uTJOrBQo9lZ3NiO3oAj0ViG53pos1VqLdguSp
         qmbKb+fvbbcwKqB1jGbmQBHigaLq/vUQgX19mHsLw9T7ExNkiPqRT4oqpQ4TIBhTxF
         Bi8S+KKCb2JDHUZ7dZgw5Qxfyj7GJIxNhr3XSE7BqBDPPjVKjlpFw+JFxSy/3Cvg8F
         83mvhNn3UZlYQ==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10012001.me.com (Postfix) with ESMTPSA id 16A8FA0045
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 15:05:32 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From:   =?utf-8?B?6Zmz5b2l6Imv?= <lj65671327@icloud.com>
Mime-Version: 1.0 (1.0)
Date:   Fri, 21 Jul 2023 23:05:12 +0800
Subject: =?utf-8?B?5b2l6Imv?=
Message-Id: <9C7D44A4-7A43-4F31-823B-4BCA7D29B949@icloud.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (21A5268h)
X-Proofpoint-ORIG-GUID: wUZjruBt_Aa1wf5RJQyqGK8yL0GtFQhm
X-Proofpoint-GUID: wUZjruBt_Aa1wf5RJQyqGK8yL0GtFQhm
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=503 suspectscore=0 spamscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2307210135
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCuW+nuaIkeeahGlQaG9uZeWCs+mAgQ==
