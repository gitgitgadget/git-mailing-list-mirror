Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E838C433C1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 04:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011976196C
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 04:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCYEXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 00:23:19 -0400
Received: from smtp43.hk.chengmail.me ([113.10.190.89]:52720 "EHLO
        smtp43.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCYEWy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 00:22:54 -0400
X-CHENGMAILHOST: 113.10.190.89
X-CHENGMAIL-INSTANCEID: 5cb8.605c1015.c2fcd.0
Date:   Thu, 25 Mar 2021 12:22:45 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Re: [PATCH 2/2] remote-curl.c: handle v1 when check_smart_http
References: <20210324053648.25584-1-lilinchao@oschina.cn>, 
        <006547b28c6311eb93820024e87935e7@oschina.cn>, 
        <xmqq7dlwxpn3.fsf@gitster.g>, 
        <388751448ce011ebaaead4ae5278bc1265898@pobox.com>
X-Priority: 3
X-GUID: A578FE83-7620-40C3-8B32-D31F9F3AD57D
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021032512214497657929@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <c0cd24e88d2111ebbdf30026b95c99cc@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

LS0tLS0tLS0tLS0tLS0KbGlsaW5jaGFvQG9zY2hpbmEuY24KPkp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JpdGVzOgo+Cj4+PiArCX0gZWxzZSBpZiAoIXN0cmNtcChyZWFkZXIu
bGluZSwgInZlcnNpb24gMSIpKSB7Cj4+PiArCWRpZShfKCJ2MSBpcyBqdXN0IHRoZSBvcmlnaW5h
bCBwcm90b2NvbCB3aXRoIGEgdmVyc2lvbiBzdHJpbmcsIHVzZSB2MCBvciB2MiBpbnN0ZWFkLiIp
KTsKPj4KPj4gVGhlIHVzZXIgbWF5IG5vIGxvbmdlciBnZXQgImludmFsaWQgcmVzcG9uc2U7IGdv
dCAndmVyc2lvbiAxJyIsIGJ1dAo+PiB0aGUgYWJvdmUgZG9lcyBub3Qgc3RpbGwgZXhwbGFpbiB3
aHkgdjEgaXMgYmFkIGFuZCB2MCBvciB2MiBpcwo+PiB3ZWxjb21lLCBlaXRoZXIuwqAgSU9XLCBJ
IGRvIG5vdCB0aGluayB0aGUgcGF0Y2ggaW1wcm92ZXMgdGhlIG1lc3NhZ2UKPj4gdG8gYWNoaWV2
ZSB3aGF0IGl0IGF0dGVtcHRlZCB0byBkbywgaS5lLgo+Pgo+PsKgwqDCoMKgIC4uLiBidXQgdGhl
IG90aGVyIHNpZGUganVzdCB0cmVhdCBpdCBhcyAiaW52YWxpZCByZXNwb25zZSIsIHRoaXMKPj7C
oMKgwqDCoCBjYW4ndCBleHBsYWluIHdoeSBpcyBub3Qgb2suCj4KPkFsdGVybmF0aXZlbHkKPgo+
CXYxIGlzIG5vdCBzdXBwb3J0ZWQ7IHVzZSB2MCBvciB2Mgo+Cj53b3VsZCBleHBsYWluIHdoeSB0
aGUgY29ubmVjdGlvbiBpcyByZWZ1c2VkLsKgIEl0IGV4cGxhaW5zIHdoeSBpdCBpcwo+bm90IG9r
IG11Y2ggY2xlYXJseSB0aGFuICJqdXN0IHRoZSBvcmlnaW5hbCB3aXRoIGEgdmVyc2lvbiBzdHJp
bmciLgo+Cj4+IEkgd29uZGVyIGlmIGl0IGlzIGEgc2Vuc2libGUgYW5kIGJldHRlciBhbHRlcm5h
dGl2ZSB0byB0cmVhdCB2MQo+PiByZXNwb25zZSBhcyBpZiB3ZSBnb3QgdjAgKGlmIHYxIGlzIHRy
dWx5IHRoZSBzYW1lIGFzIHYwIGV4Y2VwdCBmb3IKPj4gdGhlIGluaXRpYWwgdmVyc2lvbiBhZHZl
cnRpc2VtZW50KS4KPj4KPj4gSW5wdXQgZnJvbSB0aG9zZSB3aG8gYXJlIGZhbWlsaWFyIHdpdGgg
dGhlIHByb3RvY29sIHZlcnNpb25zIGlzIHZlcnkKPj4gbXVjaCBhcHByZWNpYXRlZC4KPgo+VGhp
cyBzdGlsbCBzdGFuZHM7IHdlIHJlamVjdCBiZWNhdXNlIHdlIGRvbid0IHN1cHBvcnQsIGJ1dCBp
cyBpdAo+ZWFzeSB0byBzdXBwb3J0IGl0IGluc3RlYWQsIGlmIHRoZXJlIGlzIG5vIGRpZmZlcmVu
Y2U/IAoKWWVzLCBpZiB0aGVyZSBpcyBubyBkaWZmZXJlbmNlLCBqdXN0IHRvIHN1cHBvcnQgaXQg
dG9vLiBTbyBJIGRvbid0IGtub3cKd2h5IGl0IGlzIG5vdCBzdXBwb3J0IHVudGlsIG5vdy4KClRo
YW5rcy4=

