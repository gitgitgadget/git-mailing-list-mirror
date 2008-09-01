From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] for-each-ref: `:short` format for `refname`
Date: Mon, 1 Sep 2008 16:13:15 +0200
Message-ID: <36ca99e90809010713h7c673d10j6addd1624a655371@mail.gmail.com>
References: <7vprnpbqmo.fsf@gitster.siamese.dyndns.org>
	 <1220186467-24623-1-git-send-email-bert.wesarg@googlemail.com>
	 <20080901131523.GA6739@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "=?UTF-8?Q?SZEDER_G=C3=A1bor?=" <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Sep 01 16:17:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaAAi-00045G-1J
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 16:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbYIAONS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 10:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbYIAONR
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 10:13:17 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:43882 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbYIAONR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 10:13:17 -0400
Received: by an-out-0708.google.com with SMTP id d40so307958and.103
        for <git@vger.kernel.org>; Mon, 01 Sep 2008 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VEdT3tLpa2JIweKrooZ0d03CFE9kbg1uD0UFRfRD80Y=;
        b=bmYq2upAA3PQkGuNPcAZQDp70Dc2/1mWXHNTcd6XG61mHUJiZT4W/Ydr8me4VIVJWa
         5eVIeHBc4Qn4d+NSj0l8TdXvI6Lr+V72WSwUa52zSR11G032SHdrofmZHfg7B4n9Vuxd
         aE1Zo/stuhd0ELWZybixena7KeN7XGZkyvM3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kAl/J2M3JS1CxU3VBlDnWKRmPYUNzbm5oZWmxT5G66CGfGWF/1eaG3yz+0uqzO/YWT
         nTSScKJ5Lcan10H8qIpHarXKCtheJ9gwPvpBMTjrhAqXjYMeJ+j6CPNeFqxVKI2r7LCl
         gM+PrmLOL+6yFQGqxMf0fSGVjPhccSbD59Y6E=
Received: by 10.100.112.9 with SMTP id k9mr5957325anc.72.1220278395603;
        Mon, 01 Sep 2008 07:13:15 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Mon, 1 Sep 2008 07:13:15 -0700 (PDT)
In-Reply-To: <20080901131523.GA6739@neumann>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94586>

T24gTW9uLCBTZXAgMSwgMjAwOCBhdCAxNToxNSwgU1pFREVSIEfDoWJvciA8c3plZGVyQGlyYS51
a2EuZGU+IHdyb3RlOgo+IEhpLAo+Cj4gT24gU3VuLCBBdWcgMzEsIDIwMDggYXQgMDI6NDE6MDdQ
TSArMDIwMCwgQmVydCBXZXNhcmcgd3JvdGU6Cj4+IFRoaXMgc3RyaXBzIGZyb20gdGhlIHJlZm5h
bWUgdGhlIGNvbW1vbiBkaXJlY3RvcnkgcHJlZml4IHdpdGggdGhlCj4+IG1hdGNoZWQgcGF0dGVy
bi4KPj4KPj4gVGhpcyBpcyBwYXJ0aWN1bGFyIHVzZWZ1bGwgZm9yIGJhc2ggY29tcGxldGlvbiwg
dG8gZ2V0IHJlZnMgd2l0aG91dAo+PiBgcmVmcy9oZWFkc2Agb3IgYHJlZnMvdGFnc2AuCj4KPj4g
IHJlZm5hbWU6Ogo+PiAgICAgICBUaGUgbmFtZSBvZiB0aGUgcmVmICh0aGUgcGFydCBhZnRlciAk
R0lUX0RJUi8pLgo+PiArICAgICBGb3IgYSBzaG9ydCBuYW1lIG9mIHRoZSByZWYgYXBwZW5kIGA6
c2hvcnRgLiBUaGlzIHdpbGwgc3RyaXAKPj4gKyAgICAgdGhlIGNvbW1vbiBkaXJlY3RvcnkgcHJl
Zml4IHdpdGggdGhlIHBhdHRlcm4gd2hpY2ggbWF0Y2hlcyB0aGlzIHJlZi4KPj4gKyAgICAgSS5l
LiBmb3IgYSB0aGUgcGF0dGVybiBgcmVmcy9oZWFkc2AgeW91IGdldCBgbWFzdGVyYCwgb3IgZm9y
Cj4+ICsgICAgIGByZWZzL3RhZ3MvdjEuNS5bMDFdLipgIHlvdSBnZXQgYHYxLjUuWzAxXS4qYC4K
Pj4gKyAgICAgVGhpcyBpcyBwYXJ0aWN1bGFyIHVzZWZ1bGwgZm9yIGJhc2ggY29tcGxldGlvbi4K
PiBTaG91bGQgdGhpcyBsYXN0IHNlbnRlbmNlIHJlYWxseSBiZWxvbmcgdG8gdGhlIGRvY3VtZW50
YXRpb24/CkF0IGxlYXN0IGl0IGlzIG5vdCB0aGUgb25seSBleGFtcGxlIGluIHRoZSBkb2N1bWVu
dGF0aW9uLgoKPgo+IEZ1cnRoZXJtb3JlLCBJIHRoaW5rICc6c3RyaXAnIGJldHRlciBkZXNjcmli
ZXMgd2hhdCB0aGlzIGZvcm1hdAo+IGFjdHVhbGx5IGRvZXMuICBFdmVuIHlvdSBoYXZlIHVzZWQg
dGhlIHdvcmQgJ3N0cmlwJyBpbiB0aGUgY29tbWl0Cj4gbWVzc2FnZSBhbmQgaW4gdGhlIGRvY3Vt
ZW50YXRpb24gYXMgd2VsbC4KVHJ1ZSwgSSdtIG9rIHdpdGggdGhpcyBwcm9wb3NhbC4KCj4KPgo+
IEFzIGZhciBhcyBiYXNoIGNvbXBsZXRpb24gaXMgY29uY2VybmVkLCBJJ20gZm9yIGl0LCBhcyBp
dCBkb2VzIGV4YWN0bHkKPiB3aGF0IHRoZSBjb21wbGV0aW9uIHNjcmlwdCBuZWVkcyB0byBwZXJm
b3JtIGJldHRlciwgaXQgZG9lc24ndCBoYXZlCj4gdGhvc2UgY29uY2VwdHVhbCBpc3N1ZXMgJ3Jl
ZmJhc2VuYW1lJyBoYXMsIGFuZCBpdCdzIG9ubHkgYSB0YWQgc2xvd2VyCj4gdGhhbiAncmVmYmFz
ZW5hbWUnLgo+Cj4gSG93ZXZlciwgaWYgd2UgY29uc2lkZXIgcG9zc2libGUgdXNlIGNhc2VzIG90
aGVyIHRoYW4gYmFzaCBjb21wbGV0aW9uLAo+IEkgZG9uJ3Qga25vdyB3aGljaCBvbmUgaXMgbW9y
ZSB1c2VmdWwuICBGb3IgZXhhbXBsZSwgaWYgeW91IGhhdmUgdHdvCj4gYnJhbmNoZXMgJ2Zvby9i
YXInIGFuZCAnZm9vL2JheicsIHRoZW4gJ2dpdCBtZXJnZSAkKGdpdCBmb3ItZWFjaC1yZWYKPiAt
LWZvcm1hdD0lKHJlZmJhc2VuYW1lKSByZWZzL2hlYWRzL2ZvbyknIHdpbGwgd29yayBhcyBleHBl
Y3RlZCwgYnV0Cj4gJ3JlZm5hbWU6c2hvcnQnIG5vdCwgYXMgaXQgd2lsbCBvdXRwdXQgb25seSAn
YmFyJyBhbmQgJ2Jheicgd2hpY2ggJ2dpdAo+IG1lcmdlJyBjYW4gbm90IGZpbmQuClllYWgsIHRo
YXRzIGFuIGRpc2FkdmFudGFnZSBhbmQgSSB0aG91Z2h0IGFib3V0IHRoaXMsIHRvby4gQnV0IEkg
aGF2ZQpubyBwYXJ0aWN1bGFyIG9waW5pb24gYWJvdXQgaXQuCgpSZWdhcmRzLApCZXJ0Cgo+IEJl
c3QsCj4gR8OhYm9yCg==
