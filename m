From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH 2/2] Use test-chmtime -v instead of perl in t5000 to get mtime of a file
Date: Thu, 30 Oct 2008 12:27:31 +0100
Message-ID: <81b0412b0810300427l259fb8ddl6ef92ae9dc8aeace@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24645_8527017.1225366051545"
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"=?UTF-8?Q?Ren=C3=A9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 12:28:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvVhq-0008TJ-5J
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 12:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbYJ3L1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 07:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbYJ3L1e
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 07:27:34 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:27655 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbYJ3L1d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 07:27:33 -0400
Received: by yx-out-2324.google.com with SMTP id 8so178729yxm.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 04:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:mime-version:content-type;
        bh=d6QwMhl3fzioK8mgfcp1UUO3wF3bCtajK2pL3E6GiZk=;
        b=ieiZ8DddQDx4LkhmHKvOKtvTOeEMkBRQ9sgtD2W2ZHsPR+EVz4L8L+MDbupLPn1hKZ
         86KnVq3dRq0mp314bPg+Fq4IWWUN+ud1tGexTMosdSL7Il0jtyL3S78Gvk3q5s3t/sBr
         H/VpKl0lvjTMS9ACKJ0i47SrO5t9qS+AS4zm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type;
        b=E7swCtejcQWf+TzUDcawtg2G5E+3W6DRt+q2dNUP+cGeq49eO55ohEzfdPQaqMYlrY
         6iRpoogpPCSyoyJk9eop7hFooD4Sqqvq2GuROk42UuNIoJepMypGr9GIFgPaVgoB7mFj
         +RIhyZ0hiyypk9QFklLinCNNODGCFX5226QKs=
Received: by 10.100.207.14 with SMTP id e14mr484823ang.60.1225366051564;
        Thu, 30 Oct 2008 04:27:31 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Thu, 30 Oct 2008 04:27:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99459>

------=_Part_24645_8527017.1225366051545
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The test was broken on admittedly broken combination of Windows, Cygwin,
and ActiveState Perl.

Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>
---
 t/t5000-tar-tree.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_24645_8527017.1225366051545
Content-Type: text/x-diff;
 name=0002-Use-test-chmtime-v-instead-of-perl-in-t5000-to-get.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fmxbapxq1
Content-Disposition: attachment;
 filename=0002-Use-test-chmtime-v-instead-of-perl-in-t5000-to-get.patch

RnJvbSAxMDEzYzFhMmI1MWExODNiZDBmNjA1OWIyZTFhMWVkNjhiMjE3M2Q1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUaHUsIDMwIE9jdCAyMDA4IDExOjIwOjI3ICswMTAwClN1YmplY3Q6IFtQQVRDSCAyLzJdIFVz
ZSB0ZXN0LWNobXRpbWUgLXYgaW5zdGVhZCBvZiBwZXJsIGluIHQ1MDAwIHRvIGdldCBtdGltZSBv
ZiBhIGZpbGUKClRoZSB0ZXN0IHdhcyBicm9rZW4gb24gYWRtaXR0ZWRseSBicm9rZW4gY29tYmlu
YXRpb24gb2YgV2luZG93cywgQ3lnd2luLAphbmQgQWN0aXZlU3RhdGUgUGVybC4KClNpZ25lZC1v
ZmYtYnk6IEFsZXggUmllc2VuIDxhcmllc2VuQGhhcm1hbmJlY2tlci5jb20+Ci0tLQogdC90NTAw
MC10YXItdHJlZS5zaCB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3QvdDUwMDAtdGFyLXRyZWUuc2ggYi90L3Q1
MDAwLXRhci10cmVlLnNoCmluZGV4IDBmMjdkNzMuLmM5NDJjOGIgMTAwNzU1Ci0tLSBhL3QvdDUw
MDAtdGFyLXRyZWUuc2gKKysrIGIvdC90NTAwMC10YXItdHJlZS5zaApAQCAtOTAsNyArOTAsNyBA
QCB0ZXN0X2V4cGVjdF9zdWNjZXNzIFwKICAgICAndmFsaWRhdGUgZmlsZSBtb2RpZmljYXRpb24g
dGltZScgXAogICAgICdta2RpciBleHRyYWN0ICYmCiAgICAgICIkVEFSIiB4ZiBiLnRhciAtQyBl
eHRyYWN0IGEvYSAmJgotICAgICBwZXJsIC1lICdcJydwcmludCgoc3RhdCgiZXh0cmFjdC9hL2Ei
KSlbOV0sICJcbiIpJ1wnJyA+Yi5tdGltZSAmJgorICAgICB0ZXN0LWNobXRpbWUgLXYgKzAgZXh0
cmFjdC9hL2EgfGN1dCAtZiAxID5iLm10aW1lICYmCiAgICAgIGVjaG8gIjExMTcyMzEyMDAiID5l
eHBlY3RlZC5tdGltZSAmJgogICAgICBkaWZmIGV4cGVjdGVkLm10aW1lIGIubXRpbWUnCiAKLS0g
CjEuNi4wLjMuNTUyLmc0ZmY3MwoK
------=_Part_24645_8527017.1225366051545--
