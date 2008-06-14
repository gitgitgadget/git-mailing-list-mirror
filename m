From: "=?UTF-8?Q?Jo=C3=A3o_Abecasis?=" <joao@abecasis.name>
Subject: [PATCH] git-svn: follow revisions of svm-mirrored repositories
Date: Fri, 13 Jun 2008 23:02:29 -0500
Message-ID: <7bf6f1d20806132102x71422617s26260fdc348a7c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24089_18847667.1213416149160"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 06:04:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Mzh-0002b6-S7
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 06:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbYFNECe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 00:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbYFNECe
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 00:02:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:37929 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYFNECd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 00:02:33 -0400
Received: by ug-out-1314.google.com with SMTP id h2so175963ugf.16
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 21:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:x-google-sender-auth;
        bh=6SXpul90P0LVzIHVcXYMDmipHz7zCrQQgjr+QAwNvnM=;
        b=XBpmmqFQY4X+B6h12hIsJtDoBKKNfZ3X7XVT0TyCoC+0b88fe/Hxg4f/ph80NqnNJA
         qg5Pw4RZSvJ1UNxnfHTactIkma5+qIsVXXHaZVHYt+Ze5QjlDIVT1Va0GUb+XWC3JVS4
         GATC1mP73o3w0F9aUqksls1wtRhIZ10lxkojU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :x-google-sender-auth;
        b=h1Okrzkj6y0qjWarUfHDfWAFPH+LMrcCAoplt3YJPLn3RYNa9dua1DTcctT8dxMQAj
         7HXWV/sGBGBdeAAp1n3Zf7eiNNja5yZ0/PqUTYyUCEC3NrZxIUhMViTZcW/J8Van9pDn
         PzdFbyMHGQs4IJKJLNBNwYWFow9clpG7oAFSM=
Received: by 10.67.116.11 with SMTP id t11mr2055259ugm.61.1213416149121;
        Fri, 13 Jun 2008 21:02:29 -0700 (PDT)
Received: by 10.67.94.6 with HTTP; Fri, 13 Jun 2008 21:02:29 -0700 (PDT)
X-Google-Sender-Auth: bb58cb3ca7160cc6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84961>

------=_Part_24089_18847667.1213416149160
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGksCgpXaGVuIHVzaW5nIGFuIHN2ayBtaXJyb3IgcmVwb3NpdG9yeSBhcyB0aGUgc291cmNlIGZv
ciBnaXQtc3ZuLApmaW5kLXJldiBhbmQgcmViYXNlIGRvbid0IHdvcmsuCgpmaW5kLXJldiB0YWtl
cyBhIHdoaWxlLCB3aGlsZSBpdCB0cmF2ZXJzZXMgYW5kIHByb2Nlc3NlcyBjb21taXQgbG9ncwpm
b3IgdGhlIGJyYW5jaCwgYW5kIHVsdGltYXRlbHkgZmFpbHMgd2l0aCB0aGUgZXJyb3IgbWVzc2Fn
ZTogIlVuYWJsZQp0byBkZXRlcm1pbmUgdXBzdHJlYW0gU1ZOIGluZm9ybWF0aW9uIGZyb20gZ2l0
LXN2biBoaXN0b3J5Ii4gVGhpcwpoYXBwZW5zIGJlY2F1c2UgZmluZC1yZXYgZG9lc24ndCByZWxh
dGUgaW5mb3JtYXRpb24gaW4gdGhlIGNvbW1pdAptZXNzYWdlcyB0byB0aGUgaW50ZXJuYWwgc3Zt
LXNvdXJjZSByZXZpc2lvbiBtYXBzLgoKU2ltaWxhcmx5LCByZWJhc2UgaXMgZmFzdGVyIGJ1dCBz
dGlsbCBleGl0cyB3aXRoIHRoZSBtZXNzYWdlICJVbmFibGUKdG8gZGV0ZXJtaW5lIHVwc3RyZWFt
IFNWTiBpbmZvcm1hdGlvbiBmcm9tIHdvcmtpbmcgdHJlZSBoaXN0b3J5Ii4KClRoZSBhdHRhY2hl
ZCBwYXRjaCBmaXhlcyBhIGNvdXBsZSBvZiB1bmRlcmx5aW5nIGlzc3VlcyB0byBnZXQgYXQgbGVh
c3QKdGhlc2UgdHdvIGNvbW1hbmRzIHdvcmtpbmcuIEFGQUlDVCBpdCBzdGlsbCB3b3JrcyB3ZWxs
IHdpdGggcGxhaW4gc3ZuCnJlcG9zaXRvcmllcy4KCkNhbiB0aGlzIGJlIG1lcmdlZCB1cHN0cmVh
bT8gQW55IGNvbW1lbnRzIGFyZSB3ZWxjb21lLgoKQ2hlZXJzLAoKCi0tIEpvw6NvCg==
------=_Part_24089_18847667.1213416149160
Content-Type: application/octet-stream;
 name=0001-git-svn-follow-revisions-of-svm-mirrored-repositori.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fhfo5xcr0
Content-Disposition: attachment;
 filename=0001-git-svn-follow-revisions-of-svm-mirrored-repositori.patch

RnJvbSA5ZTM0OGE0YTI1ZDBlYTFmZTQ4ZGNmNTE3NWEyODUzMjY3OTMzODYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P3V0Zi04P3E/Sm89QzM9QTNvPTIwQWJlY2FzaXM/PSA8am9h
b0BhYmVjYXNpcy5uYW1lPgpEYXRlOiBGcmksIDEzIEp1biAyMDA4IDIwOjMyOjU3IC0wNTAwClN1
YmplY3Q6IFtQQVRDSF0gZ2l0LXN2bjogZm9sbG93IHJldmlzaW9ucyBvZiBzdm0tbWlycm9yZWQg
cmVwb3NpdG9yaWVzCgpBbHRob3VnaCBnaXQtc3ZuIGtlZXBzIHRyYWNrIG9mIHNvdXJjZSByZXZp
c2lvbnMgaW4gc3ZtLW1pcnJvcmVkCnJlcG9zaXRvcmllcywgaXQgZG9lc24ndCB1c2UgdGhhdCBp
bmZvcm1hdGlvbiBpbiBhbGwgcGxhY2VzLgoKVGhpcyBmaXhlcyB3b3JraW5nX2hlYWRfaW5mbyBh
bmQgR2l0OjpTVk46OmZpbmRfYnlfdXJsIHRvIHdvcmsgd2l0aAptaXJyb3JlZCByZXBvc2l0b3Jp
ZXMgd2hlbiB1c2VTdm1Qcm9wcyBpcyBzZXQuIEF0IGxlYXN0IHRoZSBjb21tYW5kcwpmaW5kLXJl
diBhbmQgcmViYXNlLCB3aGljaCBkaWRuJ3Qgd29yayBmb3IgbWUgd2l0aCBzdm0tbWlycm9yZWQK
cmVwb3NpdG9yaWVzLCBhcmUgbm93IHdvcmtpbmcuCi0tLQogZ2l0LXN2bi5wZXJsIHwgICAyNSAr
KysrKysrKysrKysrKysrKysrKystLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZ2l0LXN2bi5wZXJsIGIvZ2l0LXN2bi5w
ZXJsCmluZGV4IDQ3YjBjMzcuLmRiMDU0ZDIgMTAwNzU1Ci0tLSBhL2dpdC1zdm4ucGVybAorKysg
Yi9naXQtc3ZuLnBlcmwKQEAgLTUzNywxMyArNTM3LDEzIEBAIHN1YiBjbWRfZmluZF9yZXYgewog
CQlteSAkaGVhZCA9IHNoaWZ0OwogCQkkaGVhZCB8fD0gJ0hFQUQnOwogCQlteSBAcmVmczsKLQkJ
bXkgKHVuZGVmLCB1bmRlZiwgdW5kZWYsICRncykgPSB3b3JraW5nX2hlYWRfaW5mbygkaGVhZCwg
XEByZWZzKTsKKwkJbXkgKHVuZGVmLCB1bmRlZiwgJHV1aWQsICRncykgPSB3b3JraW5nX2hlYWRf
aW5mbygkaGVhZCwgXEByZWZzKTsKIAkJdW5sZXNzICgkZ3MpIHsKIAkJCWRpZSAiVW5hYmxlIHRv
IGRldGVybWluZSB1cHN0cmVhbSBTVk4gaW5mb3JtYXRpb24gZnJvbSAiLAogCQkJICAgICIkaGVh
ZCBoaXN0b3J5XG4iOwogCQl9CiAJCW15ICRkZXNpcmVkX3JldmlzaW9uID0gc3Vic3RyKCRyZXZp
c2lvbl9vcl9oYXNoLCAxKTsKLQkJJHJlc3VsdCA9ICRncy0+cmV2X21hcF9nZXQoJGRlc2lyZWRf
cmV2aXNpb24pOworCQkkcmVzdWx0ID0gJGdzLT5yZXZfbWFwX2dldCgkZGVzaXJlZF9yZXZpc2lv
biwgJHV1aWQpOwogCX0gZWxzZSB7CiAJCW15ICh1bmRlZiwgJHJldiwgdW5kZWYpID0gY210X21l
dGFkYXRhKCRyZXZpc2lvbl9vcl9oYXNoKTsKIAkJJHJlc3VsdCA9ICRyZXY7CkBAIC0xMTU4LDcg
KzExNTgsNyBAQCBzdWIgd29ya2luZ19oZWFkX2luZm8gewogCQlpZiAoZGVmaW5lZCAkdXJsICYm
IGRlZmluZWQgJHJldikgewogCQkJbmV4dCBpZiAkbWF4eyR1cmx9IGFuZCAkbWF4eyR1cmx9IDwg
JHJldjsKIAkJCWlmIChteSAkZ3MgPSBHaXQ6OlNWTi0+ZmluZF9ieV91cmwoJHVybCkpIHsKLQkJ
CQlteSAkYyA9ICRncy0+cmV2X21hcF9nZXQoJHJldik7CisJCQkJbXkgJGMgPSAkZ3MtPnJldl9t
YXBfZ2V0KCRyZXYsICR1dWlkKTsKIAkJCQlpZiAoJGMgJiYgJGMgZXEgJGhhc2gpIHsKIAkJCQkJ
Y2xvc2UgJGZoOyAjIGJyZWFrIHRoZSBwaXBlCiAJCQkJCXJldHVybiAoJHVybCwgJHJldiwgJHV1
aWQsICRncyk7CkBAIC0xNDE3LDYgKzE0MTcsMTYgQEAgc3ViIHJlYWRfYWxsX3JlbW90ZXMgewog
CQkJbXkgKCRyZW1vdGUsICRsb2NhbF9yZWYsICRyZW1vdGVfcmVmKSA9ICgkMSwgJDIsICQzKTsK
IAkJCSRsb2NhbF9yZWYgPX4gc3teL317fTsKIAkJCSRyLT57JHJlbW90ZX0tPntmZXRjaH0tPnsk
bG9jYWxfcmVmfSA9ICRyZW1vdGVfcmVmOworCQl9IGVsc2lmIChtIV4oLispXC51c2Vzdm1wcm9w
cz1ccyooLiopXHMqJCEpIHsKKwkJCW15ICRzdm07CisJCQlldmFsIHsKKwkJCQlteSAkc2VjdGlv
biA9ICJzdm4tcmVtb3RlLiQxIjsKKwkJCQkkc3ZtID0geworCQkJCQlzb3VyY2UgPT4gdG1wX2Nv
bmZpZygnLS1nZXQnLCAiJHNlY3Rpb24uc3ZtLXNvdXJjZSIpLAorCQkJCQlyZXBsYWNlID0+IHRt
cF9jb25maWcoJy0tZ2V0JywgIiRzZWN0aW9uLnN2bS1yZXBsYWNlIiksCisJCQkJfQorCQkJfTsK
KwkJCSRyLT57JDF9LT57c3ZtfSA9ICRzdm07CiAJCX0gZWxzaWYgKG0hXiguKylcLnVybD1ccyoo
LiopXHMqJCEpIHsKIAkJCSRyLT57JDF9LT57dXJsfSA9ICQyOwogCQl9IGVsc2lmIChtIV4oLisp
XC4oYnJhbmNoZXN8dGFncyk9CkBAIC0xNTY2LDEzICsxNTc2LDIwIEBAIHN1YiBmaW5kX2J5X3Vy
bCB7ICMgcmVwb3Nfcm9vdCBhbmQsIHBhdGggYXJlIG9wdGlvbmFsCiAJCX0KIAkJbXkgJHAgPSAk
cGF0aDsKIAkJbXkgJHJ3ciA9IHJld3JpdGVfcm9vdCh7cmVwb19pZCA9PiAkcmVwb19pZH0pOwor
CQlteSAkc3ZtID0gJHJlbW90ZXMtPnskcmVwb19pZH0tPntzdm19CisJCQlpZiBkZWZpbmVkICRy
ZW1vdGVzLT57JHJlcG9faWR9LT57c3ZtfTsKIAkJdW5sZXNzIChkZWZpbmVkICRwKSB7CiAJCQkk
cCA9ICRmdWxsX3VybDsKIAkJCW15ICR6ID0gJHU7CisJCQlteSAkcHJlZml4ID0gJyc7CiAJCQlp
ZiAoJHJ3cikgewogCQkJCSR6ID0gJHJ3cjsKKwkJCX0gZWxzaWYgKGRlZmluZWQgJHN2bSkgewor
CQkJCSR6ID0gJHN2bS0+e3NvdXJjZX07CisJCQkJJHByZWZpeCA9ICRzdm0tPntyZXBsYWNlfTsK
KwkJCQkkcHJlZml4ID1+IHMjXlxRJHVcRSg/PS98JCkjIzsKIAkJCX0KLQkJCSRwID1+IHMjXlxR
JHpcRSg/Oi98JCkjIyBvciBuZXh0OworCQkJJHAgPX4gcyNeXFEkelxFKD86L3wkKSMkcHJlZml4
IyBvciBuZXh0OwogCQl9CiAJCWZvcmVhY2ggbXkgJGYgKGtleXMgJSRmZXRjaCkgewogCQkJbmV4
dCBpZiAkZiBuZSAkcDsKLS0gCjEuNS41LjEKCg==
------=_Part_24089_18847667.1213416149160--
