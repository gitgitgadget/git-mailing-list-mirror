Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF98FC43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 05:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbiFDFql (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 01:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiFDFqk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 01:46:40 -0400
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C8837BD6
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 22:46:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1116103|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0742874-0.00349159-0.922221;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=lilinchao@oschina.cn;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Nyt-nnP_1654321587;
Received: from Colin(mailfrom:lilinchao@oschina.cn fp:SMTPD_---.Nyt-nnP_1654321587)
          by smtp.aliyun-inc.com(33.13.197.192);
          Sat, 04 Jun 2022 13:46:27 +0800
Date:   Sat, 4 Jun 2022 13:46:29 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Re: protocol: add Accept-Language header if possible
References: <2022060211034177301214@oschina.cn>, 
        <202206040227197341312@oschina.cn>, 
        <xmqqczfpfttb.fsf@gitster.g>
X-Priority: 3
X-GUID: 7BB17AFD-CD05-4284-A487-6E4FA03EC358
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
Message-ID: <2022060413415461823368@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cj4ibGlsaW5jaGFvQG9zY2hpbmEuY24iIDxsaWxpbmNoYW9Ab3NjaGluYS5jbj4gd3JpdGVzOgo+
Cj5JIGFtIG5vdCB5b3VyIHBlcnNvbmFsIGhlbHAtZGVzay7CoCBQbGVhc2UgZG9uJ3QgQ2M6IHF1
ZXN0aW9ucyB0byBtZQo+dW5sZXNzIGl0IGlzIGEgcGllY2Ugb2YgY29kZSBJIHdyb3RlIGFuZCBh
bSBmYW1pbGlhciB3aXRoLgpGaXJzdCBvZiBhbGwsIHNvcnJ5IHRvIGRpc3R1cmIgeW91LCBJIHRo
b3VnaHQgeW91J3JlIHRoZSBwZXJzb24gbW9zdCBmYW1pbGlhcgp3aXRoIHRob3NlIGNvZGVzIDop
ClRoaXMgaXMgbm90IGp1c3QgYSBxdWVzdGlvbiwgYXMgSSBhbSBwbGFuaW5nIHRvIGRvIHNvbWUg
d29yayBvbiBnaXQgdG8gbGV0CnNlcnZlciBzaWRlIGtub3cgdGhlwqBjbGllbnQgZW5kIGxvY2Fs
ZSBpbmZvIGZvciBldmVyeSBIVFRQIHJlcXVlc3QsIHRoaXMgaXMKdmVyeSBoZWxwZnVswqBmb3Ig
bWFueSBub24tRW5nbGlzaCBzcGVha2VycyB0byB1bmRlcnN0YW5kwqB3aGF0IGhhcHBlbmVkCndo
ZW4gZ2l0IHRocm93IHNvbWUgZXJyb3IgbWVzc2FnZXMuCkJ1dCBmaXJzdCBJIHdhbnQgdG8ga25v
dyBpZiBpdCBpcyB3b3J0aCBkb2luZywgYW5kIEknbSBjdXJpb3VzIHRvIGtub3cKdGhlIG9yaWdp
bmFsIGRlc2lnbiBwdXJwb3NlLCBlc3BlY2lhbGx5IHdoZW4gSSBzZWUgaW5jb25zaXN0ZW50IGJl
aGF2aW9yLApzbyBJIGNhbWUgaGVyZSBmb3IgaGVscC4KPkJ1dCBzaW5jZSB5b3UgYWRkZWQgYW4g
ZXhwbGljaXQgQ0MsIGxldCBtZSB0cnkuwqAgRG8gbm90IGV4cGVjdCBhbnkKPmhpZ2ggcXVhbGl0
eSBhbnN3ZXJzLCB0aG91Z2guCj4KVGhhbmtzIGEgbG90ClBTOiBJJ3ZlIHRyaWVkIHRvIENjwqBZ
aSBFdW5nSnVuIDxldW5nanVuLnlpQG5hdmVyY29ycC5jb20+IGJ1dCBteSBlbWFpbAp3YXMgcmV0
dXJuZWQsIGJlY2F1c2UgIlRoZSByZWNlaXZpbmcgYWRkcmVzcyBkb2VzIG5vdCBleGlzdCwgb3Ig
dGhlIHJlY2VpdmluZwphZGRyZXNzIGlzIGRpc2FibGVkLiIuIFNvIEkgZG9uJ3Qga25vdyB3aG8g
SSBzaG91bGQgQ2MgdG8gbm93LgoKPj4+R2l0IHNlcnZlciBlbmQncyBhYmlsaXR5IHRvIGFjY2Vw
dCBBY2NlcHQtTGFuZ3VhZ2UgaGVhZGVyIHdhcwo+Pj5pbnRyb2R1Y2VkIGluIGYxODYwNGJiZjIo
aHR0cDogYWRkIEFjY2VwdC1MYW5ndWFnZSBoZWFkZXIgaWYKPj4+cG9zc2libGUpIGJ1dCBpdCBz
ZWVtcyB0aGF0IG9ubHkgcmVmcyBkaXNjb3ZlcmluZyBzdGFnZSBoYXMgdGhpcwo+Pj5hYmlsaXR5
Ogo+Cj5JIGRvIG5vdCB0aGluayB3ZSBkbyBhbnl0aGluZyBzcGVjaWFsIG9uIHRoZSBzZXJ2ZXIg
ZW5kLsKgIFRoZSBzYWlkCj5jb21taXQgdGF1Z2h0IGNsaWVudCBzaWRlIHRvIGxlYXJuIGVuZC11
c2VyJ3MgbG9jYWxlIGFuZCB0aHJvdwo+YWNjZXB0LWxhbmd1YWdlIGhlYWRlciBhdCB0aGUgb3Ro
ZXIgc2lkZS4KPgo+SSBhbSBub3Qgc3VyZSBob3cgbXVjaCBpdCBoZWxwcyBpbiB0aGUgc21hcnQg
SFRUUCwgZXNwZWNpYWxseSBpbgo+bGF0ZXIgcGhhc2VzIG9mIHRoZSB0cmFuc2ZlciwgaW4gdGhl
IGZpcnN0IHBsYWNlLsKgIEJhY2sgaW4gZHVtYiBIVFRQCj53YWxrZXIgZGF5cywgYSBmYWlsdXJl
IHRvIGZldGNoIHNpbmdsZSBvYmplY3Qgd291bGQgaGF2ZSByZXN1bHRlZCBpbgo+YW4gZXJyb3Ig
bWVzc2FnZSBnZW5lcmF0ZWQgYnkgdGhlIHdlYnNlcnZlciBkaXJlY3RseSBzaG93biBhdCB0aGUK
PmNsaWVudCBlbmQsIGJ1dCBpcyB0aGF0IHN0aWxsIHRydWUgZXZlbiBpZiB3ZSB1c2UgdGhlIHNt
YXJ0IEhUVFAgdG8KPmVuY2Fwc3VsYXRlIHRoZSBnaXQgbmF0aXZlIHByb3RvY29sIGV4Y2hhbmdl
Pwo+Cj5JIGhpZ2hseSBzdXNwZWN0IHRoYXQgYW55IGNhbGxzIHRvIGdldF9hY2NlcHRfbGFuZ3Vh
Z2UoKSBoZWxwZXIsIG9yCj5mYWlsdXJlIHRvIGNhbGwgaXQsIGluIHRoZSBzbWFydCBIVFRQIGNv
ZGVwYXRoIGlzIG5vdCBzb21ldGhpbmcKPmRlc2lnbmVkIGJ1dCBqdXN0IGhhcHBlbmVkIGJ5IGFj
Y2lkZW50LsKgIElmIGl0IGhlbHBzIHRvIGlzc3VlIHRoZQo+aGVhZGVyIHRvIHZhcmlvdXMgcmVx
dWVzdHMsIEkgdGhpbmsgaXQgd291bGQgYmUgZ29vZCBmb3IKPmNvbnNpc3RlbmN5LsKgIEFueXRo
aW5nIHRoYXQgdXNlcyBodHRwLmM6Omh0dHBfcmVxdWVzdCgpIHNob3VsZCBnZXQKPnRoZSBoZWFk
ZXIgZm9yIGZyZWUsIHNvIGRlcGVuZGluZyBvbiB0aGUgcmVhc29uIHdoeSBzb21lIHJlcXVlc3Rz
IGRvCj5ub3QgdXNlIGl0LCBhZGRpbmcgaXQgbWlnaHQgaW52b2x2ZSBzb21lIHJlZmFjdG9yaW5n
LCB0aG91Z2guCgpJIHRoaW5rIGV2ZXJ5IEhUVFAgcmVxdWVzdCBmcm9tIGdpdCBjbGllbnQgc2hv
dWxkIHNlbmQgdGhpcyBoZWFkZXIgdG8gc2VydmVyCmVuZCzCoHRvIHRlbGwgdGhlIHNlcnZlciB3
aGljaCBsYW5ndWFnZSBpdCBwcmVmZXJzLCB0aGlzIHdvdWxkIGJlIHZlcnkgZnJpZW5kbHkKZm9y
IHVzZXIgZW5kLg==

