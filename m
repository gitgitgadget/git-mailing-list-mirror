From: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
Subject: Patch (1.6.2.1) for fixing bad single quote
Date: Tue, 14 Apr 2009 14:31:44 +0200
Organization: Universitaetsklinikum Regensburg
Message-ID: <49E49E50.26678.1760A84@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed; boundary=Message-Boundary-11820
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 14:35:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lthpo-0004tR-Ch
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 14:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753968AbZDNMcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 08:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753826AbZDNMcS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 08:32:18 -0400
Received: from rrzmta1.rz.uni-regensburg.de ([194.94.155.51]:14341 "EHLO
	rrzmta1.rz.uni-regensburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753541AbZDNMcR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 08:32:17 -0400
Received: from rrzmta1.rz.uni-regensburg.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 78366ABD33
	for <git@vger.kernel.org>; Tue, 14 Apr 2009 14:32:16 +0200 (CEST)
Received: from kgate1.dvm.klinik.uni-regensburg.de (kgate1.klinik.uni-regensburg.de [132.199.176.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by rrzmta1.rz.uni-regensburg.de (Postfix) with ESMTP id 6F8CFABC68
	for <git@vger.kernel.org>; Tue, 14 Apr 2009 14:32:16 +0200 (CEST)
Received: from rkdvmks1.ngate.uni-regensburg.de (rkdvmks1.dvm.klinik.uni-regensburg.de [132.199.176.1])
	by kgate1.dvm.klinik.uni-regensburg.de (8.13.6/8.13.6/20070831MT-1) with ESMTP id n3ECW5I0031656
	for <git@vger.kernel.org>; Tue, 14 Apr 2009 14:32:05 +0200
Received: from RKDVMKS1/SpoolDir by rkdvmks1.ngate.uni-regensburg.de (Mercury 1.48);
    14 Apr 09 14:32:05 +0100
Received: from SpoolDir by RKDVMKS1 (Mercury 1.48); 14 Apr 09 14:31:50 +0100
X-mailer: Pegasus Mail for Windows (4.41)
X-Content-Conformance: HerringScan-0.29/Sophos-P=4.37.0+V=4.37+U=2.07.219+R=05 January 2009+T=589852@20090414.122528Z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116532>


--Message-Boundary-11820
Content-type: text/plain; charset=ISO-8859-15
Content-transfer-encoding: Quoted-printable
Content-description: Mail message body

Hi,

this is my very first attempt to use Git to make a Git patch; a microscopi=
c 
contribution. I hope the attached Patch is OK. basically it's this:

--- a/builtin-apply.c
+++ b/builtin-apply.c
-			"don't apply changes matching the given path",
+			"don't apply changes matching the given path",

Regards,
Ulrich


--Message-Boundary-11820
Content-type: Application/Octet-stream; name="0001-Fixed-bad-quote-character.patch"; type=Unknown
Content-disposition: attachment; filename="0001-Fixed-bad-quote-character.patch"
Content-transfer-encoding: BASE64

RnJvbSA0M2MzNWQ3YTM2Y2UyZDcwZjk4Y2Y2MDllZTM3Y2U0MzU0OGM4NTI3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBVbHJpY2ggV2luZGwgPFVscmljaC5XaW5kbEByei51
bmktcmVnZW5zYnVyZy5kZT4KRGF0ZTogVGh1LCA5IEFwciAyMDA5IDExOjEyOjU4ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gRml4ZWQgYmFkIHF1b3RlIGNoYXJhY3Rlci4KCi0tLQogYnVp
bHRpbi1hcHBseS5jIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi1hcHBseS5jIGIvYnVp
bHRpbi1hcHBseS5jCmluZGV4IGYzMTI3OTguLmE2NjQzMzggMTAwNjQ0Ci0tLSBhL2J1aWx0
aW4tYXBwbHkuYworKysgYi9idWlsdGluLWFwcGx5LmMKQEAgLTMyMTIsNyArMzIxMiw3IEBA
IGludCBjbWRfYXBwbHkoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LCBjb25zdCBjaGFy
ICp1bnVzZWRfcHJlZml4KQogCiAJc3RydWN0IG9wdGlvbiBidWlsdGluX2FwcGx5X29wdGlv
bnNbXSA9IHsKIAkJeyBPUFRJT05fQ0FMTEJBQ0ssIDAsICJleGNsdWRlIiwgTlVMTCwgInBh
dGgiLAotCQkJImRvbsK0dCBhcHBseSBjaGFuZ2VzIG1hdGNoaW5nIHRoZSBnaXZlbiBwYXRo
IiwKKwkJCSJkb24ndCBhcHBseSBjaGFuZ2VzIG1hdGNoaW5nIHRoZSBnaXZlbiBwYXRoIiwK
IAkJCTAsIG9wdGlvbl9wYXJzZV9leGNsdWRlIH0sCiAJCXsgT1BUSU9OX0NBTExCQUNLLCAw
LCAiaW5jbHVkZSIsIE5VTEwsICJwYXRoIiwKIAkJCSJhcHBseSBjaGFuZ2VzIG1hdGNoaW5n
IHRoZSBnaXZlbiBwYXRoIiwKLS0gCjEuNi4yLjEKCg==

--Message-Boundary-11820--
