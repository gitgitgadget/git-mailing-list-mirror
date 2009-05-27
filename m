From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 4/7] Allow programs to not depend on remotes having urls
Date: Wed, 27 May 2009 20:42:57 +0200
Message-ID: <36ca99e90905271142q577f026bidffa1ae89714d2a5@mail.gmail.com>
References: <alpine.LNX.2.00.0905271408380.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 27 20:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9O5w-0005NS-49
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 20:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758311AbZE0SnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 14:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753942AbZE0SnE
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 14:43:04 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:45022 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105AbZE0SnC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 14:43:02 -0400
Received: by fxm12 with SMTP id 12so3133231fxm.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 11:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RzWSYoZPdJw93cAnUzLwo83EOzb9m3zoRdJ7qU4Yfss=;
        b=Bvsp+4QEgN7obhr/B2qP2atlWO32TgG4Y27H3fFs9EsPOiHpUooYcDs3yv6MvfVbGC
         DEqPgpOF8xUhxLbhblC6j0PGhe6FAL4AAFCXfv+2SfonW+lzZMhKpB0qR6Ay5g2fPiQw
         6JAPfDTS/mALLH7Xk4oCQUgeKCVo8nEx+Bjhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fcNLevBqoMWXe7yvr2M+o9fZUYMBL46NB4TnkJfT9HISwVnZ9avNFmLx9o/WPaawAD
         DWsUlRZtZXBknnqA32zVtbuoDop3UGFMooZrWFL4p2Abp2wLme7ZB2KmzMW8gm8EdWmu
         qMzoqVLVdH1MDPkLThwAHnST5RTq5A+etOzqQ=
Received: by 10.223.126.69 with SMTP id b5mr372519fas.54.1243449777939; Wed, 
	27 May 2009 11:42:57 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0905271408380.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120093>

RGFuaWVsLAoKSSBmb3VuZCBhIHNtYWxsIHR5cG8uCgpCZXJ0CgpPbiBXZWQsIE1heSAyNywgMjAw
OSBhdCAyMDoxNSwgRGFuaWVsIEJhcmthbG93IDxiYXJrYWxvd0BpYWJlcnZvbi5vcmc+IHdyb3Rl
Ogo+IEZvciBmZXRjaCBhbmQgbHMtcmVtb3RlLCB3aGljaCB1c2UgdGhlIGZpcnN0IHVybCBvZiBh
IHJlbW90ZSwgaGF2ZQo+IHRyYW5zcG9ydF9nZXQoKSBkZXRlcm1pbmUgdGhpcyBieSBwYXNzaW5n
IGEgcmVtb3RlIGFuZCBwYXNzaW5nIE5VTEwKPiBmb3IgdGhlIHVybC4gRm9yIHB1c2gsIHdoaWNo
IHVzZXMgZXZlcnkgdXJsIG9mIGEgcmVtb3RlLCB1c2UgZWFjaCB1cmwKPiBpbiB0dXJuIGlmIHRo
ZXJlIGFyZSBhbnksIGFuZCB1c2UgTlVMTCBpZiB0aGVyZSBhcmUgbm9uZS4KPgo+IFRoaXMgd2ls
bCBhbGxvdyB0aGUgdHJhbnNwb3J0IGNvZGUgdG8gZG8gc29tZXRoaW5nIGRpZmZlcmVudCBpZiB0
aGUKPiBsb2NhdGlvbiBpcyBub3Qgc3BlY2lmaWVkIHdpdGggYSB1cmwuCj4KPiBBbHNvLCBoYXZl
IHRoZSBtZXNzYWdlIGZvciBhIGZldGNoIHNheSAiZm9yZWlnbiIgaWYgdGhlcmUgaXMgbm8gdXJs
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEJhcmthbG93IDxiYXJrYWxvd0BpYWJlcnZvbi5v
cmc+Cj4gLS0tCj4gwqBidWlsdGluLWZldGNoLmMgwqAgwqAgfCDCoCAxOSArKysrKysrKysrKy0t
LS0tLQo+IMKgYnVpbHRpbi1scy1yZW1vdGUuYyB8IMKgIMKgNCArLQo+IMKgYnVpbHRpbi1wdXNo
LmMgwqAgwqAgwqB8IMKgIDU0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLS0tCj4gwqB0cmFuc3BvcnQuYyDCoCDCoCDCoCDCoCB8IMKgIMKgMyArKwo+IMKg
NCBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9idWlsdGluLWZldGNoLmMgYi9idWlsdGluLWZldGNoLmMKPiBpbmRleCA3N2Fj
YWJmLi5iYjE1MzRhIDEwMDY0NAo+IC0tLSBhL2J1aWx0aW4tZmV0Y2guYwo+ICsrKyBiL2J1aWx0
aW4tZmV0Y2guYwo+IEBAIC0zNDEsMTIgKzM0MSwxNyBAQCBzdGF0aWMgaW50IHN0b3JlX3VwZGF0
ZWRfcmVmcyhjb25zdCBjaGFyICpyYXdfdXJsLCBjb25zdCBjaGFyICpyZW1vdGVfbmFtZSwKPiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHdoYXQgPSBybS0+bmFtZTsKPiDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoH0KPgo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgdXJsX2xlbiA9
IHN0cmxlbih1cmwpOwo+IC0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgZm9yIChpID0gdXJsX2xlbiAt
IDE7IHVybFtpXSA9PSAnLycgJiYgMCA8PSBpOyBpLS0pCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCA7Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1cmxfbGVuID0gaSArIDE7
Cj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoNCA8IGkgJiYgIXN0cm5jbXAoIi5naXQiLCB1
cmwgKyBpIC0gMywgNCkpCj4gLSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1cmxf
bGVuID0gaSAtIDM7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAodXJsKSB7Cj4gKyDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCB1cmxfbGVuID0gc3RybGVuKHVybCk7Cj4gKyDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmb3IgKGkgPSB1cmxfbGVuIC0gMTsgdXJs
W2ldID09ICcvJyAmJiAwIDw9IGk7IGktLSkKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHVybF9sZW4gPSBpICsgMTsKPiArIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGlm
ICg0IDwgaSAmJiAhc3RybmNtcCgiLmdpdCIsIHVybCArIGkgLSAzLCA0KSkKPiArIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHVybF9sZW4gPSBpIC0gMzsKPiAr
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIH0gZWxzZSB7Cj4gKyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCB1cmwgPSAiZm9yaWVnbiI7ClR5cG8uCg==
