From: "Richard Hartmann" <richih.mailinglist@gmail.com>
Subject: [Patch] Minor corrections to help & error messages
Date: Mon, 22 Dec 2008 00:53:09 +0100
Message-ID: <2d460de70812211553q56d20fb0rfbd2f8fdd555103a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_59526_25041366.1229903589396"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 00:54:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEY7y-0007i4-K5
	for gcvg-git-2@gmane.org; Mon, 22 Dec 2008 00:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbYLUXxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 18:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbYLUXxM
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 18:53:12 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:60527 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbYLUXxK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 18:53:10 -0500
Received: by an-out-0708.google.com with SMTP id d40so610041and.1
        for <git@vger.kernel.org>; Sun, 21 Dec 2008 15:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type;
        bh=67qrZzthtprv7lIBb2TmXm8rLHSKIBysUMHxgJwOEzI=;
        b=sMn9o2kT2TLXCwwDawvQiPATK/KAtwkoRlazEM22iljQOYL96MASvvTEd2mjeaNQl+
         1kcyuX9KeN5bHxApRh3iwhV8+xAQ6xpXOpaUEPd1Z9FR0jNCvWk2sOBiXriC9gLapHWB
         QRPbedL0tkzcBcjgAUd73yZhQB9MvKTeQz29k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=uW2s1zOHlpSNfQ6QmZorxdf92Sk9GFEiNudZOmqgCvb66Tyb1DHIxMmG2CBJ/Nv3MG
         MKNmLGbFW5K5MBjzjjhHTfdfRx8ZdHJYCSfowARrTK4uyHIHSkuE9vK5PTml0+QyKeyR
         Pc+h2kVE0uFYTr/H0goX+SggOJ7cOCcEuNOrk=
Received: by 10.100.6.16 with SMTP id 16mr3512991anf.108.1229903589400;
        Sun, 21 Dec 2008 15:53:09 -0800 (PST)
Received: by 10.100.43.19 with HTTP; Sun, 21 Dec 2008 15:53:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103731>

------=_Part_59526_25041366.1229903589396
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

the two patches should be so obvious, there is not much
need to explain them.

I noticed that quite a few options in the manpages are
not in alphabetical order. Would a patch which fixes
all of those be accepted?


Richard

------=_Part_59526_25041366.1229903589396
Content-Type: text/x-diff; name=0001-Make-help-entries-alphabetical.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fp0cszjf0
Content-Disposition: attachment;
 filename=0001-Make-help-entries-alphabetical.patch

RnJvbSA1OWIyOTFkNzljZGNkYjVmZTIzNTIwMmNiNDU3MDVkZDRmOGYzNTJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSaWNoYXJkIEhhcnRtYW5uIDxyaWNoaWgubWFpbGluZ2xpc3RA
Z21haWwuY29tPgpEYXRlOiBTdW4sIDIxIERlYyAyMDA4IDIzOjI4OjI1ICswMTAwClN1YmplY3Q6
IFtQQVRDSF0gTWFrZSBoZWxwIGVudHJpZXMgYWxwaGFiZXRpY2FsCgpTd2l0Y2hlZCB0aGUgb3Jk
ZXIuIElmIHRoZXJlIGlzIGEgbmVlZCBmb3IgbW9yZSBjaGFuZ2VzLCBJIGNhbiBkbyB0aGVtIGxh
dGVyLgoKU2lnbmVkLW9mZi1ieTogUmljaGFyZCBIYXJ0bWFubiA8cmljaGloQG5ldC5pbi50dW0u
ZGU+Ci0tLQogRG9jdW1lbnRhdGlvbi9jb25maWcudHh0IHwgICAgOCArKysrLS0tLQogMSBmaWxl
cyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9jb25maWcudHh0IGIvRG9jdW1lbnRhdGlvbi9jb25maWcudHh0CmluZGV4
IDIxZWExNjUuLjUyNzg2YzcgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vY29uZmlnLnR4dAor
KysgYi9Eb2N1bWVudGF0aW9uL2NvbmZpZy50eHQKQEAgLTYwMSwxMCArNjAxLDYgQEAgZGlmZi5h
dXRvcmVmcmVzaGluZGV4OjoKIAlhZmZlY3RzIG9ubHkgJ2dpdC1kaWZmJyBQb3JjZWxhaW4sIGFu
ZCBub3QgbG93ZXIgbGV2ZWwKIAknZGlmZicgY29tbWFuZHMsIHN1Y2ggYXMgJ2dpdC1kaWZmLWZp
bGVzJy4KIAotZGlmZi5zdXBwcmVzcy1ibGFuay1lbXB0eTo6Ci0JQSBib29sZWFuIHRvIGluaGli
aXQgdGhlIHN0YW5kYXJkIGJlaGF2aW9yIG9mIHByaW50aW5nIGEgc3BhY2UKLQliZWZvcmUgZWFj
aCBlbXB0eSBvdXRwdXQgbGluZS4gRGVmYXVsdHMgdG8gZmFsc2UuCi0KIGRpZmYuZXh0ZXJuYWw6
OgogCUlmIHRoaXMgY29uZmlnIHZhcmlhYmxlIGlzIHNldCwgZGlmZiBnZW5lcmF0aW9uIGlzIG5v
dAogCXBlcmZvcm1lZCB1c2luZyB0aGUgaW50ZXJuYWwgZGlmZiBtYWNoaW5lcnksIGJ1dCB1c2lu
ZyB0aGUKQEAgLTYzOSw2ICs2MzUsMTAgQEAgZGlmZi5yZW5hbWVzOjoKIAl3aWxsIGVuYWJsZSBi
YXNpYyByZW5hbWUgZGV0ZWN0aW9uLiAgSWYgc2V0IHRvICJjb3BpZXMiIG9yCiAJImNvcHkiLCBp
dCB3aWxsIGRldGVjdCBjb3BpZXMsIGFzIHdlbGwuCiAKK2RpZmYuc3VwcHJlc3MtYmxhbmstZW1w
dHk6OgorCUEgYm9vbGVhbiB0byBpbmhpYml0IHRoZSBzdGFuZGFyZCBiZWhhdmlvciBvZiBwcmlu
dGluZyBhIHNwYWNlCisJYmVmb3JlIGVhY2ggZW1wdHkgb3V0cHV0IGxpbmUuIERlZmF1bHRzIHRv
IGZhbHNlLgorCiBmZXRjaC51bnBhY2tMaW1pdDo6CiAJSWYgdGhlIG51bWJlciBvZiBvYmplY3Rz
IGZldGNoZWQgb3ZlciB0aGUgZ2l0IG5hdGl2ZQogCXRyYW5zZmVyIGlzIGJlbG93IHRoaXMKLS0g
CjEuNS42LjUKCg==
------=_Part_59526_25041366.1229903589396
Content-Type: text/x-diff;
 name=0002-Always-show-which-directory-is-not-a-git-repository.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fp0ct0sw1
Content-Disposition: attachment;
 filename=0002-Always-show-which-directory-is-not-a-git-repository.patch

RnJvbSBiYzMzMmNlYzQzZDFhMzg5Nzg2YzM2ZWU4OTNhMGExZDA5YjExMmJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSaWNoYXJkIEhhcnRtYW5uIDxyaWNoaWgubWFpbGluZ2xpc3RA
Z21haWwuY29tPgpEYXRlOiBNb24sIDIyIERlYyAyMDA4IDAwOjE3OjMyICswMTAwClN1YmplY3Q6
IFtQQVRDSF0gQWx3YXlzIHNob3cgd2hpY2ggZGlyZWN0b3J5IGlzIG5vdCBhIGdpdCByZXBvc2l0
b3J5CgpVbmlmeSBhbGwKCiAgZmF0YWw6IE5vdCBhIGdpdCByZXBvc2l0b3J5CgplcnJvciBtZXNz
YWdlcyBzbyB0aGV5IGluY2x1ZGUgcGF0aCBpbmZvcm1hdGlvbi4KClNpZ25lZC1vZmYtYnk6IFJp
Y2hhcmQgSGFydG1hbm4gPHJpY2hpaEBuZXQuaW4udHVtLmRlPgotLS0KIGNvbnRyaWIvd29ya2Rp
ci9naXQtbmV3LXdvcmtkaXIgfCAgICAyICstCiBwZXJsL0dpdC5wbSAgICAgICAgICAgICAgICAg
ICAgIHwgICAgNCArKy0tCiBzZXR1cC5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMiAr
LQogMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvY29udHJpYi93b3JrZGlyL2dpdC1uZXctd29ya2RpciBiL2NvbnRyaWIvd29ya2Rp
ci9naXQtbmV3LXdvcmtkaXIKaW5kZXggNzk1OWVhYi4uOTkzY2FjZiAxMDA3NTUKLS0tIGEvY29u
dHJpYi93b3JrZGlyL2dpdC1uZXctd29ya2RpcgorKysgYi9jb250cmliL3dvcmtkaXIvZ2l0LW5l
dy13b3JrZGlyCkBAIC0yMiw3ICsyMiw3IEBAIGJyYW5jaD0kMwogIyB3YW50IHRvIG1ha2Ugc3Vy
ZSB0aGF0IHdoYXQgaXMgcG9pbnRlZCB0byBoYXMgYSAuZ2l0IGRpcmVjdG9yeSAuLi4KIGdpdF9k
aXI9JChjZCAiJG9yaWdfZ2l0IiAyPi9kZXYvbnVsbCAmJgogICBnaXQgcmV2LXBhcnNlIC0tZ2l0
LWRpciAyPi9kZXYvbnVsbCkgfHwKLSAgZGllICJcIiRvcmlnX2dpdFwiIGlzIG5vdCBhIGdpdCBy
ZXBvc2l0b3J5ISIKKyAgZGllICJOb3QgYSBnaXQgcmVwb3NpdG9yeTogXCIkb3JpZ19naXRcIiIK
IAogY2FzZSAiJGdpdF9kaXIiIGluCiAuZ2l0KQpkaWZmIC0tZ2l0IGEvcGVybC9HaXQucG0gYi9w
ZXJsL0dpdC5wbQppbmRleCBkZGU5MTA1Li44MzkyYTY4IDEwMDY0NAotLS0gYS9wZXJsL0dpdC5w
bQorKysgYi9wZXJsL0dpdC5wbQpAQCAtMjA0LDE0ICsyMDQsMTQgQEAgc3ViIHJlcG9zaXRvcnkg
ewogCiAJCQl1bmxlc3MgKC1kICIkZGlyL3JlZnMiIGFuZCAtZCAiJGRpci9vYmplY3RzIiBhbmQg
LWUgIiRkaXIvSEVBRCIpIHsKIAkJCQkjIE1pbWljayBnaXQtcmV2LXBhcnNlIC0tZ2l0LWRpciBl
cnJvciBtZXNzYWdlOgotCQkJCXRocm93IEVycm9yOjpTaW1wbGUoJ2ZhdGFsOiBOb3QgYSBnaXQg
cmVwb3NpdG9yeScpOworCQkJCXRocm93IEVycm9yOjpTaW1wbGUoImZhdGFsOiBOb3QgYSBnaXQg
cmVwb3NpdG9yeTogJGRpciIpOwogCQkJfQogCQkJbXkgJHNlYXJjaCA9IEdpdC0+cmVwb3NpdG9y
eShSZXBvc2l0b3J5ID0+ICRkaXIpOwogCQkJdHJ5IHsKIAkJCQkkc2VhcmNoLT5jb21tYW5kKCdz
eW1ib2xpYy1yZWYnLCAnSEVBRCcpOwogCQkJfSBjYXRjaCBHaXQ6OkVycm9yOjpDb21tYW5kIHdp
dGggewogCQkJCSMgTWltaWNrIGdpdC1yZXYtcGFyc2UgLS1naXQtZGlyIGVycm9yIG1lc3NhZ2U6
Ci0JCQkJdGhyb3cgRXJyb3I6OlNpbXBsZSgnZmF0YWw6IE5vdCBhIGdpdCByZXBvc2l0b3J5Jyk7
CisJCQkJdGhyb3cgRXJyb3I6OlNpbXBsZSgiZmF0YWw6IE5vdCBhIGdpdCByZXBvc2l0b3J5OiAk
ZGlyIik7CiAJCQl9CiAKIAkJCSRvcHRze1JlcG9zaXRvcnl9ID0gYWJzX3BhdGgoJGRpcik7CmRp
ZmYgLS1naXQgYS9zZXR1cC5jIGIvc2V0dXAuYwppbmRleCA4MzNjZWQyLi42YjI3N2I2IDEwMDY0
NAotLS0gYS9zZXR1cC5jCisrKyBiL3NldHVwLmMKQEAgLTQ2OCw3ICs0NjgsNyBAQCBjb25zdCBj
aGFyICpzZXR1cF9naXRfZGlyZWN0b3J5X2dlbnRseShpbnQgKm5vbmdpdF9vaykKIAkJCQkqbm9u
Z2l0X29rID0gMTsKIAkJCQlyZXR1cm4gTlVMTDsKIAkJCX0KLQkJCWRpZSgiTm90IGEgZ2l0IHJl
cG9zaXRvcnkiKTsKKwkJCWRpZSgiTm90IGEgZ2l0IHJlcG9zaXRvcnkgKG9yIGFueSBvZiB0aGUg
cGFyZW50IGRpcmVjdG9yaWVzKTogJXMiLCBERUZBVUxUX0dJVF9ESVJfRU5WSVJPTk1FTlQpOwog
CQl9CiAJCWlmIChjaGRpcigiLi4iKSkKIAkJCWRpZSgiQ2Fubm90IGNoYW5nZSB0byAlcy8uLjog
JXMiLCBjd2QsIHN0cmVycm9yKGVycm5vKSk7Ci0tIAoxLjUuNi41Cgo=
------=_Part_59526_25041366.1229903589396--
