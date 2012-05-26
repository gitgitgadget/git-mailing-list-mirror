From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCHv2 1/2] wt-status: better advices for git status
Date: Sat, 26 May 2012 20:01:08 +0700
Message-ID: <CACsJy8Dx=HWKJ8H3LQhVAAJGtZKmMe0d5e3Q7eHER6Xo4yTAZw@mail.gmail.com>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Kong Lucien <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sat May 26 15:02:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYGdR-0005FP-Cm
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 15:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839Ab2EZNBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 09:01:41 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:58512 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab2EZNBk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 09:01:40 -0400
Received: by wibhm6 with SMTP id hm6so303243wib.1
        for <git@vger.kernel.org>; Sat, 26 May 2012 06:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CEUX3uKRDoGGdNgNX5rQaE6sVf+hxE9E0T6QE7anjw0=;
        b=ZX+tVIP+sH+pXqp+EEfSN8d6nglib9443GqVMsRYDFosEFGQGD9cwTeGDPvt5UcUNw
         YAy73okrP5QJ3ZD4nIzJRz3oH5LhGnGQdLxVqyg/mBmqtgohb3W9DaZ03o04sy/LMDKZ
         TjCLHDh2ygsgj3n5p+uw3Azan54N/n86Ca3Mw0jX9or8fb7FxUvsnjpSv/lnqt6W92hs
         ubfNS/ZfPUMhDkoSIR4irYEZk+oSFMWQBtfLpTAgfx5PSLjKwzfgIdIl/E5PFlgCaWEd
         wyEuXYy4XqrUZyh3gFwpCjz48i7pwYQvbVk0EYFTQzoX7v/iStDlbENMoeIHp8dSm9sB
         ixRw==
Received: by 10.216.216.95 with SMTP id f73mr1230938wep.149.1338037298980;
 Sat, 26 May 2012 06:01:38 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sat, 26 May 2012 06:01:08 -0700 (PDT)
In-Reply-To: <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198560>

T24gU2F0LCBNYXkgMjYsIDIwMTIgYXQgNzozOCBQTSwgS29uZyBMdWNpZW4KPEx1Y2llbi5Lb25n
QGVuc2ltYWcuaW1hZy5mcj4gd3JvdGU6Cj4gKyDCoCDCoCDCoCBwYXRoID0gbWtwYXRoKCIlcy9N
RVJHRV9IRUFEIiwgZ2l0X2Rpcik7CgpZb3UgY2FuIHVzZSBnaXRfcGF0aCgiTUVSR0VfSEVBRCIp
IGZvciB0aGlzLCBqdXN0IGRvbid0IHNhdmUgaXQuIFRoZQpzYW1lIGZvciBvdGhlciBjYWxsIHNp
dGVzCgo+ICsgwqAgwqAgwqAgaWYoYmlzZWN0X3N0YXRlKSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBzdGF0dXNfcHJpbnRmX2xuKHMsIGMsIF8oIllvdSBhcmUgY3VycmVudGx5IGJpc2VjdGlu
Zy4iKSk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdGF0dXNfcHJpbnRmX2xuKHMsIGMsIF8o
IlRvIGdldCBiYWNrIHRvIHRoZSBvcmlnaW5hbCBicmFuY2ggcnVuIFwiZ2l0IGJpc2VjdCByZXNl
dFwiIikpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgd3Rfc3RhdHVzX3ByaW50X3RyYWlsZXIo
cyk7Cj4gKyDCoCDCoCDCoCB9Cj4gKwo+ICsgwqAgwqAgwqAgaWYodW5tZXJnZWRfc3RhdGUpIHsK
PiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlmIChjb25mbGljdCkKPiArIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHN0YXR1c19wcmludGZfbG4ocywgYywgXygiWW91IGhhdmUgdW5t
ZXJnZWQgcGF0aHM6IGZpeCBjb25mbGljdHMgYW5kIHRoZW4gY29tbWl0IHRoZSByZXN1bHQuIikp
Owo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZWxzZQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgc3RhdHVzX3ByaW50Zl9sbihzLCBjLCBfKCJZb3UgYXJlIHN0aWxsIG1lcmdp
bmcsIHJ1biBcImdpdCBjb21taXRcIiB0byBjb25jbHVkZSBtZXJnZS4iKSk7Cj4gKyDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB3dF9zdGF0dXNfcHJpbnRfdHJhaWxlcihzKTsKPiArIMKgIMKgIMKgIH0K
Ck5pY2UuIEFsdGhvdWdoIGdpdC1zdGF0dXMgaXMgc29tZXRpbWVzIHRvbyBoZWF2eSBJIGF2b2lk
IGl0LiBCdXQgSQpsaWtlIHRoaXMuIEkgZG9uJ3Qga25vdywgaXQgbWlnaHQgaGVscCBpZiB0aGlz
IGluZm8gY291bGQgYmUgcHJpbnRlZAphbG9uZSwgbWF5YmUgd2l0aCBhbiBvcHRpb24sIHdpdGhv
dXQgdGhlIGFjdHVhbCBzdGF0dXMgc3R1ZmYgKGNoYW5nZWQsCmNhY2hlZCwgb3RoZXJzLi4uKS4K
Cj4gKyDCoCDCoCDCoCBpZihyZWJhc2Vfc3RhdGUgfHwgcmViYXNlX2ludGVyYWN0aXZlX3N0YXRl
KSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoY29uZmxpY3QpIHsKPiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN0YXR1c19wcmludGZfbG4ocywgYywgXygiWW91IGFy
ZSBjdXJyZW50bHkgcmViYXNpbmc6IGZpeCBjb25mbGljdHMgYW5kIHRoZW4gcnVuIFwiZ2l0IHJl
YmFzZSAtLSBjb250aW51ZVwiLiIpKTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHN0YXR1c19wcmludGZfbG4ocywgYywgXygiSWYgeW91IHdvdWxkIHByZWZlciB0byBza2lw
IHRoaXMgcGF0Y2gsIGluc3RlYWQgcnVuIFwiZ2l0IHJlYmFzZSAtLXNraXBcIi4iKSk7Cj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdGF0dXNfcHJpbnRmX2xuKHMsIGMsIF8o
IlRvIGNoZWNrIG91dCDCoHRoZSBvcmlnaW5hbCBicmFuY2ggYW5kIHN0b3AgcmViYXNpbmcgcnVu
IFwiZ2l0IHJlYmFzZSAtLWFib3J0XCIuIikpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgfQo+
ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZWxzZSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBpZiAocmViYXNlX3N0YXRlKQo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgc3RhdHVzX3ByaW50Zl9sbihzLCBjLCBfKCJZb3UgYXJlIGN1
cnJlbnRseSByZWJhc2luZzogYWxsIGNvbmZsaWN0cyBmaXhlZDsgcnVuIFwiZ2l0IHJlYmFzZSAt
LWNvbnRpbnVlXCIuIikpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZWxz
ZSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzdGF0
dXNfcHJpbnRmX2xuKHMsIGMsIF8oIllvdSBhcmUgY3VycmVudGx5IGVkaXRpbmcgaW4gYSByZWJh
c2UgcHJvZ3Jlc3MuIikpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgc3RhdHVzX3ByaW50Zl9sbihzLCBjLCBfKCJZb3UgY2FuIGFtZW5kIHRoZSBjb21t
aXQgd2l0aCIpKTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHN0YXR1c19wcmludGZfbG4ocywgYywgXygiIMKgIMKgIMKgZ2l0IGNvbW1pdCAtLWFtZW5k
IikpOwo+ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3Rh
dHVzX3ByaW50Zl9sbihzLCBjLCBfKCJPbmNlIHlvdSBhcmUgc2F0aXNmaWVkIHdpdGggeW91ciBj
aGFuZ2VzLCBydW4iKSk7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBzdGF0dXNfcHJpbnRmX2xuKHMsIGMsIF8oIiDCoCDCoCDCoGdpdCByZWJhc2UgLS1j
b250aW51ZSIpKTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0KPiArIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIH0KPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHd0X3N0YXR1c19w
cmludF90cmFpbGVyKHMpOwo+ICsgwqAgwqAgwqAgfQoKU2hvdWxkIHRoaXMgdmVyYm9zZSBhZHZp
Y2UgYmUgY29udHJvbGxlZCBieSBhZHZpY2UuKiBjb25maWcga2V5cz8KRXhwZXJpZW5jZWQgdXNl
cnMga25vdyBieSBoZWFydCB3aGF0IHRvIGRvIGFuZCB3aWxsIGFwcHJlY2lhdGUgc2NyZWVuCmVz
dGF0ZSBiZWluZyB1c2VkIG1vcmUgaGVscGZ1bCAodG8gdGhlbSkgaW5mbwotLSAKRHV5Cg==
