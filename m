From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Problems with large compressed binaries when converting from svn
Date: Thu, 8 Jan 2009 00:55:54 +0100
Message-ID: <81b0412b0901071555t62c1da3ar2b2cfd14222b502e@mail.gmail.com>
References: <c09652430901060455l5179888ep3c51ff4e3dd5a6ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Cc: git@vger.kernel.org
To: "=?UTF-8?Q?=C3=98yvind_Harboe?=" <oyvind.harboe@zylin.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 00:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKiH3-0001ME-Ex
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 00:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbZAGXz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 18:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbZAGXz4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 18:55:56 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:42315 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbZAGXzz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 18:55:55 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4453753wah.21
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 15:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DwpBj4XOxfSYZtGVcTF0l6sL/IPMY350Jaf+abdqqT8=;
        b=b5lp7Tas4NugRTdYNdWq5f2BV6nfploluK8iGDBrpxrZHYegc+thgIyCCgUw92rInc
         VOgdb1o1FjgL5FrRuDVH5f84Y8fZ8pa2vtoPzxX3l73pfAfyF9hblGTnN1PD4HrIOHCS
         P6lz0TMXoZPdR9NWqOjKIma7JA6HIICFbngUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=cWcAVmDeFqNhg/6o9f2/UaDE1ii45t0qOXT55NCHiZ9fhHlwPOuUA7EkhehDYwAfnT
         vRS9IFMGK2MQ3D9eqkNyowK6o2/S9t8JBdIBEUs316icxkfq7c2wxRNGOtDxzfXGCbn8
         Wjkiq1S6CfpR+eufbYCSbBZblGrjRErXdQgMU=
Received: by 10.114.133.1 with SMTP id g1mr15640752wad.21.1231372554059;
        Wed, 07 Jan 2009 15:55:54 -0800 (PST)
Received: by 10.114.179.4 with HTTP; Wed, 7 Jan 2009 15:55:54 -0800 (PST)
In-Reply-To: <c09652430901060455l5179888ep3c51ff4e3dd5a6ef@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104852>

MjAwOS8xLzYgw5h5dmluZCBIYXJib2UgPG95dmluZC5oYXJib2VAenlsaW4uY29tPjoKPiBJJ20g
Y29udmVydGluZyBmcm9tIHN2biBhbmQgSSd2ZSBydW4gaW50byBhCj4gcHJvYmxlbSB3aXRoIHRh
ci5neiBhbmQgdGFyLmJ6MiBjb21wcmVzc2VkIGZpbGVzLgo+Cj4gKFRoaXMgaXMgYSBzZXBhcmF0
ZSBidXQgb25seSBzbGlnaHRseSByZWxhdGVkIHRvIHByZXZpb3VzIHBvc3QpLgo+Cj4gSW4gc3Vi
dmVyc2lvbiB3ZSBjb21taXR0ZWQgbGFyZ2UgdGFyLmJ6Mi9neiBmaWxlcy4gVGhlc2UgZmlsZXMg
d291bGQKPiBjaGFuZ2UgcmVsYXRpdmVseSByYXJlbHksIGJ1dCBvbmx5IHZlcnkgc2xpZ2h0bHku
ICBUaGUgdHJvdWJsZSB3aXRoIHRoZSB0YXIuYnoyCj4gZm9ybWF0IGlzIHRoYXQgaWYgdGhlIGZp
cnN0IGJ5dGUgY2hhbmdlcywgdGhlbiB0aGUgcmVzdCBvZiB0aGUgZmlsZSB3aWxsIGFsc28KPiBi
ZSBkaWZmZXJlbnQuIC56aXAgZG9lcyBub3QgaGF2ZSB0aGlzIHByb2JsZW0sIGJ1dCAuemlwIGlz
bid0IGEgdmVyeSBmcmllbmRseQo+IGZvcm1hdCBmb3Igb3VyIHB1cnBvc2VzLgo+Cj4gTGF0ZXIg
b24gdGhlIHRhci5iejIvZ3ogZmlsZXMgc3RhcnRlZCB0byBjaGFuZ2UgZmFpcmx5IG9mdGVuLCBi
dXQgaGFyZGRyaXZlcwo+IGdldCBiaWdnZXIgbXVjaCBtb3JlIHF1aWNrbHkgdGhhbiB0aGUgLnN2
biByZXBvc2l0b3J5IGdyb3dzIHNvIHdlIGp1c3QKPiBrZXB0IGRvaW5nIHRoaW5ncyB0aGUgc2Ft
ZSB3YXkgcmF0aGVyIHRoYW4gcmVlZHVjYXRlIGFuZCByZWVuZ2luZWVyCj4gdGhlIHByb2NlZHVy
ZXMuCj4KPiBXaXRoIC5naXQgd2UgbmVlZCB0byBoYW5kbGUgdGhpcyBkaWZmZXJlbnRseSBzb21l
aG93Lgo+Cj4gRG9lcyBnaXQgaGF2ZSBzb21lIGNhcGFiaWxpdHkgdG8gc3RvcmUgZGlmZnMgb2Yg
Y29tcHJlc3NlZCBmaWxlcyBlZmZpY2llbnRseT8KCk5vLCBidXQgeW91IGNhbiB1bnBhY2sgdGhl
IHRhcmJhbGxzIGFuZCBpbmNsdWRlIHRoZSB0b29sY2hhaW5zIGFzIHN1Ym1vZHVsZXMKKGFrYSBz
dWJwcm9qZWN0cykgaW4gdGhlIHByb2plY3RzIHdoaWNoIG5lZWQgdGhlbS4KClNlZSBtYW4gcGFn
ZSB0byBnaXQgc3VibW9kdWxlLCB0aGUgdXNlci1tYW51YWwudHh0IG9uICJzdWJtb2R1bGUiIGFu
ZApnaXRtb2R1bGVzLnR4dCAoc3VibW9kdWxlIGNvbmZpZ3VyYXRpb24gZm9ybWF0cyBhbmQgY29u
dmVudGlvbnMpLgo=
