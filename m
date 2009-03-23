From: "Samman, Bassel" <Bsamman@imagitekltd.com>
Subject: RE: How to go to git from svn without checkout
Date: Mon, 23 Mar 2009 10:21:41 -0500
Message-ID: <FB1F526D99571D4DBF84F456D358792901CC7F6F@leasrv003.imagitek.local>
References: <22640020.post@talk.nabble.com> <20090322032008.GA9526@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
Cc: <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 19:25:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlooU-00033c-1X
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 19:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758882AbZCWSWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 14:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758603AbZCWSWB
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 14:22:01 -0400
Received: from gwlb1.appriver.com ([69.20.60.122]:48638 "EHLO
	server70.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758283AbZCWSV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 14:21:59 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Mar 2009 14:21:59 EDT
Received: by server70.appriver.com (CommuniGate Pro PIPE 5.2.13)
  with PIPE id 87073903; Mon, 23 Mar 2009 11:21:56 -0400
Received: from [65.38.113.218] (HELO leasrv003.imagitek.local)
  by server70.appriver.com (CommuniGate Pro SMTP 5.2.13)
  with ESMTP id 87073872; Mon, 23 Mar 2009 11:21:46 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20090322032008.GA9526@coredump.intra.peff.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to go to git from svn without checkout
Thread-Index: AcmqnR6v/+EZNBAoRmu91HS9nrwJ9gBK7wBA
X-Policy: imagitekltd.com - imagitekltd.com
X-Policy: imagitekltd.com - imagitekltd.com
X-Primary: bsamman@imagitekltd.com
X-Note: This Email was scanned by AppRiver SecureTide
X-Virus-Scan: V-
X-Note: FCH-SI:0/SG:0
X-GBUdb-Analysis: 0, 65.38.113.218, Ugly c=0.587087 p=-0.90604 Source Normal
X-Signature-Violations: 0-0-0-3765-c
X-Warn: BOUNCETRACKER Bounce User Tracking Found
X-Note: Spam Tests Failed: BOUNCETRACKER
X-Country-Path: UNITED STATES->UNITED STATES
X-Note-Sending-IP: 65.38.113.218
X-Note-Reverse-DNS: 
X-Note-WHTLIST: Bsamman@imagitekltd.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 90 91 92 93 97 98 132 166 
X-Note: Mail Class: VALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114341>

WWVzLCB1bmZvcnR1bmF0ZWx5IHRoZXkgZG8gY2hhbmdlIG9jY2FzaW9uYWxseSBhbmQgdGhleSBn
cm93IHdpdGggdGltZS4gIEl0J3MgYSBwcm9kdWN0IGNhdGFsb2d1ZSwgc28gbmV3IHByb2R1Y3Rz
IGFyZSBhZGRlZCBhbGwgdGhlIHRpbWUsIGp1c3Qgbm90IGRhaWx5LiAgVGhhdCdzIHBhcnQgb2Yg
d2h5IEkgd2FudCB0byBtb3ZlIHRvIEdpdCwgU1ZOIGhhcyBiZWVuIGdpdmluZyBtZSBsb3RzIG9m
IHRyb3VibGUgd2hlbiBhZGRpbmcgZmlsZXMgYXQgZGVlcCBsZXZlbHMgYW5kIEkgbGlrZSBob3cg
R2l0IGRvZXMgYWRkaW5nIGZpbGVzIGFuZCBob3cgZWFjaCByZXBvc2l0b3J5IGlzIHJlYWxseSBp
dCdzIG93biByZXBvc2l0b3J5LiAgQWxzbywgSSdtIG5vdCByZWFsbHkgY29uY2VybmVkIGFib3V0
IGhpc3RvcnkgYXMgdGhlIG1haW4gcHVycG9zZSBvZiB0aGUgcmVwb3NpdG9yeSBpcyByZWFsbHkg
dG8gbWFrZSB0aGUgc3luY2luZyBqb2IgZWFzaWVyLiAgVGhlIGNvZGUgaXMgdmVyeSBtaW5pbWFs
IGFuZCBJIGRvIHRoZSBtYWpvcml0eSBvZiB0aGUgbWFpbnRlbmFuY2Ugb24gdGhlIGNvZGUsIHNv
IEkgY2FuIGVhc2lseSBqdW1wIGJhY2sgdG8gc3ZuIGlmIEkgbmVlZCBoaXN0b3J5LiAgVGhlIG1h
aW4gcmVhc29uIHdlIGV2ZW4gbmVlZCB0byBzaGFyZSB0aGUgcHJvamVjdCBpcyB0aGF0IHRoZSBz
YWxlcyBndXlzIG5lZWQgdG8gZ28gd2l0aG91dCBpbnRlcm5ldCBhdCB0aW1lcyBhbmQgdGhleSBu
ZWVkIHRvIGhhdmUgdGhlIHdlYnNpdGUgbG9jYWxseSBvbiB0aGVpciBtYWNoaW5lcyBzbyB0aGV5
IGNhbiBlYXNpbHkgZGVtbyB0aGUgbGF0ZXN0IHByb2R1Y3RzIHRvIHRoZWlyIGNsaWVudHMuICBC
dXNpbmVzcyByZXF1aXJlbWVudHMgYnkgc2FsZXMgZ3V5cyBjYW4gYmUgY3JhenkgYXQgdGltZXMs
IGJ1dCB3aGF0IGNhbiB3ZSBkby4gIEFsc28sIHRoaXMgaXMgYSBmYXIgZmV0Y2gsIHNpbmNlIGFs
bCB0aGUgcHJvamVjdHMgYXJlIGluc3RhbGxlZCB1bmRlciB0aGUgc2FtZSBkaXJlY3RvcmllcyBh
bmQgYXJlIHJlYWxseSBleGFjdCBjbG9uZXMgb2YgZWFjaCBvdGhlciBpbiBldmVyeSB3YXksIGNh
biBJIGNvcHkgdGhlIC5naXQgZGlyZWN0b3J5IGFuZCBob3BlIHRvIEdvZCB0aGF0IGl0IHdpbGwg
bWFnaWNhbGx5IHdvcmsuICBJIHJlYWxseSBkb3VidCBpdCwgYnV0IEkgZmlndXJlIGl0J3Mgd29y
dGggYXNraW5nLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmVmZiBLaW5n
IFttYWlsdG86cGVmZkBwZWZmLm5ldF0gDQpTZW50OiBTYXR1cmRheSwgTWFyY2ggMjEsIDIwMDkg
MTA6MjAgUE0NClRvOiBTYW1tYW4sIEJhc3NlbA0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1
YmplY3Q6IFJlOiBIb3cgdG8gZ28gdG8gZ2l0IGZyb20gc3ZuIHdpdGhvdXQgY2hlY2tvdXQNCg0K
T24gU2F0LCBNYXIgMjEsIDIwMDkgYXQgMDE6MjU6MzhQTSAtMDcwMCwgTWVyY2VkZXM2cyB3cm90
ZToNCg0KPiBIZWxsby4gIEkndmUgYmVlbiBmYWxsaW5nIG1vcmUgYW5kIG1vcmUgaW4gbG92ZSB3
aXRoIGdpdCBhbmQgSSB3YW50IHRvIG1vdmUNCj4gb3VyIGJpZ2dlc3QgcHJvamVjdCBiZWNhdXNl
IGl0IGlzIG15IGJpZ2dlc3QgcGFpbiBvdmVyIHRvIGdpdCB0byBtYWtlIG91cg0KPiBsaXZlcyBl
YXNpZXIuICBUaGUgcHJvYmxlbSBpcyBvdXIgcHJvamVjdCBpcyBhYm91dCA1MCBnaWdzIChBIGxv
dCBvZiBtZWRpYQ0KPiBmaWxlcyBpbnZvbHZlZCkuICBBbHNvLCB3ZSBnb3QgZGV2ZWxvcGVycyBh
bGwgb3ZlciB0aGUgd29ybGQgdGhhdCBhcmUNCj4gcnVubmluZyBvbiBzbG93IGNvbm5lY3Rpb25z
LiAgU29tZSB0b29rIGEgd2VlayB0byBnZXQgdGhlIHByb2plY3QgdXAgYW5kDQo+IHJ1bm5pbmcg
aW4gdGhlIGZpcnN0IHBsYWNlLiAgTHVja2lseSwgdGhleSBhcmUgb25seSBpc29sYXRlZCBpbnN0
YW5jZXMuIA0KPiBXaGF0IEknbSB3b25kZXJpbmcgaXMgY2FuIEkgaGF2ZSBhbGwgb2YgdGhlbSB0
dXJuIHRoZWlyIHByb2plY3RzIGludG8gZ2l0DQo+IHJlcG9zaXRvcmllcyBsb2NhbGx5IGFuZCBo
YXZlIGFsbCBvZiB0aGVtIHN5bmMgd2l0aCBhIG1hc3RlciByZXBvc2l0b3J5IG9uY2UNCj4gdGhl
eSBhcmUgZG9uZS4gIFRoZSBhY3R1YWwgcHJvamVjdCBpcyBvbmx5IGFib3V0IDUwMCBtZWdzIGFu
ZCB0aGUgY2hhbmdlcw0KPiBhcmUgcHJvYmFibHkgb25seSBhIGZldyBLIHNpbmNlIHRoZXkga2Vl
cCB0aGVpciBwcm9qZWN0cyB1cCB0byBkYXRlLCBzbw0KPiB0aGF0J3MgbW9yZSBhY2NlcHRhYmxl
LCBidXQgSSBkb24ndCB3YW50IHRoZW0gdG8gYnJpbmcgZG93biBhbGwgdGhvc2UgbWVkaWENCj4g
ZmlsZXMgYWdhaW4gYW5kIEkgZG91YnQgdGhleSB3aWxsIGJlIHdpbGxpbmcgdG8gZG8gaXQuICBJ
cyB0aGlzIHBvc3NpYmxlLA0KPiBhbmQgaG93IHdvdWxkIEkgZG8gaXQ/DQoNCkknbSBub3Qgc3Vy
ZSB5b3UgY2FuLiAiZ2l0IHN2biBjbG9uZSIgd2lsbCBnaXZlIGEgc3RhYmxlIGNvbW1pdCBJRCBp
bg0KZ2l0OyB0aGF0IGlzLCB0d28gcnVucyBvZiB0aGUgc2FtZSBpbXBvcnQgd2lsbCB5aWVsZCBp
bnRlcm9wZXJhYmxlIGdpdA0KcmVwb3NpdG9yaWVzLiBIb3dldmVyLCBJJ20gbm90IHN1cmUgaWYg
dGhhdCBpcyBhY3R1YWxseSB1c2VmdWwgdG8geW91Ow0KdGhlIHBlb3BsZSB3aXRoIHN2biBjaGVj
a291dHMgZG9uJ3QgX2hhdmVfIHRoZSBoaXN0b3J5LiBTbyB0aGUgY2xvbmUNCm9wZXJhdGlvbiB3
aWxsIGhhdmUgdG8gdGFsayB0byB0aGUgc2VydmVyLg0KDQpIb3dldmVyLCB5b3Ugc2hvdWxkIHJl
YWxseSBjb25zaWRlciB3aGV0aGVyIHlvdSB3YW50IHRob3NlIDUwRyBpbiB0aGUNCmdpdCByZXBv
c2l0b3J5IGF0IGFsbC4gR2l0IGlzIHByZXR0eSBnb29kIGF0IG5vdCBsb29raW5nIGF0IHBhcnRz
IG9mIHRoZQ0KcmVwb3NpdG9yeSB0aGF0IGFyZW4ndCBuZWNlc3NhcnkgdG8gYW4gb3BlcmF0aW9u
LCBidXQgd2hvbGUtcmVwb3NpdG9yeQ0Kb3BlcmF0aW9ucyBsaWtlIHBhY2tpbmcgYW5kIGNsb25p
bmcgYXJlIGdvaW5nIHRvIGJlIGFic3VyZGx5IHNsb3cuDQoNCkFyZSB0aG9zZSBmaWxlcyBhY3R1
YWxseSBjaGFuZ2luZz8gV291bGQgaXQgYmUgZmVhc2libGUgdG8gcHV0IHRoZQ0KIm1haW4iIHBh
cnQgb2YgdGhlIHByb2plY3QgaW4gZ2l0IGFuZCBqdXN0IGluY2x1ZGUgc29tZXRoaW5nIGxpa2UN
CnN5bWxpbmtzIGluIHRoZSByZXBvc2l0b3J5IHBvaW50aW5nIHRvIHlvdXIgbWVkaWE/IFRoZW4g
ZWFjaCBsb2NhbA0KZGV2ZWxvcGVyIGNvdWxkIGNsb25lIHRoZSBnaXQgcHJvamVjdCBhbmQganVz
dCBtb3ZlIHRoZWlyIGV4aXN0aW5nIDUwRw0Kb2YgbWVkaWEgZmlsZXMgaW50byBwbGFjZS4NCg0K
LVBlZmYNCg0K
