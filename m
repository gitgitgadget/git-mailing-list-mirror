From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Disable filemode rebase tests in t3400-rebase.sh if no 
	filesystem mode support
Date: Wed, 11 Feb 2009 10:51:30 +0100
Message-ID: <81b0412b0902110151x35fbbb4esb9efefae2e1fe90a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c17a85bf6aa0462a18cc9
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 10:54:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXBmc-0002Nv-Cz
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 10:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551AbZBKJve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 04:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756540AbZBKJve
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 04:51:34 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:28686 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516AbZBKJvc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 04:51:32 -0500
Received: by nf-out-0910.google.com with SMTP id d21so9309nfb.21
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 01:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=nVMZ4FxgBvjq+F2btso1op0ibIiDOqBGyWyehEqHtWk=;
        b=qjNLGcUoKtDd3BY6AebkeaviL7ZlNFYzPf3Es4l6TyI0lAJppuVp8GFrXOguH3A1hJ
         t51u0p9bvuo15NRxZHBj/iQme639LK2nPDugcgLWMuDNDCBeJozkLGRrOpFoRrBleDjv
         i47QiNAXTXUpqiAddraD3kaxYTGml+m4hokBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=Kdyt2qjrw6nwGtq6zzNt9sLJpmmAtnFIvS5zr5uj/m6o+hXc5RSJ6pAnbQm2N8WbNQ
         +ytjOkqfV8SGykcLhNuq5jk71CKqmsbJG/u+YC53kqdB55OVqZDmIWSg9wbnzXXMrOA/
         pfCA8An6rTxjg8qz6lg2JoLvtvOfMqxHBxsx4=
Received: by 10.210.35.17 with SMTP id i17mr67464ebi.165.1234345890936; Wed, 
	11 Feb 2009 01:51:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109393>

--0015174c17a85bf6aa0462a18cc9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I'm honestly sorry for my contributions. They seem to be exclusively
in the "make Git work in Windows" area.  Depressing.

 t/t3400-rebase.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

--0015174c17a85bf6aa0462a18cc9
Content-Type: application/octet-stream; 
	name="0001-Disable-filemode-rebase-tests-in-t3400-rebase.sh-if-n.diff"
Content-Disposition: attachment; 
	filename="0001-Disable-filemode-rebase-tests-in-t3400-rebase.sh-if-n.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fr1tkhqu0

RnJvbSBmNDFiOTliYmRmMTAyNDljMGRmY2I1NDU0NTcwOWYwYThkZDAwNDg0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDExIEZlYiAyMDA5IDEwOjQ1OjQzICswMTAwClN1YmplY3Q6IFtQQVRDSF0gRGlzYWJs
ZSBmaWxlbW9kZSByZWJhc2UgdGVzdHMgaW4gdDM0MDAtcmViYXNlLnNoIGlmIG5vIGZpbGVzeXN0
ZW0gbW9kZSBzdXBwb3J0CgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21h
aWwuY29tPgotLS0KIHQvdDM0MDAtcmViYXNlLnNoIHwgICAgNSArKysrKwogMSBmaWxlcyBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdC90MzQw
MC1yZWJhc2Uuc2ggYi90L3QzNDAwLXJlYmFzZS5zaAppbmRleCA4YzBjNWY1Li5hMjI5Mjc2IDEw
MDc1NQotLS0gYS90L3QzNDAwLXJlYmFzZS5zaAorKysgYi90L3QzNDAwLXJlYmFzZS5zaApAQCAt
NzAsNiArNzAsMTAgQEAgdGVzdF9leHBlY3Rfc3VjY2VzcyBcCiAgICAgIHRlc3QgMyA9ICQoZ2l0
IHJldi1saXN0IG1hc3Rlci4uIHwgd2MgLWwpCiAnCiAKK2lmIHRlc3QgIiQoZ2l0IGNvbmZpZyAt
LWJvb2wgY29yZS5maWxlbW9kZSkiID0gZmFsc2UKK3RoZW4KKyAgICBzYXkgJ3NraXBwaW5nIHJl
YmFzZSBmaWxlbW9kZSB0ZXN0cyAobm8gZmlsZXN5c3RlbSBzdXBwb3J0KScKK2Vsc2UKIHRlc3Rf
ZXhwZWN0X3N1Y2Nlc3MgJ3JlYmFzZSBhIHNpbmdsZSBtb2RlIGNoYW5nZScgJwogICAgICBnaXQg
Y2hlY2tvdXQgbWFzdGVyICYmCiAgICAgIGVjaG8gMSA+IFggJiYKQEAgLTk0LDUgKzk4LDYgQEAg
dGVzdF9leHBlY3Rfc3VjY2VzcyAnU2hvdyB2ZXJib3NlIGVycm9yIHdoZW4gSEVBRCBjb3VsZCBu
b3QgYmUgZGV0YWNoZWQnICcKICAgICAgdGVzdF9tdXN0X2ZhaWwgZ2l0IHJlYmFzZSB0b3BpYyAy
PiBvdXRwdXQuZXJyID4gb3V0cHV0Lm91dCAmJgogICAgICBncmVwICJVbnRyYWNrZWQgd29ya2lu
ZyB0cmVlIGZpbGUgLkIuIHdvdWxkIGJlIG92ZXJ3cml0dGVuIiBvdXRwdXQuZXJyCiAnCitmaQog
CiB0ZXN0X2RvbmUKLS0gCjEuNi4yLnJjMC4yOC5nMWYwZmU4Cgo=
--0015174c17a85bf6aa0462a18cc9--
