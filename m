From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] diffcore-rename: support rename cache
Date: Sat, 8 Nov 2008 16:29:47 +0700
Message-ID: <fcaeb9bf0811080129g7b97dd0au872ec66484a9a7f5@mail.gmail.com>
References: <1226068533-10152-1-git-send-email-pclouds@gmail.com>
	 <20081107222128.GB4030@nan92-1-81-57-214-146.fbx.proxad.net>
	 <7vy6zvdt25.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0811072001o6df7ae00k1b1bffaadf75d3a1@mail.gmail.com>
	 <20081108092409.GD4030@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Nov 08 10:31:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyk9o-00055l-GL
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 10:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbYKHJ3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 04:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbYKHJ3u
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 04:29:50 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:10358 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbYKHJ3t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 04:29:49 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1364955fgg.17
        for <git@vger.kernel.org>; Sat, 08 Nov 2008 01:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3UkFU0AuAtuBB9HpJFSHoCgDcwTs88TSFg20WRh0N50=;
        b=HT3x/5LOzSUcc6hFhzkDWkuH4P35yR7UkwCx5+5noEnFHuJj3FVJF2ZuRukdp9IDtV
         lR/C3zHGeE+iglp3nBksFUsVw0I7nHxOV5Aq5nV8DC80b1FubVQFDTBxBs6RQmlHbivD
         tnndxJ8Q+yK/qoW6UA1jUK7ZLCCei6SupN6nk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oGmb+v2a+TVRMcaSmNli+lkrt1L4hl5hxy/kiuXZ23Vuq1FrGePSw2GKwPJDikXtBA
         VMP9lfVgCE73ZuyIl+uXbPvL8l4sDlXF0DP8B4Mh7vTZXSMeLM96qxOwyiVnW/H9ogXG
         rvWQM7Rrm74fj535YenSe00xI8VV+Sy/gy/Ys=
Received: by 10.86.62.3 with SMTP id k3mr4812358fga.6.1226136587787;
        Sat, 08 Nov 2008 01:29:47 -0800 (PST)
Received: by 10.86.27.20 with HTTP; Sat, 8 Nov 2008 01:29:47 -0800 (PST)
In-Reply-To: <20081108092409.GD4030@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100391>

T24gMTEvOC8wOCwgWWFubiBEaXJzb24gPHlkaXJzb25AYWx0ZXJuLm9yZz4gd3JvdGU6Cj4gT24g
U2F0LCBOb3YgMDgsIDIwMDggYXQgMTE6MDE6MjBBTSArMDcwMCwgTmd1eWVuIFRoYWkgTmdvYyBE
dXkgd3JvdGU6Cj4gID4gT24gMTEvOC8wOCwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3gu
Y29tPiB3cm90ZToKPiAgPiA+IFlhbm4gRGlyc29uIDx5ZGlyc29uQGFsdGVybi5vcmc+IHdyaXRl
czoKPiAgPiA+Cj4gID4gPiAgPiBPbiBGcmksIE5vdiAwNywgMjAwOCBhdCAwOTozNTozMlBNICsw
NzAwLCBOZ3V5Pz8/biBUaMOhaSBOZz8/P2MgRHV5IHdyb3RlOgo+ICA+ID4gID4+IFRoaXMgcGF0
Y2ggdGVhY2hlcyBkaWZmY29yZV9yZW5hbWUoKSB0byBsb29rIGludG8KPiAgPiA+ICA+PiAkR0lU
X0RJUi9yZW5hbWUtY2FjaGUgYW5kIG1ha2UgdXNlIG9mIGl0IHRvIHJlY3JlYXRlIGRpZmZfZmls
ZXBhaXIuCj4gID4gPiAgPj4gV2l0aCBwcm9wZXIgY2FjaGUsIHRoZXJlIHNob3VsZCBiZSBubyBh
dmFpbGFibGUgZW50cnkgZm9yIGVzdGltYXRpb24KPiAgPiA+ICA+PiBhZnRlciBleGFjdCBtYXRj
aGluZy4KPiAgPiA+ICA+Cj4gID4gPiAgPiBUaGlzIGlzIHNvbWV0aGluZyBJIGhhdmUgdGhvdWdo
dCBhYm91dCBpbiB0aGUgcGFzdCwgZ29vZCB0byBzZWUgdGhhdAo+ICA+ID4gID4gaW1wbGVtZW50
ZWQgOikKPiAgPiA+ICA+Cj4gID4gPiAgPj4gUmVuYW1lIGNhY2hpbmcgaXMgcGVyIGNvbW1pdC4g
SSBkb24ndCB0aGluayBhYml0cmFyeSB0cmVlLXRyZWUgY2FjaGluZwo+ICA+ID4gID4+IGlzIHdv
cnRoIGl0Lgo+ICA+ID4gID4KPiAgPiA+ICA+IFRoYXQgY291bGQgYmUgYSBuaWNlIGNvbXBsZW1l
bnQgdG8gbXkgZGlyZWN0b3J5LXJlbmFtZSBwYXRjaC4KPiAgPiA+Cj4gID4gPgo+ICA+ID4gSGFz
IGFueWJvZHkgdGhvdWdodCBhYm91dCBpbnRlcmFjdGlvbiBiZXR3ZWVuIHRoYXQgY2FjaGluZyBh
bmQgcGF0aHNwZWMKPiAgPiA+ICBsaW1pdGVkIG9wZXJhdGlvbj8KPiAgPiA+Cj4gID4KPiAgPiBJ
IGRpZG4ndC4gQnV0IEkgdGhpbmsgYWxsIG91dC1vZi1wYXRoc3BlYyBkaWZmIHBhaXJzIGFyZSBy
ZW1vdmVkCj4gID4gYmVmb3JlIGl0IHJlYWNoZXMgZGlmZmNvcmVfcmVuYW1lKCkgc28gdGhlIGNh
Y2hlIGhhcyBub3RoaW5nIHRvIGRvCj4gID4gd2l0aCBpdCAoZXhjZXB0IGl0IHN0aWxsIGxvYWRz
IGZ1bGwgY2FjaGUgZm9yIGEgY29tbWl0KS4KPgo+Cj4gV2VsbCwgaXQgY291bGQgYmUgdGhhdCBh
biBvdXQtb2YtcGF0aHNwZWMgcGFpciB3b3VsZCBoYXZlIGEgYmV0dGVyCj4gIHNjb3JlIHRoYW4g
YW4gaW4tcGF0aHNwZWMgb25lLiAgTWF5YmUgY2FjaGUgcmVjb3JkaW5nIHNob3VsZCBiZSB0dXJu
ZWQKPiAgb2ZmIHdoZW4gZG9pbmcgcGF0aHNwZWMgbGltaXRhdGlvbiA/CgpSaWdodCwgcmVjb3Jk
aW5nIHNob3VsZCBiZSB0dXJuZWQgb2ZmIG9yIHNvbWV0aGluZy4gTGV0IG1lIHNlZS4uCi0tIApE
dXkK
