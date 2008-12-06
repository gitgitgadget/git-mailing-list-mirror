From: "=?UTF-8?Q?Bj=C3=B8rn_Lindeijer?=" <bjorn@lindeijer.nl>
Subject: [PATCH] Spelling fix in release notes
Date: Sat, 6 Dec 2008 23:00:56 +0100
Message-ID: <853f61c50812061400n46904efcl534dd7c6353d7ca4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Dec 06 23:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L95Ov-0005IK-Oq
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 23:13:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbYLFWA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 17:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbYLFWA7
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 17:00:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:20289 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbYLFWA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 17:00:58 -0500
Received: by nf-out-0910.google.com with SMTP id d3so277522nfc.21
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 14:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=6h/i1uB47WLqRigBX5h7Omhegzz//jyORg5i4h+3I20=;
        b=jUrjqh2RjAUKQ0LTIUPMMn9Ub6JqPgmggiaF8OjF6Ug+BN17l6J/rb9Oy5lSCUst9w
         JViOLPz+pUuM5RMFfUH4X/hsSfVm7otdCTsqFwTpN9zLK8DEPA1ErePnZozXNEyIS6gl
         ydFJJpcGJlaFXbiLk60VvxLsyBCnyrOYn460I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=B5he3TUbjY79MZZQld7OIJ3Q8cyJ4BmPEVCQMpjl3f4OOcE0ssHwlvvn7inW2fe563
         WoCtg/YJ4MOG1WnWr+i59XfvyL9bCFq28psVxcBYks7ajOwdfzcHkKg0DL5ykebrnufE
         F9siO6joufUtKoeRyw55XsVpTkjSIBsIzyUGo=
Received: by 10.210.29.11 with SMTP id c11mr1697315ebc.141.1228600856738;
        Sat, 06 Dec 2008 14:00:56 -0800 (PST)
Received: by 10.210.102.18 with HTTP; Sat, 6 Dec 2008 14:00:56 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: ace5b59844161ed2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102479>

U2lnbmVkLW9mZi1ieTogQmrDuHJuIExpbmRlaWplciA8Ympvcm5AbGluZGVpamVyLm5sPgotLS0K
IERvY3VtZW50YXRpb24vUmVsTm90ZXMtMS42LjEudHh0IHwgICAgMiArLQogMSBmaWxlcyBjaGFu
Z2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9SZWxOb3Rlcy0xLjYuMS50eHQgYi9Eb2N1bWVudGF0aW9uL1JlbE5vdGVzLTEuNi4x
LnR4dAppbmRleCA5ZjVjMGI1Li45NTkzMDc1IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL1Jl
bE5vdGVzLTEuNi4xLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL1JlbE5vdGVzLTEuNi4xLnR4dApA
QCAtNzAsNyArNzAsNyBAQCBvbi4KICAgc3Vic2VxdWVudCAiZ2l0IGRpZmYiIHdpbGwgc2hvdyBh
IGRpZmYgYXMgaWYgdGhleSBhcmUgY3JlYXRpb24gZXZlbnRzLgoKICogImdpdCBhZGQiIGdhaW5l
ZCBhIGJ1aWx0LWluIHN5bm9ueW0gZm9yIHBlb3BsZSB3aG8gd2FudCB0byBzYXkgInN0YWdlCi0g
IGNoYW5nZXMiIGluc3RlYWQgb2YgImFkZCBjb250ZW50cyB0aGUgdGhlIHN0YWdpbmcgYXJlYSIg
d2hpY2ggYW1vdW50cworICBjaGFuZ2VzIiBpbnN0ZWFkIG9mICJhZGQgY29udGVudHMgdG8gdGhl
IHN0YWdpbmcgYXJlYSIgd2hpY2ggYW1vdW50cwogICB0byB0aGUgc2FtZSB0aGluZy4KCiAqICJn
aXQgYXBwbHkiIGxlYXJuZWQgLS1pbmNsdWRlPXBhdGhzIG9wdGlvbiwgc2ltaWxhciB0byB0aGUg
ZXhpc3RpbmcKLS0gCjEuNi4xLnJjMS41Ny5nNzE1NjIK
