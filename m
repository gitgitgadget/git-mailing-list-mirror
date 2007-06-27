From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Avoid perl in t1300-repo-config
Date: Wed, 27 Jun 2007 14:45:40 +0200
Message-ID: <81b0412b0706270545w65ca2556yaafaac6ff31b5961@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24495_17208577.1182948340023"
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 14:46:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3WuC-0005XA-Ji
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 14:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756599AbXF0Mpn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 08:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757907AbXF0Mpm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 08:45:42 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:21350 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735AbXF0Mpl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 08:45:41 -0400
Received: by ik-out-1112.google.com with SMTP id b32so121669ika
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 05:45:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=b3ky/YCareAKHmKicB/SNERrQmTlDoyHQ3E0RdcigBzsurLgaLkSLJ2dhNt+4bXQXC+QmcwSp6vq/m3HJeUV1n76Qp3Zw00YOarAwjot6zBhXR43fPqoPCT7txeBUBsDdPfgS30h9Ed5bE3bAPoABGJQJ8aVgcZ3Sg8XfyCct4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=aB5tnBglTlbskudY+L4ZmUadVxYlUfMR1Q9FxZlMk2iZEBohjl7nkVdd1d266+XejURPra8m1EVa8Fue98qq81GM7LfyiZ1M4/3pIztfZgQC8eb5N5Eicaww+Xb02e9ZRONcsspjyOHPVjVNE5Wf34ylaZzkZcsuhPODuGJbt2I=
Received: by 10.78.205.7 with SMTP id c7mr243782hug.1182948340076;
        Wed, 27 Jun 2007 05:45:40 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 27 Jun 2007 05:45:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51035>

------=_Part_24495_17208577.1182948340023
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It fixes the test on system where ActiveState Perl is used.
It is also shorter.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 t/t1300-repo-config.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

------=_Part_24495_17208577.1182948340023
Content-Type: text/plain; name=0001-Avoid-perl-in-t1300-repo-config.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f3fswzyc
Content-Disposition: attachment; filename="0001-Avoid-perl-in-t1300-repo-config.txt"

RnJvbSBlODQ0ZWRiZGM2MzE1MDM4NmRjNGViMmMyMDgwZWNlNGYzNzFjZDA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDI3IEp1biAyMDA3IDE0OjQwOjQxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gQXZvaWQg
cGVybCBpbiB0MTMwMC1yZXBvLWNvbmZpZwoKSXQgZml4ZXMgdGhlIHRlc3Qgb24gc3lzdGVtIHdo
ZXJlIEFjdGl2ZVN0YXRlIFBlcmwgaXMgdXNlZC4KSXQgaXMgc2hvcnRlciBhcyBhIGJvbnVzLgoK
U2lnbmVkLW9mZi1ieTogQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4KLS0tCiB0L3Qx
MzAwLXJlcG8tY29uZmlnLnNoIHwgICAxMiArKysrKystLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3QvdDEzMDAtcmVw
by1jb25maWcuc2ggYi90L3QxMzAwLXJlcG8tY29uZmlnLnNoCmluZGV4IDdhNzdiZWYuLjYwYjBk
YzUgMTAwNzU1Ci0tLSBhL3QvdDEzMDAtcmVwby1jb25maWcuc2gKKysrIGIvdC90MTMwMC1yZXBv
LWNvbmZpZy5zaApAQCAtNTMwLDI0ICs1MzAsMjQgQEAgRU9GCiAKIGNhdCA+IGV4cGVjdCA8PFxF
T0YKIEtleTogc2VjdGlvbi5zdWI9c2VjdGlvbi52YWwxCi1WYWx1ZTogZm9vPWJhcgorZm9vPWJh
cgogS2V5OiBzZWN0aW9uLnN1Yj1zZWN0aW9uLnZhbDIKLVZhbHVlOiBmb28KK2ZvbwogYmFyCiBL
ZXk6IHNlY3Rpb24uc3ViPXNlY3Rpb24udmFsMwotVmFsdWU6IAorCiAKIAogS2V5OiBzZWN0aW9u
LnN1Yj1zZWN0aW9uLnZhbDQKLVZhbHVlOiAKKwogS2V5OiBzZWN0aW9uLnN1Yj1zZWN0aW9uLnZh
bDUKIEVPRgogCi1naXQgY29uZmlnIC0tbnVsbCAtLWxpc3QgfCBwZXJsIC0wbmUgJ2Nob3A7KCRr
ZXksJHZhbHVlKT1zcGxpdCgvXG4vLCRfLDIpO3ByaW50ICJLZXk6ICRrZXlcbiI7cHJpbnQgIlZh
bHVlOiAkdmFsdWVcbiIgaWYgZGVmaW5lZCgkdmFsdWUpJyA+IHJlc3VsdAorZ2l0IGNvbmZpZyAt
LW51bGwgLS1saXN0IHwgeGFyZ3MgLW4xIC0wIGVjaG8gJ0tleTonID4gcmVzdWx0CiAKIHRlc3Rf
ZXhwZWN0X3N1Y2Nlc3MgJy0tbnVsbCAtLWxpc3QnICdjbXAgcmVzdWx0IGV4cGVjdCcKIAotZ2l0
IGNvbmZpZyAtLW51bGwgLS1nZXQtcmVnZXhwICd2YWxbMC05XScgfCBwZXJsIC0wbmUgJ2Nob3A7
KCRrZXksJHZhbHVlKT1zcGxpdCgvXG4vLCRfLDIpO3ByaW50ICJLZXk6ICRrZXlcbiI7cHJpbnQg
IlZhbHVlOiAkdmFsdWVcbiIgaWYgZGVmaW5lZCgkdmFsdWUpJyA+IHJlc3VsdAorZ2l0IGNvbmZp
ZyAtLW51bGwgLS1nZXQtcmVnZXhwICd2YWxbMC05XScgfCB4YXJncyAtbjEgLTAgZWNobyAnS2V5
OicgPiByZXN1bHQKIAogdGVzdF9leHBlY3Rfc3VjY2VzcyAnLS1udWxsIC0tZ2V0LXJlZ2V4cCcg
J2NtcCByZXN1bHQgZXhwZWN0JwogCi0tIAoxLjUuMi4yLjEzMDguZzU0MGI2Cgo=
------=_Part_24495_17208577.1182948340023--
