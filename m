From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Add an option to override the configured setting for merge summaries
Date: Wed, 23 May 2007 18:04:57 +0200
Message-ID: <81b0412b0705230904i70a3e325r81a9d506c30bb81b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_64032_12448029.1179936297024"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 23 18:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqtKi-0003bJ-Sr
	for gcvg-git@gmane.org; Wed, 23 May 2007 18:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758524AbXEWQFB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 12:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758798AbXEWQFA
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 12:05:00 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:49540 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758524AbXEWQFA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 12:05:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so575833ugf
        for <git@vger.kernel.org>; Wed, 23 May 2007 09:04:57 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=j6X5UCZ96C4NvU/+8EtyH8CFBRP4zUc/idwyxG/qONTmWzAc43SZItDnExsO8ZATKtYHpkpjF2TydQb5DQYSso7BYDJYWfR/9iIbrhRotcTt225cJiCCGX+uDffN0gvsyzpBl0EegngQ6W7PhK9dPgo5etG7ky0z4IiHr/+NFPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=dLCYdbeQUrz4+iC7vT1jv7EqhBYWdn51IdzCh57SODieR23RKSEJMnGYhzue0HG8wO4iOxhydsvGlFmDxWo8ar5vwhlgOUf+Aa4VwdslDUFSE7tbzYRlAb3t96w98+0CDX7yFr3mfJ3bLXkSx6EERryRMr6ggc9clRZl+c02JO4=
Received: by 10.78.120.6 with SMTP id s6mr164384huc.1179936297046;
        Wed, 23 May 2007 09:04:57 -0700 (PDT)
Received: by 10.78.97.16 with HTTP; Wed, 23 May 2007 09:04:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48162>

------=_Part_64032_12448029.1179936297024
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Just for completeness.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 git-merge.sh |    5 ++++-
 git-pull.sh  |    3 +++
 2 files changed, 7 insertions(+), 1 deletions(-)

------=_Part_64032_12448029.1179936297024
Content-Type: text/plain; 
	name=0002-Add-an-option-to-override-the-configured-setting-for-m.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f21zlrob
Content-Disposition: attachment; filename="0002-Add-an-option-to-override-the-configured-setting-for-m.txt"

RnJvbSA0OGE2YTNkYjFhMjFmMWNlM2RiNTE2OTg3YjE2N2E5ZDZiMjE0M2E3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDIzIE1heSAyMDA3IDE3OjM2OjAwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQWRkIGFu
IG9wdGlvbiB0byBvdmVycmlkZSB0aGUgY29uZmlndXJlZCBzZXR0aW5nIGZvciBtZXJnZSBzdW1t
YXJpZXMKCkp1c3QgZm9yIGNvbXBsZXRlbmVzcy4KClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2Vu
IDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQogZ2l0LW1lcmdlLnNoIHwgICAgNSArKysrLQogZ2l0
LXB1bGwuc2ggIHwgICAgMyArKysKIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1tZXJnZS5zaCBiL2dpdC1tZXJnZS5zaApp
bmRleCA3ZmJlMDNhLi5lNzljYzc2IDEwMDc1NQotLS0gYS9naXQtbWVyZ2Uuc2gKKysrIGIvZ2l0
LW1lcmdlLnNoCkBAIC0zLDcgKzMsNyBAQAogIyBDb3B5cmlnaHQgKGMpIDIwMDUgSnVuaW8gQyBI
YW1hbm8KICMKIAotVVNBR0U9J1stbl0gWy0tbm8tY29tbWl0XSBbLS1zcXVhc2hdIFstcyA8c3Ry
YXRlZ3k+XSBbLW09PG1lcmdlLW1lc3NhZ2U+XSA8Y29tbWl0PisnCitVU0FHRT0nWy1uXSBbLS1z
dW1tYXJ5XSBbLS1uby1jb21taXRdIFstLXNxdWFzaF0gWy1zIDxzdHJhdGVneT5dIFstbT08bWVy
Z2UtbWVzc2FnZT5dIDxjb21taXQ+KycKIAogU1VCRElSRUNUT1JZX09LPVllcwogLiBnaXQtc2gt
c2V0dXAKQEAgLTEyOCw2ICsxMjgsOSBAQCBkbwogCS1ufC0tbnwtLW5vfC0tbm8tfC0tbm8tc3wt
LW5vLXN1fC0tbm8tc3VtfC0tbm8tc3VtbXxcCiAJCS0tbm8tc3VtbWF8LS1uby1zdW1tYXJ8LS1u
by1zdW1tYXJ5KQogCQlub19zdW1tYXJ5PXQgOzsKKwktLXN1bW1hcnkpCisJCW5vX3N1bW1hcnk9
CisJCTs7CiAJLS1zcXwtLXNxdXwtLXNxdWF8LS1zcXVhc3wtLXNxdWFzaCkKIAkJc3F1YXNoPXQg
bm9fY29tbWl0PXQgOzsKIAktLW5vLWN8LS1uby1jb3wtLW5vLWNvbXwtLW5vLWNvbW18LS1uby1j
b21taXwtLW5vLWNvbW1pdCkKZGlmZiAtLWdpdCBhL2dpdC1wdWxsLnNoIGIvZ2l0LXB1bGwuc2gK
aW5kZXggYTM2NjVkNy4uYmEwY2EwNyAxMDA3NTUKLS0tIGEvZ2l0LXB1bGwuc2gKKysrIGIvZ2l0
LXB1bGwuc2gKQEAgLTIyLDYgKzIyLDkgQEAgZG8KIAktbnwtLW58LS1ub3wtLW5vLXwtLW5vLXN8
LS1uby1zdXwtLW5vLXN1bXwtLW5vLXN1bW18XAogCQktLW5vLXN1bW1hfC0tbm8tc3VtbWFyfC0t
bm8tc3VtbWFyeSkKIAkJbm9fc3VtbWFyeT0tbiA7OworCS0tc3VtbWFyeSkKKwkJbm9fc3VtbWFy
eT0kMQorCQk7OwogCS0tbm8tY3wtLW5vLWNvfC0tbm8tY29tfC0tbm8tY29tbXwtLW5vLWNvbW1p
fC0tbm8tY29tbWl0KQogCQlub19jb21taXQ9LS1uby1jb21taXQgOzsKIAktLXNxfC0tc3F1fC0t
c3F1YXwtLXNxdWFzfC0tc3F1YXNoKQotLSAKMS41LjIuNzg3Lmc1Njc3MAoK
------=_Part_64032_12448029.1179936297024--
