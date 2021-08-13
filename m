Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841EAC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 07:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD6B61042
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 07:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbhHMHur (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 03:50:47 -0400
Received: from smtp43.hk.chengmail.me ([113.10.190.89]:45689 "EHLO
        smtp43.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239685AbhHMHum (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 03:50:42 -0400
X-CHENGMAILHOST: 113.10.190.89
X-CHENGMAIL-INSTANCEID: 3467.6116241f.df6a5.0
Date:   Fri, 13 Aug 2021 15:49:52 +0800
From:   "lilinchao@oschina.cn" <lilinchao@oschina.cn>
To:     "Derrick Stolee" <stolee@gmail.com>, git <git@vger.kernel.org>
Cc:     "Jeff King" <peff@peff.net>, mjcheetham <mjcheetham@github.com>
Subject: Re: Re: [QUESTION]Is it possible that git would support two-factor
        authentication?
References: <66e42438fa9311ebaeb60026b95c99cc@oschina.cn>, 
        <9b199de2faab11eba548a4badb2c2b1195555@gmail.com>
X-Priority: 3
X-GUID: 2CA629A5-332C-4D9C-856E-743FEA257988
X-Has-Attach: no
X-Mailer: Foxmail 7.2.19.158[cn]
Mime-Version: 1.0
X-source-message-id: <2021081315442812231317@oschina.cn>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <0d301aeafc0b11ebb27d0024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pk9uIDgvMTEvMjAyMSA3OjAwIEFNLCBsaWxpbmNoYW9Ab3NjaGluYS5jbiB3cm90ZToKPj4gTWFu
eSB3ZWJzaXRlcyBzdXBwb3J0IHR3by1mYWN0b3IgYXV0aGVudGljYXRpb24oMkZBKSB0byBsb2cg
aW4sIGxpa2UgR2l0aHViLCBJIHdhbmRlciBpZiB3ZSBjYW4gc3VwcG9ydCBpdCBpbiBhcHBsaWNh
dGlvbiBsYXllci4KPj4gV2hlbiBjbGllbnQgY2xvbmUgc29tZXRoaW5nLCB0aGV5IG5lZWQgwqBp
bnB1dCB1c2VybmFtZSBhbmQgcGFzc3dvcmQsIGl0IGlzIGxpa2UgYSB3ZWJzaXRlIGxvZ2luIHBy
b2Nlc3MuIEZvcsKgc2VjdXJpdHksIHdlIGNhbgo+PiBlbmFibGUgwqAyRkEgZHVyaW5nIHRoaXMg
cHJvY2Vzcy4KPgo+VHlwaWNhbGx5LCB0aGlzIGlzIGhhbmRsZWQgYXQgdGhlIGNyZWRlbnRpYWwg
aGVscGVyIGxheWVyLCB3aGljaAo+aXMgYSB0b29sIG91dHNpZGUgb2YgdGhlIEdpdCBjb2RlYmFz
ZSB0aGF0IGNhbiBtb3JlIGNsb3NlbHkgd29yawo+d2l0aCBzdWNoIDJGQS9NRkEgcmVxdWlyZW1l
bnRzLiBGb3IgZXhhbXBsZSwgR0NNIENvcmUgWzFdIHN1cHBvcnRzCj4yRkEgd2l0aCBHaXRIdWIs
IEF6dXJlIERldk9wcywgYW5kIEJpdEJ1Y2tldC4KPgo+WzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9t
aWNyb3NvZnQvR2l0LUNyZWRlbnRpYWwtTWFuYWdlci1Db3JlCj4KPlRoZSBtZWNoYW5pc20gaXMg
dGhhdCBHaXQgYXR0ZW1wdHMgYW4gb3BlcmF0aW9uIGFuZCBnZXRzIGFuIGVycm9yCj5jb2RlLCBz
byBpdCBhc2tzIGZvciBhIGNyZWRlbnRpYWwgZnJvbSB0aGUgaGVscGVyLiBUaGUgaGVscGVyCj50
aGVuIGNvbW11bmljYXRlcyB3aXRoIHRoZSBzZXJ2ZXIgdG8gZG8gd2hhdGV2ZXIgYXV0aGVudGlj
YXRpb24KPmlzIHJlcXVpcmVkLCBpbmNsdWRpbmcgcG9zc2libHkgcGVyZm9ybWluZyBtdWx0aS1m
YWN0b3IgYXV0aC4KPkFsbCBvZiB0aGVzZSBkZXRhaWxzIGFyZSBoaWRkZW4gZnJvbSBHaXQsIHdo
aWNoIGlzIGdvb2QuCj4KSW5kZWVkLCB0aGlzIGlzIGdvb2QsIEkndmUgZXhwZXJpZW5jZWQgdGhp
cyB0b29sIHRoZXNlIGRheXMgYXQgV1NMIGFuZCBXaW5kb3dzLApidXQgZmluYWxseSBJIGhvcGUg
dGhlc2UgZmVhdHVyZXMgY2FuIGJlIHN1cHBvcnRlZCBieSBHaXQgaXRzZWxmLCBhbmQgdGhlbiB0
aGUgdXNlciBlbmQgY2FuIGVhc2lseSBjb25maWd1cmUgaXQuCgo+SSd2ZSBDQydkIE1hdHRoZXcg
Q2hlZXRoYW0gd2hvIGlzIHRoZSBtYWludGFpbmVyIG9mIEdDTSBDb3JlIHRvCj5jb3JyZWN0IG1l
IGlmIEkgbWlzc3RhdGVkIGFueXRoaW5nIGhlcmUuCgpUaGFua3MuCgo=

