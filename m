Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A201F403
	for <e@80x24.org>; Mon, 18 Jun 2018 13:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932654AbeFRN50 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 09:57:26 -0400
Received: from mail-db5eur01on0104.outbound.protection.outlook.com ([104.47.2.104]:58336
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754481AbeFRN5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 09:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Frontmatec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NaDhDQdTMie7BnfzqdUtWSHAbdsrXbLCc54wyTY2wc=;
 b=dPJ54onVzyv1/PsaSIU3K92EWCsefGbTsggKMSwlTDa9bwxoNsigJsEPpzOqBhccK/WCoKDoIaKPWhdgJAbQoFgZ+HALp0hbnKjH608dgygepAotgI/qZoT79dzQZaajhN5C7i6N7PWsky6a7QY7OVzPTdFl3jp3YxmGorRnkWw=
Received: from DB6PR0101MB2344.eurprd01.prod.exchangelabs.com (10.169.220.142)
 by DB6PR0101MB2166.eurprd01.prod.exchangelabs.com (10.168.51.15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Mon, 18 Jun
 2018 13:57:23 +0000
Received: from DB6PR0101MB2344.eurprd01.prod.exchangelabs.com
 ([fe80::98a7:369a:60e2:c111]) by
 DB6PR0101MB2344.eurprd01.prod.exchangelabs.com
 ([fe80::98a7:369a:60e2:c111%6]) with mapi id 15.20.0863.016; Mon, 18 Jun 2018
 13:57:23 +0000
From:   "Antoine W. Campagna" <awe@frontmatec.com>
To:     Stefan Beller <sbeller@google.com>
CC:     git <git@vger.kernel.org>
Subject: RE: fatal: could not reset submodule index
Thread-Topic: fatal: could not reset submodule index
Thread-Index: AdQDXhRDGoKkUkcaQy2EB6OED0HkCgAqeIaAADZsXIAAilkG0A==
Date:   Mon, 18 Jun 2018 13:57:22 +0000
Message-ID: <DB6PR0101MB23445AE7C96E5108B544D015D9710@DB6PR0101MB2344.eurprd01.prod.exchangelabs.com>
References: <DB6PR0101MB2344D682511891E4E9528598D97D0@DB6PR0101MB2344.eurprd01.prod.exchangelabs.com>
 <CAGZ79kYUyzJK7a+=bQMxi=YJ5LgkS_2eJA1dB325U71ks1jjGg@mail.gmail.com>
In-Reply-To: <CAGZ79kYUyzJK7a+=bQMxi=YJ5LgkS_2eJA1dB325U71ks1jjGg@mail.gmail.com>
Accept-Language: fr-CA, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=awe@frontmatec.com; 
x-originating-ip: [207.134.192.27]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0101MB2166;7:4lDM8Et66hAqgFIsamvZkN9i/+LW32wieLsjtQWAj/3GLUmqo4/evm9KnX4i0gy3KtoEh9A6mpvoNb/FYPRB6uVXyj6fvo5bVL7D9VN0eKF448ERUecgQ79tWx6SC1zCy/pQRpTp+htkfE6C0qEkQo+HRMcI4rilwkpF16Q62xJbq1rJsSKWoewfZeJHkherOHHln4oP17nUiDGVpN3B8G5+Vnto4K5egef4pgw2Fv3T6R9mFYW/Wr9DDzJxt9Rw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 018945e0-8174-40ef-d0d5-08d5d5236a82
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB6PR0101MB2166;
x-ms-traffictypediagnostic: DB6PR0101MB2166:
x-microsoft-antispam-prvs: <DB6PR0101MB216675F99D2F3AB2BC796747D9710@DB6PR0101MB2166.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:(5213294742642);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR0101MB2166;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0101MB2166;
x-forefront-prvs: 0707248B64
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39850400004)(376002)(346002)(396003)(199004)(189003)(8936002)(229853002)(4326008)(6246003)(6436002)(81156014)(74316002)(68736007)(6116002)(7736002)(66066001)(3846002)(5660300001)(55016002)(6916009)(5250100002)(305945005)(9686003)(106356001)(33656002)(2900100001)(316002)(105586002)(99286004)(86362001)(81166006)(2906002)(6506007)(478600001)(53936002)(7696005)(102836004)(26005)(8676002)(76176011)(25786009)(486006)(345774005)(3660700001)(11346002)(97736004)(446003)(186003)(14454004)(476003)(3280700002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0101MB2166;H:DB6PR0101MB2344.eurprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: frontmatec.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fM0AkD4Hze3gQEOXcv0LeLu+ti6u8rcFESxBIP8zeg9EvY2YsN1sUDMFO6/z7iWyKe5NyntHabXPalaNUPgtW1szZUXIzx2zDjN6M5fTTLJVVhKXggDBk5IlJZmDS1tEzpuD+mtmkHAIKwZFWFeXkqBpMbr8aJtCiUMOIgu4cD1lqP7397SuPTTQ9RuVwOhsw7il17cy/RjQghSkm0TS0TaTMeVBbXXzuK25d7odUDPlOdWAUFiJaX51+/iXnMPzXxDCRkPMsDEHNOYcAg5GddLt8ER/o67PMb8393z981zCZto5dLBkkKcD2XwbXxig3sCFihhuF1zXDk0IIWssDQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Frontmatec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018945e0-8174-40ef-d0d5-08d5d5236a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2018 13:57:22.9262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bfbef180-ca7f-492d-bcde-824120bd7b33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0101MB2166
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBUaGF0IGlzIHRydWU7IHN1Ym1vZHVsZS5yZWN1cnNlIGlzIG5vdCBhZmZlY3RpbmcgZ2l0IGNs
b25lLg0KPiBUaGlzIHdhcyBhIGRlc2lnbiBkZWNpc2lvbiBvbmNlIGl0IHdhcyBpbnRyb2R1Y2Vk
LCBhcyB0aGUgZ2l0IGNsb25lIG1pZ2h0IGJlIHRvbyBsYXJnZS4gTWF5YmUgd2UgbmVlZCB0byBy
ZXZpc2l0IHRoYXQgZGVjaXNpb24gYW5kIGp1c3QgY2xvbmUgdGhlIHN1Ym1vZHVsZXMgaWYgc3Vi
bW9kdWxlLnJlY3Vyc2UgaXMgc2V0Lg0KPg0KPiBUaGUgcHJvYmxlbSB0aGF0IHRoaXMgYnVnIHJl
cG9ydCBoaWdobGlnaHRzLCBpcyB0aGUgZm9sbG93aW5nOg0KPiBFYWNoIGJyYW5jaCBoYXMgaXRz
IG93biAuZ2l0bW9kdWxlcyBmaWxlIGFuZCB0aGV5IGNhbiBiZSBhbGwgZGlmZmVyZW50LCBob3dl
dmVyIGF0IGNsb25lIHRpbWUgd2Ugb25seSBjbG9uZSBzdWJtb2R1bGVzIGZyb20gdGhlIGN1cnJl
bnRseSBhY3RpdmUgYnJhbmNoLg0KPg0KPiBTbyB5b3UgY291bGQgZ2V0IHlvdXIgdGVzdCBjYXNl
IHRvIHBhc3Mgd2l0aA0KPiAgICAgZ2l0IGNsb25lIC0tYnJhbmNoIHdpdGgtc3VibW9kdWxlIG1h
aW4gY2xvbmU1DQo+IA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgaW5wdXQgU3RlZmFuLg0KDQpCdXQg
aGVyZSBpcyBvdXIgc2l0dWF0aW9uIDogDQo3IGRpZmZlcmVudCBwcm9qZWN0cyBpbiBzZXBhcmF0
ZSByZXBvc2l0b3JpZXMNCkJpZyBwYXJ0cyBvZiB0aGUgY29kZSBpcyBzaW1pbGFyIGJldHdlZW4g
dGhlIHByb2plY3RzDQpXZSB3YW50IHRvIGV4dHJhY3QgdGhlc2Ugc2ltaWxhciBwb3J0aW9ucyBp
biBzZXBhcmF0ZSByZXBvc2l0b3JpZXMgYW5kIGFkZCB0aGVtIGFzIHN1Ym1vZHVsZXMgKG1heWJl
IGFib3V0IDEwIG9mIHRoZW0pLg0KV2Ugd291bGQgZG8gdGhpcyBwcm9ncmVzc2l2ZWx5LCBhZGRp
bmcgb25lIHN1Ym1vZHVsZSBhdCBhIHRpbWUuDQpXZSBuZWVkIHRvIHN1cHBvcnQgb2xkZXIgdmVy
c2lvbnMgc28gd2UgaGF2ZSB0byBrZWVwIGJyYW5jaGVzIHRoYXQgd2lsbCBub3QgaGF2ZSBzdWJt
b2R1bGVzLg0KU2luY2Ugd2UgbmVlZCB0byBjaGVja291dCB0aGVzZSBicmFuY2hlcyByZWd1bGFy
bHksIHdlIHdvdWxkIHdhbnQgdG8gaGF2ZSBzdWJtb2R1bGUucmVjdXJzZSBlbmFibGVkLg0KV2l0
aCB0aGlzIHNldHVwLCBldmVyeSB0aW1lIGEgc3VibW9kdWxlIGlzIGFkZGVkIGluIG9uZSBvZiB0
aGUgcHJvamVjdHMsIGVhY2ggZGV2ZWxvcGVyIHdvdWxkIGdldCB0aGUgImZhdGFsOiBjb3VsZCBu
b3QgcmVzZXQgc3VibW9kdWxlIGluZGV4IiBlcnJvciBhbmQgd291bGQgYmUgdW5hYmxlIHRvIGNo
ZWNrb3V0IG1hc3RlciBicmFuY2guDQoNCg==
