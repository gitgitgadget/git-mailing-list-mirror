From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] .gitignore += vim swap files
Date: Thu, 18 Sep 2008 19:56:40 +0200
Message-ID: <36ca99e90809181056i534cffc8td8095140db4949bf@mail.gmail.com>
References: <1221755370-6817-1-git-send-email-kirr@landau.phys.spbu.ru>
	 <1221755370-6817-2-git-send-email-kirr@landau.phys.spbu.ru>
	 <36ca99e90809181038o74c73121j59849b3f24fe6469@mail.gmail.com>
	 <20080918174307.GL11602@roro3>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Kirill Smelkov" <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:58:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgNlG-0000TT-0w
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 19:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbYIRR4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 13:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbYIRR4m
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:56:42 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:2423 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbYIRR4l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:56:41 -0400
Received: by an-out-0708.google.com with SMTP id d40so614and.103
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=AGF08scP1SFASDRZvQldApujgil6M69MkmdasmsDO0w=;
        b=tCt9UFWvqL7o/b8DKinTqUOH5eVy5VW05HtKtrOChpWEsRGY9Q4xRfQz7i5VDSHerx
         ZM+tZy3f0b+EBsZTh7I6kxnGimxnyx0mEhmAcTcTo0kwn2/SsqmMssrBTz9fXq3xjW/l
         5NMPDn/hInkLqJ6GSbLy5EvQbYPHpoAdpXtbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rVjAuDCQAJZfzc5sX1Q8XZHD523BQ3b/brG9V3BUbRoHz5585YsokDzLmG6KVQxB2p
         cYkCrCBCJIyZllY/z7t2AfWQ84s70l1YGAxez2uELNGkeIHNL3913iGyi3A2c7NmYI6u
         G0pkQlU6MAvHU6ajkvGXiKtK7obvXswMSFE3k=
Received: by 10.100.177.15 with SMTP id z15mr5718850ane.124.1221760600618;
        Thu, 18 Sep 2008 10:56:40 -0700 (PDT)
Received: by 10.70.36.14 with HTTP; Thu, 18 Sep 2008 10:56:40 -0700 (PDT)
In-Reply-To: <20080918174307.GL11602@roro3>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96232>

T24gVGh1LCBTZXAgMTgsIDIwMDggYXQgMTk6NDMsIEtpcmlsbCBTbWVsa292IDxraXJyQGxhbmRh
dS5waHlzLnNwYnUucnU+IHdyb3RlOgo+IE9uIFRodSwgU2VwIDE4LCAyMDA4IGF0IDA3OjM4OjU4
UE0gKzAyMDAsIEJlcnQgV2VzYXJnIHdyb3RlOgo+PiBPbiBUaHUsIFNlcCAxOCwgMjAwOCBhdCAx
ODoyOSwgS2lyaWxsIFNtZWxrb3YgPGtpcnJAbGFuZGF1LnBoeXMuc3BidS5ydT4gd3JvdGU6Cj4+
ID4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIFNtZWxrb3YgPGtpcnJAbGFuZGF1LnBoeXMuc3BidS5y
dT4KPj4gPiAtLS0KPj4gPiAgLmdpdGlnbm9yZSB8ICAgIDIgKysKPj4gPiAgMSBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCj4+ID4KPj4gPiBkaWZmIC0tZ2l0
IGEvLmdpdGlnbm9yZSBiLy5naXRpZ25vcmUKPj4gPiBpbmRleCA4ODY4ZjJkLi5hYTM5ZGI0IDEw
MDY0NAo+PiA+IC0tLSBhLy5naXRpZ25vcmUKPj4gPiArKysgYi8uZ2l0aWdub3JlCj4+ID4gQEAg
LTE4LDMgKzE4LDUgQEAgdGctaW1wb3J0LnR4dAo+PiA+ICB0Zy1yZW1vdGUKPj4gPiAgdGctcmVt
b3RlLnR4dAo+PiA+ICB0Zwo+PiA+ICsKPj4gPiArKi5zd3AKPj4gY2FuJ3QgeW91IGRvIHRoaXMg
aW4geW91ciAuZ2l0L2luZm8vZXhjbHVkZXM/Cj4+Cj4+IGJlcnQKPgo+IEkgc3VyZSBjYW4sIGJ1
dCBJIHRoaW5rIHRoZSBxdWVzdGlvbiBpcyB3aGF0IGlzIHRoZSBtb3N0IGNvbnZlbmllbnQsIGFu
ZAo+IGZvciBtZSBpdCBpcyBjb252ZW5pZW50IHRvIHN0YXJ0IGhhY2tpbmcgcmlnaHQgb24gZnJl
c2ggdG9wZ2l0IGNsb25lLgo+Cj4KPiBBbHNvLCBpZiB5b3UnbGwgbG9vayBlLmcuIGhlcmU6Cj4K
PiBodHRwOi8vZ2l0Lmtlcm5lbC5vcmcvP3A9bGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51
eC0yLjYuZ2l0O2E9YmxvYjtmPS5naXRpZ25vcmU7aD04NjllMWEzYjY0YjZiZjk2OWVlY2VkODIw
NjkxZTk1NWUwM2UzMDY4O2hiPUhFQUQjbDY1Cj4KPiBJdCBzZWVtcyBlbWFjcyBpcyBzdXBwb3J0
ZWQgaW4gTGludXgga2VybmVsLCBzbyBJJ20gc2xvd2x5IHJlc3RvcmluZyB0aGUKPiBiYWxhbmNl
IGluIGZhdm91ciBvZiB2aW0gOikKdGhhbiBJIHdhbnQgYSBwYXR0ZXJuIGZvciBORWRpdCB0b286
Cgp+KgoKQmVydAo+Cj4gLS0KPiAgICDQktGB0LXQs9C+INGF0L7RgNC+0YjQtdCz0L4sINCa0LjR
gNC40LvQuy4KPgo=
