From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit RFC PATCH] tg mail: new command for mailing patches
Date: Fri, 19 Sep 2008 12:20:49 +0200
Message-ID: <36ca99e90809190320l4765e50eqe38bf1d2672cfcca@mail.gmail.com>
References: <1221815301-25090-1-git-send-email-kirr@landau.phys.spbu.ru>
	 <36ca99e90809190252q45f01eb2xd02b62b88f0cf3a9@mail.gmail.com>
	 <20080919100441.GF4423@roro3>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Kirill Smelkov" <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Fri Sep 19 12:22:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgd7t-0006ms-Mm
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 12:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbYISKUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 06:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbYISKUv
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 06:20:51 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:22054 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYISKUu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 06:20:50 -0400
Received: by wx-out-0506.google.com with SMTP id h27so91058wxd.4
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=J8uz3p/zqCmmu68KskT0DO/b/MLQhbLf2XCJ71p+w9s=;
        b=bCv0UjDANEJKoYR2ACbBgpRm50zY3HUQRgyMKAY8OicQ+T7y1crqNA8kyKnqWrLcph
         ajEVdo543eiX7/HMbKq3qCQFm04p5LMv84QuREB8hOq/ZmfX57xgczIFrzMPR9dsOqTg
         xSDWlkaRGJkghcLTDa0vzSxfijZjfhLC68M0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sZcXxItfM21XlsJ+mNvCi48c8BpmjzJfoSSTItWDqDbGsaZVzw49wONLI1L27Chxb9
         G8FZiyRo8c/ULH5M5EUdCGdmVr+sFr8JVxejC7rqY4AK96ymAfC8dfol1aLz/sWlI3uw
         QZejqa25flsZppeoMxyaCTxrFYloFpFSL91e8=
Received: by 10.70.39.5 with SMTP id m5mr5811171wxm.22.1221819649398;
        Fri, 19 Sep 2008 03:20:49 -0700 (PDT)
Received: by 10.70.36.14 with HTTP; Fri, 19 Sep 2008 03:20:49 -0700 (PDT)
In-Reply-To: <20080919100441.GF4423@roro3>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96275>

T24gRnJpLCBTZXAgMTksIDIwMDggYXQgMTI6MDQsIEtpcmlsbCBTbWVsa292IDxraXJyQGxhbmRh
dS5waHlzLnNwYnUucnU+IHdyb3RlOgo+IE9uIEZyaSwgU2VwIDE5LCAyMDA4IGF0IDExOjUyOjAz
QU0gKzAyMDAsIEJlcnQgV2VzYXJnIHdyb3RlOgo+PiBPbiBGcmksIFNlcCAxOSwgMjAwOCBhdCAx
MTowOCwgS2lyaWxsIFNtZWxrb3YgPGtpcnJAbGFuZGF1LnBoeXMuc3BidS5ydT4gd3JvdGU6Cj4+
ID4gUGV0ciwgc2luY2UgeW91J3ZlIGFza2VkIGZvciBoZWxwIG9uIHRoaXMsIGhlcmUgeW91IGFy
ZToKPj4gPgo+PiA+ICAgICQgdGcgbWFpbCBbTkFNRV0KPj4gPgo+PiA+IGEgc2ltcGxlIHNjcmlw
dCB0byBzZW5kIG9uZSBwYXRjaCBvdmVyIGVtYWlsLgo+PiA+Cj4+ID4KPj4gPiBBbGwgaXQgZG9l
cyBpcwo+PiA+Cj4+ID4gICAgLSBjYWxsIGB0ZyBwYXRjaGAgZm9yIGFjdHVhbCBwYXRjaCBwcmVw
YXJhdGlvbgo+PiA+ICAgIC0gZXh0cmFjdCBlbWFpbCBhZGRyZXNzZXMgZnJvbSB3aG9tIGFuZCB3
aGVyZSB0byBzZW5kIGEgbWFpbAo+PiBUaGF0IHNob3VsZG4ndCBiZSBuZWVkZWQuIGdpdCBzZW5k
LWVtYWlsIHBhcnNlcyBDYzogaGVhZGVycyBhbmQgdGhlCj4KPiBFeGFjdGx5IGZvciB0aGlzIHJl
YXNvbiBJIGRvIG5vdCBleHRyYWN0IENjLiBBbmQgZ2l0IHNlbmQtbWFpbCBkb2VzIG5vdAo+IGV4
dHJhY3QgRnJvbTogLS0gaXQganVzdCBhc2tzIHRvIGNvbmZpcm0gRnJvbSBpcyBHSVRfQ09NTUlU
VEVSX0lERU5ULAo+IGFuZCB0aGVyZSBpcyBubyBvcHRpb24gdG8gc3RvcCBpdCBkb2luZyBzbyBl
eGNlcHQgcHJvdmlkaW5nIGV4cGxpY2l0Cj4gLS1mcm9tIDxzb21lb25lPiAobWF5YmUgaSdtIG1p
c3Npbmcgc29tZXRoaW5nPykuCkFoaCwgbXkgZmF1bHQsIEkgc2hvdWxkIHRha2UgYSBicmVhaywg
c29ycnkgZm9yIHRoZSBub2lzZS4KCj4KPj4gVG86IGNvbWVzIGZyb20gJ2dpdCBjb25maWcgdG9w
Z2l0LnRvJywgc28geW91IGNhbiByZS11c2UgdGhpcy4KPgo+IFllcywgaXQgY29tZXMgZGlyZWN0
bHkgdG8gLnRvcG1zZyB3aGVuIGB0ZyBjcmVhdGVgIGlzIGRvbmUsIHNvIEkgdGhvdWdodAo+IHRo
ZSBtYWluIHNvdXJjZSBvZiBpbmZvcm1hdGlvbiBpcyB0aGUgcGF0Y2ggaXRzZWxmIC0tIHVzZXJz
IG1heSB3YW50IHRvCj4gZWRpdCB0aGF0IFRvOiBieSBoYW5kIG9yIGFkZCBhbm90aGVyIFRvOiBs
aW5lcy4KWWVhaCwgbXkgZmF1bHQsIEkgbm90aWNlZCB0aGlzIHRvbywgaXRzIGp1c3QgYSB0ZW1w
bGF0ZS4gYmV0dGVyIHRvCmV4dHJhY3QgaXQgZnJvbSB0aGUgcGF0Y2guCgo+Cj4gYW5kIHdoYXQg
SWYgYSBwYXRjaCBpcyBhbHJlYWR5IGV4cG9ydGVkIGFzIGEgZmlsZSwgYW5kIEkgd2FudCB0bwo+
IHNlbmQvcmVzZW5kIGl0IHVwc3RyZWFtIHJpZ2h0IGZyb20gdGhhdCBmaWxlPwo+Cj4gV2UgbWF5
IHdhbnQgdG8gbG9vayBmb3IgdG9wZ2l0LnRvIHRvbyB0aG91Z2guCj4KPiAtLQo+ICAgINCS0YHQ
tdCz0L4g0YXQvtGA0L7RiNC10LPQviwg0JrQuNGA0LjQu9C7Lgo+Cg==
