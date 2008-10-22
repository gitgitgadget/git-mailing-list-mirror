From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtin-blame: Reencode commit messages according
	to git-log rules.
Date: Wed, 22 Oct 2008 04:50:37 -0400
Message-ID: <20081022085036.GA1454@sigill.intra.peff.net>
References: <1224622557-6669-1-git-send-email-angavrilov@gmail.com> <20081022082016.GA18473@sigill.intra.peff.net> <bb6f213e0810220135hd520f78odb83414c248a15e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 10:51:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsZRb-0003S6-6y
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 10:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbYJVIum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 04:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYJVIum
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 04:50:42 -0400
Received: from peff.net ([208.65.91.99]:1047 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbYJVIul (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 04:50:41 -0400
Received: (qmail 31629 invoked by uid 111); 22 Oct 2008 08:50:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 22 Oct 2008 04:50:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 04:50:37 -0400
Content-Disposition: inline
In-Reply-To: <bb6f213e0810220135hd520f78odb83414c248a15e4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98850>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Oct 22, 2008 at 12:35:17PM +0400, Alexander Gavrilov wrote:

> > instead. Of course, I can't get your test to pass even with that change,
> > but I think that is just a broken iconv on Solaris.
> 
> Hm, which of the conversions fail? You can try manually converting the
> txt files with the iconv command to figure it out.

Test 2 fails for CP1251 and SJIS.  Manually converting with iconv seems
to work ok (at least, doing "iconv -f CP1251 -t UTF-8 cp1251.txt"
produces the same output as "cat utf8.txt".

The output from "t8005-blame-i18n.sh -v -i" is attached (as
application/octet-stream to protect it from email munging) if that is
helpful to you. I can't make heads or tails of it.

-Peff

--a8Wt8u1KmwUX3Y2C
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="t8005-output.txt"
Content-Transfer-Encoding: base64

SW5pdGlhbGl6ZWQgZW1wdHkgR2l0IHJlcG9zaXRvcnkgaW4gL3RtcC9naXRidWlsZC90L3Ry
YXNoIGRpcmVjdG9yeS50ODAwNS1ibGFtZS1pMThuLy5naXQvCiogZXhwZWN0aW5nIHN1Y2Nl
c3M6IAoJIyBDcmVhdGUgdGhlIGZpbGUKCWVjaG8gIlVURi04IExJTkUiID4gZmlsZSAmJgoJ
Z2l0IGFkZCBmaWxlICYmCglnaXQgY29tbWl0IC0tYXV0aG9yICIkVVRGOF9OQU1FIDx1dGY4
QGxvY2FsaG9zdD4iIC1tICIkVVRGOF9NU0ciICYmCgoJZWNobyAiQ1AxMjUxIExJTkUiID4+
IGZpbGUgJiYKCWdpdCBhZGQgZmlsZSAmJgoJZ2l0IGNvbmZpZyBpMThuLmNvbW1pdGVuY29k
aW5nIGNwMTI1MSAmJgoJZ2l0IGNvbW1pdCAtLWF1dGhvciAiJENQMTI1MV9OQU1FIDxjcDEy
NTFAbG9jYWxob3N0PiIgLW0gIiRDUDEyNTFfTVNHIiAmJgoKCWVjaG8gIlNKSVMgTElORSIg
Pj4gZmlsZSAmJgoJZ2l0IGFkZCBmaWxlICYmCglnaXQgY29uZmlnIGkxOG4uY29tbWl0ZW5j
b2Rpbmcgc2hpZnQtamlzICYmCglnaXQgY29tbWl0IC0tYXV0aG9yICIkU0pJU19OQU1FIDxz
amlzQGxvY2FsaG9zdD4iIC1tICIkU0pJU19NU0ciCgpbbWFzdGVyIChyb290LWNvbW1pdCld
OiBjcmVhdGVkIDAwNzZjZGU6ICLQotC10YHRgtC+0LLQvtC1INGB0L7QvtCx0YnQtdC90LjQ
tSIKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGZpbGUKW21hc3Rlcl06IGNyZWF0ZWQgOGM0YzY2NDogItLl
8fLu4u7lIPHu7uH55e3o5SIKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAw
IGRlbGV0aW9ucygtKQpbbWFzdGVyXTogY3JlYXRlZCAwYTM2NjkwOiAihFOEdYSDhISEgIRy
hICEdSCEg4SAhICEcYSLhHWEfoR5hHUiCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
cygrKSwgMCBkZWxldGlvbnMoLSkKKiAgIG9rIDE6IHNldHVwIHRoZSByZXBvc2l0b3J5Cgoq
IGV4cGVjdGluZyBzdWNjZXNzOiAKCWdpdCBibGFtZSAtLWluY3JlbWVudGFsIGZpbGUgfCBc
CgkJZWdyZXAgIl4oYXV0aG9yfHN1bW1hcnkpICIgPiBhY3R1YWwgJiYKCXRlc3RfY21wIGFj
dHVhbCBleHBlY3RlZAoKZGlmZiAtLWdpdCBhL2FjdHVhbCBiL2V4cGVjdGVkCmluZGV4IDMx
Y2M0YzQuLmQxZGNjYWYgMTAwNjQ0Ci0tLSBhL2FjdHVhbAorKysgYi9leHBlY3RlZApAQCAt
MSw2ICsxLDYgQEAKIGF1dGhvciCESYRyhHCEfiCEUIR1hISEgoSAhHKEeYSJIIRShHmEdISA
hIKEgIRyCiBzdW1tYXJ5IIRThHWEg4SEhICEcoSAhHUghIOEgISAhHGEi4R1hH6EeYR1Ci1h
dXRob3IgyOLg7SDP5fLw7uLo9yDR6OTu8O7iCi1zdW1tYXJ5INLl8fLu4u7lIPHu7uH55e3o
5QotYXV0aG9yINCY0LLQsNC9INCf0LXRgtGA0L7QstC40Ycg0KHQuNC00L7RgNC+0LIKLXN1
bW1hcnkg0KLQtdGB0YLQvtCy0L7QtSDRgdC+0L7QsdGJ0LXQvdC40LUKK2F1dGhvciCESYRy
hHCEfiCEUIR1hISEgoSAhHKEeYSJIIRShHmEdISAhIKEgIRyCitzdW1tYXJ5IIRThHWEg4SE
hICEcoSAhHUghIOEgISAhHGEi4R1hH6EeYR1CithdXRob3IghEmEcoRwhH4ghFCEdYSEhIKE
gIRyhHmEiSCEUoR5hHSEgISChICEcgorc3VtbWFyeSCEU4R1hIOEhISAhHKEgIR1IISDhICE
gIRxhIuEdYR+hHmEdQoqIEZBSUwgMjogYmxhbWUgcmVzcGVjdHMgaTE4bi5jb21taXRlbmNv
ZGluZwoJCgkJZ2l0IGJsYW1lIC0taW5jcmVtZW50YWwgZmlsZSB8IFwKCQkJZWdyZXAgIl4o
YXV0aG9yfHN1bW1hcnkpICIgPiBhY3R1YWwgJiYKCQl0ZXN0X2NtcCBhY3R1YWwgZXhwZWN0
ZWQKCQo=

--a8Wt8u1KmwUX3Y2C--
