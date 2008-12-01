From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 1/8] generate-cmdlist.sh: avoid selecting synopsis at wrong place
Date: Mon, 1 Dec 2008 21:11:24 +0700
Message-ID: <fcaeb9bf0812010611p68b48f65x3c078180d1089d41@mail.gmail.com>
References: <1228042478-1886-1-git-send-email-pclouds@gmail.com>
	 <1228042478-1886-2-git-send-email-pclouds@gmail.com>
	 <alpine.DEB.1.00.0812011505551.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 15:13:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79WL-0007CX-M3
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbYLAOL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbYLAOL3
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:11:29 -0500
Received: from gv-out-0910.google.com ([216.239.58.188]:50277 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbYLAOL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:11:27 -0500
Received: by gv-out-0910.google.com with SMTP id e6so340696gvc.37
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 06:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9jTV9E+Z4SZEFZkwZPNfmSajUzQCpqAPtvEDOTRvAMU=;
        b=HiGRLBBpC2gzk5b4bkx/icYSVYb6dVhav2CCGZWg8E7I8XuEdJ/ZrgT+8SjpACkSJu
         Cg49ITDk7N06GL872PxYHdoqJj9EVL7M0PXVznKaYRkRDu8GnOVdVbbSvYQcrKrDamZM
         W9WYeZ+nuBpk/O94ZcaTnsWQVuxPwKteCudT0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lOeQE8EuId5U9Ic0pxSxk3Nuotlr6DjCpHyTYDubKcBsGHEVLfNUHlwu7a78h70wol
         gKWILh02pwEROMHRdq9eivXj5FldvKHRC6uXEuPX3ZRmE1llJIhc62jOjwmYquyVcV9V
         AmKdMp85gwse/UZO4QOk9ifnHRsvhorsGTa2Y=
Received: by 10.86.74.4 with SMTP id w4mr6371095fga.2.1228140684648;
        Mon, 01 Dec 2008 06:11:24 -0800 (PST)
Received: by 10.86.62.13 with HTTP; Mon, 1 Dec 2008 06:11:24 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0812011505551.30769@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102037>

T24gMTIvMS8wOCwgSm9oYW5uZXMgU2NoaW5kZWxpbiA8Sm9oYW5uZXMuU2NoaW5kZWxpbkBnbXgu
ZGU+IHdyb3RlOgo+IEhpLAo+Cj4KPiAgT24gU3VuLCAzMCBOb3YgMjAwOCwgTmd1ecKtbiBUaMOh
aSBOZ8O3YyBEdXkgd3JvdGU6Cj4KPiAgPiBJbiAiY29tbW9uIiBtYW4gcGFnZXMgdGhlcmUgaXMg
bHVja2lseSBubyAiTkFNRSIgYW55d2hlcmUgZXhjZXB0IGF0Cj4gID4gYmVnaW5uaW5nIG9mIGRv
Y3VtZW50cy4gSWYgdGhlcmUgaXMgYW5vdGhlciAiTkFNRSIsIHNlZCBjb3VsZCBtaXMtc2VsZWN0
Cj4gID4gaXQgYW5kIGxlYWQgdG8gY29tbW9uLWNtZHMuaCBjb3JydXB0aW9uLiBTbyBiZXR0ZXIg
bmFpbCBpdCBhdCBiZWdpbm5pbmcKPiAgPiBvZiBsaW5lLCB3aGljaCB3b3VsZCByZWR1Y2UgY29y
cnVwdGlvbiBjaGFuY2UuCj4KPgo+IEkgaGF2ZSBubyBpZGVhIHdoeSB5b3UgcHV0IHRoaXMgaW50
byB0aGUgc3BhcnNlIGNoZWNrb3V0IHBhdGNoIHNlcmllcy4KCkl0J3MgbW9yZSBhbiBpbmRlcGVu
ZGVudCBidWcgZml4LiBJIHBvc3RlZCB0aGlzIG9uY2UgYnV0IGl0IHdhcyBub3QKY2F1Z2h0IHVw
LiBJIGludGVuZGVkIHRvIGp1c3QgcHV0IHNvbWUgY29tbWVudHMgaW4gQkxVUkIgYXJlYSB0byB0
ZWxsCnBlb3BsZSB0byBnZXQgdGhpcyBwYXRjaCBmcm9tIG1haWwgYXJjaGl2ZS4gQnV0IHRoYXQg
d2F5IHNlZW1zCmluY29udmVuaWVudC4gV2l0aG91dCB0aGlzIHBhdGNoLCB5b3Ugd29uJ3QgYmUg
YWJsZSB0byBjb21waWxlIHRoZQpzZXJpZXMgYmVjYXVzZSBvZiBjb21tb24tY21kcy5oIGNvcnJ1
cHRpb24uCi0tIApEdXkK
