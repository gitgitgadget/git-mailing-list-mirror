From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] More build output cleaning up
Date: Wed, 7 Mar 2007 00:13:08 +0100
Message-ID: <81b0412b0703061513g7aafc9daq46feea69d969089a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58689_19653351.1173222788184"
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOiqJ-0007xP-4U
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030657AbXCFXNL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030660AbXCFXNL
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:13:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:49239 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030657AbXCFXNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:13:09 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2659549nfa
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 15:13:08 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=HNCGyVzbZIb3GvadkX+x6i93YTvV9i2ytdytJMXx8gVSqoyhEwPwOSWsvYN0FLwjYf0U9Lb8rX15zek2j7nt/gmLHf0/DwIYDXCH2byFiXPPr3Z0DeDyHwBAm1Cpx6VgkIPiimrWZyo9D6qQ0DLOjqW6jw7yNo/LuFY5IwZM3xw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Eu02qm20cJwG6Bz4bSlcGlM8zEfGlK1XOFPFPeTpLzmQVO5cGd3+sDVNjcOZ/2FZO6W0Aej61MMoGC3zVO0wUvsegu/P2f2Jf/tzzonmHwWIUOqAa4vOT9Lk13MUI9Rs/ZVUj9YaEC5R4qOBUOTDtnT4FS2abV4Z83Zezoy6zoA=
Received: by 10.78.122.11 with SMTP id u11mr880131huc.1173222788209;
        Tue, 06 Mar 2007 15:13:08 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Tue, 6 Mar 2007 15:13:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41613>

------=_Part_58689_19653351.1173222788184
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

- print output file name for .c files
- suppress output of the names of subdirectories when make changes into them
- use GEN prefix for makefile generation in perl/

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Makefile      |    8 +++++---
 perl/Makefile |    2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

------=_Part_58689_19653351.1173222788184
Content-Type: text/x-patch; name=0001-More-build-output-cleaning-up.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyyyjcu5
Content-Disposition: attachment; filename="0001-More-build-output-cleaning-up.patch"

RnJvbSA3NmQyMWM1YTVhMGRhY2ZjMDllZDE4ZjcyYjQ1YzNmMWZjMTc0YjBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDYgTWFyIDIwMDcgMjM6Mzc6MTggKzAxMDAKU3ViamVjdDogW1BBVENIXSBNb3JlIGJ1
aWxkIG91dHB1dCBjbGVhbmluZyB1cAoKLSBwcmludCBvdXRwdXQgZmlsZSBuYW1lIGZvciAuYyBm
aWxlcwotIHN1cHByZXNzIG91dHB1dCBvZiB0aGUgbmFtZXMgb2Ygc3ViZGlyZWN0b3JpZXMgd2hl
biBtYWtlIGNoYW5nZXMgaW50byB0aGVtCi0gdXNlIEdFTiBwcmVmaXggZm9yIG1ha2VmaWxlIGdl
bmVyYXRpb24gaW4gcGVybC8KClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBn
bWFpbC5jb20+Ci0tLQogTWFrZWZpbGUgICAgICB8ICAgIDggKysrKystLS0KIHBlcmwvTWFrZWZp
bGUgfCAgICAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlCmluZGV4IDcyZDQyOTEuLmVi
NmM0MjEgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2VmaWxlCkBAIC02MDUsMTQgKzYw
NSwxNiBAQCBpZmRlZiBOT19QRVJMX01BS0VNQUtFUgogCWV4cG9ydCBOT19QRVJMX01BS0VNQUtF
UgogZW5kaWYKIGlmbmRlZiBWCi0JUVVJRVRfQ0MgICAgICAgPSBAZWNobyAnICAgJyBDQyAkPDsK
KwlRVUlFVF9DQyAgICAgICA9IEBlY2hvICcgICAnIENDICRAOwogCVFVSUVUX0FSICAgICAgID0g
QGVjaG8gJyAgICcgQVIgJEA7CiAJUVVJRVRfTElOSyAgICAgPSBAZWNobyAnICAgJyBMSU5LICRA
OwogCVFVSUVUX0JVSUxUX0lOID0gQGVjaG8gJyAgICcgQlVJTFRJTiAkQDsKIAlRVUlFVF9HRU4g
ICAgICA9IEBlY2hvICcgICAnIEdFTiAkQDsKIAlRVUlFVF9TVUJESVIwICA9IEBzdWJkaXI9Ci0J
UVVJRVRfU1VCRElSMSAgPSA7ZWNobyAnICAgJyBTVUJESVIgJCRzdWJkaXI7ICQoTUFLRSkgLUMk
JHN1YmRpcgorCVFVSUVUX1NVQkRJUjEgID0gO2VjaG8gJyAgICcgU1VCRElSICQkc3ViZGlyOyBc
CisJCQkgJChNQUtFKSAtLW5vLXByaW50LWRpcmVjdG9yeSAtQyAkJHN1YmRpcgogCWV4cG9ydCBW
CisJZXhwb3J0IFFVSUVUX0dFTgogZWxzZQogCVFVSUVUX1NVQkRJUjAgID0gJChNQUtFKSAtQwog
CVFVSUVUX1NVQkRJUjEgID0KQEAgLTY4NSw3ICs2ODcsNyBAQCAkKHBhdHN1YnN0ICUuc2gsJSwk
KFNDUklQVF9TSCkpIDogJSA6ICUuc2gKICQocGF0c3Vic3QgJS5wZXJsLCUsJChTQ1JJUFRfUEVS
TCkpOiBwZXJsL3BlcmwubWFrCiAKIHBlcmwvcGVybC5tYWs6IEdJVC1DRkxBR1MKLQkkKE1BS0Up
IC1DIHBlcmwgUEVSTF9QQVRIPSckKFBFUkxfUEFUSF9TUSknIHByZWZpeD0nJChwcmVmaXhfU1Ep
JyAkKEBGKQorCSQoUVVJRVRfU1VCRElSMClwZXJsICQoUVVJRVRfU1VCRElSMSkgUEVSTF9QQVRI
PSckKFBFUkxfUEFUSF9TUSknIHByZWZpeD0nJChwcmVmaXhfU1EpJyAkKEBGKQogCiAkKHBhdHN1
YnN0ICUucGVybCwlLCQoU0NSSVBUX1BFUkwpKTogJSA6ICUucGVybAogCSQoUVVJRVRfR0VOKXJt
IC1mICRAICRAKyAmJiBcCmRpZmYgLS1naXQgYS9wZXJsL01ha2VmaWxlIGIvcGVybC9NYWtlZmls
ZQppbmRleCAxN2QwMDRlLi41ZWMwMzg5IDEwMDY0NAotLS0gYS9wZXJsL01ha2VmaWxlCisrKyBi
L3BlcmwvTWFrZWZpbGUKQEAgLTMzLDcgKzMzLDcgQEAgJChtYWtmaWxlKTogLi4vR0lULUNGTEFH
UyBNYWtlZmlsZQogCWVjaG8gJwllY2hvICQoaW5zdGRpcl9TUSknID4+ICRACiBlbHNlCiAkKG1h
a2ZpbGUpOiBNYWtlZmlsZS5QTCAuLi9HSVQtQ0ZMQUdTCi0JJyQoUEVSTF9QQVRIX1NRKScgJDwg
UFJFRklYPSckKHByZWZpeF9TUSknCisJJChRVUlFVF9HRU4pJyQoUEVSTF9QQVRIX1NRKScgJDwg
UFJFRklYPSckKHByZWZpeF9TUSknCiBlbmRpZgogCiAjIHRoaXMgaXMganVzdCBhZGRlZCBjb21m
b3J0IGZvciBjYWxsaW5nIG1ha2UgZGlyZWN0bHkgaW4gcGVybCBkaXIKLS0gCjEuNS4wLjMuNDEw
LmdjYTQyCgo=
------=_Part_58689_19653351.1173222788184--
