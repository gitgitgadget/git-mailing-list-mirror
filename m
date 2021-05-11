Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ECEC43460
	for <git@archiver.kernel.org>; Tue, 11 May 2021 02:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD7D6162B
	for <git@archiver.kernel.org>; Tue, 11 May 2021 02:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhEKCSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 22:18:14 -0400
Received: from smtp23.hk.chengmail.me ([113.10.190.88]:58313 "EHLO
        smtp23.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbhEKCSO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 22:18:14 -0400
X-CHENGMAILHOST: 113.10.190.88
X-CHENGMAIL-INSTANCEID: 38b8.6099e91c.f12d8.0
Date:   Tue, 11 May 2021 10:17:03 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, "Derrick Stolee" <dstolee@microsoft.com>
Subject: Re: Re: [PATCH] builtin/gc: warn when core.commitGraph is disabled
References: <510425b8b17411eb93770026b95c99cc@oschina.cn>, 
        <ceb22d54b18611ebb304a4badb2c2b1147508@gmail.com>
X-Priority: 3
X-GUID: F6B00E67-F471-4AB4-A55C-8EC0B6A366DF
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <202105111016030245893@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <fa99dc5ab1fe11eb92230026b95c99cc@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pgo+T24gTW9uLCBNYXkgMTAgMjAyMSwgbGlsaW5jaGFvQG9zY2hpbmEuY24gd3JvdGU6Cj4KPj4g
RnJvbTogTGkgTGluY2hhbyA8bGlsaW5jaGFvQG9zY2hpbmEuY24+Cj4+Cj4+IFRocm93IHdhcm5p
bmcgbWVzc2FnZSB3aGVuIGNvcmUuY29tbWl0R3JhcGggaXMgZGlzYWJsZWQgaW4gY29tbWl0LWdy
YXBoCj4+IG1haW50ZW5hbmNlIHRhc2suCj4KPldvbid0IHRoaXMgY2F1c2UgdGhlIGdjLmxvZyBp
c3N1ZSBub3RlZCBpbgo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZ2l0Lzg3cjFsMjdyYWUuZnNm
QGV2bGVkcmFhci5nbWFpbC5jb20vCj4KPk1vcmUgaW1wb3J0YW50bHksIEkgZG9uJ3QgdGhpbmsg
dGhpcyBVWCBtYWtlcyBzZW5zZS4gV2Ugc2FpZCB3ZSBkaWRuJ3QKPndhbnQgaXQsIHNvIHdoeSB3
YXJuIGFib3V0IGl0Pwo+Cj5NYXliZSB0aGVyZSBhcmUgZ29vZCByZWFzb25zIHRvLCBidXQgdGhp
cyBjb21taXQgbWVzc2FnZSAvIHBhdGNoIGRvZXNuJ3QKPm1ha2UgdGhlIGNhc2UgZm9yIGl0Li4u
Cj4gCkZvcmdpdmUgbWUsIEkgZG9uJ3Qga25vdyBhbnkgb2YgeW91ciBwcmV2aW91cyBkaXNjdXNz
aW9ucy4KU29ycnkgZm9yIGRpc3R1cmJpbmcuCgo+Cj4+IFNpZ25lZC1vZmYtYnk6IExpIExpbmNo
YW8gPGxpbGluY2hhb0Bvc2NoaW5hLmNuPgo+PiAtLS0KPj7CoCBidWlsdGluL2djLmMgfCA0ICsr
Ky0KPj7CoCAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+
Cj4+IGRpZmYgLS1naXQgYS9idWlsdGluL2djLmMgYi9idWlsdGluL2djLmMKPj4gaW5kZXggOThh
ODAzMTk2Yi4uOTA2ODRjYTNiMyAxMDA2NDQKPj4gLS0tIGEvYnVpbHRpbi9nYy5jCj4+ICsrKyBi
L2J1aWx0aW4vZ2MuYwo+PiBAQCAtODYxLDggKzg2MSwxMCBAQCBzdGF0aWMgaW50IHJ1bl93cml0
ZV9jb21taXRfZ3JhcGgoc3RydWN0IG1haW50ZW5hbmNlX3J1bl9vcHRzICpvcHRzKQo+PsKgIHN0
YXRpYyBpbnQgbWFpbnRlbmFuY2VfdGFza19jb21taXRfZ3JhcGgoc3RydWN0IG1haW50ZW5hbmNl
X3J1bl9vcHRzICpvcHRzKQo+PsKgIHsKPj7CoCBwcmVwYXJlX3JlcG9fc2V0dGluZ3ModGhlX3Jl
cG9zaXRvcnkpOwo+PiAtCWlmICghdGhlX3JlcG9zaXRvcnktPnNldHRpbmdzLmNvcmVfY29tbWl0
X2dyYXBoKQo+PiArCWlmICghdGhlX3JlcG9zaXRvcnktPnNldHRpbmdzLmNvcmVfY29tbWl0X2dy
YXBoKSB7Cj4+ICsJd2FybmluZyhfKCJza2lwcGluZyBjb21taXQtZ3JhcGggdGFzayBiZWNhdXNl
IGNvcmUuY29tbWl0R3JhcGggaXMgZGlzYWJsZWQiKSk7Cj4+wqAgcmV0dXJuIDA7Cj4+ICsJfQo+
PsKgCj4+wqAgY2xvc2Vfb2JqZWN0X3N0b3JlKHRoZV9yZXBvc2l0b3J5LT5vYmplY3RzKTsKPj7C
oCBpZiAocnVuX3dyaXRlX2NvbW1pdF9ncmFwaChvcHRzKSkgewo+

