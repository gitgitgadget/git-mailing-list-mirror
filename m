From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: blameview and file contents
Date: Tue, 30 Jan 2007 12:16:52 +0530
Message-ID: <cc723f590701292246v282408d0o27a0d8320c027743@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_158405_25704999.1170139612731"
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 07:47:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBmln-00065U-TN
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 07:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933114AbXA3GrA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 01:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933132AbXA3GrA
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 01:47:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:43081 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933114AbXA3Gq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 01:46:59 -0500
Received: by nf-out-0910.google.com with SMTP id o25so115663nfa
        for <git@vger.kernel.org>; Mon, 29 Jan 2007 22:46:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=umGDeFnXJeq8rniYRWlfv72uSfE5gc2J8nb7hCiyKoH3rZV5eyqFaUxyJA04sxquIxr3dkViBPnc9bUim4SG8npN2KS7CYnDaQMLEjP7Puj4JweHZbUCfpkXwTeAGBe/UUVgcs5ITZLW/OztRpFz7yMvOKs0J2xdY5EOYXQ2OME=
Received: by 10.49.10.3 with SMTP id n3mr316457nfi.1170139612774;
        Mon, 29 Jan 2007 22:46:52 -0800 (PST)
Received: by 10.48.210.15 with HTTP; Mon, 29 Jan 2007 22:46:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38124>

------=_Part_158405_25704999.1170139612731
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I guess blame view need to pull the file content from the repository
rather than opening it directly. If i have a working copy that is not
yet committed it gives wrong results. I tried some changes as below.
But i guess there should be a much easier way.

-aneesh

------=_Part_158405_25704999.1170139612731
Content-Type: text/x-patch; name="blameview.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="blameview.diff"
X-Attachment-Id: f_exjywltu

ZGlmZiAtLWdpdCBhL2NvbnRyaWIvYmxhbWV2aWV3L2JsYW1ldmlldy5wZXJsIGIvY29udHJpYi9i
bGFtZXZpZXcvYmxhbWV2aWV3LnBlcmwKaW5kZXggYTU1Zjc5OS4uYTc1MDVkYSAxMDA3NTUKLS0t
IGEvY29udHJpYi9ibGFtZXZpZXcvYmxhbWV2aWV3LnBlcmwKKysrIGIvY29udHJpYi9ibGFtZXZp
ZXcvYmxhbWV2aWV3LnBlcmwKQEAgLTMsNiArMyw3IEBACiB1c2UgR3RrMiAtaW5pdDsKIHVzZSBH
dGsyOjpTaW1wbGVMaXN0OwogCitvdXIgJEdJVD0iZ2l0IjsKIG15ICRmbiA9IHNoaWZ0IG9yIGRp
ZSAicmVxdWlyZSBmaWxlbmFtZSB0byBibGFtZSI7CiAKIEd0azI6OlJjLT5wYXJzZV9zdHJpbmco
PDwnRU9TJyk7CkBAIC0xMyw2ICsxNCw1MCBAQCBzdHlsZSAidHJlZXZpZXdfc3R5bGUiCiBjbGFz
cyAiR3RrVHJlZVZpZXciIHN0eWxlICJ0cmVldmlld19zdHlsZSIKIEVPUwogCitzdWIgZ2V0X2Zp
bGVfaGFuZGxlCit7CisJbXkgKCRjb21taXRfaGFzaCwgJGZpbGVuYW1lKSA9IEBfOworCW15IChA
cGF0aF9jb21wLCAkaGFzaF9saW5lLCBAaGFzaF9saW5lLCAkcGF0aCk7CisJbXkgKCR0cmVlX2hh
c2gsICRoYXNoKTsKKwlteSBAZmlsZV9jb250ZW50czsKKwlAcGF0aF9jb21wID0gc3BsaXQoL1wv
LywgJGZpbGVuYW1lKTsKK3N0YXJ0OgorCWNob21wKCRjb21taXRfaGFzaCk7CisJb3BlbiBteSAk
ZmQsICItfCIsICIkR0lUIGNhdC1maWxlIC10ICRjb21taXRfaGFzaCIgb3IKKwkJCQlkaWUoIkV4
ZWN1dGUgZ2l0LWNhdC1maWxlIGZhaWxlZC4iKTsKKwkkaGFzaF9saW5lID0gPCRmZD47CisJY2hv
bXAoJGhhc2hfbGluZSk7CisJaWYgKCRoYXNoX2xpbmUgPX4gbS9jb21taXQvKSB7CisKKwkJb3Bl
biBteSAkZmQsICItfCIsICIkR0lUIGNhdC1maWxlIGNvbW1pdCAkY29tbWl0X2hhc2ggfCBncmVw
IHRyZWUiIG9yCisJCQkJCQlkaWUoIkV4ZWN1dGUgZ2l0LWNhdC1maWxlIGZhaWxlZC4iKTsKKwkJ
JGhhc2hfbGluZSA9IDwkZmQ+OworCQljbG9zZSgkZmQpOworCQlAaGFzaF9saW5lID0gc3BsaXQo
L1tcdCBdKy8sICRoYXNoX2xpbmUpOworCQkkdHJlZV9oYXNoID0gJGhhc2hfbGluZVsxXTsKKwl9
IGVsc2lmICgkaGFzaF9saW5lID1+IG0vdHJlZS8pIHsKKwkJJHRyZWVfaGFzaCA9ICRoYXNoX2xp
bmU7CisJfSBlbHNlIHsKKwkJZGllKCJOZWVkIHRvIHNwZWNpZnkgZWl0aGVyIGEgdHJlZSBvciBh
IGNvbW1pdCBoYXNoIik7CisJfQorCisJZm9yZWFjaCAkcGF0aCAoQHBhdGhfY29tcCkgeworCQlj
aG9tcCgkdHJlZV9oYXNoKTsKKwkJb3BlbiBteSAkZmQsICItfCIsICIkR0lUIGxzLXRyZWUgJHRy
ZWVfaGFzaCB8IGdyZXAgJHBhdGhcJCIgb3IKKwkJCQkJCWRpZSgiRXhlY3V0ZSBnaXQtbHMtdHJl
ZSBmYWlsZWQuIik7CisJCSRoYXNoX2xpbmUgPSA8JGZkPjsKKwkJY2xvc2UoJGZkKTsKKwkJQGhh
c2hfbGluZSA9IHNwbGl0KC9bXHQgXSsvLCAkaGFzaF9saW5lKTsKKwkJaWYgKCRoYXNoX2xpbmVb
MV0gPX4gbS90cmVlLykgeworCQkJJHRyZWVfaGFzaCA9ICRoYXNoX2xpbmVbMl07CisJCQluZXh0
OworCQl9IGVsc2lmICgkaGFzaF9saW5lWzFdID1+IG0vYmxvYi8pICB7CisJCQlvcGVuIG15ICRm
ZCwgIi18IiwgIiRHSVQgY2F0LWZpbGUgYmxvYiAkaGFzaF9saW5lWzJdIiBvcgorCQkJCQkJZGll
KCJFeGVjdXRlIGdpdC1jYXQtZmlsZSBmYWlsZWQuIik7CisJCQlyZXR1cm4gJGZkOworCQl9CisJ
fQorfQogbXkgJHdpbmRvdyA9IEd0azI6OldpbmRvdy0+bmV3KCd0b3BsZXZlbCcpOwogJHdpbmRv
dy0+c2lnbmFsX2Nvbm5lY3QoZGVzdHJveSA9PiBzdWIgeyBHdGsyLT5tYWluX3F1aXQgfSk7CiBt
eSAkc2Nyb2xsZWRfd2luZG93ID0gR3RrMjo6U2Nyb2xsZWRXaW5kb3ctPm5ldzsKQEAgLTI4LDgg
KzczLDcgQEAgJGZpbGV2aWV3LT5nZXRfY29sdW1uKDApLT5zZXRfc3BhY2luZygwKTsKICRmaWxl
dmlldy0+c2V0X3NpemVfcmVxdWVzdCgxMDI0LCA3NjgpOwogJGZpbGV2aWV3LT5zZXRfcnVsZXNf
aGludCgxKTsKIAotb3BlbihteSAkZmgsICc8JywgJGZuKQotICBvciBkaWUgInVuYWJsZSB0byBv
cGVuICRmbjogJCEiOworJGZoID0gZ2V0X2ZpbGVfaGFuZGxlKCJIRUFEIiwgJGZuKTsKIHdoaWxl
KDwkZmg+KSB7CiAgIGNob21wOwogICAkZmlsZXZpZXctPntkYXRhfS0+WyQuXSA9IFsnSEVBRCcs
ICc/JywgIiRmbjokLiIsICRfXTsK
------=_Part_158405_25704999.1170139612731--
