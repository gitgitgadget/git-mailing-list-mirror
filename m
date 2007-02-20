From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] disable t4016-diff-quote.sh on some filesystems
Date: Tue, 20 Feb 2007 10:27:40 +0100
Message-ID: <81b0412b0702200127m231425d6p67d2d67e6d7d9b04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_33569_19868642.1171963660472"
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 20 10:27:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJRHm-0004pp-Bj
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 10:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbXBTJ1n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 04:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbXBTJ1n
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 04:27:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:27475 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbXBTJ1m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 04:27:42 -0500
Received: by ug-out-1314.google.com with SMTP id 44so747139uga
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 01:27:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=MT0X23jrh0So/39v6aHB/OAOl8O6LAyfJwP0S1U2Ty6lLaLeFwKimdpT+et9U4VfFBIuQ5Z/7HRNFR26QCyLnIIfnCc/e+WWhV7KbIDUbwGzLyRBciGCCfpWX8qCnaqhIA+kVHcc0voTjMI943cxgrTvxqCbzWpM6JfgArjxcJU=
Received: by 10.78.151.3 with SMTP id y3mr1194182hud.1171963660528;
        Tue, 20 Feb 2007 01:27:40 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Tue, 20 Feb 2007 01:27:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40216>

------=_Part_33569_19868642.1171963660472
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

because the filesystems (most typically FAT and NTFS) do not support
HT nor LF in filenames.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---
God help me...

  t/t4016-diff-quote.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

------=_Part_33569_19868642.1171963660472
Content-Type: text/plain; name="0001-disable-t4016-diff-quote.sh-on-some-filesystems.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-disable-t4016-diff-quote.sh-on-some-filesystems.txt"
X-Attachment-Id: f_eye4y34j

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
------=_Part_33569_19868642.1171963660472--
