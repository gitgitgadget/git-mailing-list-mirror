Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6317C433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 03:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5CD61A0A
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 03:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhCYDjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 23:39:15 -0400
Received: from smtp512.hk.chengmail.me ([113.10.190.174]:58282 "EHLO
        smtp512.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhCYDjI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 23:39:08 -0400
X-CHENGMAILHOST: 113.10.190.174
X-CHENGMAIL-INSTANCEID: 6e01.605c05d4.e03ef.0
Date:   Thu, 25 Mar 2021 11:39:01 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Re: [PATCH 1/2] transport.c: modify comment in transport_get().
References: <f64df5f88c6211eb9c9a0024e87935e7@oschina.cn>, 
        <c6ee6c9e8cde11eba7e5a4badb2c2b1175929@pobox.com>
X-Priority: 3
X-GUID: 210E12B3-17D7-4F96-B8FE-97B0C0A09BF7
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021032511375949161922@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <a46828308d1b11eb8d710026b95c99cc@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PmxpbGluY2hhb0Bvc2NoaW5hLmNuIHdyaXRlczoKPgo+PiBGcm9tOiBsaWxpbmNoYW8gPGxpbGlu
Y2hhb0Bvc2NoaW5hLmNuPgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBsaWxpbmNoYW8gPGxpbGluY2hh
b0Bvc2NoaW5hLmNuPgo+PiAtLS0KPj7CoCB0cmFuc3BvcnQuYyB8IDIgKy0KPj7CoCAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBh
L3RyYW5zcG9ydC5jIGIvdHJhbnNwb3J0LmMKPj4gaW5kZXggMWM0YWI2NzZkMS4uNzFiM2Q0NGNm
MyAxMDA2NDQKPj4gLS0tIGEvdHJhbnNwb3J0LmMKPj4gKysrIGIvdHJhbnNwb3J0LmMKPj4gQEAg
LTEwNzgsNyArMTA3OCw3IEBAIHN0cnVjdCB0cmFuc3BvcnQgKnRyYW5zcG9ydF9nZXQoc3RydWN0
IHJlbW90ZSAqcmVtb3RlLCBjb25zdCBjaGFyICp1cmwpCj4+wqAgZGF0YS0+Y29ubiA9IE5VTEw7
Cj4+wqAgZGF0YS0+Z290X3JlbW90ZV9oZWFkcyA9IDA7Cj4+wqAgfSBlbHNlIHsKPj4gLQkvKiBV
bmtub3duIHByb3RvY29sIGluIFVSTC4gUGFzcyB0byBleHRlcm5hbCBoYW5kbGVyLiAqLwo+PiAr
CS8qIEh0dHAvaHR0cHMgYW5kIG90aGVyIHVua25vd24gcHJvdG9jb2wgaW4gVVJMLiBQYXNzIHRv
IGV4dGVybmFsIGhhbmRsZXIuICovCj4KPlRoZSBwcmV2aW91cyBibG9jayBzYXlzCj4KPgkvKgo+
CSogVGhlc2UgYXJlIGJ1aWx0aW4gc21hcnQgdHJhbnNwb3J0czsgImFsbG93ZWQiIHRyYW5zcG9y
dHMKPgkqIHdpbGwgYmUgY2hlY2tlZCBpbmRpdmlkdWFsbHkgaW4gZ2l0X2Nvbm5lY3QuCj4JKi8K
Pgo+d2hlcmUgaXQgbGlzdHMgZmlsZTovLyBnaXQ6Ly8gYW5kIHNzaDovLyBVUkxzLsKgIEFuZCBj
b250cmFzdGluZyB3aXRoCj50aGF0LCBpdCBzaG91bGQgYmUgY2xlYXIgInVua25vd24iIHJlZmVy
cyB0byAibm90IGEgYnVpbHRpbiB0aGF0IGlzCj5rbm93biB0byB0aGUgQyBjb2RlIGxpbmtlZCB0
byB0aGUgc2FtZSBiaW5hcnkiIGFuZCBpbmNsdWRlcyBodHRwOi8vCj5hbmQgaHR0cHM6Ly8uCj4g
CgpJIHRoaW5rIHRoZSBjb21tZW50IGhlcmUgc2hvdWxkIGV4cGxpY2l0bHkgbWVudGlvbiB0aGF0
IEhUVFAKaXMgaW5jbHVkZWQgOikKCj5JT1csIEkgYW0gbm90IHN1cmUgYWRkaW5nICJodHRwL2h0
dHBzIGFuZCBvdGhlciIgdG8gbWFrZSBpdCBhbgo+b3ZlcmxvbmcgbGluZSBpcyB3b3J0aCBkb2lu
Zy4KPiAKCkluZGVlZCwgb3ZlcmxvbmcgbGluZSBpcyBub3QgZ29vZCwgSSB3aWxsIGRyb3AgdGhp
cyBjaGFuZ2UuCgo+VGhhbmtzLg==

