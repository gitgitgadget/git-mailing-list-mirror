Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCFB1F404
	for <e@80x24.org>; Fri, 27 Apr 2018 10:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932685AbeD0Khr (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 06:37:47 -0400
Received: from ironport.klsmartin.com ([212.211.191.11]:7431 "EHLO
        ironport.klsmartin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932546AbeD0Khr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 06:37:47 -0400
X-IronPort-AV: E=Sophos;i="5.49,334,1520895600"; 
   d="scan'208";a="16128894"
Received: from unknown (HELO ares.klsmartin.com) ([172.30.5.65])
  by ironport.klsmartin.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 27 Apr 2018 12:37:46 +0200
Received: from SUMMAIL01.UMK.KLS.zentral ([172.25.1.63])
        by ares.klsmartin.com (8.14.3/8.13.1/SuSE Linux 0.7) with ESMTP id w3RAbdow005685;
        Fri, 27 Apr 2018 12:37:44 +0200
Received: from SUMMBX01.UMK.KLS.zentral ([172.25.1.64]) by
 SUMMAIL01.UMK.KLS.zentral ([172.25.1.63]) with mapi id 14.03.0351.000; Fri,
 27 Apr 2018 12:37:38 +0200
From:   "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>
To:     "newren@gmail.com" <newren@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git merge banch w/ different submodule revision
Thread-Topic: git merge banch w/ different submodule revision
Thread-Index: AQHT3UxIUeHy1QVy7UGFBG3KFIVVC6QTnqUAgACr34A=
Date:   Fri, 27 Apr 2018 10:37:38 +0000
Message-ID: <1524825269.2227.5.camel@klsmartin.com>
References: <1524739599.20251.17.camel@klsmartin.com>
         <CABPp-BE5jRG8JdDfH1XG-Btz9jJxfwf_oyNni8Ci1j+J3icbVQ@mail.gmail.com>
In-Reply-To: <CABPp-BE5jRG8JdDfH1XG-Btz9jJxfwf_oyNni8Ci1j+J3icbVQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.70.68]
x-kse-serverinfo: SUMMAIL01.UMK.KLS.zentral, 9
x-kse-attachmentfiltering-interceptor-info: protection disabled
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 27.04.2018 08:39:00
Content-Type: text/plain; charset="utf-8"
Content-ID: <52D3AC800430DC4397B3F3DC826056D6@klsmartin.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQoNCmZpcnN0b2ZhbGw6IHRoYW5rIGFsbCBvZiB5b3UgZm9yIHlvdXIgZmVlZGJhY2suDQoN
CkFtIERvbm5lcnN0YWcsIGRlbiAyNi4wNC4yMDE4LCAxNzoxOSAtMDcwMCBzY2hyaWViIEVsaWph
aCBOZXdyZW46DQo+IE9uIFRodSwgQXByIDI2LCAyMDE4IGF0IDM6NDkgQU0sIE1pZGRlbHNjaHVs
dGUsIExlaWYNCj4gPExlaWYuTWlkZGVsc2NodWx0ZUBrbHNtYXJ0aW4uY29tPiB3cm90ZToNCj4g
PiBIaSwNCj4gPiANCj4gPiB3ZSdyZSB1c2luZyBnaXQtZmxvdyBhcyBhIGJhc2ljIGRldmVsb3Bt
ZW50IHdvcmtmbG93LiBIb3dldmVyLCBkb2luZyBzbyByZXZlYWxlZCB1bmV4cGVjdGVkIG1lcmdl
LWJlaGF2aW9yIGJ5IGdpdC4NCj4gPiANCj4gPiBBc3N1bWUgdGhlIGZvbGxvd2luZyBzZXR1cDoN
Cj4gPiANCj4gPiAtIFJlcG9zaXRvcnkgYFNgIGlzIHNvdXJjZWQgYnkgcmVwb3NpdG9yeSBgcGAg
YXMgc3VibW9kdWxlIGBzYA0KPiA+IC0gUmVwb3NpdG9yeSBgcGAgaGFzIHR3byBicmFuY2hlczog
YGZlYXR1cmVfeGAgYW5kIGBkZXZlbG9wYA0KPiA+IC0gVGhlIHJldmlzaW9ucyBzb3VyY2VkIHZp
YSB0aGUgc3VibW9kdWxlIGhhdmUgYSBsaW5lYXIgaGlzdG9yeQ0KPiA+IA0KPiA+IA0KPiA+ICog
MWMxZDM4ZiAoZmVhdHVyZV94KSB1cGRhdGUgc3VibW9kdWxlIHJldmlzaW9uIHRvIGIxN2U5ZDkN
Cj4gPiA+ICogMzI5MGU2OSAoSEVBRCAtPiBkZXZlbG9wKSB1cGRhdGUgc3VibW9kdWxlIHJldmlz
aW9uIHRvIDA1OTgzOTQNCj4gPiA+IC8NCj4gPiANCj4gPiAqIGNkNWUxYTUgaW5pdGlhbCBzdWJt
b2R1bGUgcmV2aXNpb24NCj4gPiANCj4gPiANCj4gPiBQcm9ibGVtIGNhc2U6IE1lcmdlIGVpdGhl
ciBicmFuY2ggaW50byB0aGUgb3RoZXINCj4gPiANCj4gPiBFeHBlY3RlZCBiZWhhdmlvcjogTWVy
Z2UgY29uZmxpY3QuDQo+ID4gDQo+ID4gQWN0dWFsIGJlaGF2aW9yOiBBdXRvIG1lcmdlIHdpdGhv
dXQgY29uZmxpY3RzLg0KPiA+IA0KPiA+IE5vdGUgMTogQSBtZXJnZSBjb25mbGljdCBkb2VzIG9j
Y3VyLCBpZiB0aGUgc291cmNlZCByZXZpc2lvbnMgZG8gKm5vdCogaGF2ZSBhIGxpbmVhciBoaXN0
b3J5DQo+ID4gDQo+ID4gRGlkIEkgZ2V0IHNvbWV0aGluZyB3cm9uZyBhYm91dCBob3cgZ2l0IHJl
c29sdmVzIG1lcmdlcz8gU2hvdWxkbid0IGdpdCBiZSBsaWtlOiAiaGV5LCB5b3UncmUgdHJ5aW5n
IHRvIG1lcmdlIHR3byBkaWZmZXJlbnQgY29udGVudHMgZm9yIHRoZSBzYW1lIGxpbmUiICh0aGUg
c3VibW9kdWxlJ3MgcmV2aXNpb24pDQo+IA0KPiBIYXJkIHRvIHNheSB3aXRob3V0IHNheWluZyB3
aGF0IGNvbW1pdCB3YXMgcmVmZXJlbmNlZCBmb3IgdGhlDQo+IHN1Ym1vZHVsZSBpbiB0aGUgbWVy
Z2UtYmFzZXMgZm9yIHRoZSB0d28gcmVwb3NpdG9yaWVzIHlvdSBoYXZlLiAgSW4NCj4gdGhlIGJh
c2ljIGNhc2UuLg0KPiANCj4gSWYgYnJhbmNoIEEgYW5kIGJyYW5jaCBCIGhhdmUgZGlmZmVyZW50
IGNvbW1pdHMgY2hlY2tlZCBvdXQgaW4gdGhlDQo+IHN1Ym1vZHVsZSwgc2F5Og0KPiAgICBBOiBk
ZWFkYmVlZg0KPiAgICBCOiBiYTVlYmExMQ0KPiANCj4gdGhlbiBpdCdzIG5vdCBjbGVhciB3aGV0
aGVyIHRoZXJlJ3MgYSBjb25mbGljdCBvciBub3QuICBUaGUgbWVyZ2UtYmFzZQ0KPiAodGhlIGNv
bW1vbiBwb2ludCBvZiBoaXN0b3J5KSBtYXR0ZXJzLiAgU28sIGZvciBleGFtcGxlIGlmIHRoZQ0K
PiBvcmlnaW5hbCB2ZXJzaW9uICh3aGljaCBJJ2xsIHJlZmVyIHRvIGFzICdPIikgaGFkOg0KPiAg
IE86IGRlYWRiZWVmDQo+IA0KPiB0aGVuIHlvdSB3b3VsZCBzYXksICJPaCwgYnJhbmNoIEEgbWFk
ZSBubyBjaGFuZ2UgdG8gdGhpcyBzdWJtb2R1bGUgYnV0DQo+IEIgZGlkLiAgU28gbGV0J3MgZ28g
d2l0aCB3aGF0IEIgaGFzLiIgIENvbnZlcnNlbHksIG9mIE8gaGFkIGJhNWViYTExLA0KPiB0aGVu
IHlvdSdkIGdvIHRoZSBvdGhlciB3YXkuDQo+IA0KPiBCdXQsIHRoZXJlIGlzIHNvbWUgZnVydGhl
ciBzbWFydHMgaW4gdGhhdCBpZiBlaXRoZXIgQSBvciBCIHBvaW50IGF0DQo+IGNvbW1pdHMgdGhh
dCBjb250YWluIHRoZSBvdGhlciBpbiB0aGVpciBoaXN0b3J5IGFuZCBib3RoIGNvbnRhaW4gdGhl
DQo+IGNvbW1pdCB0aGF0IE8gcG9pbnRzIGF0LCB0aGVuIHlvdSBjYW4ganVzdCBkbyBhIGZhc3Qt
Zm9yd2FyZCB1cGRhdGUgdG8NCj4gdGhlIG5ld2VzdC4NCj4gDQo+IA0KPiBZb3UgZGlkbid0IHRl
bGwgdXMgaG93IHRoZSBtZXJnZS1iYXNlIChjZDVlMWE1IGZyb20gdGhlIGRpYWdyYW0geW91DQo+
IGdhdmUpIGRpZmZlcmVkIGluIHlvdXIgZXhhbXBsZSBoZXJlIGJldHdlZW4gdGhlIHR3byByZXBv
c2l0b3JpZXMuICBJbg0KPiBmYWN0LCB0aGUgbm9uLWxpbmVhciBjYXNlIGNvdWxkIGhhdmUgc2V2
ZXJhbCBtZXJnZS1iYXNlcywgaW4gd2hpY2gNCj4gY2FzZSB0aGV5IGFsbCBiZWNvbWUgcG90ZW50
aWFsbHkgcmVsZXZhbnQgKGFzIGRvZXMgdGhlaXIgbWVyZ2UtYmFzZXMNCj4gc2luY2UgYXQgdGhh
dCBwb2ludCB5b3UnbGwgdHJpZ2dlciB0aGUgcmVjdXJzaXZlIHBvcnRpb24gb2YNCj4gbWVyZ2Ut
cmVjdXJzaXZlKS4gIEdpdmluZyB1cyB0aGF0IGluZm8gbWlnaHQgaGVscCB1cyBwb2ludCBvdXQg
d2hhdA0KPiBoYXBwZW5lZCwgdGhvdWdoIGlmIGVpdGhlciB0aGUgZmFzdC1mb3J3YXJkIGxvZ2lj
IGNvbWVzIGludG8gcGxheSBvcg0KPiB0aGUgcmVjdXJzaXZlIGxvZ2ljIGdldHMgaW4gdGhlIG1p
eCwgdGhlbiB3ZSBtYXkgbmVlZCB5b3UgdG8gcHJvdmlkZSBhDQo+IHRlc3RjYXNlIChvciBhY2Nl
c3MgdG8gdGhlIHJlcG8gaW4gcXVlc3Rpb24pIGluIG9yZGVyIHRvIGV4cGxhaW4gaXQNCj4gYW5k
L29yIGRldGVybWluZSBpZiB5b3UndmUgZm91bmQgYSBidWcuDQoNCkkgcGxhY2VkIHR3byByZW9z
aXRvcmllcyBoZXJlOiBodHRwczovL2dpdGxhYi5jb20vZm9zcy1jb250cmlidXRpb25zL2dpdC1l
eGFtcGxlcy9uZXR3b3JrL2RldmVsb3ANClRoZSBhY2Nlc3Mgc2hvdWxkIGJlIHB1YmxpYyB3L28g
bG9naW4uDQoNCklmIHlvdSBwcmVmZXIgdGhlIGV4YW1wbGVzIHRvIGJlIHBsYWNlZCBzb21ld2hl
cmUgZWxzZSwgbGV0IG1lIGtub3cuDQoNCj4gDQo+IERvZXMgdGhhdCBoZWxwPw0KDQpJIGd1ZXNz
IGl0J3Mgc29tZWhvdyB1bmRlcnN0YW5kYWJsZSB0aGF0IGl0IHRyaWVzIHRvIGJlIG1vcmUgc21h
cnQgYWJvdXQgdGhpbmdzIHdydCBzdWJtb2R1bGVzLg0KDQpIb3dldmVyLCBJIGJlbGlldmUgdGhh
dCB0aGVyZSBzaG91bGQgYmUgc29tZSBraW5kIG9mIGNob2ljZSBoZXJlLiBOb3QgZ2l2aW5nICph
bnkqIG5vdGljZSwgbWFrZXMgdGVzdGluZyBmZWF0dXJlLWJyYW5jaGVzIGhlbGwuDQoNCkkgaG9w
ZSB0aGUgcHJvdmlkZWQgZXhhbXBsZSBleGhpYml0cyB0aGUgY2hhbGxlbmdlLg0KDQoNCkJSLA0K
DQpMZWlmDQo+IA0KPiBFbGlqYWgNCj4g
