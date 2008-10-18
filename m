From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 1/3] add alloc_ref_with_prefix()
Date: Sat, 18 Oct 2008 11:27:56 +0200
Message-ID: <36ca99e90810180227u367783f6vc3b7af0176f6df06@mail.gmail.com>
References: <48F9A054.4010703@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Oct 18 11:29:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr87T-0002w9-5L
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 11:29:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbYJRJ17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 05:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbYJRJ16
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 05:27:58 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:29215 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbYJRJ16 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 05:27:58 -0400
Received: by yx-out-2324.google.com with SMTP id 8so181276yxm.1
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 02:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Uep6+XRhpqGZGKeHDbLfTpDVURWn7yUT/+WKBTdC3dY=;
        b=ZQSPkuZ8vk5RTGHl4AJhACaw0FCSt7C6XsCrHpzqCK9eXN6B45UU7LC1gkgGdE0A0E
         4Idncl9hHleUHgt1pktmxFnrtwGB9KaRrbxym6F9P9L/PpSiN52D1M8jRO//0cp1YsYM
         S+gmuOb8qtflbZieBdI3663VeHRTmVG+N/OR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dwIe+9DdIfT3EIq6e7gUh1bgZt+UB/MJO5y2mAbsOALAHW1c+EjjNYmTFRuAZNPigR
         mnhxY2xfWxSe3fKMvO5mB7H2CAG4yOfM4k4KM2IHHrPAIKaoolo/AiyrMRfz3iKIJs3M
         /1unhz9vVymhtxRxB6wtY4/bDjuEHltditnQE=
Received: by 10.151.108.15 with SMTP id k15mr7717810ybm.53.1224322076842;
        Sat, 18 Oct 2008 02:27:56 -0700 (PDT)
Received: by 10.150.204.17 with HTTP; Sat, 18 Oct 2008 02:27:56 -0700 (PDT)
In-Reply-To: <48F9A054.4010703@lsrfire.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98533>

T24gU2F0LCBPY3QgMTgsIDIwMDggYXQgMTA6MzcsIFJlbsOpIFNjaGFyZmUgPHJlbmUuc2NoYXJm
ZUBsc3JmaXJlLmF0aC5jeD4gd3JvdGU6Cj4gSW4gdGhyZWUgY2FzZXMgaW4gcmVtb3RlLmMsIGEg
InJhdyIgcmVmIGlzIGFsbG9jYXRlZCB1c2luZyBhbGxvY19yZWYoKQo+IGFuZCB0aGVuIGl0cyBp
cyBjb25zdHJ1Y3RlZCB1c2luZyBzcHJpbnRmKCkuICBDbGVhbiBpdCB1cCBieSBhZGRpbmcgYQo+
IGhlbHBlciBmdW5jdGlvbiwgYWxsb2NfcmVmX3dpdGhfcHJlZml4KCksIHdoaWNoIGNyZWF0ZXMg
YSBjb21wb3NpdGUKPiBuYW1lLiAgVXNlIGl0IGluIGFsbG9jX3JlZl9mcm9tX3N0cigpLCB0b28s
IGFzIGl0IHNpbXBsaWZpZXMgdGhlIGNvZGUuCj4KPiBPcGVuIGNvZGUgYWxsb2NfcmVmKCkgaW4g
YWxsb2NfcmVmX3dpdGhfcHJlZml4KCksIGFzIHRoZSBmb3JtZXIgaXMKPiBnb2luZyB0byBiZSBy
ZW1vdmVkIGluIHRoZSBwYXRjaCBhZnRlciB0aGUgbmV4dC4KPgo+IFNpZ25lZC1vZmYtYnk6IFJl
bmUgU2NoYXJmZSA8cmVuZS5zY2hhcmZlQGxzcmZpcmUuYXRoLmN4Pgo+IC0tLQo+ICByZW1vdGUu
YyB8ICAgMzIgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlcyBjaGFu
Z2VkLCAxNiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9y
ZW1vdGUuYyBiL3JlbW90ZS5jCj4gaW5kZXggOGEwNDA2Ni4uOThjYmNmOSAxMDA2NDQKPiAtLS0g
YS9yZW1vdGUuYwo+ICsrKyBiL3JlbW90ZS5jCj4gQEAgLTc0OSw2ICs3NDksMTYgQEAgaW50IHJl
bW90ZV9maW5kX3RyYWNraW5nKHN0cnVjdCByZW1vdGUgKnJlbW90ZSwgc3RydWN0IHJlZnNwZWMg
KnJlZnNwZWMpCj4gICAgICAgIHJldHVybiAtMTsKPiAgfQo+Cj4gK3N0YXRpYyBzdHJ1Y3QgcmVm
ICphbGxvY19yZWZfd2l0aF9wcmVmaXgoY29uc3QgY2hhciAqcHJlZml4LCBzaXplX3QgcHJlZml4
bGVuLAo+ICsgICAgICAgICAgICAgICBjb25zdCBjaGFyICpuYW1lKQo+ICt7Cj4gKyAgICAgICBz
aXplX3QgbGVuID0gc3RybGVuKG5hbWUpOwo+ICsgICAgICAgc3RydWN0IHJlZiAqcmVmID0geGNh
bGxvYygxLCBzaXplb2Yoc3RydWN0IHJlZikgKyBwcmVmaXhsZW4gKyBsZW4gKyAxKTsKPiArICAg
ICAgIG1lbWNweShyZWYtPm5hbWUsIHByZWZpeCwgcHJlZml4bGVuKTsKPiArICAgICAgIG1lbWNw
eShyZWYtPm5hbWUgKyBwcmVmaXhsZW4sIG5hbWUsIGxlbik7CldoZXJlIGRvZXMgeW91IFwwLXRl
cm1pbmF0ZSB0aGUgc3RyaW5nPwoKUmVnYXJkcwpCZXJ0Cg==
