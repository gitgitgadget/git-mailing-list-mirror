From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 07/13] we need our own version of fast-import.c:fixup_header_footer()
Date: Thu, 5 Apr 2007 15:33:56 -0700
Message-ID: <56b7f5510704051533m1265ce33na2ae0c5e9748e861@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_59039_29686505.1175812436881"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:34:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZaWq-0006cg-J5
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767229AbXDEWd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767373AbXDEWd7
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:33:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.232]:25661 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767229AbXDEWd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:33:58 -0400
Received: by wr-out-0506.google.com with SMTP id 71so466189wri
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:33:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=GmvjrNCyJKLI2+05DTePZNogfUmkpC4+5gqI4R/VLk3zvkQSD6kGGojCxSFJkUagaFTxheqwMsTPaubTGF6nzRF6s89m9v1IW5pT9ojF1HGwWV4tj25zJxK72+OAydNuNVi7ZbrapvC5ugmW/uEQHWtIdejILCDVwxkV/27DREU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=MBFMNm8k1+u3cV4AKv211EPUeeSCaClzh4y9uB2PBYer/vooYLr6mnMU7E3Sv0FVBeC3VhsrGVnZ7+V8OXYhNXDT4TKfs1bmiQK1kz49dqsSVGx6aokk8YmfeJGPEqTFvH7F1aa3RYyYZz2SKA8Vad0e/V/Z8yCZsEn4sAOwgDI=
Received: by 10.114.122.2 with SMTP id u2mr958182wac.1175812436936;
        Thu, 05 Apr 2007 15:33:56 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:33:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43870>

------=_Part_59039_29686505.1175812436881
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 builtin-pack-objects.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_59039_29686505.1175812436881
Content-Type: text/plain; name="0007-we-need-our-own-version-of-fast-import.c-fixup_heade.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0007-we-need-our-own-version-of-fast-import.c-fixup_heade.patch.txt"
X-Attachment-Id: f_f05scw7v

RnJvbSAzZThlMTYxMTY1M2MyOGQxYzMwNTQxNTJmYjIxMmE0NGZlZTI0ZTJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTM6NTQ6NTggLTA3MDAKU3ViamVjdDogW1BBVENIIDA3
LzEzXSB3ZSBuZWVkIG91ciBvd24gdmVyc2lvbiBvZiBmYXN0LWltcG9ydC5jOmZpeHVwX2hlYWRl
cl9mb290ZXIoKQoKLS0tCiBidWlsdGluLXBhY2stb2JqZWN0cy5jIHwgICA0MCArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDQwIGluc2Vy
dGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi1wYWNrLW9iamVj
dHMuYyBiL2J1aWx0aW4tcGFjay1vYmplY3RzLmMKaW5kZXggMGE5ZGViMC4uOWViNWZkNiAxMDA2
NDQKLS0tIGEvYnVpbHRpbi1wYWNrLW9iamVjdHMuYworKysgYi9idWlsdGluLXBhY2stb2JqZWN0
cy5jCkBAIC01MTksNiArNTE5LDQ2IEBAIHN0YXRpYyBvZmZfdCB3cml0ZV9vbmUoc3RydWN0IHNo
YTFmaWxlICpmLAogCXJldHVybiBvZmZzZXQgKyB3cml0ZV9vYmplY3QoZiwgZSk7CiB9CiAKKy8q
CisgKiBNb3ZlIHRoaXMsIHRoZSB2ZXJzaW9uIGluIGZhc3QtaW1wb3J0LmMsCisgKiBhbmQgaW5k
ZXhfcGFjay5jOnJlYWRqdXN0X3BhY2tfaGVhZGVyX2FuZF9zaGExIGludG8gc2hhMV9maWxlLmMg
PworICovCitzdGF0aWMgdm9pZCBmaXh1cF9oZWFkZXJfZm9vdGVyKGludCBwYWNrX2ZkLCB1bnNp
Z25lZCBjaGFyICpwYWNrX2ZpbGVfc2hhMSwKKwkJCQljaGFyICpwYWNrX25hbWUsIHVpbnQzMl90
IG9iamVjdF9jb3VudCkKK3sKKwlzdGF0aWMgY29uc3QgaW50IGJ1Zl9zeiA9IDEyOCAqIDEwMjQ7
CisJU0hBX0NUWCBjOworCXN0cnVjdCBwYWNrX2hlYWRlciBoZHI7CisJY2hhciAqYnVmOworCisJ
aWYgKGxzZWVrKHBhY2tfZmQsIDAsIFNFRUtfU0VUKSAhPSAwKQorCQlkaWUoIkZhaWxlZCBzZWVr
aW5nIHRvIHN0YXJ0OiAlcyIsIHN0cmVycm9yKGVycm5vKSk7CisJaWYgKHJlYWRfaW5fZnVsbChw
YWNrX2ZkLCAmaGRyLCBzaXplb2YoaGRyKSkgIT0gc2l6ZW9mKGhkcikpCisJCWRpZSgiVW5hYmxl
IHRvIHJlcmVhZCBoZWFkZXIgb2YgJXMiLCBwYWNrX25hbWUpOworCWlmIChsc2VlayhwYWNrX2Zk
LCAwLCBTRUVLX1NFVCkgIT0gMCkKKwkJZGllKCJGYWlsZWQgc2Vla2luZyB0byBzdGFydDogJXMi
LCBzdHJlcnJvcihlcnJubykpOworCWhkci5oZHJfZW50cmllcyA9IGh0b25sKG9iamVjdF9jb3Vu
dCk7CisJd3JpdGVfb3JfZGllKHBhY2tfZmQsICZoZHIsIHNpemVvZihoZHIpKTsKKworCVNIQTFf
SW5pdCgmYyk7CisJU0hBMV9VcGRhdGUoJmMsICZoZHIsIHNpemVvZihoZHIpKTsKKworCWJ1ZiA9
IHhtYWxsb2MoYnVmX3N6KTsKKwlmb3IgKDs7KSB7CisJCXNpemVfdCBuID0geHJlYWQocGFja19m
ZCwgYnVmLCBidWZfc3opOworCQlpZiAoIW4pCisJCQlicmVhazsKKwkJaWYgKG4gPCAwKQorCQkJ
ZGllKCJGYWlsZWQgdG8gY2hlY2tzdW0gJXMiLCBwYWNrX25hbWUpOworCQlTSEExX1VwZGF0ZSgm
YywgYnVmLCBuKTsKKwl9CisJZnJlZShidWYpOworCisJU0hBMV9GaW5hbChwYWNrX2ZpbGVfc2hh
MSwgJmMpOworCXdyaXRlX29yX2RpZShwYWNrX2ZkLCBwYWNrX2ZpbGVfc2hhMSwgMjApOworCWNs
b3NlKHBhY2tfZmQpOworfQorCiB0eXBlZGVmIGludCAoKmVudHJ5X3NvcnRfdCkoY29uc3Qgc3Ry
dWN0IG9iamVjdF9lbnRyeSAqLCBjb25zdCBzdHJ1Y3Qgb2JqZWN0X2VudHJ5ICopOwogCiBzdGF0
aWMgZW50cnlfc29ydF90IGN1cnJlbnRfc29ydDsKLS0gCjEuNS4xLnJjMi4xOC5nOWM4OC1kaXJ0
eQoK
------=_Part_59039_29686505.1175812436881--
