Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05521F454
	for <e@80x24.org>; Fri,  8 Nov 2019 09:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbfKHJYC (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 04:24:02 -0500
Received: from m13-28.163.com ([220.181.13.28]:4364 "EHLO m13-28.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfKHJYC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 04:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=5Yj/w
        9eI6Xz6q8W20tUbzrW563zaZYiOx2SpZsrGMYM=; b=J1vYhQWG00xqW8MEn5f9W
        au9PWgog10TGUC6GCWi1OQ9ydUm+wS6YIFbeUVjVRzr0ptnVn3Vh0FGrYyB1qCmc
        BK4YK8rcWacSWa+jyMvTohjdd0NfTiPryxxh3FFAw9Cmpfndk1moJd10owXEHdTL
        KBGgzO1lkZpH/Ob4veyQfU=
Received: from 13411091171$163.com ( [113.119.31.55] ) by
 ajax-webmail-wmsvr28 (Coremail) ; Fri, 8 Nov 2019 17:23:59 +0800 (CST)
X-Originating-IP: [113.119.31.55]
Date:   Fri, 8 Nov 2019 17:23:59 +0800 (CST)
From:   L <13411091171@163.com>
To:     git@vger.kernel.org
Subject: git check-ignore bug reports supplement
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2019 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <42266508.6960.16e4a53d99b.Coremail.13411091171@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: HMGowAD38ZwvNMVdKxr2AA--.837W
X-CM-SenderInfo: hoqpmkiswzjli6rwjhhfrp/xtbBZg9nFVaD4PJn9wADsP
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2hlbiB0aGUgZ2l0aWdub3JlIGZpbGUgaGFzIGNvbnNlY3V0aXZlIF5NJCBzcGVjaWFsIHN5bWJv
bHMsIHJ1bm5pbmcgdGhlICJnaXQgY2hlY2staWdub3JlICc8cGF0aG5hbWU+LyciIGNvbW1hbmQg
d2lsbCBwcm9tcHQgJzxwYXRobmFtZT4vJyBleGlzdHMgKGV2ZW4gaWYgaXQgZG9lc24ndCBleGlz
dCksIGFuZCBwcm9tcHRzICc8cGF0aG5hbWU+LycgaW4gdGhlIGxhc3QgY29uc2VjdXRpdmUgXk0k
IGxvY2F0aW9uLgpOb3RvOiBBbGwgY29tbWFuZCBydW4gaW4gR2l0QmFzaC4KTXkgRW5nbGlzaCBp
cyB2ZXJ5IGJhZCwgcGxlYXNlIGZvcmdpdmUgbWUuCgplbnZpcm9ubWVudDoKICB3aW5kb3dzMTAK
ICBnaXQgdmVyc2lvbiAyLjIzLjAud2luZG93cy4xCgpmb3IgZXhhbXBsZToKCi5naXRpZ25vcmUg
bm9ybWFsIHZpZXcKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMjIyBBbmRyb2lkIHRlbXBs
YXRlCiMgQnVpbHQgYXBwbGljYXRpb24gZmlsZXMKKi5hcGsKKi5hcF8KKi5hYWIKCiMgRmlsZXMg
Zm9yIHRoZSBBUlQvRGFsdmlrIFZNCiouZGV4CgojIEphdmEgY2xhc3MgZmlsZXMKKi5jbGFzcwoK
IyBHZW5lcmF0ZWQgZmlsZXMKYmluLwpnZW4vCm91dC8KcmVsZWFzZS8KCiMgR3JhZGxlIGZpbGVz
Ci5ncmFkbGUvCmJ1aWxkLwotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCi5naXRpZ25vcmUg
ZGV0YWlsZWQgdmlldwotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICAgICAxICAjIyMgQW5k
cm9pZCB0ZW1wbGF0ZV5NJAogICAgIDIgICMgQnVpbHQgYXBwbGljYXRpb24gZmlsZXNeTSQKICAg
ICAzICAqLmFwa15NJAogICAgIDQgICouYXBfXk0kCiAgICAgNSAgKi5hYWJeTSQKICAgICA2ICBe
TSQKICAgICA3ICAjIEZpbGVzIGZvciB0aGUgQVJUL0RhbHZpayBWTV5NJAogICAgIDggICouZGV4
Xk0kCiAgICAgOSAgXk0kCiAgICAxMCAgIyBKYXZhIGNsYXNzIGZpbGVzXk0kCiAgICAxMSAgKi5j
bGFzc15NJAogICAgMTIgIF5NJAogICAgMTMgICMgR2VuZXJhdGVkIGZpbGVzXk0kCiAgICAxNCAg
YmluL15NJAogICAgMTUgIGdlbi9eTSQKICAgIDE2ICBvdXQvXk0kCiAgICAxNyAgcmVsZWFzZS9e
TSQKICAgIDE4ICBeTSQKICAgIDE5ICAjIEdyYWRsZSBmaWxlc15NJAogICAgMjAgIC5ncmFkbGUv
Xk0kCiAgICAyMSAgYnVpbGQvXk0kCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKCnByb2pl
Y3QgZGlyZWN0b3J5Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpkcnd4ci14ci14IDEgTCAx
OTcxMjEgICAwIDEx1MIgIDggMTY6MTMgLi8KZHJ3eHIteHIteCAxIEwgMTk3MTIxICAgMCAxMdTC
ICA4IDE2OjEyIC4uLwpkcnd4ci14ci14IDEgTCAxOTcxMjEgICAwIDEx1MIgIDggMTY6MTMgLmdp
dC8KLXJ3LXItLXItLSAxIEwgMTk3MTIxIDIyNiAxMdTCICA4IDE2OjE3IC5naXRpZ25vcmUKZHJ3
eHIteHIteCAxIEwgMTk3MTIxICAgMCAxMdTCICA4IDE2OjEyIC5pZGVhLwotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KCgpydW4gZ2l0IGNoZWNrLWlnbm9yZSBjb21tYW5kCi0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQokIGdpdCBjaGVjay1pZ25vcmUgLXYgJy5pZGVhLycKLmdpdGlnbm9y
ZToxODogIC5pZGVhLwokIGdpdCBjaGVjay1pZ25vcmUgLXYgJy5pZGVhL3Nmc2YvJwouZ2l0aWdu
b3JlOjE4OiAgLmlkZWEvc2ZzZi8KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
