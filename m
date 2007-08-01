From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Hack git-add--interactive to make it work with ActiveState Perl
Date: Wed, 1 Aug 2007 15:09:14 +0200
Message-ID: <81b0412b0708010609h3346704bg4f708100bb5d6b93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_46998_19185652.1185973754235"
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 15:09:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGDx7-0004As-GO
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 15:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762407AbXHANJR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 09:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762508AbXHANJR
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 09:09:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:46246 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762309AbXHANJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 09:09:15 -0400
Received: by ug-out-1314.google.com with SMTP id j3so202828ugf
        for <git@vger.kernel.org>; Wed, 01 Aug 2007 06:09:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=axoKKcewgyrtpq5l4LpiNcRcKg04b1TOVVOE2FabFE5bkt1PiY2HnQB6c98aME5fPy2R0KKJjqyqoc65g/RdPEaJnFpBAiJsZD8MuAEVcShfs1kMxlmDZ2POM/LX3jshjNJ+EN6jDmXI52N/y+npcCdToIeU032u+Vt/UWWXoBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=QZUOVGCb8rcFDMj1Umc9dDJ+6dDGKqj6mdIFjd6LJuYOASavL5ovcSeytyLxhGxRVqAzYXBOHTUu8kCkT+dvXlouYHCD+Ax0O2qpQe7O79GzE8QqydoPlGKOTMk3DE8FaGD0bgZ8ejsOBd3iQYdqiUeEEr+LOc+nnL/MWzj2GOI=
Received: by 10.78.140.16 with SMTP id n16mr177961hud.1185973754269;
        Wed, 01 Aug 2007 06:09:14 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 1 Aug 2007 06:09:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54432>

------=_Part_46998_19185652.1185973754235
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It wont work for arguments with special characters (like ", : or *).
It is generally not possible on Windows, so I didn't even try.
---
 git-add--interactive.perl |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

------=_Part_46998_19185652.1185973754235
Content-Type: text/plain; name="0001-Hack-git-add-interactive-to-make-it-work-with-ActiveS.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Hack-git-add-interactive-to-make-it-work-with-ActiveS.txt"
X-Attachment-Id: f_f4tu7m4j

RnJvbSAwMjA2YjE2NWRhYjcxYjBkYzYzOTZmODhjZmI4ZjcwZjY3Mjc3ZGRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDEgQXVnIDIwMDcgMTQ6NTc6NDMgKzAyMDAKU3ViamVjdDogW1BBVENIXSBIYWNrIGdp
dC1hZGQtLWludGVyYWN0aXZlIHRvIG1ha2UgaXQgd29yayB3aXRoIEFjdGl2ZVN0YXRlIFBlcmwK
Ckl0IHdvbnQgd29yayBmb3IgYXJndW1lbnRzIHdpdGggc3BlY2lhbCBjaGFyYWN0ZXJzIChsaWtl
ICIsIDogb3IgKikuCkl0IGlzIGdlbmVyYWxseSBub3QgcG9zc2libGUgb24gV2luZG93cywgc28g
SSBkaWRuJ3QgZXZlbiB0cnkuCi0tLQogZ2l0LWFkZC0taW50ZXJhY3RpdmUucGVybCB8ICAgMTkg
KysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1hZGQtLWludGVyYWN0aXZlLnBlcmwgYi9n
aXQtYWRkLS1pbnRlcmFjdGl2ZS5wZXJsCmluZGV4IGRjMzAzODAuLjc5MjFjZGUgMTAwNzU1Ci0t
LSBhL2dpdC1hZGQtLWludGVyYWN0aXZlLnBlcmwKKysrIGIvZ2l0LWFkZC0taW50ZXJhY3RpdmUu
cGVybApAQCAtMyw5ICszLDE2IEBACiB1c2Ugc3RyaWN0OwogCiBzdWIgcnVuX2NtZF9waXBlIHsK
LQlteSAkZmggPSB1bmRlZjsKLQlvcGVuKCRmaCwgJy18JywgQF8pIG9yIGRpZTsKLQlyZXR1cm4g
PCRmaD47CisJaWYgKCReTyBlcSAnTVNXaW4zMicpIHsKKwkJbXkgQGludmFsaWQgPSBncmVwIHtt
L1siOipdL30gQF87CisJCWRpZSAiJF5PIGRvZXMgbm90IHN1cHBvcnQ6IEBpbnZhbGlkXG4iIGlm
IEBpbnZhbGlkOworCQlteSBAYXJncyA9IG1hcCB7IG0vIC9vID8gIlwiJF9cIiI6ICRfIH0gQF87
CisJCXJldHVybiBxeHtAYXJnc307CisJfSBlbHNlIHsKKwkJbXkgJGZoID0gdW5kZWY7CisJCW9w
ZW4oJGZoLCAnLXwnLCBAXykgb3IgZGllOworCQlyZXR1cm4gPCRmaD47CisJfQogfQogCiBteSAo
JEdJVF9ESVIpID0gcnVuX2NtZF9waXBlKHF3KGdpdCByZXYtcGFyc2UgLS1naXQtZGlyKSk7CkBA
IC0xNyw3ICsyNCw3IEBAIGNob21wKCRHSVRfRElSKTsKIAogc3ViIHJlZnJlc2ggewogCW15ICRm
aDsKLQlvcGVuICRmaCwgJy18JywgcXcoZ2l0IHVwZGF0ZS1pbmRleCAtLXJlZnJlc2gpCisJb3Bl
biAkZmgsICdnaXQgdXBkYXRlLWluZGV4IC0tcmVmcmVzaCB8JwogCSAgICBvciBkaWU7CiAJd2hp
bGUgKDwkZmg+KSB7CiAJCTsjIGlnbm9yZSAnbmVlZHMgdXBkYXRlJwpAQCAtMjk2LDcgKzMwMyw3
IEBAIHN1YiByZXZlcnRfY21kIHsKIAkJbXkgQGxpbmVzID0gcnVuX2NtZF9waXBlKHF3KGdpdCBs
cy10cmVlIEhFQUQgLS0pLAogCQkJCQkgbWFwIHsgJF8tPntWQUxVRX0gfSBAdXBkYXRlKTsKIAkJ
bXkgJGZoOwotCQlvcGVuICRmaCwgJ3wtJywgcXcoZ2l0IHVwZGF0ZS1pbmRleCAtLWluZGV4LWlu
Zm8pCisJCW9wZW4gJGZoLCAnfCBnaXQgdXBkYXRlLWluZGV4IC0taW5kZXgtaW5mbycKIAkJICAg
IG9yIGRpZTsKIAkJZm9yIChAbGluZXMpIHsKIAkJCXByaW50ICRmaCAkXzsKQEAgLTcyNSw3ICs3
MzIsNyBAQCBzdWIgcGF0Y2hfdXBkYXRlX2NtZCB7CiAJaWYgKEByZXN1bHQpIHsKIAkJbXkgJGZo
OwogCi0JCW9wZW4gJGZoLCAnfC0nLCBxdyhnaXQgYXBwbHkgLS1jYWNoZWQpOworCQlvcGVuICRm
aCwgJ3wgZ2l0IGFwcGx5IC0tY2FjaGVkJzsKIAkJZm9yIChAeyRoZWFkLT57VEVYVH19LCBAcmVz
dWx0KSB7CiAJCQlwcmludCAkZmggJF87CiAJCX0KLS0gCjEuNS4zLnJjMy4xNDUuZzRkOWNkYgoK

------=_Part_46998_19185652.1185973754235--
