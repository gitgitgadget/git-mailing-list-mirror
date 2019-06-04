Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E101F609
	for <e@80x24.org>; Tue,  4 Jun 2019 14:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfFDOs1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 10:48:27 -0400
Received: from mr85p00im-hyfv06021301.me.com ([17.58.23.188]:17276 "EHLO
        mr85p00im-hyfv06021301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727715AbfFDOs1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jun 2019 10:48:27 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Jun 2019 10:48:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
        t=1559659262; bh=//TGSvbpFOurizr8IfLTitD4Y0jcpzgY+8F0nk1Wcj0=;
        h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To;
        b=4JSvvKE/enyNx3l7xRsponISc4wPdt4YbzNWrXKV5iWR+qjdxw9SNTVp/UR5AtssP
         kCrvOh7Retp6AP8Bo+mpj+cbL30KB1BK2FeT4pSEn2Hp4Kckf3j+yo6mQooWPbyzFH
         fCPJjMoYVqGyEj1HhRJ3pHWRx9Hm9G/QvEbS/Z6x9eMXruJAfJ+vHz7O7Zev6wtdcX
         wpMYFsrtRD9FLy2h8By1uEK1zAMpJoDTbegDHTqDo2JDOjranFu1MJxjvI2hIGtxbb
         7w7G+XApWN0IJb4nEM9ZWKeQeDfRuYZSVKXvtLMcrgY82H7aFoNUnboHk3Hc2uHloy
         NsZ4wqqJwubtQ==
Received: from [10.2.2.43] (bzq-179-121-75.cust.bezeqint.net [212.179.121.75])
        by mr85p00im-hyfv06021301.me.com (Postfix) with ESMTPSA id 0BCE140B35
        for <git@vger.kernel.org>; Tue,  4 Jun 2019 14:41:02 +0000 (UTC)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Starodubski Reuven <mixmind@me.com>
Mime-Version: 1.0 (1.0)
Date:   Tue, 4 Jun 2019 17:40:58 +0300
Subject: Ssl key verify
Message-Id: <FAB768B6-2633-4387-B55E-F6717FE52418@me.com>
To:     git@vger.kernel.org
X-Mailer: iPhone Mail (16E227)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=433 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1812120000 definitions=main-1906040097
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. I am using ssl certificates in order to work with git. The problem is th=
at on Linux when I trying to work with repository it git asks me passphrase o=
f my certificate, but on windows it=E2=80=99s don=E2=80=99t work properly. I=
=E2=80=99m using the same key on windows and Linux, and windows git client d=
on=E2=80=99t asks to enter passphrase. What can I do?
It=E2=80=99s my config
git config --global http.sslVerify false
git config --global http.sslCert ~/.ssl/client.crt
git config --global http.sslKey ~/.ssl/client.key=

