Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4E2C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 02:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1288222314
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 02:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfLSCmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 21:42:19 -0500
Received: from smtp26.cstnet.cn ([159.226.251.26]:51816 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726799AbfLSCmT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 21:42:19 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2019 21:42:19 EST
Received: by ajax-webmail-APP-08 (Coremail) ; Thu, 19 Dec 2019 10:35:08
 +0800 (GMT+08:00)
X-Originating-IP: [106.120.127.15]
Date:   Thu, 19 Dec 2019 10:35:08 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
To:     git@vger.kernel.org
Subject: How to determine a branch whether has a specified commit
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.9a build 20190604(696d1518)
 Copyright (c) 2002-2019 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <62a8f522.6873.16f1c0243f6.Coremail.wuzhouhui14@mails.ucas.ac.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: 0ACowADn_UTc4fpd7SoDAA--.37331W
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/1tbiBgUIAV0TeeKwIg
        ACsP
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksCgpJIGtub3cKICAgIGdpdCBicmFuY2ggLS1jb250YWlucyA8Y29tbWl0PgpjYW4gZGlzcGxh
eSBhbGwgbG9jYWwgYnJhbmNoZXMgdGhhdCBoYXMgc3BlY2lmaWVkIGNvbW1pdC4gSG93ZXZlciwg
c3BlY2lmeSBhCmJyYW5jaCBhbmQgY29tbWl0LCBJIGRvbid0IGtub3cgaG93IHRvIGRldGVybWlu
ZSB3aGV0aGVyIHRoaXMgYnJhbmNoIGNvbnRhaW5zCnRoaXMgY29tbWl0LgoKSSB0aGluawogICAg
Z2l0IGJyYW5jaCAtLWNvbnRhaW5zIDxjb21taXQ+IHwgZ3JlcCA8YnJhbmNoIG5hbWU+CmlzIG5v
dCBnb29kIGVub3VnaC4gRG9lcyBhbnlvbmUgaGF2ZSBhIGJldHRlciBzb2x1dGlvbj8KClRoYW5r
cy4K
