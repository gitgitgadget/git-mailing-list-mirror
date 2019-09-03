Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55E381F461
	for <e@80x24.org>; Tue,  3 Sep 2019 06:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfICGed (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 02:34:33 -0400
Received: from eml2-img01-day.reyrey.com ([206.180.2.9]:24078 "EHLO
        eml2-img01-day.reyrey.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfICGed (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 02:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=reyrey.com; i=@reyrey.com; q=dns/txt; s=reyrey.com;
  t=1567492472; x=1599028472;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JkHb/9+aDsZr6Vpbz9SFQOi4UpqnvX3EMs4yKhUKLe4=;
  b=nrms2HK7h9W3XUgLhPYMSjyyEOh6ie987SpBPyxK7HZBEDX1Z/+VGpYx
   zCGP1j3c0cBrNQ1Z4igJR47JfS+TF0/HTSBP05T756bB9GMwTzeSchMYo
   EnGWneivc3bxDQ9TMni4R+8BFn0bOovTAd9RlisGWv7gb+lyGxPuoGoL1
   w=;
IronPort-SDR: hvCIENchE1l+Gb0MuhpZqZWvTzQJ38wMKcSQQYthGUwsjaeLVNy+CgvsabgvAuTVMWHo6TX+yD
 jt4Phn1Z/opariVU67gZQRUHXU72eKNpnFFcMCEu1TYSZewyPagn4l+PSM5QSNAAvTvoTh+nA1
 1CmslBgaBOKR/xXKgzwkmNJ1xhpi42vusTtzlchHcAbZRGtUCgFO/IscU8/BDb9GQWlZauLVWL
 qFyQjWwESrPCAzPXo1BgI+rQpG8yvmEhdIU1DyOd1b49EDiamcx/RSdAYuX/XBmcD7kTTN9N1R
 hto=
X-CrossPremisesHeadersFilteredBySendConnector: EML-MBX18-DAY.ad.reyrey.com
From:   "van den Berg, Kasper" <Kasper_vandenBerg@reyrey.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: git range-diff <range1> <range2> throws Segmentation fault
Thread-Topic: git range-diff <range1> <range2> throws Segmentation fault
Thread-Index: AdVe/Yxl4Q1g4P2RTlmn5jhPmEBLHwAj+jgAAKTDchA=
Date:   Tue, 3 Sep 2019 06:34:30 +0000
Message-ID: <a675af41c66a457f97fe0e61d914fe58@EML-MBX11-DAY.ad.reyrey.com>
References: <6802cf61dcbf438cb2e01cd390c57390@EML-MBX11-DAY.ad.reyrey.com>
 <nycvar.QRO.7.76.6.1908302147490.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1908302147490.46@tvgsbejvaqbjf.bet>
Accept-Language: nl-NL, en-US
Content-Language: nl-NL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.95.6.35]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OrganizationHeadersPreserved: EML-MBX18-DAY.ad.reyrey.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgSm9oYW5uZXMsIGhlbGxvIFRob21hcywNCg0KQ3VycmVudGx5LCBJJ20gYXBwcm9hY2hpbmcg
YSByZWxlYXNlIGRlYWRsaW5lIGFuZCB0aGVyZSBhcmUgc29tZSB0YXNrcyB3aXRoIGhpZ2hlciBw
cmlvcml0eSB3YWl0aW5nIGZvciBtZSBhbmQgY3JlYXRpbmcgYSBNQ1ZFIHRha2VzIHNvbWUgdGlt
ZS4gIENyZWF0aW5nIHRoZSBzdGFja3RyYWNlIGFuZCBlbnN1cmluZyBJIGRvbid0IGxlYWsgcHJv
cHJpZXRhcnkgY29kZSBhbHNvIHRha2VzIG1vcmUgdGltZSB0aGFuIEkgY2FuIGN1cnJlbnRseSBh
ZmZvcmQuDQpJbiB0d28gd2Vla3MgSSBtaWdodCBoYXZlIG1vcmUgdGltZS4gIElmIG5lZWRlZCwg
SSB3aWxsIHRyeSB0byBoZWxwIHdpdGggYXBwcm9wcmlhdGUgZXJyb3IgZGF0YSBhbmQvb3IgYSBy
ZXByb2R1Y3Rpb24uDQoNCldpdGgga2luZCByZWdhcmRzLA0KS2FzcGVyIHZhbiBkZW4gQmVyZw0K
DQotLS0tLU9vcnNwcm9ua2VsaWprIGJlcmljaHQtLS0tLQ0KVmFuOiBKb2hhbm5lcyBTY2hpbmRl
bGluIDxKb2hhbm5lcy5TY2hpbmRlbGluQGdteC5kZT4gDQpWZXJ6b25kZW46IHZyaWpkYWcgMzAg
YXVndXN0dXMgMjAxOSAyMTo0OQ0KQWFuOiB2YW4gZGVuIEJlcmcsIEthc3BlciA8S2FzcGVyX3Zh
bmRlbkJlcmdAcmV5cmV5LmNvbT4NCkNDOiBnaXRAdmdlci5rZXJuZWwub3JnDQpPbmRlcndlcnA6
IFJlOiBnaXQgcmFuZ2UtZGlmZiA8cmFuZ2UxPiA8cmFuZ2UyPiB0aHJvd3MgU2VnbWVudGF0aW9u
IGZhdWx0DQoNCkhpIEthc3BlciwNCg0KT24gRnJpLCAzMCBBdWcgMjAxOSwgdmFuIGRlbiBCZXJn
LCBLYXNwZXIgd3JvdGU6DQoNCj4gYGdpdCByYW5nZS1kaWZmIDxyYW5nZTE+IDxyYW5nZTI+YCBw
cmludHMgInNlZ21lbnRhdGlvbiBmYXVsdCIgdG8gdGhlIA0KPiBjb25zb2xlIGFuZCBub3RoaW5n
IGVsc2UuICBJdCBoYXBwZW5zIGluIGdpdCB2ZXJzaW9uIDIuMjMuMC53aW5kb3dzLjEgDQo+IGFu
ZCBvbmx5IG9jY3VycyBmb3Igc29tZSBicmFuY2hlcyBpbiBteSByZXBvc2l0b3J5Lg0KDQpNYXli
ZSB5b3UgY2FuIGNvbWUgdXAgd2l0aCBhIE1pbmltYWwsIENvbXBsZXRlIGFuZCBWZXJpZmlhYmxl
IEV4YW1wbGUgKGh0dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vaGVscC9tY3ZlKT8NCg0KQ2lhbywN
CkpvaGFubmVzDQo=
