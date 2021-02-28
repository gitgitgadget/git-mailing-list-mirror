Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E75DC433DB
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 17:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CFF64E54
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 17:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhB1R7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 12:59:17 -0500
Received: from smtp38.hk.chengmail.me ([113.10.190.104]:38040 "EHLO
        smtp38.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhB1R7R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 12:59:17 -0500
X-CHENGMAILHOST: 113.10.190.104
X-CHENGMAIL-INSTANCEID: 66e9.603bd9bf.bf74d.0
Date:   Mon, 1 Mar 2021 01:58:26 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, "Derrick Stolee" <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>,
        "Jonathan Tan" <jonathantanmy@google.com>
Subject: Re: Re: [PATCH v4] builtin/clone.c: add --reject-shallow option
References: <pull.865.v3.git.1612793576910.gitgitgadget@gmail.com>, 
        <pull.865.v4.git.1613891147977.gitgitgadget@gmail.com>, 
        <8f3c00de753911eb93d3d4ae5278bc1270191@pobox.com>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021030101582548655030@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <905d20d879ee11eb9c1e0024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ci0tLS0tLS0tLS0tLS0tCmxpbGluY2hhb0Bvc2NoaW5hLmNuCj5bamM6IEkndmUgQ0MnZWQgSm9u
YXRoYW4gVGFuLCB3aG8gaXMgbXVjaCBtb3JlIGtub3dsZWRnZWFibGUgdGhhbiBJCj5hbSBvbiB0
aGUgdHJhbnNwb3J0IGxheWVyIGlzc3VlcywgdG8gc2FuaXR5IGNoZWNrIG15IGFzc3VtcHRpb25d
Cj4KPiJMaSBMaW5jaGFvIHZpYSBHaXRHaXRHYWRnZXQiIDxnaXRnaXRnYWRnZXRAZ21haWwuY29t
PiB3cml0ZXM6Cj4KPj4gQEAgLTEzNjMsNiArMTM4NCwxMiBAQCBpbnQgY21kX2Nsb25lKGludCBh
cmdjLCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqcHJlZml4KQo+PsKgIGdvdG8gY2xl
YW51cDsKPj7CoCB9Cj4+wqAKPj4gKwlpZiAocmVqZWN0X3NoYWxsb3cpIHsKPj4gKwlpZiAobG9j
YWxfc2hhbGxvdyB8fCBpc19yZXBvc2l0b3J5X3NoYWxsb3codGhlX3JlcG9zaXRvcnkpKSB7Cj4K
PlRoaXMgbWF5IHJlamVjdCB0byBjbG9uZSBmcm9tIGEgc2hhbGxvdyByZXBvc2l0b3J5LCBidXQg
YXQgdGhpcwo+cG9pbnQgdGhlIGJ1bGsgb2YgdGhlIHRyYW5mZXIgZnJvbSB0aGUgb3JpZ2luIHJl
cG9zaXRvcnkgaGFzIGFscmVhZHkKPmhhcHBlbmVkLCBubz/CoCBSZWplY3RpbmcgYWZ0ZXIgdHJh
bnNmZXJyaW5nIG1hbnkgbWVnYWJ5dGVzIGZlZWxzIGEKPmJpdCB0b28gbGF0ZS7CoCBUaGF0IGlz
IG9uZSBvZiB0aGUgcmVhc29ucyB3aHkgSSBrZXB0IGhpbnRpbmcgdGhhdAo+dGhlIHRyYW5zcG9y
dCBsYXllciBuZWVkcyB0byBiZSB0YXVnaHQgYW4gb3B0aW9uIHRvIHJlamVjdCB0YWxraW5nCj50
byBhIHNoYWxsb3cgY291bnRlcnBhcnQgaWYgd2Ugd2FudCB0byBhZGQgdGhpcyBmZWF0dXJlIFsq
MSpdLgo+Cj5BbHNvLCB3b3VsZG4ndCAiY2xvbmUgLS1kZXB0aD0xIC0tcmVqZWN0LXNoYWxsb3ci
IGZyb20gYSByZXBvc2l0b3J5Cj50aGF0IGlzIG5vdCBzaGFsbG93IG1ha2UgdGhlX3JlcG9zaXRv
cnkgYSBzaGFsbG93IG9uZSBhdCB0aGlzIHBvaW50Cj5hbmQgbWFrZXMgaXQgZmFpbD/CoCBJZiB0
aGUgZ29hbCBvZiB0aGUgLS1yZWplY3Qtc2hhbGxvdyBvcHRpb24gd2VyZQo+dG8gbWFrZSBzdXJl
IHRoZSByZXN1bHRpbmcgcmVwb3NpdG9yeSBpcyBub3Qgc2hhbGxvdywgdGhlbiB0aGF0IGlzIGEK
PnRlY2huaWNhbGx5IGNvcnJlY3QgaW1wbGVtZW50YXRpb24gKGV2ZW4gdGhvdWdoIGl0IGlzIHdh
c3RlZnVsIHRvCj50cmFuc2ZlciBhIGZ1bGwgdHJlZSB3b3J0aCBvZiBtZWdhYnl0ZXMgYW5kIHRo
ZW4gYWJvcnQpLCBidXQgaXMgdGhlCj5mZWF0dXJlIGlzIGV4cGxhaW5lZCB0byByZWplY3QgY2xv
bmluZyBmcm9tIGEgc2hhbGxvdyBvbmUsIHRoZW4KPnVzZXJzIHdvdWxkIGJlIHN1cHJpc2VkIHRv
IHNlZSAuLi4KPgo+PiArCWRpZShfKCJzb3VyY2UgcmVwb3NpdG9yeSBpcyBzaGFsbG93LCByZWpl
Y3QgdG8gY2xvbmUuIikpOwo+Cj4uLi4gdGhpcyBtZXNzYWdlLCB3aGVuIGNsb25pbmcgZnJvbSB3
ZWxsIGtub3duIHB1YmxpY2ggcmVwb3NpdG9yaWVzCj50aGF0IGFyZSBub3Qgc2hhbGxvdy4KPiAK
VWgsIElNTyB0aGUgZ29hbCBvZiB0aGlzIG5ldyBvcHRpb24gaXMgbm90IHRvIG1ha2Ugc3VyZSB0
aGUgY2xvbmVkIHJlcG8KaXMgbm90IHNoYWxsb3csIGJ1dCB0byBwcmV2ZW50KGp1c3QgYXMgb3B0
aW9uYWwpIHRoZSByZW1vdGUgcmVwbyBpcyBzaGFsbG93LMKgCndlIHN0aWxswqBhbGxvdyB0aGUg
cmVzdWx0aW5nIHJlcG8gaXMgc2hhbGxvdyBieSB1c2luZyAiLS1kZXB0aCIgb3B0aW9uLgpzbywg
aWYgd2UgYXBwbHkgImNsb25lIC0tZGVwdGg9MSAtLXJlamVjdC1zaGFsbG93PXRydWUiIHRvIGEg
Y2xvbmUgcHJvY2VzcywKdGhlIGV4cGVjdGVkIHJlc3VsdCBpcyBhIHNoYWxsb3cgcmVwby4KT2gs
IHdhaXQsIHdoYXQgaWYgd2UgYXBwbHkgIi0tZGVwdGg9MSIgdG8gYSByZW1vdGUgc2hhbGxvdyBy
ZXBvLCBpbiBvdGhlciB3b3JkLApzaGFsbG93IGEgcmVtb3RlIHNoYWxsb3cgcmVwbz8gdGhlbiB0
aGUgcmVzdWx0IHdpbGwgbm90IGJlIHdoYXQgd2UgZXhwZWN0ZWQuClRoaXMgY2FuIGJlIGNvbmZ1
c2luZy4KCj5JIHRoaW5rIGNsb25pbmcgd2l0aCAtLWRlcHRoPTxuPiB3aGVuIHRoZSBzb3VyY2Ug
cmVwb3NpdG9yeSBpcyBkZWVwCj5lbm91Z2gsIHNob3VsZCBiZSBhbGxvd2VkLCBzbyB0aGUgY2xl
YW5lc3Qgc29sdXRpb24gZm9yIHRoZSBsYXR0ZXIKPm1heSBiZSB0byBub3RpY2UgdGhlIGNvbWJp
bmF0aW9uIG9mIG9wdGlvbnMgdGhhdCBtYWtlIHRoZSByZXN1bHRpbmcKPnJlcG9zaXRvcnkgc2hh
bGxvdyAoSSBtZW50aW9uZWQgLS1kZXB0aD08bj4sIGJ1dCB0aGVyZSBtYXkgYmUgb3RoZXJzKQo+
YW5kIHRoZSAtLXJlamVjdC1zaGFsbG93IG9wdGlvbiBhbmQgZXJyb3Igb3V0IGJlZm9yZSBldmVu
IHRhbGtpbmcKPnRvIHRoZSBvdGhlciBzaWRlIGF0IHRoZSB0aW1lIHdlIHBhcnNlIHRoZSBjb21t
YW5kIGxpbmUuCj4KPlRoYW5rcy4KPgo+Cj5bRm9vdG5vdGVdCj4KPioxKiBMb29raW5nIGF0IERv
Y3VtZW50YXRpb24vdGVjaG5pY2FsL3BhY2stcHJvdG9jb2wudHh0LCAiZ2l0Cj7CoMKgwqAgZmV0
Y2giIHNlZW0gdG8gbGVhcm4gaWYgdGhlIHJlcG9zaXRvcnkgaXMgc2hhbGxvdyBpbW1lZGlhdGVs
eQo+wqDCoMKgIHVwb24gY29udGFjdGluZyAidXBsb2FkLXBhY2siIGR1cmluZyB0aGUgUmVmZXJl
bmNlIERpc2NvdmVyeQo+wqDCoMKgIHBoYXNlICh3ZSdkIHNlZSAnc2hhbGxvdycgcGFja2V0cyBp
ZiB0aGV5IGFyZSBzaGFsbG93KS4gSQo+wqDCoMKgIHN1c3BlY3QgdGhhdCB0aGUgcmlnaHQgc29s
dXRpb24gd291bGQgYmUgdG8gdGVhY2ggdGhlIGNvZGVwYXRoCj7CoMKgwqAgb24gdGhlICJnaXQg
ZmV0Y2giIHNpZGUgdGhhdCBhY2NlcHRzLCBwYXJzZXMsIGFuZCBhY3RzIG9uIHRoaXMKPsKgwqDC
oCBwYWNrZXQgdG8gb3B0aW9uYWxseSBzdG9wIGNvbW11bmljYXRpb24gYW5kIGVycm9yIG91dCB3
aGVuIHRoZQo+wqDCoMKgIGNhbGxlciBhc2tzIG5vdCB0byB0YWxrIHdpdGggYSBzaGFsbG93IHJl
cG9zaXRvcnkuIAoKSSB0b29rIHRoZSB0aW1lIHRvIHVwZGF0ZSB0aGUgcGF0Y2ggYXMgeW91IHN1
Z2dlc3RlZCB0aGVyZSwgaXQgbWF5IGxvb2sKaW1wZXJmZWN0LCBJIG9ubHkgdGVzdGVkIHRoZSBs
b2NhbCBwcm90b2NvbCwgYW5kIHRoZSBzbWFydCBwcm90b2NvbHMsCm5vdCBkdW1iwqBwcm90b2Nv
bCwgYW5kIG5vdCBwcm90b2NvbCB2ZXJzaW9uMSB5ZXQuwqAKSG9wZSB0byBnZXQgc29tZSBzdWdn
ZXN0aW9ucyBmcm9tIHlvdS4=

