From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 19:35:39 +0000
Message-ID: <AANLkTinVFvv2J4z36zc9LAs+_-Pp2_+bYeLVxVeavWtJ@mail.gmail.com>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
	<7v39tveq0j.fsf@alter.siamese.dyndns.org>
	<AANLkTinKgOdgTpORf-NSJ1wpURw9xOkQ3rXZvmV6XtBb@mail.gmail.com>
	<20100831180832.GQ2315@burratino>
	<AANLkTikk8nVyvp0hTycMY9bjMub38msxrOHMMLNER_DS@mail.gmail.com>
	<20100831192247.GU2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:35:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWcW-00064f-7n
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab0HaTfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 15:35:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33968 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718Ab0HaTfm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 15:35:42 -0400
Received: by iwn5 with SMTP id 5so6070117iwn.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qzyL4edtLHYBJD0ulXa2r0ItPtgs7M11Tr008XrDU0s=;
        b=EjyafoATz2Q/x58vK0eQJ5BcgpF7NSmmpwnF+Qs358UVAESWqzAt4qXysaJ74O1uI/
         JBPk3Ue3NRpt+z97tWIzvIhHsL3ZV3uDShzQY6Fv5GBp6LWw9WOkjc+vQ8qfWmUylv3G
         FHfREubCLqlDH0JFxvxf8LlkleLktTzKipeDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qoixQMZ3xQ9Bs7O37hl/L+4OqeAswHCEb1dmn6sz/NuQ3S6z1EIUkxe0cXnVASVp6c
         uRopYQ26UJCdC1KIy0kg3vm6p3pn1g9qfxdqOjzxT94rSO90tUfpkx30M8FDqiRXXbpb
         KH7pNooLBw9+OttFUjdN5an8gRxJRk+2JitJM=
Received: by 10.231.13.133 with SMTP id c5mr7025501iba.73.1283283339752; Tue,
 31 Aug 2010 12:35:39 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 31 Aug 2010 12:35:39 -0700 (PDT)
In-Reply-To: <20100831192247.GU2315@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154974>

T24gVHVlLCBBdWcgMzEsIDIwMTAgYXQgMTk6MjIsIEpvbmF0aGFuIE5pZWRlciA8anJuaWVkZXJA
Z21haWwuY29tPiB3cm90ZToKPiDDhnZhciBBcm5masO2csOwIEJqYXJtYXNvbiB3cm90ZToKPgo+
PiBNYXliZSwgYnV0IGl0J2xsIGFsd2F5cyBiZSAtLW91dHB1dD1wby9naXQucG90IHNvIEkgc2F3
IG5vIHJlYXNvbiB0bwo+PiBzZXBlcmF0ZSBpdC4gU2hvdWxkIGl0IGJlPwo+Cj4gTm8gYmlnIGRl
YWwuIMKgSSBhbSB2YWd1ZWx5IHdvcnJpZWQgYWJvdXQgaW50ZXJydXB0ZWQgIm1ha2UiCj4gaW52
b2NhdGlvbnMuIMKgRG9uJ3QgZ2V0dGV4dGl6ZWQgcGFja2FnZXMgdHlwaWNhbGx5IGRvIHNvbWV0
aGluZyBsaWtlIHRoaXM/Cj4KPiDCoCDCoCDCoCDCoHJlbW92ZV9jcmVhdGlvbl9kYXRlKCkgewo+
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc2VkICcjIS9iaW4vc2VkIC1mCj4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvXiJQT1QtQ3JlYXRpb24tRGF0ZTogLioiJC8hYgo+IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgeAo+IMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIyBUZXN0IGlmIHRoZSBob2xkIHNwYWNlIGlzIGVtcHR5Lgo+IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcy9QL1AvCj4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqB0YQo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IyBZZXMgaXQgd2FzIGVtcHR5LiBGaXJzdCBvY2N1cnJlbmNlLiBSZW1vdmUgdGhlIGxpbmUuCj4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBnCj4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBkCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBi
Ygo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgOmEKPiDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCMgVGhlIGhvbGQgc3BhY2Ugd2FzIG5vbmVtcHR5LiBGb2xs
b3dpbmcgb2NjdXJyZW5jZXMuIERvIG5vdGhpbmcuCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqB4Cj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA6YicKPiDC
oCDCoCDCoCDCoH0KPiDCoCDCoCDCoCDCoChjZCBwbyAmJiB4Z2V0dGV4dCAtLWRlZmF1bHQtZG9t
YWluPWdpdCAuLi4pCj4gwqAgwqAgwqAgwqBzZXQgLWU7IFwKPiDCoCDCoCDCoCDCoGlmIHRlc3Qg
LWYgcG8vZ2l0LnBvdCAmJgo+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmVtb3ZlX2NyZWF0aW9u
X2RhdGUgPHBvL2dpdC5wb3QgPnBvL2dpdC4xcG8rICYmCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqByZW1vdmVfY3JlYXRpb25fZGF0ZSA8cG8vZ2l0LnBvID5wby9naXQuMnBvKyAmJgo+IMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgY21wIHBvL2dpdC4xcG8rIHBvL2dpdC4ycG8rOyBcCj4gwqAgwqAg
wqAgwqB0aGVuIFwKPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJtIC1mIHBvL2dpdC4xcG8rIHBv
L2dpdC4ycG8rIHBvL2dpdC5wbzsgXAo+IMKgIMKgIMKgIMKgZWxzZSBcCj4gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBybSAtZiBwby9naXQuMXBvKyBwby9naXQuMnBvKyBwby9naXQucG90OyBcCj4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBtdiBwby9naXQucG8gcG8vZ2l0LnBvdDsgXAo+IMKgIMKg
IMKgIMKgZmkKPgo+PiBUaGUgLW8gZm9yIHRoZSBDIGNvbXBpbGVyIGNoYW5nZXMsIGJ1dCB0aGUK
Pj4gIm1ha2UgcG90IiB0YXJnZXQgd2lsbCBhbHdheXMgd3JpdGUgdG8gcG8vZ2l0LnBvdC4KPgo+
IEluIHBhcnRpY3VsYXIsIHRvIGF2b2lkIHVzaW5nIGEgcGFydGlhbCAucG90IGZpbGUsIG9uZSBt
aWdodCB3YW50IHRvIHdyaXRlIHRvCj4gcG8vZ2l0LnBvdCssIHBvL2dpdC5wbywgb3Igc2ltaWxh
ciBhbmQgdGhlbiByZW5hbWUgaXQuCgpJIGRvbid0IGtub3cgd2hhdCB0aGV5IHVzdWFsbHkgZG8u
IEJ1dCB0aGF0IGxvb2tzIGxpa2UgYSBsb3Qgb2Ygd29yawp0byB3b3JrIGFyb3VuZCBhIHZlcnkg
cmFyZSBwb3RlbnRpYWwgZWRnZSBjYXNlLiAibWFrZSBwb3QiIGlzIG9ubHkKZXZlciBydW4gbWFu
dWFsbHkgYnkgYSB0cmFuc2xhdG9yIHJpZ2h0IGJlZm9yZSBtc2dtZXJnZS4KCkluIHRoZSB2ZXJ5
IHJhcmUgY2FzZSB3aGVyZSBtYWtlIGlzIGludGVycnVwdGVkIGFuZCBnaXQucG90IGlzIGxlZnQg
aW4KYSBwYXJ0aWFsIHN0YXRlIHlvdSdsbCBub3RpY2UgYmVjYXVzZSB5b3VyIG1zZ21lcmdlIGZh
aWxzLgoKPj4gT3I6IGdpdDovL2dpdGh1Yi5jb20vYXZhci9naXQuZ2l0IGdldHRleHRpemUtZ2l0
LW1haW5wb3JjZWxhaW4tdjMKPgo+IExvb2tzIGdvb2QuCgpUaGFua3MgZm9yIGNoZWNraW5nIGl0
IG91dC4K
