Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA86C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8EA4613BF
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhEMIT1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 04:19:27 -0400
Received: from smtp40.hk.chengmail.me ([113.10.190.45]:35816 "EHLO
        smtp40.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbhEMITK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 04:19:10 -0400
X-CHENGMAILHOST: 113.10.190.45
X-CHENGMAIL-INSTANCEID: 1e3e.609ce0af.ddf6d.0
Date:   Thu, 13 May 2021 16:17:54 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Derrick Stolee" <dstolee@microsoft.com>,
        "Junio C Hamano" <gitster@pobox.com>
Subject: Re: Re: [PATCH] builtin/gc: warn when core.commitGraph is disabled
References: <510425b8b17411eb93770026b95c99cc@oschina.cn>, 
        <87tunau7ia.fsf@evledraar.gmail.com>
X-Priority: 3
X-GUID: A340AC70-C213-441C-9663-DA39719DBA01
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021051316134036953120@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <b87b12b4b3c311eba1fd0024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cj4KPk9uIE1vbiwgTWF5IDEwIDIwMjEsIGxpbGluY2hhb0Bvc2NoaW5hLmNuIHdyb3RlOgo+Cj4+
IEZyb206IExpIExpbmNoYW8gPGxpbGluY2hhb0Bvc2NoaW5hLmNuPgo+Pgo+PiBUaHJvdyB3YXJu
aW5nIG1lc3NhZ2Ugd2hlbiBjb3JlLmNvbW1pdEdyYXBoIGlzIGRpc2FibGVkIGluIGNvbW1pdC1n
cmFwaAo+PiBtYWludGVuYW5jZSB0YXNrLgo+Cj5Xb24ndCB0aGlzIGNhdXNlIHRoZSBnYy5sb2cg
aXNzdWUgbm90ZWQgaW4KPmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2dpdC84N3IxbDI3cmFlLmZz
ZkBldmxlZHJhYXIuZ21haWwuY29tLwo+Cj5Nb3JlIGltcG9ydGFudGx5LCBJIGRvbid0IHRoaW5r
IHRoaXMgVVggbWFrZXMgc2Vuc2UuIFdlIHNhaWQgd2UgZGlkbid0Cj53YW50IGl0LCBzbyB3aHkg
d2FybiBhYm91dCBpdD8KPgo+TWF5YmUgdGhlcmUgYXJlIGdvb2QgcmVhc29ucyB0bywgYnV0IHRo
aXMgY29tbWl0IG1lc3NhZ2UgLyBwYXRjaCBkb2Vzbid0Cj5tYWtlIHRoZSBjYXNlIGZvciBpdC4u
Lgo+ClVoLCB3ZWxsLCBtYXliZSBJIHNob3VsZCBhcmd1ZSBmb3IgdGhpcyBwYXRjaCBhIGJpdCBt
b3JlLgoKRmlyc3QgdGhpcyBpcyBpbiBnaXQgbWFpbnRlbmFuY2UgdGFzaywgSSd2ZSByZWFkIHRo
ZSBsaW5rIHlvdSBwb3N0LCBhbmQgSSBmZWVsIGl0IGhhcyBub3RoaW5nIHRvIGRvIHdpdGjCoG1h
aW50ZW5hbmNlIHRhc2suCgpTZWNvbmQgSSBob3BlIHRoZSBgY29tbWl0LWdyYXBoYCB0YXNrIGNh
biBkbyB0aGUgc2FtZSB0aGluZyB3aXRoIGBpbmNyZW1lbnRhbCByZXBhY2tgIHRhc2sgdGhhdCB0
byB3YXJuIHVzZXIgd2hlbiB0aGUgcmVsYXRlZCBuZWNlc3Nhcnkgc2V0dGluZyBpcyBub3QgeWV0
IHJlYWR5LCBpbnN0ZWFkIG9mIHJ1bm5pbmcgcXVpZXRseSwgYnV0IGRvaW5nIG5vdGhpbmcuCgpU
aGFua3M=

