From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: PATCH: disable t4016-diff-quote.sh on some filesystems
Date: Tue, 20 Feb 2007 10:07:22 +0100
Message-ID: <81b0412b0702200107s767d13abj40e2a021e4307b9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_33445_15729338.1171962442143"
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 10:07:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJQy9-0003ql-5k
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 10:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbXBTJHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 04:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbXBTJHZ
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 04:07:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:12286 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbXBTJHX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 04:07:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so744762uga
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 01:07:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=CAo45HYfmkNPRRnYJk48c5i5nvi+95CPeSlf/kfruDNcqhW3JXyqQeT7OSM513wFsapGdzZp68GpLtMOi19W0L7szW/YgXDMLFyYZZs/BeSFYsOxoqstvZTzhZuot2YwYKrc5O5U/c28YAEjuSwgXreRO9jeyCOazmivHnNVmA8=
Received: by 10.78.171.20 with SMTP id t20mr501863hue.1171962442173;
        Tue, 20 Feb 2007 01:07:22 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 20 Feb 2007 01:07:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40215>

------=_Part_33445_15729338.1171962442143
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

because the filesystems (most typically FAT and NTFS) do not support
HT nor LF in filenames.

---
 t/t4016-diff-quote.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

------=_Part_33445_15729338.1171962442143
Content-Type: text/plain; 
	name=0001-disable-t4016-diff-quote.sh-on-some-filesystems.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eye46gb6
Content-Disposition: attachment; filename="0001-disable-t4016-diff-quote.sh-on-some-filesystems.txt"

RnJvbSAwZWRiYzZkZjk3N2U3ZDk1NDAzMmVhZjcyNzIwYzkzYjg2YWI0YzBmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDIwIEZlYiAyMDA3IDEwOjA0OjMyICswMTAwClN1YmplY3Q6IFtQQVRDSF0gZGlzYWJs
ZSB0NDAxNi1kaWZmLXF1b3RlLnNoIG9uIHNvbWUgZmlsZXN5c3RlbXMKCi0tLQogdC90NDAxNi1k
aWZmLXF1b3RlLnNoIHwgICAgNCArKysrCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90L3Q0MDE2LWRpZmYtcXVvdGUuc2ggYi90
L3Q0MDE2LWRpZmYtcXVvdGUuc2gKaW5kZXggZWRkZThmNS4uOGU5NDIyYyAxMDA3NTUKLS0tIGEv
dC90NDAxNi1kaWZmLXF1b3RlLnNoCisrKyBiL3QvdDQwMTYtZGlmZi1xdW90ZS5zaApAQCAtMTMs
NiArMTMsMTAgQEAgUDE9J3BhdGhuYW1lCXdpdGggSFQnCiBQMj0ncGF0aG5hbWUgd2l0aCBTUCcK
IFAzPSdwYXRobmFtZQogd2l0aCBMRicKK2lmICEgdGVzdCA6IDI+L2Rldi9udWxsID4iJFAxIiA7
IHRoZW4KKwllY2hvID4mMiAnRmlsZXN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0IHRhYnMgaW4gbmFt
ZXMnCisJdGVzdF9kb25lCitmaQogCiB0ZXN0X2V4cGVjdF9zdWNjZXNzIHNldHVwICcKIAllY2hv
IFAwLjAgPiIkUDAuMCIgJiYKLS0gCjEuNS4wLnJjNC44NC5nNjdmYzEKCg==
------=_Part_33445_15729338.1171962442143--
