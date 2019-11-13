Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9526B1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 01:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKMBBK (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 20:01:10 -0500
Received: from smtpbgsg2.qq.com ([54.254.200.128]:57777 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbfKMBBK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 20:01:10 -0500
X-QQ-FEAT: yGNZ4f+HfTDd9GNrFSwMtEyzlLg8EI4AhX/9a8BwnPha7J96THKeDbdh2ynPY
        UiF+q6rLIG+q80Hn/db7oOevh3jlbu9EFKaU+bHnE9FDiz931tfnxJuXT4jrIv8RubYSIii
        bOuSgLWl39T0l86KpIekxGuqxUgSph5dck9dfN23B0pynkOdvZpaIvcmOGoTsYnelPOL9av
        hBbcFRr4A/lREHMZnVXNz5XI94HuYZ+jC4AFzN/frDi8YA+oOhLGc/kyHkIz+6KEaQaAGtY
        rFRjYbeP2qPqm19t6E5Mu73EE=
X-QQ-SSF: 00000000000000F000000000000000Z
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 183.14.141.1
X-QQ-STYLE: 
X-QQ-mid: webmail302t1573606852t7334530
From:   "=?gb18030?B?Rm9yY2UuQ2hhcmxpZQ==?=" <force@forcemz.net>
To:     "=?gb18030?B?Z2l0?=" <git@vger.kernel.org>
Subject:  Protocol v2: The wrong --shallow-since time format causes git to wait indefinitely
Mime-Version: 1.0
Content-Type: text/plain;
        charset="gb18030"
Content-Transfer-Encoding: base64
Date:   Wed, 13 Nov 2019 09:00:52 +0800
X-Priority: 3
Message-ID: <tencent_AB1A7466D1F2EF9A84B437705F06A7652709@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Wed, 13 Nov 2019 09:00:53 +0800 (CST)
Feedback-ID: webmail:forcemz.net:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

UmVjZW50bHksIHdoZW4gSSB0ZXN0ZWQgbXkgR2l0IE92ZXIgSFRUUCBzZXJ2ZXIsIEkgZm91
bmQgYSBidWcgaW4gR2l0LiBXaGVuIHdlIHVzZWQgZ2l0IC1jIHByb3RvY29sLnZlcnNpb249
MiBjbG9uZSAtLXNoYWxsb3ctc2luY2UgLCBpZiB0aGUgdGltZSBmb3JtYXQgaXMgd3Jvbmcs
IGl0IHdpbGwgY2F1c2UgZ2l0IHRvIHdhaXQgaW5kZWZpbml0ZWx5Lg0KDQpHaXRodWIgc3Vw
cG9ydHMgV2lyZSBQcm90b2NvbCB0byByZXByb2R1Y2UsIEdpdGxhYiBkb2VzIG5vdCBzdXBw
b3J0IGl0IGFuZCBkb2VzIG5vdCByZXByb2R1Y2UgaXQuDQoNClRoZSBjb21tYW5kcyB0aGF0
IGNhbiBiZSByZXRyaWVkIGFyZSBhcyBmb2xsb3dzOg0KDQpgYGBzaGVsbA0KIyB0aW1lIGZv
cm1hdCB3cm9uZw0KZ2l0IC1jIHByb3RvY29sLnZlcnNpb249MiBjbG9uZSBodHRwczovL2dp
dGh1Yi5jb20vZ2l0L2dpdC5naXQgLS1zaGFsbG93LXNpbmNlPTIwMTUxMDEyDQojIHRyYWNl
DQpHSVRfVFJBQ0U9MSBHSVRfQ1VSTF9WRVJCT1NFPTEgR0lUX1RSQUNFX1BBQ0tFVD0yIGdp
dCAtYyBwcm90b2NvbC52ZXJzaW9uPTIgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL2dpdC9n
aXQuZ2l0IC0tc2hhbGxvdy1zaW5jZT0yMDE1MTAxMg0KYGBgDQpXZSBjYW4gc2VlIHRoYXQg
dGhlIHNlcnZlciBjbG9zZXMgdGhlIEhUVFAgY29ubmVjdGlvbiBhZnRlciBzZW5kaW5nIHRo
ZSBgc2hhbGxvdy1pbmZvXG5gIG1lc3NhZ2UsIGFuZCBnaXQtcmVtb3RlLWh0dHAocykgaXMg
c3RpbGwgd2FpdGluZy4NCg0KYGBgDQokIGdpdCAtLXZlcnNpb24gLS1idWlsZC1vcHRpb25z
DQpnaXQgdmVyc2lvbiAyLjI0LjANCmNwdTogeDg2XzY0DQpubyBjb21taXQgYXNzb2NpYXRl
ZCB3aXRoIHRoaXMgYnVpbGQNCnNpemVvZi1sb25nOiA4DQpzaXplb2Ytc2l6ZV90OiA4DQoN
CmBgYA0KDQpXaGVuIHRoZSB0aW1lIGZvcm1hdCBpcyBjb3JyZWN0LCB0aGUgY2xvbmUgaXMg
c3VjY2Vzc2Z1bCwgc28gdGhpcyBpcyBmb2xsb3dlZCBieSB0aGUgc2hhbGxvdy1saXN0o7oN
Cg0KYGBgc2hlbGwNCkdJVF9UUkFDRT0xIEdJVF9DVVJMX1ZFUkJPU0U9MSBHSVRfVFJBQ0Vf
UEFDS0VUPTIgZ2l0IC1jIHByb3RvY29sLnZlcnNpb249MiBjbG9uZSBodHRwczovL2dpdGh1
Yi5jb20vZ2l0L2dpdC5naXQgLS1zaGFsbG93LXNpbmNlPTIwMTUtMTAtMTINCmBgYA0KDQpH
aXRodWIgSXNzdWVzOiBodHRwczovL2dpdGh1Yi5jb20vZ2l0Z2l0Z2FkZ2V0L2dpdC9pc3N1
ZXMvNDU3



