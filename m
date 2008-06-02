From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT BUG] StGIT errors out on rebasing patch deleting file with Unicode filename
Date: Mon, 2 Jun 2008 17:11:59 +0100
Message-ID: <b0943d9e0806020911l63f5c5e5t39bb3b513d7aaccd@mail.gmail.com>
References: <200806011046.51872.jnareb@gmail.com>
	 <200806020939.05902.jnareb@gmail.com>
	 <b0943d9e0806020626s3a1009d6q2a4cdb2526be9c8d@mail.gmail.com>
	 <200806021747.35243.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 18:13:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Cej-0007O5-Ie
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 18:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480AbYFBQMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 12:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754233AbYFBQMO
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 12:12:14 -0400
Received: from rn-out-0910.google.com ([64.233.170.186]:22396 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbYFBQMM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 12:12:12 -0400
Received: by rn-out-0910.google.com with SMTP id k40so219742rnd.17
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Q3JrFX5nP4kVy/d/2kcX6yynfVQB2zbFypBjKENK0bk=;
        b=AskoyhdCdvyfTbrUMmIT2qs/ZzATCM/WaTQQRrpbKc6q32MU8BsQfTSmNWsw5CRXAv4BfVRc/4E8cApzLC+Qw2GDpRMEIEffnN3iXkVX+o0Kku6SRr9KWnzVC/UMg9mfgNF8sDVpbfhJ95YmorJnZhNgjXyXqEGKmzMZUNskNUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SZNL/faTVGFafo7jPltvIk44z5wkd7CRL41UDuxKxPfRe/Qn9tpirOzDDk6Lgv/39zqskXbT8N8weLzZhrQlCVM0xXRUQK6jQkXSRW6FefeQBCYe7JLddHtT7IIZLOlxkIv9JtJcv8ojk+UtTxn1FlbvDgorAnjqosPJtu6O2dw=
Received: by 10.114.127.1 with SMTP id z1mr3312898wac.94.1212423119287;
        Mon, 02 Jun 2008 09:11:59 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Mon, 2 Jun 2008 09:11:59 -0700 (PDT)
In-Reply-To: <200806021747.35243.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83539>

MjAwOC82LzIgSmFrdWIgTmFyZWJza2kgPGpuYXJlYkBnbWFpbC5jb20+Ogo+IERuaWEgcG9uaWVk
emlhs2VrIDIuIGN6ZXJ3Y2EgMjAwOCAxNToyNiwgQ2F0YWxpbiBNYXJpbmFzIG5hcGlzYbM6Cj4+
IDIwMDgvNi8yIEpha3ViIE5hcmVic2tpIDxqbmFyZWJAZ21haWwuY29tPjoKPj4+IE9uIFN1biwg
MSBKdW5lIDIwMDgsIEpha3ViIE5hcmVic2tpIHdyb3RlOgo+Pj4KPj4+PiBTdEdJVCBlcnJvcnMg
b3V0IG9uIHJlYmFzaW5nIHBhdGNoIHdoaWNoIGRlbGV0ZXMgZmlsZSB3aXRoIFVuaWNvZGUKPj4+
PiBjaGFyYWN0ZXJzIGluIGZpbGVuYW1lICh3aXRoIGNoYXJhY3RlcnMgb3V0c2lkZSBVUy1BU0NJ
SSBpbiBmaWxlbmFtZSkuCj4+Pj4gVGhlIHBhdGNoIGluIHF1ZXN0aW9uIGlzIHBhdGNoIGRlbGV0
aW5nIGdpdHdlYi90ZXN0LyogaW4gZ2l0IGRpcmVjdG9yeSwKPj4+PiBhbmQgaXMgcHJlc2VudCBh
bHJlYWR5IG9uIHRoZSAnb3JpZ2luJyBicmFuY2ggKHRoZSBicmFuY2ggd2UgcmViYXNlCj4+Pj4g
b250byksIHNvIHN0Zy1yZWJhc2Ugc2hvdWxkIHJlc3VsdCBpbiBhbiBlbXB0eSBwYXRjaCAoYXMg
Zmlyc3QgcGF0Y2gpLgo+Pj4+Cj4+Pj4gICJnaXR3ZWIvdGVzdC9NXDMwM1wyNDRyY2hlbiIgfCAg
ICAyIC0tCj4+Pj4gIGdpdHdlYi90ZXN0L2ZpbGUgd2l0aCBzcGFjZXMgfCAgICA0IC0tLS0KPj4+
PiAgZ2l0d2ViL3Rlc3QvZmlsZStwbHVzK3NpZ24gICB8ICAgIDYgLS0tLS0tCj4+Pj4gIDMgZmls
ZXMgY2hhbmdlZCwgMCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPj4+PiAgZGVsZXRl
IG1vZGUgMTAwNjQ0IGdpdHdlYi90ZXN0L03kcmNoZW4KPj4+PiAgZGVsZXRlIG1vZGUgMTAwNjQ0
IGdpdHdlYi90ZXN0L2ZpbGUgd2l0aCBzcGFjZXMKPj4+PiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGdp
dHdlYi90ZXN0L2ZpbGUrcGx1cytzaWduCj4+Pj4KPj4+PiBJIGd1ZXNzIHRoZSBlcnJvciBpcyBj
YXVzZWQgYnkgdXNpbmcgdW5lc2NhcGVkIChxdW90ZWQpIGZpbGVuYW1lLgo+Pj4KPj4+IFlvdSBj
YW4gV09SS0FST1VORCB0aGlzIGJ1ZyBieSBzZXR0aW5nIGNvcmUucXVvdGVwYXRoIHRvIGZhbHNl
LiAgVGhpcwo+Pj4gYWxsb3dlZCBtZSB0byBtYWtlIHN0Zy1yZWJhc2UuCj4+Cj4+IEkgY2FuIGFk
ZCBhIHdvcmthcm91bmQgaW4gU3RHSVQgdG8gYWN0dWFsbHkgaWdub3JlIHRoZSBleGNlcHRpb24K
Pj4gcmFpc2VkIGJ5IG9zLnJlbW92ZSgpIGJ1dCBJIGRvbid0IGtub3cgaG93IHRvIGNvbnZlcnQg
dGhlIHF1b3RlZCBmaWxlCj4+IG5hbWUgYmFjayB0byBpdHMgdW5pY29kZSB2YWx1ZSBpbiBQeXRo
b24uCj4KPiBJbiBQZXJsIGl0IGlzIGFzIHNpbXBsZSBhcyAoc2VlIHVucXVvdGUoKSBpbiBnaXR3
ZWIvZ2l0d2ViLnBlcmwpCgpBY3R1YWxseSwgUHl0aG9uIHNlZW1zIE9LIGF0IGhhbmRsaW5nIHF1
b3RlZCBjaGFyYWN0ZXJzLCB0aGUgb25seQpjb25mdXNpb24gaXMgdGhhdCBpdCBkb3VibGVzIHRo
ZSBiYWNrc2xhc2ggaW4gdGhlIHN0cmluZyBzaW5jZSBpdApkb2Vzbid0IGtub3cgdGhhdCB0aGUg
dGV4dCByZWNlaXZlZCBmcm9tIEdpdCBpcyBxdW90ZWQgb3Igbm90LiBJIHdvdWxkCnByb2JhYmx5
IGhhdmUgdG8gY2hlY2sgZm9yIHRoZSAiY29yZS5xdW90ZXBhdGgiIHZhbHVlIGFuZCBhY3QKYWNj
b3JkaW5nbHkuCgotLSAKQ2F0YWxpbgo=
