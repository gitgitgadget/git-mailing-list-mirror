Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64527C433E0
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 03:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3624561A2A
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 03:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhCZDev (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 23:34:51 -0400
Received: from smtp38.hk.chengmail.me ([113.10.190.104]:43295 "EHLO
        smtp38.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhCZDep (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 23:34:45 -0400
X-CHENGMAILHOST: 113.10.190.104
X-CHENGMAIL-INSTANCEID: 12b1.605d564b.80d76.0
Date:   Fri, 26 Mar 2021 11:34:36 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, "Derrick Stolee" <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        "Jonathan Tan" <jonathantanmy@google.com>
Subject: Re: Re: [PATCH v7] builtin/clone.c: add --reject-shallow option
References: <pull.865.v6.git.1614878345754.gitgitgadget@gmail.com>, 
        <pull.865.v7.git.1616670558261.gitgitgadget@gmail.com>, 
        <19c9dc128da911ebacc7d4ae5278bc1233465@pobox.com>
X-Priority: 3
X-GUID: 9F3ABA10-45CA-453B-B938-B67609C113E2
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <202103261132150912037@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <33a250a28de411eb9ccd0024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CgoKLS0tLS0tLS0tLS0tLS0KbGlsaW5jaGFvQG9zY2hpbmEuY24KPiJMaSBMaW5jaGFvIHZpYSBH
aXRHaXRHYWRnZXQiIDxnaXRnaXRnYWRnZXRAZ21haWwuY29tPiB3cml0ZXM6Cj4KPj4gLi4uCj4+
IFRoaXMgcGF0Y2ggb2ZmZXJzIGEgbmV3IG9wdGlvbiAnLS1yZWplY3Qtc2hhbGxvdycgdGhhdCBj
YW4gcmVqZWN0IHRvCj4+IGNsb25lIGEgc2hhbGxvdyByZXBvc2l0b3J5Lgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBsaWxpbmNoYW8gPGxpbGluY2hhb0Bvc2NoaW5hLmNuPgo+Pgo+PiBSZXZpZXdlZC1i
eTogRGVycmljayBTdG9sZWUgPGRzdG9sZWVAbWljcm9zb2Z0LmNvbT4KPj4gUmV2aWV3ZWQtYnk6
IEp1bmlvIEMgSGFtYW5vPGdpdHN0ZXJAcG9ib3guY29tPgo+PiBSZXZpZXdlZC1ieTogSm9oYW5u
ZXMgU2NoaW5kZWxpbiA8am9oYW5uZXMuc2NoaW5kZWxpbkBnbXguZGU+Cj4+IFJldmlld2VkLWJ5
OiBKb25hdGhhbiBUYW48am9uYXRoYW50YW5teUBnb29nbGUuY29tPgo+Cj5UaGUgUmV2aWV3ZWQt
YnkgdHJhaWxlciBtZWFucyBzb21ldGhpbmcgcXVpdGUgZGlmZmVyZW50IGZyb20gd2hhdAo+eW91
IHNlZW0gdG8gdGhpbmsgaGVyZS7CoCBJdCBpcyBvbmx5IGdpdmVuIGJ5IHRoZSByZXZpZXdlcnMg
dG8gdGhlCj5wYXRjaCB3aGVuIHRoZXkgY2FyZWZ1bGx5IHJldmlld2VkIGFuZCBhZ3JlZXMgd2hh
dCBpcyBpbiB0aGUgcGF0Y2guCj5UaGUgcGF0Y2ggYXV0aG9ycyBhcmUgaW4gbm8gcG9zaXRpb24g
dG8gYWRkIGl0LCB1bmxlc3MgdGhleSBhcmUKPmV4cGxpY2l0bHkgdG9sZCBieSByZXZpZXdlcnMg
dGhhdCAidGhpcyBwYXRjaCBub3cgY2FuIGhhdmUgbXkKPlJldmlld2VkLWJ5OiIgb3Igc29tZSBl
cXVpdmFsZW50Lgo+Cj5UaGUgKGlkZWFsKSBmbG93IG9mIGV2ZW50cyBpcwo+Cj4gMC4gVGhlIGF1
dGhvciBjb21lcyB1cCB3aXRoIGFuIGlkZWEgYW5kIHdyaXRlcyBhIHBhdGNoLgo+Cj4gMS4gVGhl
IHBhdGNoIGlzIHNlbnQgdG8gdGhlIGxpc3QgYW5kIENjJ2VkIHRvIHBlb3BsZSB3aG8gbWF5IGJl
Cj7CoMKgwqAgZmFtaWxpYXIgd2l0aCB0aGUgYXJlYSB0aGUgcGF0Y2ggdG91Y2hlcy7CoCBGb3Ig
c2Vjb25kIGFuZAo+wqDCoMKgIHN1YnNlcXVlbnQgaXRlcmF0aW9ucywgdGhvc2Ugd2hvIGdhdmUg
cmV2aWV3IGNvbW1lbnRzIHRvIHRoZQo+wqDCoMKgIHByZXZpb3VzIGl0ZXJhdGlvbnMgYXJlIGFs
c28gZ29vZCBwZW9wbGUgdG8gQ2MgdG8uCj4KPiAyLiBQZW9wbGUgZ2l2ZSBjb21tZW50cyBhcyBy
ZXBvbnNlcyB0byB0aGUgcGF0Y2guCj4KPsKgwqDCoCAoYSkgc29tZSBtYXkgYmUgaGFwcHkgd2l0
aCB0aGUgaXRlcmF0aW9uIG9mIHRoZSBwYXRjaCB0aGV5Cj7CoMKgwqDCoMKgwqDCoCByZXZpZXdl
ZCwgYW5kIG1heSBzYXkgIlRoYW5rcyBmb3IgY29udHJpYnV0aW5nLCB0aGlzIGlzIG5vdwo+wqDC
oMKgwqDCoMKgwqAgUmV2aWV3ZWQtYnk6IG1lIi7CoCBGb3Igc2Vjb25kIGFuZCBzdWJzZXF1ZW50
IGl0ZXJhdGlvbnMsCj7CoMKgwqDCoMKgwqDCoCB0aGV5IG1heSBzYXkgIlRoaXMgd2FzIGltcHJv
dmVkIHJlbGF0aXZlIHRvIHRoZSBwcmV2aW91cwo+wqDCoMKgwqDCoMKgwqAgaXRlcmF0aW9uLCBh
bmQgaXQgc3RpbGwgbG9va3MgZ29vZCBhbmQgeW91IGhhdmUgbXkKPsKgwqDCoMKgwqDCoMKgIFJl
dmlld2VkLWJ5OiIuCj4KPsKgwqDCoCAoYikgc29tZSBtYXkgZ2l2ZSBjb25zdHJ1Y3RpdmUgY3Jp
dGljaXNtLCBhbHRlcm5hdGl2ZXMsCj7CoMKgwqDCoMKgwqDCoCBlbmhhbmNlbWVudHMsIG9yIG91
dHJpZ2h0ICJub3QgYSBnb29kIGlkZWEsIGRvbid0IGRvIHRoaXMKPsKgwqDCoMKgwqDCoMKgIGJl
Y2F1c2UgLi4uIi4KPgo+wqDCoMKgIChjKSBzb21lIG1heSBqdXN0IGFjdCBhcyBjaGVlcmxlYWRl
cnMuCj4KPiAzLiBUaGUgYXV0aG9yIHRoaW5rcyBhYm91dCB0aGUgcmV2aWV3IGNvbW1lbnRzIGFu
ZCBhbHNvIG1heSBmaW5kCj7CoMKgwqAgaW1wcm92ZW1lbnQgaGltL2hlcnNlbGYuCj4KPsKgwqDC
oCAoYSkgVGhlcmUgbWF5IG5lZWQgYW4gdXBkYXRlIHRvIHRoZSBwYXRjaC7CoCBJZiB0aGUgcGF0
Y2ggaGFzCj7CoMKgwqDCoMKgwqDCoCBjaGFuZ2VkIHNpbmNlIHRoZSBwcmV2aW91cyB2ZXJzaW9u
IGluIGFueSB3YXksIGlnbm9yZQo+wqDCoMKgwqDCoMKgwqAgUmV2aWV3ZWQtYnk6IHJlY2VpdmVk
IGluIDItKGEpLsKgIFdoZW4gYSBzaWduaWZpY2FudCBoZWxwIHdhcwo+wqDCoMKgwqDCoMKgwqAg
Z2l2ZW4gdG8gdXBkYXRlIHRoZSBwYXRjaCwgeW91IG1heSBhZGQgIkhlbHBlZC1ieToiIHRyYWls
ZXIKPsKgwqDCoMKgwqDCoMKgIHRvIGNyZWRpdCB0aGUgcGVyc29uJ3MgY29udHJpYnV0aW9uLgo+
Cj7CoMKgwqDCoMKgwqDCoCBZb3VyIG93biAiU2lnbmVkLW9mZi1ieToiIGFwcGVhcnMgdGhlIGxh
c3QgaW4gdGhlIHRyYWlsZXJzCj7CoMKgwqDCoMKgwqDCoCAoaS5lLiAidGhpcyBpdGVyYXRpb24g
b2YgdGhlIHBhdGNoIHdhcyB3cml0dGVuIHdpdGggaGVscAo+wqDCoMKgwqDCoMKgwqAgZnJvbSB0
aGVzZSBwZW9wbGUsIGFuZCB0aGVuIEkgYW0gc2lnbmluZyBpdCBvZmYganVzdCBiZWZvcmUKPsKg
wqDCoMKgwqDCoMKgIHNlbmRpbmcgaXQgb3V0IikuCj4KPglHbyBiYWNrIHRvIDEuIGFuZCByZXBl
YXQgYXMgbWFueSB0aW1lcyBhcyBpdCB0YWtlcy4KPsKgwqDCoAo+wqDCoMKgIChiKSBUaGVyZSBt
YXkgbm90IGJlIGEgbmVlZCBmb3IgYW55IHVwZGF0ZSB0byB0aGUgcGF0Y2guwqAgT25seQo+wqDC
oMKgwqDCoMKgwqAgYWRkIHRoZSBSZXZpZXdlZC1ieTogcmVjZWl2ZWQgaW4gMi0oYSkgYW5kIG90
aGVyd2lzZSBkbyBub3QKPsKgwqDCoMKgwqDCoMKgIGNoYW5nZSBhbnl0aGluZy7CoCBZb3VyIG93
biAiU2lnbmVkLW9mZi1ieToiIGFwcGVhcnMgdGhlIGxhc3QKPsKgwqDCoMKgwqDCoMKgIGluIHRo
ZSB0cmFpbGVycy7CoCBTZW5kIGl0IHRvIHRoZSBsaXN0IGFuZCB0byB0aGUgbWFpbnRhaW5lcgo+
wqDCoMKgwqDCoMKgwqAgKG1lKS4KPgo+IDQuIFRoZSBtYWludGFpbmVyIGFwcGxpZXMgdGhlIHBh
dGNoLCB1bmxlc3MgdGhlcmUgaXMgbm8gb3RoZXIKPsKgwqDCoCBjb21tZW50cyByZWNlaXZlZCBv
biB0aGF0IHN1cHBvc2VkbHktdGhlLWZpbmFsIHZlcnNpb24gc2VudCBpbgo+wqDCoMKgIDMtKGIp
LCBidXQgYSBsYXRlIHJldmlldyBjb21tZW50IG1heSBtYWtlIHVzIHJlYWxpemUgdGhhdCBpdCB3
YXMKPsKgwqDCoCBwcmVtYXR1cmUsIGluIHdoaWNoIGNhc2Ugd2UgbWF5IGdvIGJhY2sgdG8gMy0o
YSkuCj4gCgpNYW55IHRoYW5rcyBmb3Igc28gZGV0YWlsZWQgaW5zdHJ1Y3Rpb25zIGFib3V0IHdv
cmsgZmxvdyBpbiBnaXQgY29tbXVuaXR5LgpJIHdpbGwgZm9sbG93IHRoaXMgZmxvdyB0aWdodGx5
Lg==

