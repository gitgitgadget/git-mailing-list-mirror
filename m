From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 05/13] new file statics and struct fields for --pack-limit
Date: Thu, 5 Apr 2007 15:30:54 -0700
Message-ID: <56b7f5510704051530r4a02f06ej51eee75c95f3e34b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_59011_7136745.1175812254265"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:30:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZaTq-0005ic-Mi
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767369AbXDEWa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767370AbXDEWa4
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:30:56 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:4524 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767369AbXDEWaz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:30:55 -0400
Received: by wx-out-0506.google.com with SMTP id h31so757274wxd
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:30:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Dq2+z6LQgDoKxhC5IU+p1TIb4x3Bl4Wr2uTe5/rH3L+V+4mFH61VhljQPej7KaSqSC0PpY8LD5607+O6s70U/GjTyt/w11+GYRlIZmIBIHhJoIbKbpjmqc0TlO0NLcOw3PlfnVpDvCCxnVKdmNgjecFhS94LVxcVEPWBtDLzw/s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=FwJ57DrMCUHXCa8GcoDFTrff7gIjwzAuVTnovCnva3Rs7aNFzgAPfFIrW8zDgQKS1cofCwuDksrZciowZShXGML/iOI8BbZVNmLogTwwxlq7gOjbIWeM+VTuzTG2gmfJYYVf+yZcUNJVkANEtcgNU4sLrgxw6nQSnzbrNoEiFDY=
Received: by 10.114.75.1 with SMTP id x1mr933386waa.1175812254305;
        Thu, 05 Apr 2007 15:30:54 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:30:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43868>

------=_Part_59011_7136745.1175812254265
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 builtin-pack-objects.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_59011_7136745.1175812254265
Content-Type: text/plain; name="0005-new-file-statics-and-struct-fields-for-pack-limit.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0005-new-file-statics-and-struct-fields-for-pack-limit.patch.txt"
X-Attachment-Id: f_f05s91ei

RnJvbSBjMThmMWJjOTkxMWY1YjMzZmJmMmYwMzJjNGVhYWU5ZWQxNDQ2YTIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTM6MzA6NDEgLTA3MDAKU3ViamVjdDogW1BBVENIIDA1
LzEzXSBuZXcgZmlsZSBzdGF0aWNzIGFuZCBzdHJ1Y3QgZmllbGRzIGZvciAtLXBhY2stbGltaXQK
Ci0tLQogYnVpbHRpbi1wYWNrLW9iamVjdHMuYyB8ICAgIDYgKysrKystCiAxIGZpbGVzIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9idWlsdGlu
LXBhY2stb2JqZWN0cy5jIGIvYnVpbHRpbi1wYWNrLW9iamVjdHMuYwppbmRleCA1MDI0NmUxLi43
ZGEwNmE4IDEwMDY0NAotLS0gYS9idWlsdGluLXBhY2stb2JqZWN0cy5jCisrKyBiL2J1aWx0aW4t
cGFjay1vYmplY3RzLmMKQEAgLTI5LDYgKzI5LDcgQEAgc3RydWN0IG9iamVjdF9lbnRyeSB7CiAJ
dW5zaWduZWQgaW50IGRlcHRoOwkvKiBkZWx0YSBkZXB0aCAqLwogCXVuc2lnbmVkIGludCBkZWx0
YV9saW1pdDsJLyogYmFzZSBhZGp1c3RtZW50IGZvciBpbi1wYWNrIGRlbHRhICovCiAJdW5zaWdu
ZWQgaW50IGhhc2g7CS8qIG5hbWUgaGludCBoYXNoICovCisJY2hhciBub193cml0ZTsJCS8qIGZs
YWc6IHdyaXR0ZW4gdG8gcHJldmlvdXMgcGFjayBPUiB0b28gYmlnICovCiAJZW51bSBvYmplY3Rf
dHlwZSB0eXBlOwogCWVudW0gb2JqZWN0X3R5cGUgaW5fcGFja190eXBlOwkvKiBjb3VsZCBiZSBk
ZWx0YSAqLwogCXVuc2lnbmVkIGxvbmcgZGVsdGFfc2l6ZTsJLyogZGVsdGEgZGF0YSBzaXplICh1
bmNvbXByZXNzZWQpICovCkBAIC02OCw3ICs2OSwxMCBAQCBzdGF0aWMgaW50IGFsbG93X29mc19k
ZWx0YTsKIAogc3RhdGljIHN0cnVjdCBvYmplY3RfZW50cnkgKipzb3J0ZWRfYnlfc2hhLCAqKnNv
cnRlZF9ieV90eXBlOwogc3RhdGljIHN0cnVjdCBvYmplY3RfZW50cnkgKm9iamVjdHM7Ci1zdGF0
aWMgdWludDMyX3QgbnJfb2JqZWN0cywgbnJfYWxsb2MsIG5yX3Jlc3VsdDsKK3N0YXRpYyBzdHJ1
Y3Qgb2JqZWN0X2VudHJ5ICoqd3JpdHRlbl9saXN0Oworc3RhdGljIHVpbnQzMl90IG5yX29iamVj
dHMsIG5yX2FsbG9jLCBucl9yZXN1bHQsIG5yX3dyaXR0ZW4sIG5yX3NraXBwZWQgPSAwOworc3Rh
dGljIHVpbnQzMl90IG9mZnNldF9saW1pdCA9IDA7CitzdGF0aWMgdWludDMyX3QgYmxvYl9saW1p
dCA9IDA7CiBzdGF0aWMgY29uc3QgY2hhciAqYmFzZV9uYW1lOwogc3RhdGljIHVuc2lnbmVkIGNo
YXIgcGFja19maWxlX3NoYTFbMjBdOwogc3RhdGljIGludCBwcm9ncmVzcyA9IDE7Ci0tIAoxLjUu
MS5yYzIuMTguZzljODgtZGlydHkKCg==
------=_Part_59011_7136745.1175812254265--
