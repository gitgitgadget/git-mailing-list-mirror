From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: bzr to git syncing
Date: Fri, 28 Aug 2009 17:02:22 +0100
Message-ID: <b2cdc9f30908280902m22d594bam3c70259d4c296e52@mail.gmail.com>
References: <F84D4C0F-1CEF-4853-84DB-B7927CBE62B3@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364d2303374fa0047235cf22
To: git@vger.kernel.org, David Reitter <david.reitter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 18:02:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh3uL-0004hN-M1
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 18:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbZH1QCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 12:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbZH1QCX
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 12:02:23 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:50850 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbZH1QCW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 12:02:22 -0400
Received: by ey-out-2122.google.com with SMTP id 25so460923eya.19
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 09:02:23 -0700 (PDT)
Received: by 10.216.13.75 with SMTP id a53mr281592wea.22.1251475342183; Fri, 
	28 Aug 2009 09:02:22 -0700 (PDT)
In-Reply-To: <F84D4C0F-1CEF-4853-84DB-B7927CBE62B3@gmail.com>
X-Google-Sender-Auth: 0dd807454dfd14dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127307>

--0016364d2303374fa0047235cf22
Content-Type: text/plain; charset=ISO-8859-1

2009/6/29 David Reitter <david.reitter@gmail.com>:
> Does anyone have experience syncing a Bzr repository to git?
> I would ideally want two-way syncing, but even the bzr->git route would be a
> start.

I've a sneaking suspicion a breakage has been introduced to either the
git-bzr script or
the bzr fast-import module. I say this as I have successfully pulled
from a bzr repo into
git before but having need to do it today and I get a crash in fast-import.

A few quick questions:

* What versions of git/bzr are you using (me: git 1.6.4, bzr 1.17)?
* Which git-bzr script are you using (me:
http://github.com/mcepl/git-bzr/tree/master)?

I've attached the fast-import crash I'm seeing. Are you seeing the
same sort of failure?


--
Alex, homepage: http://www.bennee.com/~alex/
http://www.half-llama.co.uk

--0016364d2303374fa0047235cf22
Content-Type: application/octet-stream; name=fast_import_crash_21774
Content-Disposition: attachment; filename=fast_import_crash_21774
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyx43krf0

ZmFzdC1pbXBvcnQgY3Jhc2ggcmVwb3J0OgogICAgZmFzdC1pbXBvcnQgcHJvY2VzczogMjE3NzQK
ICAgIHBhcmVudCBwcm9jZXNzICAgICA6IDIxNzczCiAgICBhdCBGcmkgQXVnIDI4IDE2OjU0OjE0
IDIwMDkKCmZhdGFsOiBDb3JydXB0IG1vZGU6IE0gMDQwMDAwIC0gY29udGVudAoKTW9zdCBSZWNl
bnQgQ29tbWFuZHMgQmVmb3JlIENyYXNoCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQogIGNvbW1pdCByZWZzL2hlYWRzL2J6ci91cHN0cmVhbQogIG1hcmsgOjEKICBjb21taXR0ZXIg
QWxleGFuZGVyIFNhY2sgPGFzYWNAandzZG90LmNvbT4gMTE4MTc0Mzk1NCArMDIwMAogIGRhdGEg
MzkKICBNIDY0NCBpbmxpbmUgYnVpbGQuc2gKICBkYXRhIDM5NjMKICBNIDY0NCBpbmxpbmUgY2hy
b21lLm1hbmlmZXN0CiAgZGF0YSAxOTIKICBNIDY0NCBpbmxpbmUgY29uZmlnX2J1aWxkLnNoCiAg
ZGF0YSAxNzAKKiBNIDA0MDAwMCAtIGNvbnRlbnQKCkFjdGl2ZSBCcmFuY2ggTFJVCi0tLS0tLS0t
LS0tLS0tLS0tCiAgICBhY3RpdmVfYnJhbmNoZXMgPSAxIGN1ciwgNSBtYXgKCiAgcG9zICBjbG9j
ayBuYW1lCiAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAg
IDEpICAgICAgMCByZWZzL2hlYWRzL2J6ci91cHN0cmVhbQoKSW5hY3RpdmUgQnJhbmNoZXMKLS0t
LS0tLS0tLS0tLS0tLS0KcmVmcy9oZWFkcy9ienIvdXBzdHJlYW06CiAgc3RhdHVzICAgICAgOiBh
Y3RpdmUgbG9hZGVkIGRpcnR5CiAgdGlwIGNvbW1pdCAgOiAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwCiAgb2xkIHRyZWUgICAgOiAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwCiAgY3VyIHRyZWUgICAgOiAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwCiAgY29tbWl0IGNsb2NrOiAwCiAgbGFzdCBwYWNrICAgOiAKCgpN
YXJrcwotLS0tLQogIGV4cG9ydGVkIHRvIC9leHBvcnQvc3JjL2RlYnMvY2JubGZveC5naXQvLmdp
dC9ienItZ2l0L3Vwc3RyZWFtLWdpdC1tYXAKCi0tLS0tLS0tLS0tLS0tLS0tLS0KRU5EIE9GIENS
QVNIIFJFUE9SVAo=
--0016364d2303374fa0047235cf22--
