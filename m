From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] for-each-ref: `:short` format for `refname`
Date: Mon, 1 Sep 2008 23:10:38 +0200
Message-ID: <36ca99e90809011410w646cc6eajb3063ea3501f173c@mail.gmail.com>
References: <7vprnpbqmo.fsf@gitster.siamese.dyndns.org>
	 <1220186467-24623-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080901131523.GA6739@neumann>
	 <36ca99e90809010713h7c673d10j6addd1624a655371@mail.gmail.com>
	 <36ca99e90809011052s568fa6e4y89e56769f63806c1@mail.gmail.com>
	 <20080901191051.GD7482@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "=?UTF-8?Q?SZEDER_G=C3=A1bor?=" <szeder@ira.uka.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 23:14:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaGjK-0003hf-9L
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 23:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbYIAVKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 17:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbYIAVKk
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 17:10:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:45965 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbYIAVKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 17:10:40 -0400
Received: by wx-out-0506.google.com with SMTP id h29so595488wxd.4
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jKOzPiT1zOIw7GdTomCMUtOQgQ5LDFWni8HwoYepjiA=;
        b=Dzgrj2cygM2TzNkPt71n44p/q3FL9HI+MWdO2KttmOj9HsuTKU/loJgoxdb4XHHlOL
         2OpbwO1kvBEArqJgit1D/Df99z/6KEcgdT5fYiZUPoJoct74t8bRv92pwhVMUM/2Vz0P
         uEhXLjpxgwF6TJDe0CWC8ZTsiaARwF91bMnP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HLQnHb+YciOWFgT+uza30XjjzDDmbJj3l/Wvz/huTxtHA4YEh25JVnGxAp49dfnOmU
         WkCxDWkXG7mF+ZwxxDg3aqrBQtQ7SCN0KLt6C5+BIAVY/W00e8Dn1kybWL+SjieDxnUe
         qyq98MZB1FsgMU9AYYXd9Gyx73nuaI0l6+3Oo=
Received: by 10.70.66.18 with SMTP id o18mr8430625wxa.66.1220303438367;
        Mon, 01 Sep 2008 14:10:38 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Mon, 1 Sep 2008 14:10:38 -0700 (PDT)
In-Reply-To: <20080901191051.GD7482@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94610>

T24gTW9uLCBTZXAgMSwgMjAwOCBhdCAyMToxMCwgU2hhd24gTy4gUGVhcmNlIDxzcGVhcmNlQHNw
ZWFyY2Uub3JnPiB3cm90ZToKPiBCZXJ0IFdlc2FyZyA8YmVydC53ZXNhcmdAZ29vZ2xlbWFpbC5j
b20+IHdyb3RlOgo+PiBJTUhPIHRoZSBnb2FsIG9mIHRoaXMgbmV3IGZvcm1hdCBmb3IgcmVmbmFt
ZSBzaG91bGQgYmUsIHRoYXQgaXQgY2FuIGJlCj4+IHVzZWQgYXMgYW4gcmVmIG9uIHRoZSBjb21t
YW5kIGxpbmUuIFRoaXMgaXNuJ3QgZ2l2ZW4gd2l0aCBteSBjdXJyZW50Cj4+IDpzaG9ydCBwcm9w
b3NhbCAod2hpY2ggSSBjYWxsIDpzdHJpcCBhcyBvZiBub3cpLCBhcyBHw6Fib3Igc2hvd2VkLiBX
aGF0Cj4+IHdlIG5lZWQgaXMgdGhlIHJldmVyc2Ugb2Ygd2hhdCBoYXBwZW5lZCB3aXRoIHJlZm5h
bWVzIGdpdmVuIG9uIHRoZQo+PiBjb21tYW5kIGxpbmUgdG8gY29tbWFuZHMgbGlrZSBjaGVja291
dC9tZXJnZS8uLi4gVGhlIG9ubHkgdGhpbmcgdGhhdAo+PiBjb21lcyBuZWFyIHRvIHRoaXMgaXMg
dGhpcyBmcm9tIHJlZnMuYzoKPj4KPj4gICAgIGNvbnN0IGNoYXIgKnJlZl9yZXZfcGFyc2VfcnVs
ZXNbXSA9IHsKPj4gICAgICAgICAgICAgIiUuKnMiLAo+PiAgICAgICAgICAgICAicmVmcy8lLipz
IiwKPj4gICAgICAgICAgICAgInJlZnMvdGFncy8lLipzIiwKPj4gICAgICAgICAgICAgInJlZnMv
aGVhZHMvJS4qcyIsCj4+ICAgICAgICAgICAgICJyZWZzL3JlbW90ZXMvJS4qcyIsCj4+ICAgICAg
ICAgICAgICJyZWZzL3JlbW90ZXMvJS4qcy9IRUFEIiwKPj4gICAgICAgICAgICAgTlVMTAo+PiAg
ICAgfTsKPj4KPj4gV2hpY2ggZG9lc24ndCBsb29rIHZlcnkgdXNlZnVsLCBiZWNhdXNlIGV2ZXJ5
IHJlZiBmcm9tIGZvcl9lYWNoX3JlZgo+PiB3b3VsZCBtYXRjaCBydWxlIG9uZS4gU28gd2UgcHJv
YmFibHkgbmVlZCB0byB0cnkgdGhlIHJldmVyc2Ugb2YgdGhpcwo+PiBsaXN0Lgo+Cj4gWXVwLiAg
SWYgeW91IHNlYXJjaCB0aGUgbGlzdCBiYWNrd2FyZHMgYW5kIGV4dHJhY3QgdGhlIHBhcnQgb2Yg
dGhlCj4gcmVmIHRoYXQgbWF0Y2hlcyAlLipzIHlvdSdsbCBnZXQgYSBuYW1lIHRoYXQgb3RoZXIg
dG9vbHMgY2FuIGZpbmQsCj4gYW5kIHdoaWNoIGlzIHRoZSBzaG9ydGVzdCBuYW1lIHBvc3NpYmxl
Lgo+Cj4gWW91IGNhbiBzdGlsbCBnZXQgYW1iaWd1b3VzIG5hbWVzLiAgQXZvaWRpbmcgdGhlbSBy
ZXF1aXJlcyBnb2luZwo+IHRocm91Z2ggYWxsIHJlZnMgYW5kIGJ1aWxkaW5nIHRoZWlyIHNob3J0
IGZvcm1zLCB0aGVuIHVzaW5nIHRoZQo+IGZ1bGwgcmVmIG5hbWUgZm9yIGFueSByZWYgd2hpY2gg
aGFkIG1vcmUgdGhhbiBvbmUgbmFtZSBzaG9ydGVuIHRvCj4gdGhlIHNhbWUgc3RyaW5nLiAgVWds
eSwgYnV0IGltcGxlbWVudGFibGUsIGFuZCBwcm9iYWJseSBzb21ldGhpbmcKPiB0aGF0IHNob3Vs
ZCBiZSBjb25zaWRlcmVkLgpXaGF0IGFib3V0OiB0cnkgdGhlIGxpc3QgYmFja3dhcmRzIHVudGls
IHRoZSBmaXJzdCBtYXRjaCwgdGhhbiB0cnkgdGhlCm1hdGNoZWQgcGFydCAodGhpcyB3aGF0ICUu
KnMgbWF0Y2hlZCkgd2l0aCB0aGUgZm9yd2FyZCBsaXN0LCBpZiBib3RoCmdpdmUgdGhlIHNhbWUg
cGF0dGVybiwgaXRzIG5vdCBkaXNhbWJpZ3VvdXMuIElmIG5vdCB0cnkgdGhlIG5leHQKcGF0dGVy
biBiYWNrd2FyZHMuCgpJdHMgcXVhZHJhdGljIGluIHRoZSBudW1iZXIgb2YgcGF0dGVybnMsIGJ1
dCB0aGlzIGlzIG1heWJlIHNtYWxsZXIKdGhhbiBzY2FubmluZyBhbGwgcmVmcyAod2hpY2ggbWF5
IGluY2x1ZGUgYSBzb3J0IHBoYXNlKS4KCkJlcnQKPiAtLQo+IFNoYXduLgo+Cg==
