From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Support of "make -s": do not output anything of the build itself
Date: Wed, 7 Mar 2007 00:59:03 +0100
Message-ID: <81b0412b0703061559v7a42c8d8t5b9ecdb0fa6d0d47@mail.gmail.com>
References: <81b0412b0703061514m2f2b3237yd1192dd651a1109e@mail.gmail.com>
	 <20070306232927.GB25785@spearce.org>
	 <81b0412b0703061533o532dfeedo1aeb65723717227a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_59069_10059552.1173225543332"
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:59:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOjYl-0003ML-Hj
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030738AbXCFX7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030743AbXCFX7I
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:59:08 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:34886 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030738AbXCFX7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:59:05 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2670796nfa
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 15:59:04 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=tugDL4kygcSNLj22ow9ZUmhnPYCFbeBzQS/UHlUzxGbRiSOIQUFd/kKRSwm/6+tOZZSq5/jMih/2vnHW0oxcgAxyygXbG7c4uSM8qtZbRQWmhEuLIgAgWOq8TajL3j15W+coF7GH6kc+HctSAkfsx9iKWp93rn/+IjzWe2bSvec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=kDgbF5P7mEJynP+3JIMmQLycCOmFs8q0vMvoWphNGYpNs/JvLDAPNH0NqEFLITFGAAaTrYHg/JMUplk7zklE/4f0pcVPEqprqdgtdXUeSvkwh+cBkz2I0Ljc+whwW2220VOsPvGV2mdwG0OFt2Sb3UOtfBKEXpufaYoX8RE0gCY=
Received: by 10.78.18.3 with SMTP id 3mr881965hur.1173225543370;
        Tue, 06 Mar 2007 15:59:03 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Tue, 6 Mar 2007 15:59:03 -0800 (PST)
In-Reply-To: <81b0412b0703061533o532dfeedo1aeb65723717227a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41623>

------=_Part_59069_10059552.1173225543332
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---
 Makefile |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

------=_Part_59069_10059552.1173225543332
Content-Type: text/x-patch; 
	name=0003-Support-of-make-s-do-not-output-anything-of-the.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyz06cuz
Content-Disposition: attachment; filename="0003-Support-of-make-s-do-not-output-anything-of-the.patch"

RnJvbSBmNzQxODU2YzgyYWE4NDBhMTk4ZTNkNzUxYTE3MjFiMjI1YjViNDMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDcgTWFyIDIwMDcgMDA6NDQ6NDkgKzAxMDAKU3ViamVjdDogW1BBVENIXSBTdXBwb3J0
IG9mICJtYWtlIC1zIjogZG8gbm90IG91dHB1dCBhbnl0aGluZyBvZiB0aGUgYnVpbGQgaXRzZWxm
CgotLS0KIE1ha2VmaWxlIHwgICAxMCArKysrKysrLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2Vm
aWxlCmluZGV4IGViNmM0MjEuLjk4M2RhNjAgMTAwNjQ0Ci0tLSBhL01ha2VmaWxlCisrKyBiL01h
a2VmaWxlCkBAIC02MDQsNiArNjA0LDExIEBAIGVuZGlmCiBpZmRlZiBOT19QRVJMX01BS0VNQUtF
UgogCWV4cG9ydCBOT19QRVJMX01BS0VNQUtFUgogZW5kaWYKKworUVVJRVRfU1VCRElSMCAgPSAk
KE1BS0UpIC1DICMgc3BhY2UgdG8gc2VwYXJhdGUgLUMgYW5kIHN1YmRpcgorUVVJRVRfU1VCRElS
MSAgPQorCitpZm5lcSAoJChmaW5kc3RyaW5nICQoTUFLRUZMQUdTKSxzKSxzKQogaWZuZGVmIFYK
IAlRVUlFVF9DQyAgICAgICA9IEBlY2hvICcgICAnIENDICRAOwogCVFVSUVUX0FSICAgICAgID0g
QGVjaG8gJyAgICcgQVIgJEA7CkBAIC02MTUsOSArNjIwLDggQEAgaWZuZGVmIFYKIAkJCSAkKE1B
S0UpIC0tbm8tcHJpbnQtZGlyZWN0b3J5IC1DICQkc3ViZGlyCiAJZXhwb3J0IFYKIAlleHBvcnQg
UVVJRVRfR0VOCi1lbHNlCi0JUVVJRVRfU1VCRElSMCAgPSAkKE1BS0UpIC1DCi0JUVVJRVRfU1VC
RElSMSAgPQorCWV4cG9ydCBRVUlFVF9CVUlMVF9JTgorZW5kaWYKIGVuZGlmCiAKICMgU2hlbGwg
cXVvdGUgKGRvIG5vdCB1c2UgJChjYWxsKSB0byBhY2NvbW1vZGF0ZSBhbmNpZW50IHNldHVwcyk7
Ci0tIAoxLjUuMC4zLjQzMC5nNTU3M2YKCg==
------=_Part_59069_10059552.1173225543332--
