From: "Sean" <seanlkml@sympatico.ca>
Subject: Commit template
Date: Sun, 8 May 2005 15:07:36 -0400 (EDT)
Message-ID: <1965.10.10.10.24.1115579256.squirrel@linux1>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20050508150736_40098"
Cc: "GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 08 21:00:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUr1L-0008Pl-Rj
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVEHTHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbVEHTHo
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:07:44 -0400
Received: from simmts7.bellnexxia.net ([206.47.199.165]:62350 "EHLO
	simmts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261549AbVEHTHh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 15:07:37 -0400
Received: from linux1 ([69.156.111.46]) by simmts7-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050508190736.OIJI3701.simmts7-srv.bellnexxia.net@linux1>;
          Sun, 8 May 2005 15:07:36 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j48J7Zo3027573;
	Sun, 8 May 2005 15:07:35 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 8 May 2005 15:07:36 -0400 (EDT)
To: "Petr Baudis" <pasky@ucw.cz>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

------=_20050508150736_40098
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi Petr,

This adds the ability to have a per repository commit template.  Create a
.git/commit.form file containg  "CG: " and other lines and it will be used
in place of the regular top 3 lines.  This is kind of handy so that you
can include your signed-off-by: with your email etc.

 cg-commit |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

Sean

P.s. Can't inline patches with this mailer.

------=_20050508150736_40098
Content-Type: application/octet-stream; name="cg-commit.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cg-commit.patch"

Y2ctY29tbWl0OiBuZWVkcyB1cGRhdGUKSW5kZXg6IGNnLWNvbW1pdAo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBi
MmNlODUyZmQ3NzIwOWUxMTJlMGI1Mzg2NmNhNzAwNGU5YjA4NzlmL2NnLWNvbW1pdCAgKG1vZGU6
MTAwNzU1KQorKysgdW5jb21taXR0ZWQvY2ctY29tbWl0ICAobW9kZToxMDA3NTUpCkBAIC02Nyw5
ICs2NywxNCBAQAogCiBMT0dNU0c9JChta3RlbXAgLXQgZ2l0Y2kuWFhYWFhYKQogTE9HTVNHMj0k
KG1rdGVtcCAtdCBnaXRjaTIuWFhYWFhYKQotZWNobyBDRzogLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSA+PiRMT0dNU0cKLWVjaG8gQ0c6
IExpbmVzIGJlZ2dpbmluZyB3aXRoIENHOiB3aWxsIGJlIGF1dG9tYXRpY2FsbHkgcmVtb3ZlZCAg
ICAgPj4kTE9HTVNHCi1lY2hvIENHOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgID4+JExPR01TRworaWYgWyAtZSAuZ2l0L2NvbW1pdC5m
b3JtIF07IHRoZW4KKwljYXQgLmdpdC9jb21taXQuZm9ybSA+PiRMT0dNU0cKK2Vsc2UKKwl7CisJ
ZWNobyAiQ0c6IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0iCisJZWNobyAiQ0c6IExpbmVzIGJlZ2dpbmluZyB3aXRoIENHOiB3aWxsIGJl
IGF1dG9tYXRpY2FsbHkgcmVtb3ZlZCIKKwllY2hvICJDRzoiOyB9ID4+JExPR01TRworZmkKIGlm
IFsgISAiJGlnbm9yZWNhY2hlIiBdOyB0aGVuCiAJaWYgWyAhICIke2NvbW1pdGZpbGVzWypdfSIg
XTsgdGhlbgogCQllY2hvICdOb3RoaW5nIHRvIGNvbW1pdC4nID4mMgo=
------=_20050508150736_40098--


