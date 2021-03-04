Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958FCC433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 06:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6086364EF9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 06:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbhCDG1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 01:27:13 -0500
Received: from smtp32.hk.chengmail.me ([210.209.85.96]:49994 "EHLO
        smtp32.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhCDG06 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 01:26:58 -0500
X-CHENGMAILHOST: 210.209.85.96
X-CHENGMAIL-INSTANCEID: 6985.60407d81.1a60e.0
Date:   Thu, 4 Mar 2021 14:26:09 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     dscho <Johannes.Schindelin@gmx.de>
Cc:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
        "Derrick Stolee" <stolee@gmail.com>
Subject: Re: Re: [PATCH v5] builtin/clone.c: add --reject-shallow option
References: <pull.865.v4.git.1613891147977.gitgitgadget@gmail.com>, 
        <pull.865.v5.git.1614535588332.gitgitgadget@gmail.com>, 
        <697bdaee7a5d11eb919e0026b95c99cc@oschina.cn>, 
        <nycvar.QRO.7.76.6.2103012338100.57@tvgsbejvaqbjf.bet>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021030414260803729822@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <84f2a4d67cb211eb83f10024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PkhpLAo+Cj5PbiBNb24sIDEgTWFyIDIwMjEsIGxpbGluY2hhb0Bvc2NoaW5hLmNuIHdyb3RlOgo+
Cj4+ID5AQCAtMTQ0MCw2ICsxNDQ0LDggQEAgc3RhdGljIHZvaWQgcmVjZWl2ZV9zaGFsbG93X2lu
Zm8oc3RydWN0IGZldGNoX3BhY2tfYXJncyAqYXJncywKPj4gPiAqIHNoYWxsb3cuIEluIHYwLCBy
ZW1vdGUgcmVmcyB0aGF0IHJlYWNoIHRoZXNlIG9iamVjdHMgYXJlCj4+ID4gKiByZWplY3RlZCAo
dW5sZXNzIC0tdXBkYXRlLXNoYWxsb3cgaXMgc2V0KTsgZG8gdGhlIHNhbWUuCj4+ID4gKi8KPj4g
PisJaWYgKGFyZ3MtPnJlbW90ZV9zaGFsbG93KQo+PiA+KwlkaWUoInNvdXJjZSByZXBvc2l0b3J5
IGlzIHNoYWxsb3csIHJlamVjdCB0byBjbG9uZS4iKTsKPj4KPj4gSSBqdXN0IGZvdW5kIHRoYXQg
Sm9oYW5uZXMgU2NoaW5kZWxpbiB3cm90ZSBhIGRvY3VtZW50IDE0IHllYXIgYWdvCj4+IGluIERv
Y3VtZW50YXRpb24vdGVjaG5pY2FsL3NoYWxsb3cudHh0Ogo+Pgo+PiAiVGhlcmUgYXJlIHNvbWUg
dW5maW5pc2hlZCBlbmRzIG9mIHRoZSB3aG9sZSBzaGFsbG93IGJ1c2luZXNzOgo+Pgo+PiBBIHNw
ZWNpYWwgaGFuZGxpbmcgb2YgYSBzaGFsbG93IHVwc3RyZWFtIGlzIG5lZWRlZC4gQXQgc29tZSBz
dGFnZSwKPj4gdXBsb2FkLXBhY2sgaGFzIHRvIGNoZWNrIGlmIGl0IHNlbmRzIGEgc2hhbGxvdyBj
b21taXQsIGFuZCBpdCBzaG91bGQKPj4gc2VuZCB0aGF0IGluZm9ybWF0aW9uIGVhcmx5IChvciBm
YWlsLCBpZiB0aGUgY2xpZW50IGRvZXMgbm90IHN1cHBvcnTCoAo+PiBzaGFsbG93IHJlcG9zaXRv
cmllcykuIFRoZXJlIGlzIG5vIHN1cHBvcnQgYXQgYWxsIGZvciB0aGlzIGluIHRoaXMgcGF0Y2gK
Pj4gc2VyaWVzLiIKPgo+T2ggd293LCB3aGF0IGEgYmxhc3QgZnJvbSB0aGUgcGFzdC4KPgo+SSBk
byBhZ3JlZSB0aGF0IHlvdXIgcGF0Y2ggaXMgYW4gaW1wcm92ZW1lbnQgb3ZlciB0aGUgY3VycmVu
dCBzaXR1YXRpb24uIAo+IAoKVGhhbmtzLiBHbGFkIHRvIGhlYXIgdGhlIHZvaWNlIGZyb20geW91
LCBob3BlIEkgY2FuIGdldCBzb21lIHN1Z2dlc3Rpb25zCmZyb20geW91IHRvbywgZXNwZWNpYWxs
eSBvbiB0aGUgdHJhbnNwb3J0IHBhcnQuCgo+VGhhbmtzLAo+Sm9oYW5uZXMKPgo+PiBJdCBzZWVt
cyB0aGF0IG15IHBhdGNoIGNhbiBzb3ZsZSBoaXMgd29ycnkgaW4gc29tZSBkZWdyZWUsCj4+IGFu
ZCBtYXliZSB3ZSBjb3VsZCB3YXJuIGNsaWVudCBpbiBmZXRjaC1wYWNrIHN0YWdlLCBpZiB3ZSBk
b24ndAo+PiBjaG9vc2UgdG8gcmVqZWN0IHNoYWxsb3cgY2xvbmluZy4KPj4KPj4gaWYgKGFyZ3Mt
PnJlbW90ZV9zaGFsbG93KQo+PiBkaWUoInNvdXJjZSByZXBvc2l0b3J5IGlzIHNoYWxsb3csIHJl
amVjdCB0byBjbG9uZS4iKTsKPj4gZWxzZQo+PiB3YXJuaW5nKCJyZW1vdGUgc291cmNlIHJlcG9z
aXRvcnkgaXMgc2hhbGxvdy4iKTsKPj4gCgoKCg==

