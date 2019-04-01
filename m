Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D0FE20248
	for <e@80x24.org>; Mon,  1 Apr 2019 06:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDAGUd (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 02:20:33 -0400
Received: from mail.bs-ag.com ([188.21.13.130]:60409 "EHLO mail.bs-ag.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfDAGUd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 02:20:33 -0400
Received: from mail.bs-ag.com (mail.bs-ag.com [127.0.0.1])
        by mail.bs-ag.com (Postfix) with ESMTP id B9609148;
        Mon,  1 Apr 2019 08:20:30 +0200 (CEST)
Received: from BSEDGE02.bsbanksysteme.com (bsedge02.bsbanksysteme.com [192.168.12.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.bs-ag.com (Postfix) with ESMTPS id 68E09148;
        Mon,  1 Apr 2019 08:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bs-ag.com; s=mail;
        t=1554099630; bh=LgWSa1aWZpc+7TpLBluD2C2CRlbGJLJKRef1vddSXaw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SxrjNeuQ0aTOK6CqxcfxKPrfpFMiI/Y96usCBwm6b7rzHPymv15bwPSa8q1ygX5Vn
         ISF2GCODFc5QH/zm0KH+X5jd75//p+hMTXAGAGiP2aFYvkcJ3dFlD+cF307XEsYkVJ
         buRYugung6KqCMEoF+d6lxLVKrQf52lV448sfi0E=
Received: from BSMAIL04.bsbanksysteme.com (192.168.61.4) by
 BSEDGE02.bsbanksysteme.com (192.168.12.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 1 Apr 2019 08:19:59 +0200
Received: from BSMAIL03.bsbanksysteme.com (192.168.61.3) by
 BSMAIL04.bsbanksysteme.com (192.168.61.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 1 Apr 2019 08:20:30 +0200
Received: from BSMAIL03.bsbanksysteme.com ([fe80::7caf:3000:a4ad:8b1e]) by
 BSMAIL03.bsbanksysteme.com ([fe80::7caf:3000:a4ad:8b1e%3]) with mapi id
 15.01.1531.010; Mon, 1 Apr 2019 08:20:30 +0200
From:   Kurt Ablinger <kurt.ablinger@bs-ag.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: Problem with filename containing '?'
Thread-Topic: Problem with filename containing '?'
Thread-Index: AdTmMDmLpwQZ0+zUTtiuFmuefskE2///9t6A//u1TIA=
Date:   Mon, 1 Apr 2019 06:20:29 +0000
Message-ID: <5b0bf4aab0e443408675e53ba2d39f62@bs-ag.com>
References: <1c1c5d858d8b431fb96b1d48044c00b7@bs-ag.com>
 <20190329133349.GA21802@sigill.intra.peff.net>
In-Reply-To: <20190329133349.GA21802@sigill.intra.peff.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.61.246]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EndpointSecurity-0xde81-EV: v:6.6.9.134, d:out, a:y, w:t, t:32, sv:1554089354, ts:1554099599
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R29vZCBtb3JuaW5nLA0KDQpzb3JyeSB0byB3YXN0ZSB5b3VyIHRpbWUgLSBteSBjaGVjayB3YXMg
aW5jb21wbGV0ZSAtIHRoZSBmaWxlIGluIHF1ZXN0aW9uIGlzIHRoZXJlLg0KDQpCdXQgdGhlIHBy
b2JsZW0gd2l0aCBlR2l0L2pHaXQgb24gV2luZG93cyAoRWNsaXBzZSkgcGVyc2lzdHMuIEkgZGlk
IG5vdCBjaGVjayBqR2l0IGluIGxpbnV4Lg0KDQpUaGUgcHJvYmxlbSBzZWVtcyB0byBiZSwgdGhh
dCBsaW51eCBhY2NlcHRzID8gaW4gZmlsZW5hbWVzIC0gYnV0IHdpbmRvd3MgZG9lcyBub3QgLSBz
byBubyBwcm9ibGVtIHdpdCBnaXQgKG5hdGl2ZSBvciBqYXZhKS4NCg0KQW55d2F5IC0gbWF5YmUg
dGhpcyBjb3VsZCBiZSBhbiBvcHRpb24gZm9yIGEgZnV0dXJlIHZlcnNpb24gb2YgZ2l0Og0KDQoJ
YWNjZXB0IG9ubHkgJ2NvbXBhdGlibGUnIGZpbGUvcGF0aC1uYW1lcw0Kb3INCgl2YWxpZCBmaWxl
L3BhdGgtbmFtZS1wYXR0ZXJuDQoNCnRoaXMgY291bGQgYmUgdXNlZnVsIGZvciB1c2FnZSBvbiBk
aWZmZXJlbnQgcGxhdGZvcm1zLg0KDQpTb3JyeSBhZ2FpbiwgdGhhbmtzIGFuZCBncmVldGluZ3MN
Ckt1cnQNCg0KDQotLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQpWb246IEplZmYg
S2luZyA8cGVmZkBwZWZmLm5ldD4gDQpHZXNlbmRldDogRnJlaXRhZywgMjkuIE3DpHJ6IDIwMTkg
MTQ6MzQNCkFuOiBLdXJ0IEFibGluZ2VyIDxrdXJ0LmFibGluZ2VyQGJzLWFnLmNvbT4NCkNjOiBn
aXRAdmdlci5rZXJuZWwub3JnDQpCZXRyZWZmOiBSZTogUHJvYmxlbSB3aXRoIGZpbGVuYW1lIGNv
bnRhaW5pbmcgJz8nDQoNCk9uIEZyaSwgTWFyIDI5LCAyMDE5IGF0IDAxOjEwOjE5UE0gKzAwMDAs
IEt1cnQgQWJsaW5nZXIgd3JvdGU6DQoNCj4gaW4gTGludXggdGhlIGdpdC1jbGllbnQgYWNjZXB0
cyAoYWRkLCBjb21taXQsIHB1c2gpIGZpbGVzIHdpdGggJz8nIChxdWVzdGlvbm1hcmspICBpbiBp
dHMgbmFtZS4NCj4gDQo+IFdoZW4gY2xvbmluZyBzdWNoIGEgcmVwb3NpdG9yeSBpbnRvIEVjbGlw
c2UgKGVHaXQvakdpdCkgdGhlIA0KPiByZXBvc2l0b3J5LWNsb25lIGlzIHJlamVjdGVkIHdpdGgg
YW4gJ0ludmFsaWQgUGF0aCctbWVzc2FnZSB3aXRoIHRoZSANCj4gPy1maWxlbmFtZS4NCj4gDQo+
IFVuZGVyIExpbnV4IGl0IGlzIHBvc3NpYmxlIHRvIGNyZWF0ZSBhIGNsb25lICh0aGUgc2FtZSBn
aXQtYmluYXJ5IHVzZWQgDQo+IHRvIGNoZWNraW4gdGhlID8tZmlsZSkgd2l0aG91dCBhbnkgbWVz
c2FnZS4NCj4gQnV0IHRoZSBkaXJlY3RvcnkgY29udGFpbmluZyB0aGUgPy1maWxlIGlzIHNpbGVu
dGx5IGRpc2NhcmRlZCB3aGF0ZXZlciANCj4geW91IGNoZWNrb3V0IChtYXN0ZXIvSEVBRCwgZmly
c3Qgb3IgYW55IG90aGVyIGNvbW1pdCBjb250YWluaW5nIHRoaXMgDQo+IGZpbGUpLg0KDQpJdCBz
ZWVtcyB0byB3b3JrIGZpbmUgZm9yIG1lIHdpdGggYSBmZXcgc2ltcGxlIGV4ZXJjaXNlczoNCg0K
ICBnaXQgaW5pdCByZXBvDQogIGNkIHJlcG8NCiAgbWtkaXIgc3ViZGlyDQogIGVjaG8gZm9vID4n
c3ViZGlyL2Jhcj8nDQogIGdpdCBhZGQgLg0KICBnaXQgY29tbWl0IC1tICdmaWxlIHdpdGggcXVl
c3Rpb24gbWFyayBpbiBuYW1lJw0KDQogIGdpdCBjbG9uZSAtLW5vLWxvY2FsIC4gY2hpbGQNCiAg
Y2QgY2hpbGQNCiAgbHMgLWwNCiAgZWNobyBjaGFuZ2VzID4nc3ViZGlyL2Jhcj8nDQogIGdpdCBj
b21taXQgLWFtICdjaGFuZ2VzJw0KICBnaXQgc2hvdw0KDQpJdCBhbHNvIHNlZW1zIHRvIGNsb25l
IGZpbmUgd2l0aCBqZ2l0Og0KDQogIGpnaXQgY2xvbmUgJFBXRC9yZXBvIGpnaXQtY2xvbmUNCg0K
Q2FuIHlvdSBzaG93IHVzIG1vcmUgZXhhY3RseSB3aGF0IHlvdSdyZSBydW5uaW5nLCBhbmQgd2hh
dCBkb2Vzbid0IHdvcms/DQoNCkFsc28sIG9uZSBvdGhlciBxdWVzdGlvbjogYXJlIHlvdSBzdXJl
IGl0J3MgYWN0dWFsbHkgYSBxdWVzdGlvbiBtYXJrIGluIHRoZSBuYW1lPyBJZiB0aGVyZSBhcmUg
bm9uLWFzY2lpIGdhcmJhZ2UgY2hhcmFjdGVycywgImxzIiB3aWxsIHR5cGljYWxseSBzaG93IGEg
cXVlc3Rpb24gbWFyayB3aGVuIG91dHB1dCBpcyBnb2luZyB0byB0aGUgdGVybWluYWwuIEUuZy46
DQoNCiAgJCBlY2hvIGZvbyA+IiQocHJpbnRmICdmdW5ueVwxY2hhcicpIg0KICAkIGxzDQogIGZ1
bm55P2NoYXINCiAgJCBscyB8IGNhdCAtQQ0KICBmdW5ueV5BY2hhciQNCiAgJCBscyB8IHh4ZA0K
ICAwMDAwMDAwMDogNjY3NSA2ZTZlIDc5MDEgNjM2OCA2MTcyIDBhICAgICAgICAgICAgICBmdW5u
eS5jaGFyLg0KDQpJZiBpdCdzIHNvbWUgbW9yZSBleG90aWMgY2hhcmFjdGVyLCB0aGVuIHRoYXQg
bWF5IGJlIHdoeSBqZ2l0IHJlamVjdHMgaXQuDQoNCi1QZWZmDQo=
