From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Add a test for git-config --file
Date: Tue, 31 Jul 2007 13:53:49 +0200
Message-ID: <81b0412b0707310453n5077a018ybbbfcf690fb82467@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_36590_2059235.1185882829791"
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 13:53:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFqIV-0001N2-9b
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 13:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbXGaLxw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 07:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754755AbXGaLxw
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 07:53:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:2628 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbXGaLxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 07:53:51 -0400
Received: by ug-out-1314.google.com with SMTP id j3so65407ugf
        for <git@vger.kernel.org>; Tue, 31 Jul 2007 04:53:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Cn/u8m+9wsB5o8xipe5EKTwWdoVnXONPGJ7DfkvSkkIsdrJBwigaracW2H2cS/fCRXMatmWgSRGYdw1M309iqFb0XW/himjtcQEjuv5NpmiP7J4IVUlM17qvzP3akMIJ3RBLlAMjvko/hD77F8FNJpl8kt2RCW0LMYFW+q1RZ4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=EEdhb/9TIBXAD8De9ZlJBPnNOH9HURzrwnv5EhV/ZvNdiTX7kPCGsUwTnB+c3E0Y32PHXf2u7RR7VbKjWBKACXbXHeZ5aTiDvTW6ojs0+gdrQZ9jVo1r2UwcdJnHLQO03aMQUGYfUlvDtBY2RHf0mmMYt+cxeMckeHVtL1pPps8=
Received: by 10.78.170.6 with SMTP id s6mr1768438hue.1185882830036;
        Tue, 31 Jul 2007 04:53:50 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Tue, 31 Jul 2007 04:53:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54339>

------=_Part_36590_2059235.1185882829791
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Check for non-0 exit code if the confiog file does not exist and
if it works exactly like when setting GIT_CONFIG.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t1300-repo-config.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

------=_Part_36590_2059235.1185882829791
Content-Type: text/plain; name=0002-Add-a-test-for-git-config-file.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f4sc2qa5
Content-Disposition: attachment; filename="0002-Add-a-test-for-git-config-file.txt"

RnJvbSBhNWFlMThmMjk5ZDQzMTA1MzA3NGMwZWJkY2YyZDk2YTNhYzlkZmY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDMxIEp1bCAyMDA3IDEyOjMwOjUyICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQWRkIGEg
dGVzdCBmb3IgZ2l0LWNvbmZpZyAtLWZpbGUKCkNoZWNrIGZvciBub24tMCBleGl0IGNvZGUgaWYg
dGhlIGNvbmZpb2cgZmlsZSBkb2VzIG5vdCBleGlzdCBhbmQKaWYgaXQgd29ya3MgZXhhY3RseSBs
aWtlIHdoZW4gc2V0dGluZyBHSVRfQ09ORklHLgoKU2lnbmVkLW9mZi1ieTogQWxleCBSaWVzZW4g
PHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiB0L3QxMzAwLXJlcG8tY29uZmlnLnNoIHwgICAgNiAr
KysrKysKIDEgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL3QvdDEzMDAtcmVwby1jb25maWcuc2ggYi90L3QxMzAwLXJlcG8tY29uZmln
LnNoCmluZGV4IDE4N2NhMmQuLjFkMmJmMmMgMTAwNzU1Ci0tLSBhL3QvdDEzMDAtcmVwby1jb25m
aWcuc2gKKysrIGIvdC90MTMwMC1yZXBvLWNvbmZpZy5zaApAQCAtMzI1LDYgKzMyNSw5IEBAIEVP
RgogCiB0ZXN0X2V4cGVjdF9zdWNjZXNzICduZXcgdmFyaWFibGUgaW5zZXJ0cyBpbnRvIHByb3Bl
ciBzZWN0aW9uJyAnY21wIC5naXQvY29uZmlnIGV4cGVjdCcKIAordGVzdF9leHBlY3Rfc3VjY2Vz
cyAnYWx0ZXJuYXRpdmUgR0lUX0NPTkZJRyAobm9uLWV4aXN0aW5nIGZpbGUgc2hvdWxkIGZhaWwp
JyBcCisJJ2dpdCBjb25maWcgLS1maWxlIG5vbi1leGlzdGluZy1jb25maWcgLWw7IHRlc3QgJD8g
IT0gMCcKKwogY2F0ID4gb3RoZXItY29uZmlnIDw8IEVPRgogW2Vpbl0KIAliYWhuID0gc3RyYXNz
ZQpAQCAtMzM4LDYgKzM0MSw5IEBAIEdJVF9DT05GSUc9b3RoZXItY29uZmlnIGdpdCBjb25maWcg
LWwgPiBvdXRwdXQKIAogdGVzdF9leHBlY3Rfc3VjY2VzcyAnYWx0ZXJuYXRpdmUgR0lUX0NPTkZJ
RycgJ2NtcCBvdXRwdXQgZXhwZWN0JwogCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdhbHRlcm5hdGl2
ZSBHSVRfQ09ORklHICgtLWZpbGUpJyBcCisJJ2dpdCBjb25maWcgLS1maWxlIG90aGVyLWNvbmZp
ZyAtbCA+IG91dHB1dCAmJiBjbXAgb3V0cHV0IGV4cGVjdCcKKwogR0lUX0NPTkZJRz1vdGhlci1j
b25maWcgZ2l0IGNvbmZpZyBhbndvaG5lci5wYXJrIGF1c3dlaXMKIAogY2F0ID4gZXhwZWN0IDw8
IEVPRgotLSAKMS41LjMucmMzLjEzMi5nMzkxNzkKCg==
------=_Part_36590_2059235.1185882829791--
