From: =?ISO-8859-1?Q?G=E1bor_Szeder?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/5] git-prompt: do not look for refs/stash in $GIT_DIR
Date: Sun, 24 Aug 2014 20:22:41 +0700
Message-ID: <E1XLXkh-0002sL-IJ@iramx2.ira.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 24 15:39:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLY1L-0003bj-EW
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 15:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650AbaHXNj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 09:39:26 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:41499 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752573AbaHXNjZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Aug 2014 09:39:25 -0400
X-Greylist: delayed 981 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Aug 2014 09:39:24 EDT
Received: from [217.118.79.43] (helo=[192.168.43.124])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1XLXkh-0002sL-IJ; Sun, 24 Aug 2014 15:22:47 +0200
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1408886567.
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1408887550.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255790>

SGksCgpPbiBBdWcgMjMsIDIwMTQgMTI6MjYgUE0sIEplZmYgS2luZyA8cGVmZkBwZWZmLm5ldD4g
d3JvdGU6Cj4gU2luY2UgZGQwYjcyYyAoYmFzaCBwcm9tcHQ6IHVzZSBiYXNoIGJ1aWx0aW5zIHRv
IGNoZWNrIHN0YXNoIAo+IHN0YXRlLCAyMDExLTA0LTAxKSwgZ2l0LXByb21wdCBjaGVja3Mgd2hl
dGhlciB3ZSBoYXZlIGEgCj4gc3Rhc2ggYnkgbG9va2luZyBmb3IgJEdJVF9ESVIvcmVmcy9zdGFz
aC4gR2VuZXJhbGx5IGV4dGVybmFsIAo+IHByb2dyYW1zIHNob3VsZCBuZXZlciBkbyB0aGlzLCBi
ZWNhdXNlIHRoZXkgd291bGQgbWlzcyAKPiBwYWNrZWQtcmVmcy4KCk5vdCBzdXJlIHdoZXRoZXIg
dGhlIHByb21wdCBzY3JpcHQgaXMgZXh0ZXJuYWwgcHJvZ3JhbSBvciBub3QsIGJ1dCBkb2Vzbid0
IG1hdHRlciwgdGhpcyBpcyB0aGUgcmlnaHQgdGhpbmcgdG8gZG8uCgo+IFRoYXQgY29tbWl0IGNs
YWltcyB0aGF0IHBhY2tlZC1yZWZzIGRvZXMgbm90IHBhY2sgCj4gcmVmcy9zdGFzaCwgYnV0IHRo
YXQgaXMgbm90IHF1aXRlIHRydWUuIEl0IGRvZXMgcGFjayB0aGUgCj4gcmVmLCBidXQgZHVlIHRv
IGEgYnVnLCBmYWlscyB0byBwcnVuZSB0aGUgcmVmLiBXaGVuIHdlIGZpeCAKPiB0aGF0IGJ1Zywg
d2Ugd291bGQgd2FudCB0byBiZSBkb2luZyB0aGUgcmlnaHQgdGhpbmcgaGVyZS4gCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBKZWZmIEtpbmcgPHBlZmZAcGVmZi5uZXQ+IAo+IC0tLSAKPiBJIGtub3cgd2Ug
YXJlIHByZXR0eSBzZW5zaXRpdmUgdG8gZm9ya3MgaW4gdGhlIHByb21wdCBjb2RlIChhZnRlciBh
bGwsIAo+IHRoYXQgd2FzIHRoZSBwb2ludCBvZiBkZDBiNzJjKS4gVGhpcyBwYXRjaCBpcyBlc3Nl
bnRpYWxseSBhIHJldmVyc2lvbiBvZiAKPiB0aGlzIGh1bmsgb2YgZGQwYjcyYywgYW5kIGlzIGRl
ZmluaXRlbHkgc2FmZS4KCkknbSBub3Qgc3VyZSwgYnV0IGlmIEkgcmVtZW1iZXIgY29ycmVjdGx5
IChkb24ndCBoYXZlIHRoZSBtZWFucyB0byBjaGVjayBpdCBhdCB0aGUgbW9tZW50LCBzb3JyeSkg
aW4gdGhhdCBjb21taXQgSSBhbHNvIGFkZGVkIGEgJ2dpdCBwYWNrLXJlZicgaW52b2NhdGlvbiB0
byB0aGUgcmVsZXZhbnQgdGVzdChzPykgdG8gZ3VhcmQgdXMgYWdhaW5zdCBicmVha2FnZXMgZHVl
IHRvIGNoYW5nZXMgaW4gJ2dpdCBwYWNrLXJlZnMnLsKgIElmIHRoYXQgaXMgc28sIHRoZW4gSSB0
aGluayB0aG9zZSBpbnZvY2F0aW9ucyBzaG91bGQgYmUgcmVtb3ZlZCBhcyB3ZWxsLCBhcyB0aGV5
J2xsIGJlY29tZSB1c2VsZXNzLgoKQmVzdCwKR8OhYm9y
