Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CDDC433E9
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 11:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0E864EDB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 11:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBTLJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Feb 2021 06:09:49 -0500
Received: from smtp28.hk.chengmail.me ([210.209.93.12]:56516 "EHLO
        smtp28.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhBTLJr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Feb 2021 06:09:47 -0500
X-Greylist: delayed 1696 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Feb 2021 06:09:46 EST
X-CHENGMAILHOST: 210.209.93.12
X-CHENGMAIL-INSTANCEID: 2d26.6030e728.e6c2c.0
Date:   Sat, 20 Feb 2021 18:40:41 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, "Derrick Stolee" <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>
Subject: Re: Re: [PATCH v3] builtin/clone.c: add --reject-shallow option
References: <pull.865.v2.git.1612773119.gitgitgadget@gmail.com>, 
        <pull.865.v3.git.1612793576910.gitgitgadget@gmail.com>, 
        <026bd8966b1611eb975aa4badb2c2b1190694@pobox.com>, 
        <5c4295e46b7f11eb8acc0024e87935e7@oschina.cn>, 
        <eaa219a86bbc11ebb6c7a4badb2c2b1165032@pobox.com>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021022018404081108319@oschina.cn>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Message-ID: <1689e980736811eb80250026b95c99cc@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CgoKLS0tLS0tLS0tLS0tLS0KbGlsaW5jaGFvQG9zY2hpbmEuY24KPiJsaWxpbmNoYW9Ab3NjaGlu
YS5jbiIgPGxpbGluY2hhb0Bvc2NoaW5hLmNuPiB3cml0ZXM6Cj4KPj4gU29ycnksIHlvdSBtYXkg
Zm9yZ2V0IHRoZXJlIGlzIGEgcmUtcmVhZCBnaXQtY29uZmlnIHVuZGVyIHRoZXNlIGxpbmVzCj4K
PkFoaGhoLCB0aGFua3MuwqAgWW91J3JlIHJpZ2h0IHRoYXQgImNsb25lIiBpcyAic3BlY2lhbCIg
aW4gdGhhdCB3YXkKPmFuZCByZXF1aXJlcyB1bnVzdWFsIG9yZGVyLS0tSSBmb3Jnb3QgYWJvdXQg
dGhhdC4KPgo+Pj5UaGlzIGlzIG9ubHkgZm9yIGNsb25pbmcgZnJvbSBhIGxvY2FsIHJlcG9zaXRv
cnksIG5vP8KgIElPVywgcGF0aCBhdAo+Pj50aGlzIHBvaW50IG1heSBldmVuIGJlICJnaXQ6Ly9n
aXRodWIuY29tL2dpdC9naXQvIiBhbmQgY2hlY2tpbmcgd2l0aAo+Pj5hY2Nlc3MoKSBkb2VzIG5v
dCBtYWtlIHNlbnNlLgo+Pj4KPj4+QWgsIGl0IGlzIGV2ZW4gd29yc2UuwqAgZ2V0X3JlcG9fcGF0
aCgpIGNhbiByZXR1cm4gTlVMTCwgc28gbWtwYXRoKCkKPj4+d2lsbCBjcmFzaCBpbiBzdWNoIGEg
Y2FzZS7CoCBUaGlzIG11c3QgYmUgYXQgbGVhc3QKPj4+Cj4+PglpZiAocGF0aCAmJiAhYWNjZXNz
KG1rcGF0aCgiJXMvc2hhbGxvdyIsIHBhdGgpLCBGX09LKSkKPj4+CWlzX3NoYWxsb3cgPSAxOwo+
Pj4gLi4uCj4+Pgo+Pj5TbywgSSB0aGluayB0aGUgYWJvdmUgdHdvIGh1bmtzIGFyZSBtYWtpbmcg
dGhlIGNvZGUgd29yc2UuwqAgSWYgd2UKPj4+YXJlIHRvIGRldGVjdCBhbmQgcmVqZWN0IGNsb25p
bmcgZnJvbSB0aGUgc2hhbGxvdyByZXBvc2l0b3J5IHdoZW4KPj4+Z29pbmcgdGhyb3VnaCB0aGUg
dHJhbnNwb3J0IGxheWVyIChpLmUuICItLW5vLWxvY2FsIiBvciBjbG9uaW5nIGZyb20KPj4+Imdp
dDovL2dpdGh1Yi5jb20vZ2l0L2dpdCIsIG9yICJodHRwczovL2dpdGh1Yi5jb20vZ2l0L2dpdCIs
IGlmIGl0Cj4+PndlcmUgYSBzaGFsbG93IHJlcG9zaXRvcnkpLCB0aGF0IG11c3QgYmUgaGFuZGxl
ZCBzZXBhcmF0ZWx5Lgo+Pj4KPj4gU29ycnksIEkgbWFkZSB0aGUgcXVlc3Rpb24gc2ltcGxlLiBS
ZWplY3QgY2xvbmluZyBhIHNoYWxsb3cgcmVwb3NpdG9yeQo+PiBzaG91bGQgYXBwbHkgdG8gYWxs
IGZvdXIgdHlwZSB0cmFuc3BvcnQgcHJvdG9jb2xzLiBUaGVyZSBzdGlsbCBhIGJ1bmNoIG9mCj4+
IHdvcmsgdG8gYmUgZG9uZS4KPgo+U29ycnksIGJ1dCBJIGRpZG4ndCByZWFsaXplIHRoYXQgdGhp
cyBpcyBqdXN0IGEgd29yay1pbi1wcm9ncmVzcwo+dGhhdCBzaG93cyBhbiBlYXJseSAib25seSBs
b2NhbCB0cmFuc3BvcnQgaXMgY292ZXJlZCIgcHJldmlldy7CoCBJCj50aGluaywgbW9kdWxvIHRo
YXQgdGhlIGFjY2Vzcyhta3BhdGgoKSkgdGhpbmcgc2hvdWxkIGJlIGluIHRoZSAiaWYKPihpc19s
b2NhbCkiIGJsb2NrLCB0aGUgcGF0Y2ggY292ZXJzIHRoZSBjYXNlIG9mIGxvY2FsIHRyYW5zcG9y
dCB3ZWxsCj5lbm91Z2guwqAgSSB0aGluayBieSAiZm91ciB0eXBlcyBvZiB0cmFuc3BvcnQiIHlv
dSBtZWFuIHNzaDovLywgZ2l0Oi8vCj5odHRwczovLyBldGMuLCBidXQgdGhleSBhbGwgZ28gdGhy
b3VnaCB0aGUgc2FtZSB0cmFuc3BvcnQgQVBJLCBzbwo+aG9wZWZ1bGx5IG9uY2Ugb25lIG9mIHRo
ZW0sIHNheSwgZ2l0Oi8vLCBpcyBjb3ZlcmVkLCB0aGF0IHdvdWxkIHRha2UKPnVzIGEgbG9uZyB3
YXkuCj4gCkhpLCBhZnRlciBzb21lIGV4cGxvcmF0aW9uLCBJIGZvdW5kIHRoYXQgdGhlIGZvbGxv
d2luZyBjaGFuZ2VzCmNhbiBhY2hpZXZlIHRoZSBnb2FsOgooYXJvdW5kIGF0IGxpbmUgMTM4NiBp
biBidWlsdGluL2Nsb25lLmMpCsKgIMKgwqAvKiBiZWxvdyBwYXJ0IGlzIG15IGNoYW5nZXMgKi8K
wqAgwqAgwqAgwqDCoMKgIMKgIGlmIChyZWplY3Rfc2hhbGxvdykgewrCoCDCoMKgIMKgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgaWYgKGxvY2FsX3NoYWxsb3cgfHwgaXNfcmVwb3NpdG9yeV9zaGFsbG93
KHRoZV9yZXBvc2l0b3J5KSkgewrCoCDCoMKgIMKgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgZGllKF8oInNvdXJjZSByZXBvc2l0b3J5IGlzIHNoYWxsb3csIHJlamVjdCB0byBjbG9u
ZS4iKSk7CsKgIMKgIMKgwqDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9CsKgIMKgwqDCoCDCoCDCoCDC
oCB9CsKgIMKgwqAvKiBlbmQgKi8KwqAgwqDCoMKgIMKgIMKgIMKgIHVwZGF0ZV9yZW1vdGVfcmVm
cyhyZWZzLCBtYXBwZWRfcmVmcywgcmVtb3RlX2hlYWRfcG9pbnRzX2F0LArCoMKgIMKgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmFuY2hfdG9wLmJ1ZiwgcmVmbG9n
X21zZy5idWYsIHRyYW5zcG9ydCwKwqAgwqAgwqDCoMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIWlzX2xvY2FsKTsKCmFzIGl0IHNob3dzLCB1c2luZyBleGlzdGluZyBtZXRo
b2QgImlzX3JlcG9zaXRvcnlfc2hhbGxvdyIgdG8gZGV0ZWN0CndoZXRoZXLCoHRoZSByZXBvIGlz
IHNoYWxsb3cgb3Igbm90LCBiZWZvcmUgInVwZGF0ZV9yZW1vdGVfcmVmcyIKSSBtYWRlIHNvbWUg
dGVzdHMgYmFzZWQgb24gdGhpcyBjaGFuZ2UsIGFuZCBpdCBzZWVtcyBvay4Kd2hhdCBkbyB5b3Ug
dGhpbmsgYWJvdXQgdGhpcz8KCgo+VGhhbmtzLg==

