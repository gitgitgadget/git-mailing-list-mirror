Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5AAE2023D
	for <e@80x24.org>; Mon, 22 May 2017 12:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757976AbdEVMtP (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 08:49:15 -0400
Received: from mail96.atlas.de ([194.156.172.86]:54626 "EHLO mail96.atlas.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757963AbdEVMtO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 08:49:14 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 May 2017 08:49:13 EDT
X-IPAS-Result: =?us-ascii?q?A2ADAwCS2yJZ/wXKxApcGgEBAQECAQEBAQgBAQEBiTKbZyG?=
 =?us-ascii?q?YBYYkAhqGORUBAgEBAQEBAQGBE4UZAgEDIwQNRRACAQgaAiYCAgIqBhUCAQ0CB?=
 =?us-ascii?q?AEMAQcBAbohgWw6iw8BAQEBAQEBAQEBAQEBAQEBAQEBH4ELhzIrC4JlhHqCe4J?=
 =?us-ascii?q?gAQSJRpRQniCGb4wWiDI1gSxxh1GKIAEBAQ?=
Received: from scesrv02.atlas.de ([10.196.202.5])
  by MGW102FE.atlas.de with ESMTP/TLS/DHE-RSA-AES128-GCM-SHA256; 22 May 2017 14:39:06 +0200
Received: by SCESRV02.atlas.de (Postfix, from userid 600)
        id 3wWdWZ3QrTz2yWRs; Mon, 22 May 2017 12:38:37 +0000 (UTC)
Received: from MGW201PAR.atlas.de (unknown [10.206.101.60])
        by SCESRV02.atlas.de (Postfix) with ESMTPS id 3wWdW12CvDz2yWRZ
        for <git@vger.kernel.org>; Mon, 22 May 2017 12:38:37 +0000 (UTC)
Received: from atlas-elektronik.com (HELO MSEXSRV1.atlas.de) ([10.200.102.56])
  by MGW201DAT.atlas.de with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 May 2017 14:38:37 +0200
Received: from MSEXSRV6.atlas.de ([169.254.4.29]) by MSEXSRV1.atlas.de
 ([10.200.102.56]) with mapi id 14.03.0351.000; Mon, 22 May 2017 14:38:36
 +0200
From:   <stefan.naewe@atlas-elektronik.com>
To:     <j6t@kdbg.org>, <johannes.schindelin@gmx.de>
CC:     <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix warnings on access of a remote with Windows
 paths
Thread-Topic: [PATCH 0/2] Fix warnings on access of a remote with Windows
 paths
Thread-Index: AQHS0TJ7tMiKPNp0qkWKzzbW3NJ8DaIALLuA
Date:   Mon, 22 May 2017 12:38:35 +0000
Message-ID: <122838f4-5f6b-6921-9242-2724bb6d8c95@atlas-elektronik.com>
References: <cover.1495261020.git.j6t@kdbg.org>
In-Reply-To: <cover.1495261020.git.j6t@kdbg.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Content-Type: text/plain; charset="utf-8"
Content-ID: <38543202C61FE5438F6BC065D03E0404@atlas.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QW0gMjAuMDUuMjAxNyB1bSAwODoyOCBzY2hyaWViIEpvaGFubmVzIFNpeHQ6DQo+IFRoaXMgc21h
bGwgc2VyaWVzIGZpeGVzIHRoZXNlIHdhcm5pbmdzIG9uIFdpbmRvd3M6DQo+IA0KPiBDOlxUZW1w
XGdpdHRlc3Q+Z2l0IGZldGNoIEM6XFRlbXBcZ2l0dGVzdA0KPiB3YXJuaW5nOiB1bmFibGUgdG8g
YWNjZXNzICcuZ2l0L3JlbW90ZXMvQzpcVGVtcFxnaXR0ZXN0JzogSW52YWxpZCBhcmd1bWVudA0K
PiB3YXJuaW5nOiB1bmFibGUgdG8gYWNjZXNzICcuZ2l0L2JyYW5jaGVzL0M6XFRlbXBcZ2l0dGVz
dCc6IEludmFsaWQgYXJndW1lbnQNCj4gRnJvbSBDOlxUZW1wXGdpdHRlc3QNCj4gICogYnJhbmNo
ICAgICAgICAgICAgSEVBRCAgICAgICAtPiBGRVRDSF9IRUFEDQoNCldoYXQgaXMgdGhlIGV4YWN0
IHByZWNvbmRpdGlvbiB0byBnZXQgc3VjaCBhIHdhcm5pbmcgPw0KDQpKdXN0IHdvbmRlcmluZywg
YmVjYXVzZSBJJ20gbm90IGFibGUgdG8gcmVwcm9kdWNlIHRoYXQgd2FybmluZw0KKHdpdGggR2l0
NHdpbiB2ZXJzaW9uIDIuMTMuMC53aW5kb3dzLjEpLg0KDQpTdGVmYW4NCi0tIA0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
L2Rldi9yYW5kb20gc2F5czogU3BvY2ssIHlvdSBhcmUgc3VjaCBhIHB1dHohDQpweXRob24gLWMg
InByaW50ICc3Mzc0NjU2NjYxNmUyZTZlNjE2NTc3NjU0MDYxNzQ2YzYxNzMyZDY1NmM2NTZiNzQ3
MjZmNmU2OTZiMmU2MzZmNmQnLmRlY29kZSgnaGV4JykiIA0KR1BHIEtleSBmaW5nZXJwcmludCA9
IDJERjUgRTAxQiAwOUMzIDc1MDEgQkNBOSAgOTY2NiA4MjlCIDQ5QzUgOTIyMSAyN0FG
