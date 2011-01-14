From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] handle rename of case only, for windows
Date: Fri, 14 Jan 2011 21:17:27 +0700
Message-ID: <AANLkTinbnYzTqP5-vA4hJqSgSBBjJrx8LCsq5G3nVmFW@mail.gmail.com>
References: <1295012644.7883.1415296115@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: Tim Abell <tim@timwise.co.uk>
X-From: git-owner@vger.kernel.org Fri Jan 14 15:20:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdkWN-000234-F9
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 15:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757902Ab1ANOUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 09:20:35 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61046 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849Ab1ANOTk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 09:19:40 -0500
Received: by wyb28 with SMTP id 28so2865738wyb.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 06:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=GhSDIXDhQXGgrvMePW4avSz4NTuRxi7kDKxf8of+vD4=;
        b=hCDQE2rb7viPUu+xXXZV0GFIK9iu7xCroD5VVHCY3kgAzD/00oxavtMtbGWiPKs9VR
         snZvFI/g4UXp2SMk5Yme1b2nbvxQjWqV5HVv5+wbjWSAmjMuFoAVixY6oEb20Pt8uy7t
         CJ2kjn8lBnTi9Q2F9Jfp3AFrnqcfIuC8pfJHs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qV/Nw6mc7/SGR55D7iw6iymdq+JP9p8wmtHYagKlF0x7IxkMsAQUiKLjd3o7azq1WX
         PA2F3hojatmCPPYMN4JssobTE32WYK/KsP2cp0xEawgJFzcP0VlYBHgcQxEMDES09qZG
         6jZa7emgMns9YA3tHuId3RxJg4xWwBiOP81Pk=
Received: by 10.216.52.134 with SMTP id e6mr635854wec.49.1295014779071; Fri,
 14 Jan 2011 06:19:39 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Fri, 14 Jan 2011 06:17:27 -0800 (PST)
In-Reply-To: <1295012644.7883.1415296115@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165102>

T24gRnJpLCBKYW4gMTQsIDIwMTEgYXQgODo0NCBQTSwgVGltIEFiZWxsIDx0aW1AdGltd2lzZS5j
by51az4gd3JvdGU6Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBlbHNlIGlmIChsc3RhdChkc3Qs
ICZzdCkgPT0gMCkgewo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYmFkID0g
ImRlc3RpbmF0aW9uIGV4aXN0cyI7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCBpZiAoZm9yY2UpIHsKPiAtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIC8qCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCogb25seSBmaWxlcyBjYW4gb3ZlcndyaXRlIGVhY2ggb3RoZXI6Cj4gLSDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCogY2hlY2sgYm90aCBzb3VyY2Ug
YW5kIGRlc3RpbmF0aW9uCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCovCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBpZiAoU19JU1JFRyhzdC5zdF9tb2RlKSB8fCBTX0lTTE5LKHN0LnN0X21vZGUpKSB7Cj4g
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCB3YXJuaW5nKCIlczsgd2lsbCBvdmVyd3JpdGUhIiwgYmFkKTsKPiAtIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGJhZCA9IE5VTEw7Cj4g
LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB9IGVsc2UKPiAt
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IGJhZCA9ICJDYW5ub3Qgb3ZlcndyaXRlIjsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIC8qIElmIHdlIGFyZSBvbiBhIGNhc2UgaW5zZW5zaXRpdmUgZmlsZXM9IHN5c3RlbSAo
d2luZG93cykgaHR0cDovL2lzLmdkL2t5eGdnCj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCogYW5kIHdlIGFyZSBvbmx5IGNoYW5naW5nIHRoZSBjYXNlIG9mIHRoZSBmaWxl
IHRoZW4gbHN0YXQgZm9yIHRoZQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAqIGRlc3RpbmF0aW9uIHdpbGwgcmV0dXJuICE9IDAgYmVjYXVzZSBpdCBzZWVzIHRoZSBzb3Vy
Y2UgZmlsZS4KPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBUbyBwcmV2
ZW50IHRoaXMgY2F1c2luZyBmYWlsdXJlLCBsc3RhdCBpcyB1c2VkIHRvIGdldCB0aGUgaW5vZGUg
b2YgdGhlIHNyYwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIGFuZCBz
ZWUgaWYgaXQncyBhY3R1YWxseSB0aGUgc2FtZSBmaWxlLgo+ICsgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAqLwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
bHN0YXQoc3JjLCAmc3JjX3N0KTsgLy9nZXQgZmlsZSBzZXJpYWwgbnVtYmVyIChpbm9kZSkgZm9y
IHNvdXJjZQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgI3dhcm5pbmcoInNy
YyBpbm9kZTogJXMsIGRzdCBpbm9kZTogJXMiLCBzcmNfc3Quc3RfaW5vLCBzdC5zdF9pbm8pOwo+
ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKHNyY19zdC5zdF9pbm8gIT0g
c3Quc3RfaW5vKSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBiYWQgPSAiZGVzdGluYXRpb24gZXhpc3RzIjsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChmb3JjZSkgewo+ICsgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLyoKPiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBvbmx5
IGZpbGVzIGNhbiBvdmVyd3JpdGUgZWFjaCBvdGhlcjoKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKiBjaGVjayBib3RoIHNvdXJj
ZSBhbmQgZGVzdGluYXRpb24KPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKi8KPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChTX0lTUkVHKHN0LnN0X21vZGUpIHx8
IFNfSVNMTksoc3Quc3RfbW9kZSkpIHsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHdhcm5pbmcoIiVzOyB3aWxs
IG92ZXJ3cml0ZSEiLCBiYWQpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgYmFkID0gTlVMTDsKPiArIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0gZWxz
ZQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgYmFkID0gIkNhbm5vdCBvdmVyd3JpdGUiOwo+ICsgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfQo+IMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfSBlbHNlIGlmIChz
dHJpbmdfbGlzdF9oYXNfc3RyaW5nKCZzcmNfZm9yX2RzdCwgZHN0KSkKPiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJhZCA9ICJtdWx0aXBsZSBzb3VyY2VzIGZvciB0aGUgc2Ft
ZSB0YXJnZXQiOwoKSSB3b25kZXIgaWYgd2UgY2FuIG1ha2UgbHN0YXRfY2FzZSgpIHRoYXQgd291
bGQgb25seSByZXR1cm4gMCBpZiBpdAptYXRjaGVzIGV4YWN0bHkgdGhlIGZpbGVuYW1lLCBldmVu
IG9uIEZBVC4gRmluZEZpcnN0RmlsZS9GaW5kTmV4dEZpbGUKc2hvdWxkIHJldHVybiB0cnVlIGZp
bGUgbmFtZSwgSSB0aGluay4gSWYgbm90LCB3ZSBjYW4gbWFrZQpsc3RhdF9jYXNlKCkgdGFrZSB0
d28gcGF0aHMgKHNyYyBhbmQgZHN0KSBhbmQgbW92ZSBhbGwgaW5vZGUKY29tcGFyaXNvbiBjb2Rl
IGluIHRoZXJlLiBNdWNoIGNsZWFuZXIuCi0tIApEdXkK
