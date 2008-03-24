From: "Timothy Schaeffer" <tschaeffer@dramail.com>
Subject: Symbolic links create dirty state from git.
Date: Mon, 24 Mar 2008 17:28:29 -0400
Message-ID: <138905EB75AB0D44B6A0ECD251A92EA79C2D67@sdra00198.intranet.dra-inc.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 22:29:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JduED-0006j8-29
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 22:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbYCXV2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 17:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752825AbYCXV2a
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 17:28:30 -0400
Received: from dramail.com ([66.195.237.160]:5265 "EHLO
	sdra00198.intranet.dra-inc.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750781AbYCXV2a (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 17:28:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Symbolic links create dirty state from git.
Thread-Index: AciN9gB4PruZ8PnpEdxLngAb/CT+FA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78101>

SGVsbG8sDQoNCkkgY2xvbmVkIGEgcmVwbyBmcm9tIGFub3RoZXIgd2l0aCBzeW1ib2xpYyBsaW5r
cy4gIE5vdyB0aGUgc3ltYm9saWMgbGlua3MgDQphcHBlYXIgYXMgbW9kaWZpZWQgZmlsZXMsIGFu
ZCBub3IgcmVzZXR0aW5nLCBub3IgY29tbWl0dGluZywgbm9yIGlnbm9yaW5nLCANCm5vciBgcm0g
LS1jYWNoZWBpbmcgd2lsbCB0YWtlIHRoZW0gb3V0IG9mIHRoZWlyIGRpcnR5IHN0YXRlLiAgDQoN
CklmIEkgdHJ5IHRvIGNvbW1pdCB0aGVtLCBJIGdldA0KDQplcnJvcjogcmVhZGxpbmsoImxpYi9z
eXN0ZW1zL2FzZGYtc3lzdGVtLWNvbm5lY3Rpb25zLmFzZCIpOiBJbnZhbGlkIGFyZ3VtZW50DQpm
YXRhbDogdW5hYmxlIHRvIGluZGV4IGZpbGUgbGliL3N5c3RlbXMvYXNkZi1zeXN0ZW0tY29ubmVj
dGlvbnMuYXNkDQoNClRoZSBsaW5rLCBob3dldmVyLCBpcyBmaW5lOiBpdCBwb2ludHMgdG8gYSB2
YWxpZCwgZXhpc3RpbmcgZmlsZSwgd2hpY2ggSSBjYW4gDQpyZWFkIHRocm91Z2ggdGhlIGxpbmsu
ICBJdCBpcyBhIHJlbGF0aXZlIGxpbmsgcG9pbnRpbmcgdG8gYW5vdGhlciBmaWxlIHdoaWNoDQpp
cyBhbHNvIHRyYWNrZWQgYnkgdGhlIHJlcG8uICBUaGUgbGlua3MgaGF2ZSBub3QgY2hhbmdlZC4N
Cg0KSSBoYXZlIGFkZGVkIHRoZXNlIGZpbGVzIHRvIC5naXRpZ25vcmUsIGJ1dCBnaXQgZG9lc24n
dC4NCg0KSSBjYW4gc3dpdGNoIHRvIGFub3RoZXIgYnJhbmNoIHdpdGggcmVndWxhciBnaXQtY2hl
Y2tvdXQgPGJyYW5jaD4sIGFuZCB0aGVzZSANCm5vIGxvbmdlciBhcHBlYXIgaW4gdGhlIGluZGV4
IHdoaWxlIGluIHRoYXQgYnJhbmNoLiBXaGVuIEkgc3dpdGNoIGJhY2ssIHRoZXkNCnNob3cgdXAg
YWdhaW4uDQoNCldoZW4gSSBsb29rIGF0IHRoZXNlIGluIGdpdC1ndWksIGl0IHRlbGxzIG1lIHRo
YXQgaXQgY2FuIGZpbmQgbm8gZGlmZmVyZW5jZXMsDQphbmQgdHJpZXMgdG8gcmVtb3ZlIGl0IGZy
b20gdGhlbSBpbmRleCwgYnV0IGl0IHBvcHMgcmlnaHQgYmFjayBpbnRvIA0KIlVuc3RhZ2VkIENo
YW5nZXMiLg0KDQpUaGUgdGltZXMgb24gYWxsIG9mIHRoZSBzeW1saW5rcyBhcmUgdG9kYXkncy4g
IElzIHRoaXMgd2h5IGdpdCB0aGlua3MgdGhleSBoYXZlDQpjaGFuZ2VkPw0KDQpOb3csIEknbSBz
dHVjay4gIENhbiBhbnlvbmUgdGVsbCBtZSBob3cgSSBtaWdodCBnZXQgdGhlc2Ugb3V0IG9mIHRo
ZSB3YXk/DQoNCmdpdCB2ZXJzaW9uIDEuNS40LnJjMi40MTcuZzNkNTFlDQpMaW51eCBkcmEwMDU5
NCAyLjYuMjAtMTYtZ2VuZXJpYyAjMiBTTVAgVHVlIEZlYiAxMiAwNTo0MTozNCBVVEMgMjAwOCBp
Njg2IEdOVS9MaW51eA0KDQoNClRoYW5rcywNCg0KVGltIFMuDQo=
