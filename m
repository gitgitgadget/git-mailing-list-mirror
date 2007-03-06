From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Allow "make -w" generate its usual output
Date: Wed, 7 Mar 2007 00:15:18 +0100
Message-ID: <81b0412b0703061515x44e5c4fcr496b3c90981764a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58709_2422416.1173222918610"
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:15:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOisO-0000Qa-DK
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030673AbXCFXPV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030674AbXCFXPV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:15:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:52259 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030673AbXCFXPT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:15:19 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2660080nfa
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 15:15:18 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=JFYEj2GOlg7p9fg3rz+5v90oPj1GWWi+CLdWuMjUI4UNW3wq8TT1vV8ILXcuxwFjm9NGqZyGAlEq2DKFo993HwXt5/PG0Eve1kP6wcRAnxp+kscSjzMK+EVwWiV5HGUVJM6jXXqPmoKsFiiacbmm0QLyHVSnQpvKVhyvHjcu+Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=HGtb8pagDEfbaR3inV/MlJPIADPVNzzeN6M1cVhQY5Uyzw+ON26FqlrHH8bNMwv1+TN4cuxjBmiXu4RG91TXW5wf+5OAXDyM5nYO4cnT3XV9eIGAvhladG4877v/4n7SNGQlDlRWwFrWf2d5JyeLzDFajxPJwZGFgK2426Ueamc=
Received: by 10.78.157.8 with SMTP id f8mr879222hue.1173222918642;
        Tue, 06 Mar 2007 15:15:18 -0800 (PST)
Received: by 10.78.138.5 with HTTP; Tue, 6 Mar 2007 15:15:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41615>

------=_Part_58709_2422416.1173222918610
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Makefile |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

------=_Part_58709_2422416.1173222918610
Content-Type: text/x-patch; 
	name=0003-Allow-make-w-generate-its-usual-output.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eyyymij2
Content-Disposition: attachment; filename="0003-Allow-make-w-generate-its-usual-output.patch"

RnJvbSBhNjllMTE3NTVjZTFiNDk3OTdlMTAwMzI2YTE3ODNmZDVkMjJlY2U1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDcgTWFyIDIwMDcgMDA6MDU6MzQgKzAxMDAKU3ViamVjdDogW1BBVENIXSBBbGxvdyAi
bWFrZSAtdyIgZ2VuZXJhdGUgaXRzIHVzdWFsIG91dHB1dAoKU2lnbmVkLW9mZi1ieTogQWxleCBS
aWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiBNYWtlZmlsZSB8ICAgMTAgKysrKysrKyst
LQogMSBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvTWFrZWZpbGUgYi9NYWtlZmlsZQppbmRleCA5ODNkYTYwLi5iYWI3NTY1IDEwMDY0
NAotLS0gYS9NYWtlZmlsZQorKysgYi9NYWtlZmlsZQpAQCAtNjA4LDYgKzYwOCwxMiBAQCBlbmRp
ZgogUVVJRVRfU1VCRElSMCAgPSAkKE1BS0UpIC1DICMgc3BhY2UgdG8gc2VwYXJhdGUgLUMgYW5k
IHN1YmRpcgogUVVJRVRfU1VCRElSMSAgPQogCitpZm5lcSAoJChmaW5kc3RyaW5nICQoTUFLRUZM
QUdTKSx3KSx3KQorUFJJTlRfRElSID0gLS1uby1wcmludC1kaXJlY3RvcnkKK2Vsc2UgIyAibWFr
ZSAtdyIKK05PX1NVQkRJUiA9IDoKK2VuZGlmCisKIGlmbmVxICgkKGZpbmRzdHJpbmcgJChNQUtF
RkxBR1MpLHMpLHMpCiBpZm5kZWYgVgogCVFVSUVUX0NDICAgICAgID0gQGVjaG8gJyAgICcgQ0Mg
JEA7CkBAIC02MTYsOCArNjIyLDggQEAgaWZuZGVmIFYKIAlRVUlFVF9CVUlMVF9JTiA9IEBlY2hv
ICcgICAnIEJVSUxUSU4gJEA7CiAJUVVJRVRfR0VOICAgICAgPSBAZWNobyAnICAgJyBHRU4gJEA7
CiAJUVVJRVRfU1VCRElSMCAgPSBAc3ViZGlyPQotCVFVSUVUX1NVQkRJUjEgID0gO2VjaG8gJyAg
ICcgU1VCRElSICQkc3ViZGlyOyBcCi0JCQkgJChNQUtFKSAtLW5vLXByaW50LWRpcmVjdG9yeSAt
QyAkJHN1YmRpcgorCVFVSUVUX1NVQkRJUjEgID0gOyQoTk9fU1VCRElSKSBlY2hvICcgICAnIFNV
QkRJUiAkJHN1YmRpcjsgXAorCQkJICQoTUFLRSkgJChQUklOVF9ESVIpIC1DICQkc3ViZGlyCiAJ
ZXhwb3J0IFYKIAlleHBvcnQgUVVJRVRfR0VOCiAJZXhwb3J0IFFVSUVUX0JVSUxUX0lOCi0tIAox
LjUuMC4zLjQxMC5nY2E0MgoK
------=_Part_58709_2422416.1173222918610--
