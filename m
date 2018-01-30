Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 693A21F576
	for <e@80x24.org>; Tue, 30 Jan 2018 15:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbeA3Pmx (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 10:42:53 -0500
Received: from smtppost.atos.net ([193.56.114.166]:20056 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbeA3Pmw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 10:42:52 -0500
Received: from mail2-ext.my-it-solutions.net (mail2-ext.my-it-solutions.net) by smarthost6.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 6de4_608a_f0a83584_74a1_4074_88e8_79d92b03b86c;
        Tue, 30 Jan 2018 16:42:50 +0100
Received: from mail3-int.my-it-solutions.net ([10.92.32.10])
        by mail2-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id w0UFgohd027978
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 16:42:50 +0100
Received: from FRAUVJ99ET2MSX.ww931.my-it-solutions.net ([172.23.231.42])
        by mail3-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id w0UFgokJ031651
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 16:42:50 +0100
Received: from FRAUVJ99ET3MSX.ww931.my-it-solutions.net (172.23.231.44) by
 FRAUVJ99ET2MSX.ww931.my-it-solutions.net (172.23.231.42) with Microsoft SMTP
 Server (TLS) id 14.3.361.1; Tue, 30 Jan 2018 16:42:50 +0100
Received: from FRCRPVV9EX5MSX.ww931.my-it-solutions.net ([169.254.10.241]) by
 FRAUVJ99ET3MSX.ww931.my-it-solutions.net ([172.23.231.44]) with mapi id
 14.03.0361.001; Tue, 30 Jan 2018 16:42:49 +0100
From:   "FIGADERE, LAURENT" <laurent.figadere@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: 2.15.1 - merge with submodule output issue
Thread-Topic: 2.15.1 - merge with submodule output issue
Thread-Index: AdOZ4Pnekz7pG8a1Tk6LKhBoxRkdDA==
Date:   Tue, 30 Jan 2018 15:42:49 +0000
Message-ID: <DDD544204D3240408540BFCC028E06882F12F237@FRCRPVV9EX5MSX.ww931.my-it-solutions.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.23.231.120]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

RGVhciBnaXQsDQoNCkkgdXNlIHNpbmNlIGZldyB3ZWVrcyBub3cgZ2l0IDIuMTUuMS4NCg0KSSBk
aWQgZmV3IHRyaWFscyBidXQgcGxlYXNlIGZpbmQgaGVyZSBteSBvdXRwdXRzLg0KDQpUbyByZXBy
b2R1Y2U6DQpVc2UgYSB0b3AgbW9kdWxlIGdpdCB3aGljaCBpbmNsdWRlIGEgc3VibW9kdWxlDQpG
aXJzdCBzdGVwOiBmcm9tIGEgd29yayBhcmVhLCBJIGNoYW5nZWQgc2VsZWN0ZWQgdmVyc2lvbiBv
ZiBzdWJtb2R1bGUgaW4gbWFzdGVyIGJyYW5jaC4NClRoZW4gZ2l0IGFkZCArIGdpdCBjb21taXQg
KyBnaXQgcHVzaA0K74OoCUEgbmV3IGNvbW1pdCBvbiBtYXN0ZXIgYnJhbmNoIGhhcyBiZWVuIHB1
Ymxpc2hlZCBvbiBteSBvcmlnaW4gcmVwb3NpdG9yeSB3aXRoIHRoZSB2ZXJzaW9uIHYxLjIgb2Yg
c3VibW9kdWxlDQoNClNlY29uZCBzdGVwOiBpbiBteSBzZWNvbmQgd29ya2FyZWEsIEkgY3JlYXRl
ZCBhIHVzZXIgYnJhbmNoIG15YnJhbmNoLCB0aGVuIHNlbGVjdGVkIGFub3RoZXIgcmVsZWFzZSBv
ZiBzdWJtb2R1bGUNCkkgYWRkZWQgdGhlIHVwZGF0ZSBhbmQgdGhlbiBjb21taXQgaW4gbXlicmFu
Y2guDQrvg6gJQSBuZXcgY29tbWl0IHdpdGggcmVsZWFzZSB2Mi4wIG9mIHN1Ym1vZHVsZSBpcyBp
biBteSBsYXN0IFNIQTEgb2YgbXlicmFuY2gNCg0KTGFzdCBzdGVwOiBpbiB0aGUgc2Vjb25kIHdv
cmthcmVhLCBpbiBteWJyYW5jaCwgSSBmaXJzdCBydW4g4oCYZ2l0IGZldGNo4oCZIGFuZCB0aGVu
IOKAmGdpdCBtZXJnZSBvcmlnaW4vbWFzdGVy4oCZDQpJIGdvdCBhIENPTkZMSUNUIG1lc3NhZ2Ug
b2YgY291cnNlIGR1ZSB0byB0aGUgMiBkaWZmZXJlbnQgdmVyc2lvbnMgb2Ygc3VibW9kdWxlLg0K
SGVyZSB0aGUgbWVzc2FnZToNCndhcm5pbmc6IEZhaWxlZCB0byBtZXJnZSBzdWJtb2R1bGUgc3Vi
bW9kdWxlIChjb21taXRzIGRvbid0IGZvbGxvdyBtZXJnZS1iYXNlKSANCkF1dG8tbWVyZ2luZyBz
dWJtb2R1bGUgDQpDT05GTElDVCAoc3VibW9kdWxlKTogTWVyZ2UgY29uZmxpY3QgaW4gc3VibW9k
dWxlIA0KQXV0b21hdGljIG1lcmdlIGZhaWxlZDsgZml4IGNvbmZsaWN0cyBhbmQgdGhlbiBjb21t
aXQgdGhlIHJlc3VsdC4gDQoNCk5vdyBJIHRob3VnaHQgdGhhdCB0aGUgY29tbWFuZCDigJhnaXQg
c3VibW9kdWxl4oCZIHByb3ZpZGVkIGFuIG91dHB1dCB3aXRoIGJvdGggdmVyc2lvbnMgb2YgbW9k
dWxlcyAobG9jYWwgYW5kIHJlbW90ZSkuDQpCdXQgdGhpcyBpcyBub3QgdGhlIGNhc2UgaW4gbXkg
ZW52aXJvbm1lbnQ6DQpbMTU6MjA6MTBdICQgZ2l0IHN1Ym1vZHVsZSBzdGF0dXMgDQpVMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCBzdWJtb2R1bGUNCg0KQW5kIHdoZW4g
SSBydW4gdGhlIG1lcmdldG9vbCBjb21tYW5kIEkgaGF2ZSB0aGlzIG91dHB1dDoNClsxNDo1NDo0
MV0gJCBnaXQgbWVyZ2V0b29sIA0KTWVyZ2luZzogDQpzdWJtb2R1bGUgDQpTdWJtb2R1bGUgbWVy
Z2UgY29uZmxpY3QgZm9yICdzdWJtb2R1bGUnOiANCiAge2xvY2FsfTogc3VibW9kdWxlIGNvbW1p
dCAwOGY4NmYyNDA0ZDlmOGY2MTYyNjI5NzFhMzEyN2U2OWYzOWY5ZDExIA0KICB7cmVtb3RlfTog
c3VibW9kdWxlIGNvbW1pdCBiM2RkNmZkZTRmMDIyNThiODhhZDBiMmRiYTY0NzRjMTI2YjQ5OWY3
IA0KVXNlIChsKW9jYWwgb3IgKHIpZW1vdGUsIG9yIChhKWJvcnQ/IA0KDQpTbywgaXQgbWVhbnMg
aXTigJlzIG5vdCB1c2VmdWxsIHRvIGRldGVybWluZSB3aGljaCB2ZXJzaW9uIGhhcyB0byBiZSBz
ZWxlY3RlZC4NCklzIGl0IGEgYnVnIG9yIHBlcmhhcHMgSSBtYWtlIHNvbWV0aGluZyB3cm9uZz8N
Cg0KSXQgd2lsbCBiZSB1c2VmdWxsIGlmIHdlIGNhbiBoYXYgZSB0aGlzIGluZm9ybWF0aW9uIGR1
cmluZyBnaXQgbWVyZ2V0b29sIGNvbW1hbmQgbGlrZSB3aXRoIGdpdCBkZXNjcmliZSAuDQoNClRo
YW5rcyBmb3IgeW91ciBoZWxwLiANCg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
DQpMYXVyZW50IEZJR0FERVJFDQpDQUQgRW5naW5lZXINCkdCRFMgUkQgQXNpYyBWZXJpZmljYXRp
b24NCiszMzEzMDgwNTM2MQ0KbGF1cmVudC5maWdhZGVyZUBhdG9zLm5ldA0KUnVlIEplYW4gSmF1
cmVzIEJQIDY4DQo3ODM0MCBMZXMgQ2xheWVzLXNvdXMtQm9pcw0KRnJhbmNlDQp3d3cuQXRvcy5u
ZXQNCg0KDQoNClRoaXMgZS1tYWlsIGFuZCB0aGUgZG9jdW1lbnRzIGF0dGFjaGVkIGFyZSBjb25m
aWRlbnRpYWwgYW5kIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIGFkZHJlc3NlZTsgaXQgbWF5IGFs
c28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBs
ZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZGVzdHJveSBpdC4gQXMgaXRz
IGludGVncml0eSBjYW5ub3QgYmUgc2VjdXJlZCBvbiB0aGUgSW50ZXJuZXQsIHRoZSBBdG9zIGdy
b3VwIGxpYWJpbGl0eSBjYW5ub3QgYmUgdHJpZ2dlcmVkIGZvciB0aGUgbWVzc2FnZSBjb250ZW50
LiBBbHRob3VnaCB0aGUgc2VuZGVyIGVuZGVhdm9ycyB0byBtYWludGFpbiBhIGNvbXB1dGVyIHZp
cnVzLWZyZWUgbmV0d29yaywgdGhlIHNlbmRlciBkb2VzIG5vdCB3YXJyYW50IHRoYXQgdGhpcyB0
cmFuc21pc3Npb24gaXMgdmlydXMtZnJlZSBhbmQgd2lsbCBub3QgYmUgbGlhYmxlIGZvciBhbnkg
ZGFtYWdlcyByZXN1bHRpbmcgZnJvbSBhbnkgdmlydXMgdHJhbnNtaXR0ZWQuDQoNCg0KDQoNCg==
