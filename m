From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 2/2] git-gui: support for diff3 conflict style
Date: Sun, 27 Feb 2011 21:15:18 +0100
Message-ID: <AANLkTin4-1_bNuH2kQ0m6wpevnO5uCJUmLvy=gP4mLfH@mail.gmail.com>
References: <1289899312-2732-1-git-send-email-bert.wesarg@googlemail.com>
	<1289899618-2845-1-git-send-email-bert.wesarg@googlemail.com>
	<87fwuxh75m.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Feb 27 21:15:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptn1d-0002gk-1p
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 21:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746Ab1B0UPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 15:15:21 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45795 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab1B0UPU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 15:15:20 -0500
Received: by wwb22 with SMTP id 22so2311946wwb.1
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 12:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sFvHQYU8a7FpGgeXLn6d63z8UjFlTcP+r6M3JBQbBlY=;
        b=VJ/qy20R6aBEG2aFeLicmMp39hANI0ZjSESHe0o8MnPj0trNqr39DhhmMrweSzsc/S
         dkqx+vDd9bEjWN/Jkv5NuMHgYJOEghEJODSD2GS18LYAW1et+FipSKlUvvKvUsoHrWD8
         +L8SazwvgUZ/kAgnfWttxtgyi1gZyu1KBqHc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jW8EV7hO70QoK+wgKazsyPJD0JQ9g+qDFCPRnDY1bR736QcAEIbCOKM6fcif/Ap2l/
         cmzWzaKCFQGZ38nTJVSlpWgHZlkzoe8f+3gpkOkhf5O46qZyPTT77lhRhtCeW2Fc+oRq
         Mmahhkk04DPppE2u1vVaeltnUrZH/GZrTrTYM=
Received: by 10.227.157.1 with SMTP id z1mr4245881wbw.23.1298837718679; Sun,
 27 Feb 2011 12:15:18 -0800 (PST)
Received: by 10.227.132.137 with HTTP; Sun, 27 Feb 2011 12:15:18 -0800 (PST)
In-Reply-To: <87fwuxh75m.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168053>

T24gRnJpLCBOb3YgMTksIDIwMTAgYXQgMTI6NDEsIFBhdCBUaG95dHMKPHBhdHRob3l0c0B1c2Vy
cy5zb3VyY2Vmb3JnZS5uZXQ+IHdyb3RlOgo+IEJlcnQgV2VzYXJnIDxiZXJ0Lndlc2FyZ0Bnb29n
bGVtYWlsLmNvbT4gd3JpdGVzOgo+Cj4+VGhpcyBhZGRzIGhpZ2hsaWdodCBzdXBwb3J0IGZvciB0
aGUgZGlmZjMgY29uZmxpY3Qgc3R5bGUuCj4+Cj4+VGhlIGNvbW1vbiBwcmUtaW1hZ2Ugd2lsbCBi
ZSByZXZlcnNlZCB0byAtLSwgYmVjYXVzZSBpdCBoYXMgYmVlbiByZW1vdmVkCj4+YW5kIGVpdGhl
ciByZXBsYWNlZCB3aXRoIG91ciBvciB0aGVpciBzaWRlLgo+Pgo+PlNpZ25lZC1vZmYtYnk6IEJl
cnQgV2VzYXJnIDxiZXJ0Lndlc2FyZ0Bnb29nbGVtYWlsLmNvbT4KPj4KPj4tLS0KPj4gZ2l0LWd1
aS9naXQtZ3VpLnNoIMKgIHwgwqAgwqAzICsrKwo+PiBnaXQtZ3VpL2xpYi9kaWZmLnRjbCB8IMKg
IDEwICsrKysrKysrKysKPj4gMiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQo+Pgo+PmRpZmYgLS1naXQgYS9naXQtZ3VpL2dpdC1ndWkuc2ggYi9naXQtZ3Vp
L2dpdC1ndWkuc2gKPj5pbmRleCAzODM2MmZhLi4wMTM0NDM4IDEwMDc1NQo+Pi0tLSBhL2dpdC1n
dWkvZ2l0LWd1aS5zaAo+PisrKyBiL2dpdC1ndWkvZ2l0LWd1aS5zaAo+PkBAIC0zMzU0LDYgKzMz
NTQsOSBAQCAkdWlfZGlmZiB0YWcgY29uZiBkX3MtIFwKPj4gJHVpX2RpZmYgdGFnIGNvbmYgZDwg
XAo+PiDCoCDCoCDCoCAtZm9yZWdyb3VuZCBvcmFuZ2UgXAo+PiDCoCDCoCDCoCAtZm9udCBmb250
X2RpZmZib2xkCj4+KyR1aV9kaWZmIHRhZyBjb25mIGR8IFwKPj4rIMKgIMKgIMKgLWZvcmVncm91
bmQgb3JhbmdlIFwKPj4rIMKgIMKgIMKgLWZvbnQgZm9udF9kaWZmYm9sZAo+PiAkdWlfZGlmZiB0
YWcgY29uZiBkPSBcCj4+IMKgIMKgIMKgIC1mb3JlZ3JvdW5kIG9yYW5nZSBcCj4+IMKgIMKgIMKg
IC1mb250IGZvbnRfZGlmZmJvbGQKPj5kaWZmIC0tZ2l0IGEvZ2l0LWd1aS9saWIvZGlmZi50Y2wg
Yi9naXQtZ3VpL2xpYi9kaWZmLnRjbAo+PmluZGV4IGQ0ZTJjZTMuLmNjZDRjNzAgMTAwNjQ0Cj4+
LS0tIGEvZ2l0LWd1aS9saWIvZGlmZi50Y2wKPj4rKysgYi9naXQtZ3VpL2xpYi9kaWZmLnRjbAo+
PkBAIC0zMzksNiArMzM5LDcgQEAgcHJvYyBzdGFydF9zaG93X2RpZmYge2NvbnRfaW5mbyB7YWRk
X29wdHMge319fSB7Cj4+IMKgIMKgIMKgIH0KPj4KPj4gwqAgwqAgwqAgc2V0IDo6Y3VycmVudF9k
aWZmX2luaGVhZGVyIDEKPj4rIMKgIMKgIMKgc2V0IDo6aW5fY29uZmxpY3RfcHJlX2ltYWdlIDAK
Pj4gwqAgwqAgwqAgZmNvbmZpZ3VyZSAkZmQgXAo+PiDCoCDCoCDCoCDCoCDCoCDCoCDCoCAtYmxv
Y2tpbmcgMCBcCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIC1lbmNvZGluZyBbZ2V0X3BhdGhfZW5j
b2RpbmcgJHBhdGhdIFwKPj5AQCAtNDIwLDYgKzQyMSwxNSBAQCBwcm9jIHJlYWRfZGlmZiB7ZmQg
Y29uZmxpY3Rfc2l6ZSBjb250X2luZm99IHsKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc2V0IGlzX2NvbmZsaWN0X2RpZmYgMQo+PiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBz
ZXQgbGluZSBbc3RyaW5nIHJlcGxhY2UgJGxpbmUgMCAxIHsgwqB9XQo+PiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzZXQgdGFncyBkJG9w
Cj4+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHNldCA6OmluX2NvbmZsaWN0X3ByZV9pbWFnZSAwCj4+KyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZWlmIHtbcmVnZXhwIHteXCtcK1x8eyRjb25m
bGljdF9zaXplfSg/OiB8JCl9ICRsaW5lXX0gewo+PisgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZXQgaXNfY29uZmxpY3RfZGlmZiAxCj4+
KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oHNldCBsaW5lIFtzdHJpbmcgcmVwbGFjZSAkbGluZSAwIDEgeyDCoH1dCj4+KyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNldCB0YWdzIGR8
Cj4+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoHNldCA6OmluX2NvbmZsaWN0X3ByZV9pbWFnZSAxCj4+KyDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoH0gZWxzZWlmICgkOjppbl9jb25mbGljdF9wcmVfaW1h
Z2UpIHsKPj4rIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc2V0IGxpbmUgW3N0cmluZyByZXBsYWNlICRsaW5lIDAgMSB7LS19XQo+PisgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzZXQg
dGFncyBkXy0tCj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IH0gZWxzZSB7Cj4+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHNldCB0YWdzIGRfKysKPj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgfQo+Cj4gVGhpcyBoYXMgdGhlIHNhbWUgaXNzdWUgYXMgdGhlIGxh
c3QgcGF0Y2ggd2l0aCB2YXJpYWJsZSBzdWJzdGl0dXRpb24KPiBpbnRvIHRoZSByZWdleHAuIFJl
cGxhY2VkIHRoZSByZWdleHAgZXhwcmVzc2lvbiB3aXRoCj4gwqAgW3JlZ2V4cCAiXlxcK1xcK1xc
fHskY29uZmxpY3Rfc2l6ZX0oPzogfFwkKSIgJGxpbmVdCj4KPiBJIGNvbmZpZ3VyZWQgYSB0ZXN0
IHJlcG9zaXRvcnkgd2l0aAo+ICdtZXJnZS5jb25mbGljdHN0eWxlIGRpZmYzJyBhbmQgY291bGQg
dGVzdCB0aGlzLiBMb29rcyBmaW5lLgoKSSBtaXNzIHRoaXMgb25lIGluIGdpdC1ndWkuZ2l0CgpU
aGFua3MsCkJlcnQKCj4gLS0KPiBQYXQgVGhveXRzIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaHR0cDovL3d3dy5wYXR0aG95dHMudGsvCj4gUEdQIGZpbmdlcnByaW50
IDJDIDZFIDk4IDA3IDJDIDU5IEM4IDk3IMKgMTAgQ0UgMTEgRTYgMDQgRTAgQjkgREQKPgo=
