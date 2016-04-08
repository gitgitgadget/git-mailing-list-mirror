From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jkt@kde.org>
Subject: [PATCH] log: allow --graph and --show-linear-break used together
Date: Fri, 08 Apr 2016 13:21:07 +0200
Organization: KDE
Message-ID: <3305f7dc-0044-41fe-8aab-ee800535d6e9@kde.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="trojita=_b5aa5f27-30e3-4a00-a5a7-b3db84f3b64f"
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 08 13:28:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoUa7-0001M6-Qj
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 13:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758218AbcDHL1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 07:27:46 -0400
Received: from latimerie.flaska.net ([46.28.111.182]:50984 "EHLO
	latimerie.flaska.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567AbcDHL1p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 07:27:45 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Apr 2016 07:27:44 EDT
Received: by latimerie.flaska.net (Postfix, from userid 1000)
	id EA5CC630B3; Fri,  8 Apr 2016 13:21:06 +0200 (CEST)
User-Agent: Trojita/v0.6-160-g874a773; Qt/5.6.1; xcb; Linux; 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291023>

This is a multipart/mixed message in MIME format.

--trojita=_b5aa5f27-30e3-4a00-a5a7-b3db84f3b64f
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,
this patch makes it possible to use --show-linear-break in `git log --graph=20=

--oneline --all`.

(Please Cc me on replies, I'm not subscribed to the Git ML.)

Cheers,
Jan

--=20
Trojit=C3=A1, a fast Qt IMAP e-mail client -- http://trojita.flaska.net/
--trojita=_b5aa5f27-30e3-4a00-a5a7-b3db84f3b64f
Content-Type: text/x-patch
Content-Disposition: inline;
	filename=0001-log-allow-graph-and-show-linear-break-used-together.patch
Content-Transfer-Encoding: base64

RnJvbSAxYWM2YmI3YzMxNjUyODM1ZDNkMDQ2YzgyZTQyM2YwY2VhNmUwOTA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/SmFuPTIwS3VuZHI9QzM9QTF0Pz0gPGprdEBr
ZGUub3JnPgpEYXRlOiBGcmksIDggQXByIDIwMTYgMTM6MDY6MzEgKzAyMDAKU3ViamVjdDogW1BB
VENIXSBsb2c6IGFsbG93IC0tZ3JhcGggYW5kIC0tc2hvdy1saW5lYXItYnJlYWsgdXNlZCB0b2dl
dGhlcgpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9
VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKVGhlcmUgd2FzIG5vIHZpc3Vh
bCBicmVhayB3aGVuIC0tZ3JhcGggLS1vbmVsaW5lIHdhcyB1c2VkIHdpdGggc2V2ZXJhbApoaXN0
b3J5IHRyZWVzIHdpdGggZGlzam9pbnQgcGFyZW50cy4KClRoZSBvcmlnaW5hbCByZWFzb25pbmcg
Z2l2ZW4gaW4gY29tbWl0IDFiMzJkZWNlZiB3YXMgcHJvYmFibHkgdGhhdCBhCmdyYXBoIGFscmVh
ZHkgY29udmV5cyBlbm91Z2ggaW5mb3JtYXRpb24gdG8gaW5kaWNhdGUgdGhhdCB0aGVyZSdzIG5v
CnBhcmVudC1jaGlsZCByZWxhdGlvbiBiZXR3ZWVuIHRoZXNlIHR3byBjb21taXRzLiBIb3dldmVy
LCB0aGlzIGlzIG5vdAp0aGUgY2FzZSB3aGVuIGEgc2luZ2xlLWxpbmUgcHJldHRpZmljYXRpb24g
b2YgYSBsb2cgaXMgdXNlZCwgaW4gd2hpY2gKY2FzZSB0aGUgY29tbWl0cyBhcmUgZGlzcGxheWVk
IG9uIHRvcCBvZiBlYWNoIG90aGVyIHdpdGggbm8gc3BhY2UgZm9yCnRoYXQgZ3JhcGggbGluZSB0
byBzaG93IHRoZSBzZXBhcmF0aW9uLgoKSXQgbWlnaHQgYmUgaW50ZXJlc3RpbmcgdG8gY2hhbmdl
IHRoZSBhY3R1YWwgcHJpbnRpbmcgb2YgdGhlIGJyZWFrX2Jhcgp0byBwcmludCBmZXdlciBsaW5l
IGJyZWFrcywgYnV0IHRoaXMgc2ltcGxlIGFwcHJvYWNoIHdvcmtzIGFuZCBpcyBJTUhPCm5vdCB0
aGF0IGJhZCB2aXN1YWxseSwgYW55d2F5LgoKU2lnbmVkLW9mZi1ieTogSmFuIEt1bmRyw6F0IDxq
a3RAa2RlLm9yZz4KLS0tCiBEb2N1bWVudGF0aW9uL3Jldi1saXN0LW9wdGlvbnMudHh0IHwgNSAr
KystLQogcmV2aXNpb24uYyAgICAgICAgICAgICAgICAgICAgICAgICB8IDQgKystLQogMiBmaWxl
cyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9yZXYtbGlzdC1vcHRpb25zLnR4dCBiL0RvY3VtZW50YXRpb24vcmV2LWxp
c3Qtb3B0aW9ucy50eHQKaW5kZXggNGYwMDlkNC4uYzVlNDg3YyAxMDA2NDQKLS0tIGEvRG9jdW1l
bnRhdGlvbi9yZXYtbGlzdC1vcHRpb25zLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL3Jldi1saXN0
LW9wdGlvbnMudHh0CkBAIC04MDcsOCArODA3LDkgQEAgVGhpcyBpbXBsaWVzIHRoZSBgLS10b3Bv
LW9yZGVyYCBvcHRpb24gYnkgZGVmYXVsdCwgYnV0IHRoZQogYC0tZGF0ZS1vcmRlcmAgb3B0aW9u
IG1heSBhbHNvIGJlIHNwZWNpZmllZC4KIAogLS1zaG93LWxpbmVhci1icmVha1s9PGJhcnJpZXI+
XTo6Ci0JV2hlbiAtLWdyYXBoIGlzIG5vdCB1c2VkLCBhbGwgaGlzdG9yeSBicmFuY2hlcyBhcmUg
ZmxhdHRlbmVkCi0Jd2hpY2ggY2FuIG1ha2UgaXQgaGFyZCB0byBzZWUgdGhhdCB0aGUgdHdvIGNv
bnNlY3V0aXZlIGNvbW1pdHMKKwlJZiB0aGUgaGlzdG9yeSBpcyBmbGF0dGVuZWQsIHN1Y2ggYXMg
d2hlbiAtLWdyYXBoIGlzIG5vdCB1c2VkCisJb3IgaWYgLS1ncmFwaCBpcyBjb21iaW5lZCB3aXRo
IC0tb25lbGluZSB0byBwcm9kdWNlIGEgY29tcGFjdAorCXZpZXcsIGl0IGNhbiBiZSBoYXJkIHRv
IHNlZSB0aGF0IHRoZSB0d28gY29uc2VjdXRpdmUgY29tbWl0cwogCWRvIG5vdCBiZWxvbmcgdG8g
YSBsaW5lYXIgYnJhbmNoLiBUaGlzIG9wdGlvbiBwdXRzIGEgYmFycmllcgogCWluIGJldHdlZW4g
dGhlbSBpbiB0aGF0IGNhc2UuIElmIGA8YmFycmllcj5gIGlzIHNwZWNpZmllZCwgaXQKIAlpcyB0
aGUgc3RyaW5nIHRoYXQgd2lsbCBiZSBzaG93biBpbnN0ZWFkIG9mIHRoZSBkZWZhdWx0IG9uZS4K
ZGlmZiAtLWdpdCBhL3JldmlzaW9uLmMgYi9yZXZpc2lvbi5jCmluZGV4IDhiMmRmZTMuLjgwOWM0
M2UgMTAwNjQ0Ci0tLSBhL3JldmlzaW9uLmMKKysrIGIvcmV2aXNpb24uYwpAQCAtMTg2NCw2ICsx
ODY0LDggQEAgc3RhdGljIGludCBoYW5kbGVfcmV2aXNpb25fb3B0KHN0cnVjdCByZXZfaW5mbyAq
cmV2cywgaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmcKIAkJICAgc3RhcnRzX3dpdGgoYXJnLCAi
LS1zaG93LWxpbmVhci1icmVhaz0iKSkgewogCQlpZiAoc3RhcnRzX3dpdGgoYXJnLCAiLS1zaG93
LWxpbmVhci1icmVhaz0iKSkKIAkJCXJldnMtPmJyZWFrX2JhciA9IHhzdHJkdXAoYXJnICsgMjAp
OworCQllbHNlIGlmIChyZXZzLT5ncmFwaCkKKwkJCXJldnMtPmJyZWFrX2JhciA9ICIgIC4uLi4u
Li4uLi5cbiI7CiAJCWVsc2UKIAkJCXJldnMtPmJyZWFrX2JhciA9ICIgICAgICAgICAgICAgICAg
ICAgIC4uLi4uLi4uLi4iOwogCQlyZXZzLT50cmFja19saW5lYXIgPSAxOwpAQCAtMTk5Myw4ICsx
OTk1LDYgQEAgc3RhdGljIGludCBoYW5kbGVfcmV2aXNpb25fb3B0KHN0cnVjdCByZXZfaW5mbyAq
cmV2cywgaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmcKIAkJCXVua3ZbKCp1bmtjKSsrXSA9IGFy
ZzsKIAkJcmV0dXJuIG9wdHM7CiAJfQotCWlmIChyZXZzLT5ncmFwaCAmJiByZXZzLT50cmFja19s
aW5lYXIpCi0JCWRpZSgiLS1zaG93LWxpbmVhci1icmVhayBhbmQgLS1ncmFwaCBhcmUgaW5jb21w
YXRpYmxlIik7CiAKIAlyZXR1cm4gMTsKIH0KLS0gCjIuNy4zCgo=

--trojita=_b5aa5f27-30e3-4a00-a5a7-b3db84f3b64f--
