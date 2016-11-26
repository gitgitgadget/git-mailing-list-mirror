Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,BODY_URI_ONLY,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BEAA1FC96
	for <e@80x24.org>; Sat, 26 Nov 2016 13:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbcKZNC5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Nov 2016 08:02:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:13227 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbcKZNCz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Nov 2016 08:02:55 -0500
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP; 26 Nov 2016 05:02:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,552,1473145200"; 
   d="scan'208";a="195847309"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2016 05:02:47 -0800
Received: from fmsmsx155.amr.corp.intel.com (10.18.116.71) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Sat, 26 Nov 2016 05:02:47 -0800
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 FMSMSX155.amr.corp.intel.com (10.18.116.71) with Microsoft SMTP Server (TLS)
 id 14.3.248.2; Sat, 26 Nov 2016 05:02:46 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.44]) by
 hasmsx107.ger.corp.intel.com ([169.254.6.69]) with mapi id 14.03.0248.002;
 Sat, 26 Nov 2016 15:02:44 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "jnareb@gmail.com" <jnareb@gmail.com>, Jeff King <peff@peff.net>,
        "Jiri Slaby" <jslaby@suse.cz>,
        "Greg KH (gregkh@linuxfoundation.org)" <gregkh@linuxfoundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
CC:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [char-misc-next] mei: request async autosuspend at the end of
 enumeration
Thread-Topic: [char-misc-next] mei: request async autosuspend at the end of
 enumeration
Thread-Index: AQHSRj7WsbWcWoZfOE2E/htadCzu2KDoR37ggAAxQACAADXbcIAAN3AAgAEiXgCAAOi0gA==
Date:   Sat, 26 Nov 2016 13:02:43 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B54331DE4@hasmsx108.ger.corp.intel.com>
References: <1479987242-32050-1-git-send-email-tomas.winkler@intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B5433132E@hasmsx108.ger.corp.intel.com>
 <20161124204316.sqxjpc7uzbrzhvho@sigill.intra.peff.net>
 <5B8DA87D05A7694D9FA63FD143655C1B54331476@hasmsx108.ger.corp.intel.com>
 <20161125031425.gefijvssvygp6pl4@sigill.intra.peff.net>
 <e11d28d3-c1b5-2c04-643f-0b3bd96cb4d3@gmail.com>
In-Reply-To: <e11d28d3-c1b5-2c04-643f-0b3bd96cb4d3@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_IC
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2Q3ODUzOWUtMzgwMi00NDg1LTg2YTctNWQ3ZTM1Y2MzMjc3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX0lDIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE1LjkuNi42IiwiVHJ1c3RlZExhYmVsSGFzaCI6IlRrQUxvbkNTUzRaMTF6WG5xY0pWaVZSY1VZUENNRU4wcXdzc1pFMDhucjg9In0=
x-originating-ip: [10.184.70.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiANCj4gVyBkbml1IDI1LjExLjIwMTYgbyAwNDoxNCwgSmVmZiBLaW5nIHBpc3plOg0KPiA+IE9u
IFRodSwgTm92IDI0LCAyMDE2IGF0IDEwOjM3OjE0UE0gKzAwMDAsIFdpbmtsZXIsIFRvbWFzIHdy
b3RlOg0KPiA+DQo+ID4+Pj4+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyA0LjQrDQo+
ID4+Pj4NCj4gPj4+PiBMb29rcyBsaWtlIGdpdCBzZW5kLWVtYWlsIGlzIG5vdCBhYmxlIHRvIHBh
cnNlIHRoaXMgYWRkcmVzcw0KPiA+Pj4+IGNvcnJlY3RseSB0aG91Z2ggdGhpcyBpcyBzdWdnZXN0
ZWQgZm9ybWF0IGJ5DQo+IERvY3VtZW50YXRpb24vc3RhYmxlX2tlcm5lbF9ydWxlcy50eHQuDQo+
ID4+Pj4gQ3JlYXRlIHdyb25nIGFkZHJlc3MgSWYgZ2l0IHBhcnNlcnMgaXMgdXNlZCA6ICdzdGFi
bGVAdmdlci5rZXJuZWwub3JnIzQuNCsnDQo+IFsuLi5dDQo+IA0KPiA+IFRoZSBwYXRjaCBqdXN0
IGJyaW5ncyBwYXJpdHkgdG8gdGhlIE1haWw6OkFkZHJlc3MgYmVoYXZpb3IgYW5kIGdpdCdzDQo+
ID4gZmFsbGJhY2sgcGFyc2VyLCBzbyB0aGF0IHlvdSBkb24ndCBlbmQgdXAgd2l0aCB0aGUgYnJv
a2VuDQo+ID4gc3RhYmxlQHZnZXIua2VybmVsLm9yZyM0LjQrIGFkZHJlc3MuIEluc3RlYWQsIHRo
YXQgY29udGVudCBnb2VzIGludG8NCj4gPiB0aGUgbmFtZSBwYXJ0IG9mIHRoZSBhZGRyZXNzLg0K
PiA+DQo+ID4gSXQgc291bmRzIGxpa2UgeW91IHdhbnQgdGhlICIjIDQuNCsiIHRvIGJlIGRyb3Bw
ZWQgZW50aXJlbHkgaW4gdGhlDQo+ID4gcmZjODIyIGhlYWRlci4gSXQgbG9va3MgbGlrZSBzZW5k
LWVtYWlsIHVzZWQgdG8gZG8gdGhhdCwgYnV0IHN0b3BwZWQNCj4gPiBpbg0KPiA+IGIxYzhhMTFj
OCAoc2VuZC1lbWFpbDogYWxsb3cgbXVsdGlwbGUgZW1haWxzIHVzaW5nIC0tY2MsIC0tdG8gYW5k
DQo+ID4gLS1iY2MsIDIwMTUtMDYtMzApLg0KPiA+DQo+ID4gU28gcGVyaGFwcyB0aGVyZSBhcmUg
ZnVydGhlciBmaXhlcyByZXF1aXJlZCwgYnV0IGl0J3MgaGFyZCB0byBrbm93Lg0KPiA+IFRoZSBp
bnB1dCBpc24ndCBhIHZhbGlkIHJmYzgyMiBoZWFkZXIsIHNvIGl0J3Mgbm90IGVudGlyZWx5IGNs
ZWFyIHdoYXQNCj4gPiB0aGUgb3V0cHV0IGlzIHN1cHBvc2VkIHRvIGJlLiBJIGNhbiBidXkgZWl0
aGVyICJkcm9wIGl0IGNvbXBsZXRlbHkiIG9yDQo+ID4gInN0aWNrIGl0IGluIHRoZSBuYW1lIGZp
ZWxkIG9mIHRoZSBjYyBoZWFkZXIiIGFzIHJlYXNvbmFibGUuDQo+IA0KPiBXZWxsLCB3ZSBjb3Vs
ZCBhbHdheXMgY29udmVydCBpdCB0byBlbWFpbCBhZGRyZXNzIGNvbW1lbnQsIGNvbnZlcnRpbmcg
Zm9yDQo+IGV4YW1wbGUgdGhlIGZvbGxvd2luZyB0cmFpbGVyOg0KPiANCj4gICBDYzogSm9obiBE
b2UgPGpvaG5AZXhhbXBsZS5jb20+ICMgY29tbWVudA0KPiANCj4gdG8gdGhlIGZvbGxvd2luZyBh
ZGRyZXNzOg0KPiANCj4gICBKb2huIERvZSA8am9obkBleGFtcGxlLmNvbT4gKGNvbW1lbnQpDQo+
IA0KPiBKdXN0IEZZSS4gIFRob3VnaCBJJ20gbm90IHN1cmUgaG93IHdlbGwgdGhpcyB3b3VsZCB3
b3JrLi4uDQo+IA0KWWVwLCBpdCBhY3R1YWxseSBsb29rcyBhcyByaWdodCBwbGFjZSB0byBwdXQg
dGhpcyBraW5kICBvZiBpbmZvLCAgDQp0aG91Z2ggSSdtICBub3Qgb24gdGhlIHJlY2VpdmluZyBz
aWRlLg0KSSdtIG5vdCBzdXJlIGlmIGFuZCBob3cgaXMgdGhpcyB1c2VkIGJ5IHN0YWJsZSBtYWlu
dGFpbmVycy4gDQpUaGFua3MNClRvbWFzIA0KDQoNCg==
