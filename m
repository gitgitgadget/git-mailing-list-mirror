From: "Dan Langille (dalangil)" <dalangil@cisco.com>
Subject: Re: git-http-backend auth via Kerberos
Date: Fri, 19 Dec 2014 15:07:20 +0000
Message-ID: <D562883B-47D7-4569-B1BB-84BFBDCBA93A@cisco.com>
References: <540A8740-B240-40FF-BB50-0D90DEA04031@cisco.com>
 <20141218225418.GA84625@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 16:16:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1zIG-0006EU-8h
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 16:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbaLSPQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 10:16:36 -0500
Received: from alln-iport-5.cisco.com ([173.37.142.92]:24311 "EHLO
	alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbaLSPQf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 10:16:35 -0500
X-Greylist: delayed 554 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Dec 2014 10:16:35 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4690; q=dns/txt; s=iport;
  t=1419002195; x=1420211795;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U8v6d2TsFPWrAiihgUeH9kMgByhuO746eeVheryq2+Y=;
  b=AJol/L8kE0RYl+zjlezZJUY0Qcumr7J/++/I4hqJrlZ9Ix32K0wc4Yw2
   IpuYHFbaGhOV5FnVHtBhwOn9tY22DPxJ/3Sdql4yUuoZKsPEdIUsTDWFI
   PYIl18SowAHsOYV6LY/l12Su70minXYnJ0HIwaDuIznGa55/Qm8bKg3yU
   U=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq8GAGo+lFStJV2d/2dsb2JhbABagwZSWASDAcMghXECHIEAFgEBAQEBfYQMAQEBAwEjEUUFCwIBCBgCAhQSAgICMBUQAgQOBYgkCA26F5YqAQEBAQEBAQEBAQEBAQEBAQEBAQEBF4EhjgwSMwcEFIJQLoETBY4Ngz6FNIE9ijqFUSKDbm+BRX4BAQE
X-IronPort-AV: E=Sophos;i="5.07,607,1413244800"; 
   d="scan'208";a="106944335"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by alln-iport-5.cisco.com with ESMTP; 19 Dec 2014 15:07:21 +0000
Received: from xhc-aln-x10.cisco.com (xhc-aln-x10.cisco.com [173.36.12.84])
	by rcdn-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id sBJF7LU4028228
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 19 Dec 2014 15:07:21 GMT
Received: from xmb-rcd-x03.cisco.com ([169.254.7.194]) by
 xhc-aln-x10.cisco.com ([173.36.12.84]) with mapi id 14.03.0195.001; Fri, 19
 Dec 2014 09:07:20 -0600
Thread-Topic: git-http-backend auth via Kerberos
Thread-Index: AQHQGxCrd+//UJfMPkWu780RpZEfpJyWWaAAgAEPyoA=
In-Reply-To: <20141218225418.GA84625@vauxhall.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.82.216.181]
Content-ID: <AA52C4612C943E4D993EFE3EC1D02222@emea.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261562>

PiBPbiBEZWMgMTgsIDIwMTQsIGF0IDU6NTQgUE0sIGJyaWFuIG0uIGNhcmxzb24gPHNhbmRhbHNA
Y3J1c3R5dG9vdGhwYXN0ZS5uZXQ+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBEZWMgMTgsIDIwMTQg
YXQgMTA6MTk6MTlQTSArMDAwMCwgRGFuIExhbmdpbGxlIChkYWxhbmdpbCkgd3JvdGU6DQo+PiBU
aGlzIGlzIHdoYXQgaGFwcGVucyB3aXRob3V0IGEgdmFsaWQgdGlja2V0Og0KPj4gDQo+PiAkIGdp
dCBjbG9uZSBodHRwczovL3VzLmV4YW1wbGUuY29tL2dpdC9jbGFtYXYtYnl0ZWNvZGUtY29tcGls
ZXINCj4+IENsb25pbmcgaW50byAnY2xhbWF2LWJ5dGVjb2RlLWNvbXBpbGVyJy4uLg0KPj4gVXNl
cm5hbWUgZm9yICdodHRwczovL3VzLmV4YW1wbGUuY29tJzogZGFuDQo+PiBQYXNzd29yZCBmb3Ig
J2h0dHBzOi8vZGFuQHVzLmV4YW1wbGUuY29tJzogDQo+PiBmYXRhbDogQXV0aGVudGljYXRpb24g
ZmFpbGVkIGZvciAnaHR0cHM6Ly91cy5leGFtcGxlLmNvbS9naXQvY2xhbWF2LWJ5dGVjb2RlLWNv
bXBpbGVyLycNCj4gDQo+IFNvIHRoZXJlIGFyZSB0d28gd2F5cyB0byBkbyB0aGlzLiAgT25lIGlz
IGFsbG93aW5nIHVzZXJzIHRvIGNsb25lDQo+IHdpdGhvdXQgYW55IGNyZWRlbnRpYWxzLCB3aGlj
aCBJIHRha2UgaXQgeW91IGFyZSB0cnlpbmcgdG8gYXZvaWQuICBJZg0KPiB0aGF0ICppcyogd2hh
dCB5b3UncmUgZ29pbmcgZm9yLCBJIGNhbiBwcm92aWRlIHlvdSB3aXRoIG15IEFwYWNoZQ0KPiBj
b25maWd1cmF0aW9uLCB3aGljaCBkb2VzIGFsbG93IHRoYXQuDQoNCkNvcnJlY3QsIHdlIGFyZSB0
cnlpbmcgdG8gYXZvaWQgdGhhdC4gIEluIGFkZGl0aW9uLCB0aGVyZSBpcyBvbmx5IGh0dHBzLCBu
byBodHRwLg0KDQo+IFdoYXQgSSB3b3VsZCByZWNvbW1lbmQgaXMgZ29pbmcgdG8NCj4gaHR0cHM6
Ly91cy5leGFtcGxlLmNvbS9naXQvY2xhbWF2LWJ5dGVjb2RlLWNvbXBpbGVyL2luZm8vcmVmcyBp
biBhIHdlYg0KPiBicm93c2VyIHdpdGhvdXQgYSB0aWNrZXQsIGFuZCBzZWUgaWYgaXQgcHJvbXB0
cyB5b3UgZm9yIGEgdXNlcm5hbWUgYW5kDQo+IHBhc3N3b3JkLg0KDQpUbyBiZSBjbGVhciwgZm9y
IHRoZSBmb2xsb3dpbmcgdGVzdHMsIHRoZXJlIGlzIG5vIEtlcmJlcm9zIHRpY2tldC4NCg0KSSB0
cmllZCB0aGF0IFVSTCB1c2luZyB0aHJlZSBkaWZmZXJlbnQgYnJvd3NlcnMuICBFYWNoIHRpbWUg
SSBhbSBwcm9tcHRlZCBmb3INCmEgdXNlcm5hbWUgJiBwYXNzd29yZC4gIEFmdGVyIGVudGVyaW5n
IHZhbGlkIGNyZWRlbnRpYWxzLCBJIGdldDoNCg0KQ2hyb21lOiBObyBkYXRhIHJlY2VpdmVkLiBV
bmFibGUgdG8gbG9hZCB0aGUgd2VicGFnZSBiZWNhdXNlIHRoZSBzZXJ2ZXINCnNlbnQgbm8gZGF0
YS4gRXJyb3IgY29kZTogRVJSX0VNUFRZX1JFU1BPTlNFDQoNCldpdGggRmlyZWZveDogVGhlIGNv
bm5lY3Rpb24gd2FzIHJlc2V0DQoNClNhZmFyaTogU2FmYXJpIENhbuKAmXQgT3BlbiBUaGUgUGFn
ZQ0KDQpIb3dldmVyLCBJIGRpZCBzdHVtYmxlIGFjcm9zcyBzb21ldGhpbmcgd2hpY2ggc2VlbXMg
cHJvbWlzaW5nLg0KDQpBZnRlciB0aGUgYWJvdmUgZmFpbHVyZXMsIGlmIEkgdGhlbiBicm93c2Ug
dG8gL2dpdHdlYi8NCih3aGVyZSBJIHNlZSBleHBlY3RlZCByZXN1bHRzKSBhbmQgdGhlbiBnbyB0
byB0aGUgaW5mby9yZWZzIFVSTCB5b3Ugc3VwcGxpZWQsDQpJIHNlZSBkYXRhIHN1Y2ggYXMgdGhp
czoNCg0KICAgZmUwNjhhOGFlNTVjZWE0YmI5MGUyY2M3MTQxMDdmNGM1Mzg5ZDUxNglyZWZzL2hl
YWRzLzAuOTYueA0KICAgZDM4NGE5NjM5ODBlOWI0MGUzNGRlYTgwZWFjMjgwY2YyZDRiN2M3Mwly
ZWZzL2hlYWRzLzAuOTcueA0KDQpDb25jbHVzaW9uOiB0aGVyZSBpcyBzb21ldGhpbmcgaW4gdGhl
IC9naXR3ZWIgYXV0aCB3aGljaCBpcyBzdWNjZWVkaW5nIGFuZCB0aGVuDQphbGxvd2luZyAvZ2l0
IHRvIHdvcmsNCg0KRm9yIHRoZSByZWNvcmQsIHRoaXMgaXMgdGhlIGdpdHdlYiBhdXRoOg0KDQo8
TG9jYXRpb24gL2dpdHdlYj4NCiAgU1NMT3B0aW9ucyArU3RkZW52VmFycw0KICBPcHRpb25zICtF
eGVjQ0dJICtGb2xsb3dTeW1MaW5rcyArU3ltTGlua3NJZk93bmVyTWF0Y2gNCg0KICBBdXRoVHlw
ZSAgICAgICAgICAgS2VyYmVyb3MNCiAgQXV0aE5hbWUgICAgICAgICAgIOKAnHVzLmV4YW1wbGUu
Y29tIg0KICBLcmJBdXRoUmVhbG1zICAgICAgdXMuZXhhbXBsZS5jb20NCiAgS3JiU2VydmljZU5h
bWUgICAgIEhUVFAvdXMuZXhhbXBsZS5jb20NCiAgS3JiNUtleXRhYiAgICAgICAgIC91c3IvbG9j
YWwvZXRjL2FwYWNoZTIyL3JlcG8tdGVzdC5rZXl0YWINCiAgS3JiTWV0aG9kTmVnb3RpYXRlIG9u
DQogIEtyYk1ldGhvZGs1UGFzc3dkICBvbg0KDQogIHJlcXVpcmUgICAgICAgICAgICB2YWxpZC11
c2VyDQo8L0xvY2F0aW9uPg0KDQoNCj4gIFdoZW4geW91IGdldCB0aGF0IHdvcmtpbmcsIGl0IHdp
bGwgcHJvYmFibHkgYWxzbyB3b3JrIGZvciB5b3UNCj4gd2l0aCBnaXQuDQoNCk5vdCB5ZXQuLi4N
Cg0KPiANCj4gWW91IGNhbiBhbHNvIHJ1biBnaXQgd2l0aCBHSVRfQ1VSTF9WRVJCT1NFPTEgYW5k
IHNlZSB0aGUgcHJvdG9jb2wNCj4gZXhjaGFuZ2UgcHJpbnRlZCBvdXQsIHNvIHlvdSBjYW4gc2Vl
IHdoYXQncyBoYXBwZW5pbmcuICANCg0KVGhhdCBhdHRlbXB0IGlzIHNob3duIGhlcmU6IGh0dHA6
Ly9kcGFzdGUuY29tLzA0UkczN0UudHh0DQoNCj4gWW91J2xsIG9idmlvdXNseQ0KPiB3YW50IHRv
IHNlZSBpZiB0aGUgc2VydmVyIG9mZmVycyBCYXNpYyBhdXRoIGFzIHdlbGwgYXMgTmVnb3RpYXRl
Lg0KDQpJ4oCZbSBub3QgdXAgb24gbXkga25vd2xlZGdlIGhlcmUuICBZb3UgbWVhbiB0aGUgS2Vy
YmVyb3Mgc2VydmVyPw0KDQoNCj4gWW91IG1pZ2h0IGFsc28gdHJ5IHNwZWNpZnlpbmcgS3JiTWV0
aG9kSzVQYXNzd2Qgb24gZXhwbGljaXRseS4gIEkgZG9uJ3QNCj4gaGFwcGVuIHRvIHVzZSB0aGF0
IG9wdGlvbiAoSSB1c2UgS2VyYmVyb3MgdG8gYXZvaWQgcGFzc3dvcmRzIGFsdG9nZXRoZXIpDQo+
IHNvIHRoYXQgbWlnaHQgd29yayBmb3IgeW91Lg0KPiANCj4gSSBkb24ndCBrbm93IHdoYXQgdmVy
c2lvbiBvZiBnaXQgeW91J3JlIHVzaW5nLCBidXQgc29tZSBvbGRlciB2ZXJzaW9ucw0KPiB3aWxs
IHN0aWxsIHByb21wdCBmb3IgYSBwYXNzd29yZCB3aGVuZXZlciBhdXRoZW50aWNhdGlvbiBmYWls
cy4NCj4gVGhlcmVmb3JlLCBqdXN0IGJlY2F1c2UgeW91J3JlIGdldHRpbmcgYSBwYXNzd29yZCBw
cm9tcHQgZG9lc24ndCBtZWFuDQo+IHRoYXQgcHJvdmlkaW5nIGEgcGFzc3dvcmQgd2lsbCBuZWNl
c3NhcmlseSB3b3JrLg0KDQpIb3cgb2xkIGlzIG9sZGVyPw0KDQokIGdpdCAtLXZlcnNpb24NCmdp
dCB2ZXJzaW9uIDEuOS4zIChBcHBsZSBHaXQtNTApDQoNCk1pZ2h0IHRoYXQgYmUgaXQ/ICBIbW1t
Lg0KDQo=
