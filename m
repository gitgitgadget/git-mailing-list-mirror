From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Support of "make -s": do not output anything of the build itself
Date: Wed, 7 Mar 2007 00:14:30 +0100
Message-ID: <81b0412b0703061514m2f2b3237yd1192dd651a1109e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58701_3033038.1173222870970"
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:14:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOirb-0008W7-KP
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030660AbXCFXOd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030666AbXCFXOd
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:14:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:51193 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030660AbXCFXOc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:14:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2659901nfa
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 15:14:31 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=gfRSPuIh9QfA/vWhawmNtPZg1+M14LaOBdYUBuNcI6cvuXg+8sAAGO3o4UnVeXXJLGvfJ8bP89jH2Bw57LsN4TSad61lcC1N8puEV5cwrbaHb9E0JJBK+L05MgOl1LBxhkOKjxICH+KdgNYteJyVHgfbyXjuhLArIU9TqaUi21Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=WIOiXUdd278wIGRLhB4zyy5eraeaEvaPYMNnyrEvTPxxqnNkjXeArQvwu/aC6S3oZFXG8OiVtjmh8IcW77M9IsI+DsS53Wqb/L0U9qQcADDmi3fSz/sDUzi4g4k4e8s7HXGa+byZFG+ccRikQPBWNR7uZzma6z6VKwX3ToKnwUc=
Received: by 10.78.181.13 with SMTP id d13mr882025huf.1173222870999;
        Tue, 06 Mar 2007 15:14:30 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Tue, 6 Mar 2007 15:14:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41614>

------=_Part_58701_3033038.1173222870970
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Makefile         |   10 +++++++---
 git-gui/Makefile |    5 -----
 2 files changed, 7 insertions(+), 8 deletions(-)

------=_Part_58701_3033038.1173222870970
Content-Type: text/x-patch; 
	name=0002-Support-of-make-s-do-not-output-anything-of-the.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyyyl9a9
Content-Disposition: attachment; filename="0002-Support-of-make-s-do-not-output-anything-of-the.patch"

RnJvbSBkNDMzZWQxZDY4MmI2NGViNGE4YWMxY2I1NWJjNTY4ZTBmMGYxMGYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDYgTWFyIDIwMDcgMjM6NTc6NTUgKzAxMDAKU3ViamVjdDogW1BBVENIXSBTdXBwb3J0
IG9mICJtYWtlIC1zIjogZG8gbm90IG91dHB1dCBhbnl0aGluZyBvZiB0aGUgYnVpbGQgaXRzZWxm
CgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgotLS0KIE1h
a2VmaWxlICAgICAgICAgfCAgIDEwICsrKysrKystLS0KIGdpdC1ndWkvTWFrZWZpbGUgfCAgICA1
IC0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2VmaWxlCmluZGV4IGViNmM0MjEuLjk4M2RhNjAg
MTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01ha2VmaWxlCkBAIC02MDQsNiArNjA0LDExIEBA
IGVuZGlmCiBpZmRlZiBOT19QRVJMX01BS0VNQUtFUgogCWV4cG9ydCBOT19QRVJMX01BS0VNQUtF
UgogZW5kaWYKKworUVVJRVRfU1VCRElSMCAgPSAkKE1BS0UpIC1DICMgc3BhY2UgdG8gc2VwYXJh
dGUgLUMgYW5kIHN1YmRpcgorUVVJRVRfU1VCRElSMSAgPQorCitpZm5lcSAoJChmaW5kc3RyaW5n
ICQoTUFLRUZMQUdTKSxzKSxzKQogaWZuZGVmIFYKIAlRVUlFVF9DQyAgICAgICA9IEBlY2hvICcg
ICAnIENDICRAOwogCVFVSUVUX0FSICAgICAgID0gQGVjaG8gJyAgICcgQVIgJEA7CkBAIC02MTUs
OSArNjIwLDggQEAgaWZuZGVmIFYKIAkJCSAkKE1BS0UpIC0tbm8tcHJpbnQtZGlyZWN0b3J5IC1D
ICQkc3ViZGlyCiAJZXhwb3J0IFYKIAlleHBvcnQgUVVJRVRfR0VOCi1lbHNlCi0JUVVJRVRfU1VC
RElSMCAgPSAkKE1BS0UpIC1DCi0JUVVJRVRfU1VCRElSMSAgPQorCWV4cG9ydCBRVUlFVF9CVUlM
VF9JTgorZW5kaWYKIGVuZGlmCiAKICMgU2hlbGwgcXVvdGUgKGRvIG5vdCB1c2UgJChjYWxsKSB0
byBhY2NvbW1vZGF0ZSBhbmNpZW50IHNldHVwcyk7CmRpZmYgLS1naXQgYS9naXQtZ3VpL01ha2Vm
aWxlIGIvZ2l0LWd1aS9NYWtlZmlsZQppbmRleCBlNDg2ZThmLi40ZjNmYzc0IDEwMDY0NAotLS0g
YS9naXQtZ3VpL01ha2VmaWxlCisrKyBiL2dpdC1ndWkvTWFrZWZpbGUKQEAgLTIyLDExICsyMiw2
IEBAIGlmbmRlZiBJTlNUQUxMCiAJSU5TVEFMTCA9IGluc3RhbGwKIGVuZGlmCiAKLWlmbmRlZiBW
Ci0JUVVJRVRfR0VOICAgICAgPSBAZWNobyAnICAgJyBHRU4gJEA7Ci0JUVVJRVRfQlVJTFRfSU4g
PSBAZWNobyAnICAgJyBCVUlMVElOICRAOwotZW5kaWYKLQogREVTVERJUl9TUSA9ICQoc3Vic3Qg
JywnXCcnLCQoREVTVERJUikpCiBnaXRleGVjZGlyX1NRID0gJChzdWJzdCAnLCdcJycsJChnaXRl
eGVjZGlyKSkKIFNIRUxMX1BBVEhfU1EgPSAkKHN1YnN0ICcsJ1wnJywkKFNIRUxMX1BBVEgpKQot
LSAKMS41LjAuMy40MTAuZ2NhNDIKCg==
------=_Part_58701_3033038.1173222870970--
