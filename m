From: Caleb Cushing <xenoterracide@gmail.com>
Subject: feature request mergetool, skip, abort
Date: Tue, 20 Jan 2009 11:39:59 -0500
Message-ID: <81bfc67a0901200839q361923f1xb25ddadfdac37981@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5ab80a7b61e0460ecb0b2
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 17:42:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPJfx-00051S-4Y
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 17:42:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757127AbZATQkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 11:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756843AbZATQkj
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 11:40:39 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:36105 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088AbZATQkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 11:40:39 -0500
Received: by bwz14 with SMTP id 14so11114515bwz.13
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 08:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=+dlZWU4O2woqiJYZOx25BQoe+/4Bm1AqYeuMJM939HQ=;
        b=Q+7hmIWg++cNSrhska2Y2g1/LMOikiKlA+0bedgG6z//+lgOW7+dEURJKLgFspRHwR
         /Kd3rgBTlzkwUm9wLD/Fx3LyKlxQ9pMB4sEGq9DSBNHVcYkUWW9zWqARlzE5j2IKjQT+
         6JmlKVUgTZpuJVjhHPQK61KIP+RgeHlNedE7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=XTle3YevA8vKYI8xuE71h6+Pf0HgcLj2fNBtMNqfAmGp2kNq/sXmIII3hozvhjxUMu
         GGieH75jm+5Mf1Y0FxCAO2KzPsL41lliboXe8OUSMejRc1DIt8gKfIOxqAOtdqXEqtqw
         hCKp3HA80NK08RIB+J3vRVrmxrrZBIzA+q1Gk=
Received: by 10.223.110.10 with SMTP id l10mr2673674fap.51.1232469599171; Tue, 
	20 Jan 2009 08:39:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106489>

--001636c5ab80a7b61e0460ecb0b2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

firstly my patch sucks, and I know it. but hopefully it'll give some
idea of what I'm trying to do and someone can implement it properly.

basically there are some files, that I can't merge with git, but I
need to merge other files before I can fix those and I like to use
mergetool, so I want a way to skip the files I'm not going to be able
to merge.

-- 
Caleb Cushing

http://xenoterracide.blogspot.com

--001636c5ab80a7b61e0460ecb0b2
Content-Type: application/octet-stream; 
	name="0001-preliminary-merge-skip-abort-patch.patch"
Content-Disposition: attachment; 
	filename="0001-preliminary-merge-skip-abort-patch.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fq6se4gq

RnJvbSBiNDM2MDNiY2Q0MDhjY2NlYTdiYTU1MDQxYTgzNTZkMGNhNTM2OTg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDYWxlYiBDdXNoaW5nIDx4ZW5vdGVycmFjaWRlQGdtYWlsLmNv
bT4KRGF0ZTogVHVlLCAyMCBKYW4gMjAwOSAxMTozMzozMCAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IHByZWxpbWluYXJ5IG1lcmdlL3NraXAvYWJvcnQgcGF0Y2gKCi0tLQogZ2l0LW1lcmdldG9vbC5z
aCB8ICAgMjIgKysrKysrKysrKysrKysrKysrLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1tZXJnZXRvb2wuc2gg
Yi9naXQtbWVyZ2V0b29sLnNoCmluZGV4IDAwZTEzMzcuLmMwYjI3ZWQgMTAwNzU1Ci0tLSBhL2dp
dC1tZXJnZXRvb2wuc2gKKysrIGIvZ2l0LW1lcmdldG9vbC5zaApAQCAtMTc3LDExICsxNzcsMjUg
QEAgbWVyZ2VfZmlsZSAoKSB7CiAgICAgZGVzY3JpYmVfZmlsZSAiJGxvY2FsX21vZGUiICJsb2Nh
bCIgIiRMT0NBTCIKICAgICBkZXNjcmliZV9maWxlICIkcmVtb3RlX21vZGUiICJyZW1vdGUiICIk
UkVNT1RFIgogICAgIGlmICIkcHJvbXB0IiA9IHRydWU7IHRoZW4KLQlwcmludGYgIkhpdCByZXR1
cm4gdG8gc3RhcnQgbWVyZ2UgcmVzb2x1dGlvbiB0b29sICglcyk6ICIgIiRtZXJnZV90b29sIgot
CXJlYWQgYW5zCi0gICAgZmkKKwkJd2hpbGUgdHJ1ZTsgZG8KKwkJcHJpbnRmICJVc2UgKG0pZXJn
ZSBmaWxlIG9yIChzKXNraXAgZmlsZSwgb3IgKGEpYm9ydD8gKCVzKTogIiBcCisJCSIkbWVyZ2Vf
dG9vbCIKKwkJcmVhZCBhbnMKKwkJY2FzZSAiJGFucyIgaW4KKwkJCVttTV0qKQorCQkJYnJlYWsK
KwkJCTs7CisJCQlbc1NdKikKKwkJCXJldHVybiAwICNnbyB0byB0aGUgbmV4dCBmaWxlLCBuZWVk
cyB0byBjbGVhbiB1cAorCQkJOzsKKwkJCVthQV0qKQorCQkJcmV0dXJuIDEgI3Nob3VsZCBleGl0
IGltbWVkaWF0ZWx5LCBkb2Vzbid0CisJCQk7OworCQllc2FjCisJCWRvbmUKKwlmaQogCi0gICAg
Y2FzZSAiJG1lcmdlX3Rvb2wiIGluCisJY2FzZSAiJG1lcmdlX3Rvb2wiIGluCiAJa2RpZmYzKQog
CSAgICBpZiBiYXNlX3ByZXNlbnQgOyB0aGVuCiAJCSgiJG1lcmdlX3Rvb2xfcGF0aCIgLS1hdXRv
IC0tTDEgIiRNRVJHRUQgKEJhc2UpIiAtLUwyICIkTUVSR0VEIChMb2NhbCkiIC0tTDMgIiRNRVJH
RUQgKFJlbW90ZSkiIFwKLS0gCjEuNi4xCgo=
--001636c5ab80a7b61e0460ecb0b2--
