Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364EEC433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347112AbiFCShz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347253AbiFCShU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:37:20 -0400
Received: from out28-50.mail.aliyun.com (out28-50.mail.aliyun.com [115.124.28.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7A11FCE5
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:33:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07263833|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.043679-0.01031-0.946011;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Nyfc.o4_1654281208;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.Nyfc.o4_1654281208)
          by smtp.aliyun-inc.com(33.45.46.134);
          Sat, 04 Jun 2022 02:33:30 +0800
Date:   Sat, 4 Jun 2022 02:33:30 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     git <git@vger.kernel.org>
Cc:     "Junio C Hamano" <gitster@pobox.com>
Subject: Re: protocol: add Accept-Language header if possible
References: <2022060211034177301214@oschina.cn>
X-Priority: 3
X-GUID: 66C02D7E-54E8-4502-B30C-DDD458085CF7
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <202206040227197341312@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PkdpdCBzZXJ2ZXIgZW5kJ3MgYWJpbGl0eSB0byBhY2NlcHQgQWNjZXB0LUxhbmd1YWdlIGhlYWRl
ciB3YXMgaW50cm9kdWNlZCBpbsKgZjE4NjA0YmJmMihodHRwOiBhZGQgQWNjZXB0LUxhbmd1YWdl
IGhlYWRlciBpZiBwb3NzaWJsZSkKPmJ1dCBpdCBzZWVtcyB0aGF0IG9ubHkgcmVmcyBkaXNjb3Zl
cmluZyBzdGFnZSBoYXMgdGhpcyBhYmlsaXR5Ogo+Igo+4pWw4pSAJCBHSVRfQ1VSTF9WRVJCT1NF
PTEgZ2l0IGxzLXJlbW90ZQo+Li4uCj4xMDo0MjozNi45MzkxMDggaHR0cC5jOjYyMyDCoCDCoCDC
oCDCoCDCoCDCoCDCoD0+IFNlbmQgaGVhZGVyOiBHRVQgL29wZW5zb3VyY2UvdGVzdC5naXQvaW5m
by9yZWZzP3NlcnZpY2U9Z2l0LXVwbG9hZC1wYWNrIEhUVFAvMS4xCj4xMDo0MjozNi45MzkxMTIg
aHR0cC5jOjYyMyDCoCDCoCDCoCDCoCDCoCDCoCDCoD0+IFNlbmQgaGVhZGVyOiBIb3N0OiBnaXRl
ZS5jb20KPjEwOjQyOjM2LjkzOTExNCBodHRwLmM6NjIzIMKgIMKgIMKgIMKgIMKgIMKgIMKgPT4g
U2VuZCBoZWFkZXI6IFVzZXItQWdlbnQ6IGdpdC8yLjM1LjEuMTAyLmcyYjljMTIwOTcwCj4xMDo0
MjozNi45MzkxMTYgaHR0cC5jOjYyMyDCoCDCoCDCoCDCoCDCoCDCoCDCoD0+IFNlbmQgaGVhZGVy
OiBBY2NlcHQ6ICovKgo+MTA6NDI6MzYuOTM5MTE3IGh0dHAuYzo2MjMgwqAgwqAgwqAgwqAgwqAg
wqAgwqA9PiBTZW5kIGhlYWRlcjogQWNjZXB0LUVuY29kaW5nOiBkZWZsYXRlLCBnemlwCj4xMDo0
MjozNi45MzkxMTggaHR0cC5jOjYyMyDCoCDCoCDCoCDCoCDCoCDCoCDCoD0+IFNlbmQgaGVhZGVy
OiBBY2NlcHQtTGFuZ3VhZ2U6IGVuLVVTLCAqO3E9MC45Cj4xMDo0MjozNi45MzkxMjAgaHR0cC5j
OjYyMyDCoCDCoCDCoCDCoCDCoCDCoCDCoD0+IFNlbmQgaGVhZGVyOiBQcmFnbWE6IG5vLWNhY2hl
Cj4xMDo0MjozNi45MzkxMjEgaHR0cC5jOjYyMyDCoCDCoCDCoCDCoCDCoCDCoCDCoD0+IFNlbmQg
aGVhZGVyOiBHaXQtUHJvdG9jb2w6IHZlcnNpb249Mgo+MTA6NDI6MzYuOTM5MTIzIGh0dHAuYzo2
MjMgwqAgwqAgwqAgwqAgwqAgwqAgwqA9PiBTZW5kIGhlYWRlcjoKPi4uLgo+MTA6NDI6MzYuOTk5
MDEyIGh0dHAuYzo2MTEgwqAgwqAgwqAgwqAgwqAgwqAgwqA9PiBTZW5kIGhlYWRlciwgMDAwMDAw
MDMwMiBieXRlcyAoMHgwMDAwMDEyZSkKPjEwOjQyOjM2Ljk5OTAzNCBodHRwLmM6NjIzIMKgIMKg
IMKgIMKgIMKgIMKgIMKgPT4gU2VuZCBoZWFkZXI6IEdFVCAvb3BlbnNvdXJjZS90ZXN0LmdpdC9p
bmZvL3JlZnM/c2VydmljZT1naXQtdXBsb2FkLXBhY2sgSFRUUC8xLjEKPjEwOjQyOjM2Ljk5OTAz
OSBodHRwLmM6NjIzIMKgIMKgIMKgIMKgIMKgIMKgIMKgPT4gU2VuZCBoZWFkZXI6IEhvc3Q6IGdp
dGVlLmNvbQo+MTA6NDI6MzYuOTk5MDQxIGh0dHAuYzo2MjMgwqAgwqAgwqAgwqAgwqAgwqAgwqA9
PiBTZW5kIGhlYWRlcjogQXV0aG9yaXphdGlvbjogQmFzaWMgPHJlZGFjdGVkPgo+MTA6NDI6MzYu
OTk5MDQyIGh0dHAuYzo2MjMgwqAgwqAgwqAgwqAgwqAgwqAgwqA9PiBTZW5kIGhlYWRlcjogVXNl
ci1BZ2VudDogZ2l0LzIuMzUuMS4xMDIuZzJiOWMxMjA5NzAKPjEwOjQyOjM2Ljk5OTA0NCBodHRw
LmM6NjIzIMKgIMKgIMKgIMKgIMKgIMKgIMKgPT4gU2VuZCBoZWFkZXI6IEFjY2VwdDogKi8qCj4x
MDo0MjozNi45OTkwNjMgaHR0cC5jOjYyMyDCoCDCoCDCoCDCoCDCoCDCoCDCoD0+IFNlbmQgaGVh
ZGVyOiBBY2NlcHQtRW5jb2Rpbmc6IGRlZmxhdGUsIGd6aXAKPjEwOjQyOjM2Ljk5OTA4MSBodHRw
LmM6NjIzIMKgIMKgIMKgIMKgIMKgIMKgIMKgPT4gU2VuZCBoZWFkZXI6IEFjY2VwdC1MYW5ndWFn
ZTogZW4tVVMsICo7cT0wLjkKPjEwOjQyOjM2Ljk5OTEwMSBodHRwLmM6NjIzIMKgIMKgIMKgIMKg
IMKgIMKgIMKgPT4gU2VuZCBoZWFkZXI6IFByYWdtYTogbm8tY2FjaGUKPjEwOjQyOjM2Ljk5OTEw
NSBodHRwLmM6NjIzIMKgIMKgIMKgIMKgIMKgIMKgIMKgPT4gU2VuZCBoZWFkZXI6IEdpdC1Qcm90
b2NvbDogdmVyc2lvbj0yCj4xMDo0MjozNi45OTkxMDYgaHR0cC5jOjYyMyDCoCDCoCDCoCDCoCDC
oCDCoCDCoD0+IFNlbmQgaGVhZGVyOgo+Li4uCj4xMDo0MjozNy4wOTgzMjUgaHR0cC5jOjYxMSDC
oCDCoCDCoCDCoCDCoCDCoCDCoD0+IFNlbmQgaGVhZGVyLCAwMDAwMDAwMzQxIGJ5dGVzICgweDAw
MDAwMTU1KQo+MTA6NDI6MzcuMDk4MzY4IGh0dHAuYzo2MjMgwqAgwqAgwqAgwqAgwqAgwqAgwqA9
PiBTZW5kIGhlYWRlcjogUE9TVCAvb3BlbnNvdXJjZS90ZXN0LmdpdC9naXQtdXBsb2FkLXBhY2sg
SFRUUC8xLjEKPjEwOjQyOjM3LjA5ODM3NyBodHRwLmM6NjIzIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PT4gU2VuZCBoZWFkZXI6IEhvc3Q6IGdpdGVlLmNvbQo+MTA6NDI6MzcuMDk4MzgxIGh0dHAuYzo2
MjMgwqAgwqAgwqAgwqAgwqAgwqAgwqA9PiBTZW5kIGhlYWRlcjogQXV0aG9yaXphdGlvbjogQmFz
aWMgPHJlZGFjdGVkPgo+MTA6NDI6MzcuMDk4Mzg0IGh0dHAuYzo2MjMgwqAgwqAgwqAgwqAgwqAg
wqAgwqA9PiBTZW5kIGhlYWRlcjogVXNlci1BZ2VudDogZ2l0LzIuMzUuMS4xMDIuZzJiOWMxMjA5
NzAKPjEwOjQyOjM3LjA5ODM4NyBodHRwLmM6NjIzIMKgIMKgIMKgIMKgIMKgIMKgIMKgPT4gU2Vu
ZCBoZWFkZXI6IEFjY2VwdC1FbmNvZGluZzogZGVmbGF0ZSwgZ3ppcAo+MTA6NDI6MzcuMDk4NDE3
IGh0dHAuYzo2MjMgwqAgwqAgwqAgwqAgwqAgwqAgwqA9PiBTZW5kIGhlYWRlcjogQ29udGVudC1U
eXBlOiBhcHBsaWNhdGlvbi94LWdpdC11cGxvYWQtcGFjay1yZXF1ZXN0Cj4xMDo0MjozNy4wOTg0
MjEgaHR0cC5jOjYyMyDCoCDCoCDCoCDCoCDCoCDCoCDCoD0+IFNlbmQgaGVhZGVyOiBBY2NlcHQ6
IGFwcGxpY2F0aW9uL3gtZ2l0LXVwbG9hZC1wYWNrLXJlc3VsdAo+MTA6NDI6MzcuMDk4NDI1IGh0
dHAuYzo2MjMgwqAgwqAgwqAgwqAgwqAgwqAgwqA9PiBTZW5kIGhlYWRlcjogR2l0LVByb3RvY29s
OiB2ZXJzaW9uPTIKPjEwOjQyOjM3LjA5ODQyOCBodHRwLmM6NjIzIMKgIMKgIMKgIMKgIMKgIMKg
IMKgPT4gU2VuZCBoZWFkZXI6IENvbnRlbnQtTGVuZ3RoOiAxMTgKPjEwOjQyOjM3LjA5ODQzMSBo
dHRwLmM6NjIzIMKgIMKgIMKgIMKgIMKgIMKgIMKgPT4gU2VuZCBoZWFkZXI6Cj4uLi4KPiIKPldo
ecKgZ2l0LXVwbG9hZC1wYWNrL2dpdC1yZWNlaXZlLXBhY2sgc3RhZ2UgZG9lc24ndCBlbmFibGUg
dGhpcyBhYmlsaXR5Pwo+CkNhbiBhbnlvbmUgdGVsbCBtZSBpZiB0aGlzIGRlc2lnbiBpcyBpbnRl
bnRpb25hbC4=

