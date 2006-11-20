X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: [PATCH] Documentation tutorial.txt: Teach the reader about git commit -a -s
Date: Mon, 20 Nov 2006 23:30:56 +0100
Message-ID: <4d8e3fd30611201430l6135814yc89f4abdb9044340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_37789_1457800.1164061856161"
NNTP-Posting-Date: Mon, 20 Nov 2006 22:31:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=nddWPgel5tnXnIE3jfMiIB/0+Ck4RcaLgtg7LsjfrHHZK+Qrx+l9ufASjPOM4hmAb92tR3BVh0ZOhPzxw+VifMl4ypb3k+0jpJw0IgXVom+ZdBfCqUPaYc/FlRLXd9LR2evMh1oGpp0C+LD4N3ZPApJWBYTS5ggvow3TWK2A850=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31945>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmHfK-0005lw-Pe for gcvg-git@gmane.org; Mon, 20 Nov
 2006 23:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934278AbWKTWa7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 17:30:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934272AbWKTWa6
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 17:30:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:64763 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S934278AbWKTWa5
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 17:30:57 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2493856nfa for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 14:30:56 -0800 (PST)
Received: by 10.78.26.9 with SMTP id 9mr5658910huz.1164061856232; Mon, 20 Nov
 2006 14:30:56 -0800 (PST)
Received: by 10.78.165.3 with HTTP; Mon, 20 Nov 2006 14:30:56 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

------=_Part_37789_1457800.1164061856161
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think it's important to mention, in the collaboration section,
that is possible to use the -s option to add the Signed-off-by
line

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
---
 Documentation/tutorial.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 554ee0a..402afdf 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -200,7 +200,7 @@ Bob then makes some changes and commits

 ------------------------------------------------
 (edit files)
-$ git commit -a
+$ git commit -a (add -s to add Signed-off-by line at the end of the
commit message)
 (repeat as necessary)
 ------------------------------------------------

-- 
1.4.4.gef06


-- 
Paolo
http://www.linkedin.com/pub/0/132/9a3

------=_Part_37789_1457800.1164061856161
Content-Type: text/plain; 
	name=0001-Documentation-Teach-the-reader-about-git-commit-a-s.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eurgcq42
Content-Disposition: attachment; filename="0001-Documentation-Teach-the-reader-about-git-commit-a-s.txt"

RnJvbSAxZDFlZWQ3MDgxNjk5N2VlYjE4MWE1NDkzY2VjOWY1ODQ2N2JkMDFlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYW9sbyBDaWFycm9jY2hpIDxwYW9sby5jaWFycm9jY2hpQGdt
YWlsLmNvbT4KRGF0ZTogTW9uLCAyMCBOb3YgMjAwNiAyMzoyODoxNiArMDEwMApTdWJqZWN0OiBb
UEFUQ0hdIERvY3VtZW50YXRpb246IFRlYWNoIHRoZSByZWFkZXIgYWJvdXQgZ2l0IGNvbW1pdCAt
YSAtcwoKSSB0aGluayBpdCdzIGltcG9ydGFudCB0byBtZW50aW9uLCBpbiB0aGUgY29sbGFib3Jh
dGlvbiBzZWN0aW9uLAp0aGF0IGlzIHBvc3NpYmxlIHRvIHVzZSB0aGUgLXMgb3B0aW9uIHRvIGFk
ZCB0aGUgU2lnbmVkLW9mZi1ieQpsaW5lCgpTaWduZWQtb2ZmLWJ5OiBQYW9sbyBDaWFycm9jY2hp
IDxwYW9sby5jaWFycm9jY2hpQGdtYWlsLmNvbT4KLS0tCiBEb2N1bWVudGF0aW9uL3R1dG9yaWFs
LnR4dCB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vdHV0b3JpYWwudHh0IGIvRG9jdW1l
bnRhdGlvbi90dXRvcmlhbC50eHQKaW5kZXggNTU0ZWUwYS4uNDAyYWZkZiAxMDA2NDQKLS0tIGEv
RG9jdW1lbnRhdGlvbi90dXRvcmlhbC50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi90dXRvcmlhbC50
eHQKQEAgLTIwMCw3ICsyMDAsNyBAQCBCb2IgdGhlbiBtYWtlcyBzb21lIGNoYW5nZXMgYW5kIGNv
bW1pdHMKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiAoZWRpdCBmaWxlcykKLSQgZ2l0IGNvbW1pdCAtYQorJCBnaXQgY29tbWl0IC1hIChhZGQgLXMg
dG8gYWRkIFNpZ25lZC1vZmYtYnkgbGluZSBhdCB0aGUgZW5kIG9mIHRoZSBjb21taXQgbWVzc2Fn
ZSkKIChyZXBlYXQgYXMgbmVjZXNzYXJ5KQogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCiAKLS0gCjEuNC40LmdlZjA2Cgo=
