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
	by dcvr.yhbt.net (Postfix) with ESMTP id 734BF1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 08:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfKHIt4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 03:49:56 -0500
Received: from m13-28.163.com ([220.181.13.28]:58206 "EHLO m13-28.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfKHIt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 03:49:56 -0500
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Nov 2019 03:49:55 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=RttjN
        2P1XoGK406Wpkcb0evs96RME7802EfEeyA5mLw=; b=p8bb0pZkgkOZ2zfDoTMhL
        ROFD/L5Hwo7OH3CjbQmpmr0rMpI3X/jlTqXkJ3SD/DkGzr+aTGuaTCTyW5sCPjRs
        d638AYrnty1gPSt097Txf6GL2XfeRcrrzuuCsSKAT1CAaQeSV6wEcPdq4i8OgO1G
        V8svoeYMBQ1/bCBii+gDxs=
Received: from 13411091171$163.com ( [113.119.31.55] ) by
 ajax-webmail-wmsvr28 (Coremail) ; Fri, 8 Nov 2019 16:34:43 +0800 (CST)
X-Originating-IP: [113.119.31.55]
Date:   Fri, 8 Nov 2019 16:34:43 +0800 (CST)
From:   L <13411091171@163.com>
To:     git@vger.kernel.org
Subject: git check-ignore bug reports
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2019 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <60f40fd7.5ff5.16e4a26bded.Coremail.13411091171@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: HMGowAD3_0ejKMVdIwz2AA--.51375W
X-CM-SenderInfo: hoqpmkiswzjli6rwjhhfrp/xtbBZg9nFVaD4PJn9wABsN
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V2hlbiB0aGUgZ2l0aWdub3JlIGZpbGUgaGFzIGNvbnNlY3V0aXZlIF5NJCBzcGVjaWFsIHN5bWJv
bHMsIHJ1bm5pbmcgdGhlICJnaXQgY2hlY2staWdub3JlICc8cGF0aG5hbWU+LyciIGNvbW1hbmQg
d2lsbCBwcm9tcHQgJzxwYXRobmFtZT4vJyBleGlzdHMgKGV2ZW4gaWYgaXQgZG9lc24ndCBleGlz
dCksIGFuZCBwcm9tcHRzICc8cGF0aG5hbWU+LycgaW4gdGhlIGxhc3QgY29uc2VjdXRpdmUgXk0k
IGxvY2F0aW9uLgpNeSBFbmdsaXNoIGlzIHZlcnkgYmFkLCBwbGVhc2UgZm9yZ2l2ZSBtZS4KCmVu
dmlyb25tZW50OgogIHdpbmRvd3MxMAogIGdpdCB2ZXJzaW9uIDIuMjMuMC53aW5kb3dzLjEKCmZv
ciBleGFtcGxlOgoKLmdpdGlnbm9yZSBub3JtYWwgdmlldwotLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KIyMjIEFuZHJvaWQgdGVtcGxhdGUKIyBCdWlsdCBhcHBsaWNhdGlvbiBmaWxlcwoqLmFw
awoqLmFwXwoqLmFhYgoKIyBGaWxlcyBmb3IgdGhlIEFSVC9EYWx2aWsgVk0KKi5kZXgKCiMgSmF2
YSBjbGFzcyBmaWxlcwoqLmNsYXNzCgojIEdlbmVyYXRlZCBmaWxlcwpiaW4vCmdlbi8Kb3V0Lwpy
ZWxlYXNlLwoKIyBHcmFkbGUgZmlsZXMKLmdyYWRsZS8KYnVpbGQvCi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQoKLmdpdGlnbm9yZSBkZXRhaWxlZCB2aWV3Ci0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQogICAgIDEgICMjIyBBbmRyb2lkIHRlbXBsYXRlXk0kCiAgICAgMiAgIyBCdWlsdCBh
cHBsaWNhdGlvbiBmaWxlc15NJAogICAgIDMgICouYXBrXk0kCiAgICAgNCAgKi5hcF9eTSQKICAg
ICA1ICAqLmFhYl5NJAogICAgIDYgIF5NJAogICAgIDcgICMgRmlsZXMgZm9yIHRoZSBBUlQvRGFs
dmlrIFZNXk0kCiAgICAgOCAgKi5kZXheTSQKICAgICA5ICBeTSQKICAgIDEwICAjIEphdmEgY2xh
c3MgZmlsZXNeTSQKICAgIDExICAqLmNsYXNzXk0kCiAgICAxMiAgXk0kCiAgICAxMyAgIyBHZW5l
cmF0ZWQgZmlsZXNeTSQKICAgIDE0ICBiaW4vXk0kCiAgICAxNSAgZ2VuL15NJAogICAgMTYgIG91
dC9eTSQKICAgIDE3ICByZWxlYXNlL15NJAogICAgMTggIF5NJAogICAgMTkgICMgR3JhZGxlIGZp
bGVzXk0kCiAgICAyMCAgLmdyYWRsZS9eTSQKICAgIDIxICBidWlsZC9eTSQKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCgoKcHJvamVjdCBkaXJlY3RvcnkKLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCmRyd3hyLXhyLXggMSBMIDE5NzEyMSAgIDAgMTHUwiAgOCAxNjoxMyAuLwpkcnd4ci14
ci14IDEgTCAxOTcxMjEgICAwIDEx1MIgIDggMTY6MTIgLi4vCmRyd3hyLXhyLXggMSBMIDE5NzEy
MSAgIDAgMTHUwiAgOCAxNjoxMyAuZ2l0Lwotcnctci0tci0tIDEgTCAxOTcxMjEgMjI2IDEx1MIg
IDggMTY6MTcgLmdpdGlnbm9yZQpkcnd4ci14ci14IDEgTCAxOTcxMjEgICAwIDEx1MIgIDggMTY6
MTIgLmlkZWEvCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKCnJ1biBnaXQgY2hlY2staWdu
b3JlIGNvbW1hbmQKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiQgZ2l0IGNoZWNrLWlnbm9y
ZSAtdiAnLmlkZWEvJwouZ2l0aWdub3JlOjE4OiAgLmlkZWEvCiQgZ2l0IGNoZWNrLWlnbm9yZSAt
diAnLmlkZWEvc2ZzZi8nCi5naXRpZ25vcmU6MTg6ICAuaWRlYS9zZnNmLwotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0=
