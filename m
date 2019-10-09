Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6576E1F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 02:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfJICgv (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 22:36:51 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:51872 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbfJICgv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 22:36:51 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Oct 2019 22:36:50 EDT
Received: by ajax-webmail-APP-10 (Coremail) ; Wed, 9 Oct 2019 10:28:40 +0800
 (GMT+08:00)
X-Originating-IP: [106.120.127.15]
Date:   Wed, 9 Oct 2019 10:28:40 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
To:     git@vger.kernel.org
Cc:     cuifang@sugon.com
Subject: How to find the commit that erase a change
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.9a build 20190604(696d1518)
 Copyright (c) 2002-2019 www.mailtech.cn cnic.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5e12e2d8.1ed16.16dae58d6ac.Coremail.wuzhouhui14@mails.ucas.ac.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: tACowADHz5_YRZ1dtygDAA--.30984W
X-CM-SenderInfo: xzx2x05xkxxi2u6ptx1ovo3u1dvotugofq/1tbiCwASAVz4isLQMw
        AAsX
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksCgpJIGhhdmUgYSBmaWxlIHdoaWNoIGNvbnRhaW5zIGNvbXBsaWNhdGVkIGNoYW5nZSBoaXN0
b3J5LiBXaGVuIEkgdXNlCiAgICBnaXQgbG9nIC1wIGZpbGUKdG8gc2VlIGFsbCBjaGFuZ2VzIG1h
ZGUgaW4gdGhpcyBmaWxlLCBJIGZvdW5kIHRoYXQgYSBjaGFuZ2UgZGlzYXBwZWFyZWQKZm9yIG5v
IHJlYXNvbi4KCkZvciBleGFtcGxlLCBJIG1hZGUgZm9sbG93aW5nIGNoYW5nZSBpbiBhIGNvbW1p
dDoKCkBAIC0yLDMgKzIsOCBAQCBpbnQgbWFpbih2b2lkKQogewogICAgICAgIHByaW50ZigiaGVs
bG8gd29ybGQiKTsKIH0KKworZnVuYyh2b2lkKQoreworICAgICAgIHByaW50ZigiYSBmdW5jIik7
Cit9CgpCdXQgd2hlbiBJIG9wZW4gdGhpcyBmaWxlIG9mIGxhdGVzdCB2ZXJzaW9uLCBJIGZvdW5k
IHRoZSBhYm92ZSBjaGFuZ2UgaXMKZGlzYXBwZWFyZWQuIFNvIEkgZGVjaWRlIHVzZQogICAgZ2l0
IGxvZyAtcCBmaWxlCnRvIHNlZSB3aGljaCBjb21taXQgZXJhc2UgbXkgY2hhbmdlLiBCdXQgSSBk
b2Vzbid0IHNlZSBhbnkgY29tbWl0IHdoaWNoCmNvbnRhaW5zIGNoYW5nZXMgbGlrZSBmb2xsb3dp
bmc6CgpAQCAtMiw4ICsyLDMgQEAgaW50IG1haW4odm9pZCkKIHsKICAgICAgICBwcmludGYoImhl
bGxvIHdvcmxkIik7CiB9Ci0KLWZ1bmModm9pZCkKLXsKLSAgICAgICBwcmludGYoImEgZnVuYyIp
OwotfQoKU28sIGhvdyB0byBmaW5kIHRoZSBjb21taXQgdGhhdCBlcmFzZSBteSBjaGFuZ2U/CgpU
aGFua3MuIFBsZWFzZSB1c2UgUmVwbHktQWxsIHdoZW4gcmVwbHkgdGhpcyBlbWFpbC4=
