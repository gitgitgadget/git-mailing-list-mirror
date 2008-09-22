From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] prev/next/tsort: commands to explore dependencies
Date: Mon, 22 Sep 2008 22:18:52 +0200
Message-ID: <36ca99e90809221318t1a690cdbq3456e69939a5b5e1@mail.gmail.com>
References: <1221818101-14333-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080922153614.GO10360@machine.or.cz>
	 <36ca99e90809221032x3003c1f7q8ef09cb92a0473ad@mail.gmail.com>
	 <20080922201025.GB792@strlen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: g@strlen.de, "Petr Baudis" <pasky@suse.cz>, git@vger.kernel.org
To: "=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=" <ukleinek@strlen.de>
X-From: git-owner@vger.kernel.org Mon Sep 22 22:20:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khrt6-0007TZ-7n
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 22:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbYIVUSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 16:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbYIVUSz
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 16:18:55 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:58500 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYIVUSz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 16:18:55 -0400
Received: by gxk9 with SMTP id 9so3576324gxk.13
        for <git@vger.kernel.org>; Mon, 22 Sep 2008 13:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zBVbS42ZfpZsxFD9lNTJwdiXrCxDPBf8G0IBZItoYbY=;
        b=wZVSxIwliw/Y7EJWEGOSPkzklQ+g9FlVt8XX46NefA/+BlH+d2+Za2yMbU/i01P9cG
         /+fZ9VuD1I2jGuXR5VX4eCahkk4NFX0CNRSNHbd8JDmJF2BbFoLVzGRu4tBfoRQuTt23
         R/0nRTI2V0K/z1cKpws4fbexgdhZqChvJT+jI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qZQDT0PAw1v2PW//q84xJtafXMLlDzvFilp04FXsChv07lmQJUhp+HH0IS8eoHfgFM
         0eLTIHAhzo5EUPRI/8PMJZojjhn+C3L6iPb+lXyzE2M9DysZe+p1jsvtvD3TMUsb593n
         xGbK9aZv7OmlbwmBpFw1NJElyFQfNHsJiZ8JI=
Received: by 10.150.12.3 with SMTP id 3mr7966211ybl.14.1222114732438;
        Mon, 22 Sep 2008 13:18:52 -0700 (PDT)
Received: by 10.150.204.17 with HTTP; Mon, 22 Sep 2008 13:18:52 -0700 (PDT)
In-Reply-To: <20080922201025.GB792@strlen.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96510>

T24gTW9uLCBTZXAgMjIsIDIwMDggYXQgMjI6MTAsIFV3ZSBLbGVpbmUtS8O2bmlnIDx1a2xlaW5l
a0BzdHJsZW4uZGU+IHdyb3RlOgo+IE9uIE1vbiwgU2VwIDIyLCAyMDA4IGF0IDA3OjMyOjUwUE0g
KzAyMDAsIEJlcnQgV2VzYXJnIHdyb3RlOgo+PiBPbiBNb24sIFNlcCAyMiwgMjAwOCBhdCAxNzoz
NiwgUGV0ciBCYXVkaXMgPHBhc2t5QHN1c2UuY3o+IHdyb3RlOgo+PiA+ICBIaSwKPj4gPgo+PiA+
IE9uIEZyaSwgU2VwIDE5LCAyMDA4IGF0IDExOjU1OjAwQU0gKzAyMDAsIEJlcnQgV2VzYXJnIHdy
b3RlOgo+PiA+PiBJIGhhY2tlZCAzIGNvbW1hbmRzIHRvIGV4cGxvcmUgdGhlIGRlcGVuZGVuY2ll
cyBvZiBUb3BHaXQgcGF0Y2hlczoKPj4gPgo+PiA+ICB0aGFua3MsIHRoZSBpZGVhIG9mIGFsbCB0
aHJlZSBjb21tYW5kcyBpcyBnb29kLAo+PiA+Cj4+ID4+ICAgSSkgdGcgcHJldiBbTkFNRV0KPj4g
Pj4gICAgICBvdXRwdXRzIHRoZSBkZXBlbmRlbmNpZXMgb2YgTkFNRQo+PiA+Pgo+PiA+PiAgSUkp
IHRnIG5leHQgW05BTUVdCj4+ID4+ICAgICAgb3V0cHV0cyBwYXRjaGVzIHRoYXQgZGVwZW5kcyBv
biBOQU1FCj4+ID4KPj4gPiAgYnV0IEkgdGhpbmsgaXQgd291bGQgYmUgY2xlYW5lciB0byBhZGQg
dGhpcyBmdW5jdGlvbmFsaXR5IHRvCj4+ID4gdGcgaW5mby4uLgo+PiBSaWdodCwgYnV0ICd0ZyBu
ZXh0JyBpcyBzaG9ydGVyIHRoYW4gYW55ICd0ZyBpbmZvIC0tbmV4dCcuCj4+Cj4+ID4KPj4gPj4g
SUlJKSB0ZyB0c29ydCBbUEFUVEVSTl0KPj4gPj4gICAgICBvdXRwdXRzIGEgdG9wb2xvZ2ljYWwg
b3JkZXIgb2YgYWxsIHBhdGNoZXMgc3RhcnRpbmcgd2l0aCBQQVRURVJOCj4+ID4KPj4gPiAuLi5h
bmQgdGcgc3VtbWFyeSAob3ZlcmFsbHksIHRvIGhhdmUgYSB0cmVlIHZpZXcgb2YgYnJhbmNoZXMp
Lgo+PiBNYXliZSBzb21ldGhpbmcgbGlrZSB0aGUgZ3JhcGggb3V0cHV0IGZyb20gZ2l0IHJldi1s
b2cgLS1ncmFwaD8KPj4KPj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBwcmludGYgIiVzXHQlcVxuIiAiJHtkZXBfcmV2fSIgIiR7ZGVwfSIgPiYzCj4+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpbnRmICIlc1x0JXNcbiIgIiR7dG9w
aWNfcmV2fSIgIiR7ZGVwX3Jldn0iCj4+ID4KPj4gPiAlcT8KPj4KPj4gImFuZCAlcSBjYXVzZXMg
cHJpbnRmIHRvIG91dHB1dCB0aGUgY29ycmVzcG9uZGluZyBhcmd1bWVudCBpbiAgYQo+PiBmb3Jt
YXQgdGhhdCBjYW4gYmUgcmV1c2VkIGFzIHNoZWxsIGlucHV0LiIKPiBXaXRoIC9iaW4vc2ggPT0g
ZGFzaCB0aGlzIGRvZXNuJ3Qgd29yay4gIEkgaGF2bid0IGxvb2tlZCB3aGVyZSBhbmQgaG93Cj4g
dGhpcyBpcyB1c2VkLCBidXQgcmV2LXBhcnNlIGhhcyBhbiAtLXNxIG9wdGlvbiB0aGF0IHJlc3Vs
dHMgaW4gdGhlCj4gb3V0cHV0IGJlaW5nIHNoZWxsIHF1b3RlZC4gIE1heWJlIHRoaXMgY2FuIGhl
bHA/CkknbSB1bnN1cmUgaWYgdGhpcyBxdW90aW5nIGlzIGFjdHVhbGx5IG5lZWRlZC4KCkkgYnVp
bGQgYSBtYXAgZnJvbSByZXZpc2lvbiAoc2hhMSkgdG8gdG9waWMgbmFtZToKCiAgYWJjLi5cdHQv
dG9waWMKCmFuZCB1c2UgdGhpcyBmaWxlIChhZnRlciB8c29ydHx1bmlxKSB0byBidWlsZCBhIHNl
ZCBzY3JpcHQgd2hpY2gKcmVwbGFjZXMgc2hhMSB3aXRoIHRoZSB0b3BpYyBuYW1lIGluIHRoZSBv
dXRwdXQgIGZyb20gdHNvcnQ6CgogcyNhYmMuLi4jdC90b3BpYyMKCk1heWJlIHRoZSBxdW90aW5n
IGlzIG5vdCBuZWVkZWQuCgpCZXJ0Cgo+Cj4gQmVzdCByZWdhcmRzCj4gVXdlCj4K
