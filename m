From: "Matt McCutchen" <hashproduct@gmail.com>
Subject: File archiver using git
Date: Sun, 27 Aug 2006 09:10:34 -0400
Message-ID: <3bbc18d20608270610o102968d2kd340d40843262dc5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_202778_11919204.1156684234223"
X-From: git-owner@vger.kernel.org Sun Aug 27 15:10:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHKPQ-00016F-S7
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 15:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWH0NKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 09:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWH0NKg
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 09:10:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:8033 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932122AbWH0NKf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 09:10:35 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1328125ugc
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 06:10:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=fLoAJWqHxlxbQHVOoCFoaXnul5ME6EtId4V3+fBUhhtzuelFp/BejCAS3z5giZfZNGyykLHZjD+haejwuArk89yj7YBAZY+WrmxD2qRRkJCJ0xidwnv8Z04Tp6YvvQYb0WCWIEvVvV0H3OIHWNmmAxUC8dzmcCWB+5WgyX/7CP4=
Received: by 10.67.100.17 with SMTP id c17mr3096126ugm;
        Sun, 27 Aug 2006 06:10:34 -0700 (PDT)
Received: by 10.67.26.9 with HTTP; Sun, 27 Aug 2006 06:10:34 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26096>

------=_Part_202778_11919204.1156684234223
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear git people,

You might like the two attached scripts that I wrote around git to
pack file trees containing lots of redundancy into very small
packages.  For example, if I have ten slightly different versions of a
piece of software because I didn't use version control, I can use
gitar to compress them together.

Matt

------=_Part_202778_11919204.1156684234223
Content-Type: application/octet-stream; name=gitar
Content-Transfer-Encoding: base64
X-Attachment-Id: f_erdfw0ls
Content-Disposition: attachment; filename="gitar"

IyEvYmluL2Jhc2gKIyB1c2FnZTogZ2l0YXIgZm9vLWRpciA+Zm9vLmdpdGFyCgpzZXQgLWUKdHJh
cCAnZWNobyAiVW5leHBlY3RlZCBlcnJvciEKSSBhbSBsZWF2aW5nIHRoZSAuZ2l0IHN1YmRpcmVj
dG9yeSBhcm91bmQgc28geW91IGNhbiB0cm91Ymxlc2hvb3Q7CmRlbGV0ZSB0aGUgc3ViZGlyZWN0
b3J5IGJlZm9yZSB0cnlpbmcgdG8gZ2l0YXIgYWdhaW4uIiAxPiYyJyBFUlIKY2QgIiQxIgoKaWYg
WyAtZSAnLmdpdCcgXTsgdGhlbgoJZWNobyAnVGhlIHNvdXJjZSBkaXJlY3RvcnkgaXMgYWxyZWFk
eSBhIGdpdCByZXBvc2l0b3J5IScgMT4mMgoJZXhpdCAxCmZpCgppZiAhIGZpbmQgLiAtdHlwZSBk
IC1lbXB0eSB8IGNtcCAvZGV2L251bGwgLSA+L2Rldi9udWxsOyB0aGVuCgllY2hvICdXQVJOSU5H
OiBUaGUgc291cmNlIGRpcmVjdG9yeSBjb250YWlucyBlbXB0eSBkaXJlY3RvcmllcywgYW5kIGdp
dCB3aWxsIGRyb3AgdGhlbS4nIDE+JjIKZmkKCiMgTWFrZSByZXBvc2l0b3J5LgpnaXQtaW5pdC1k
YiA+L2Rldi9udWxsCgojIE1ha2UgYSBkdW1teSBjb21taXQgdG8gaG9sZCBhbGwgdGhlIGZpbGVz
LgpmdW5jdGlvbiBsaXN0LWZpbGVzLXRvLWFkZCB7CglmaW5kIC4gLXdob2xlbmFtZSAnLi8uZ2l0
JyAtcHJ1bmUgLW9yICcoJyAtdHlwZSBmIC1vciAtdHlwZSBsICcpJyAtcHJpbnRmICclUFxuJwp9
Cmxpc3QtZmlsZXMtdG8tYWRkIHwgZ2l0LXVwZGF0ZS1pbmRleCAtLWFkZCAtLXN0ZGluID4vZGV2
L251bGwKdHJlZT0kKGdpdC13cml0ZS10cmVlKQpmdW5jdGlvbiBjbGVhbi1jb21taXQgewoJR0lU
X0FVVEhPUl9OQU1FPSdyZXByb2R1Y2libGUnIEdJVF9BVVRIT1JfRU1BSUw9JycgR0lUX0FVVEhP
Ul9EQVRFPSc5NDY2ODQ4MDEgKzAwMDAnIEdJVF9DT01NSVRURVJfTkFNRT0ncmVwcm9kdWNpYmxl
JyBHSVRfQ09NTUlUVEVSX0VNQUlMPScnIEdJVF9DT01NSVRURVJfREFURT0nOTQ2Njg0ODAxICsw
MDAwJyBnaXQtY29tbWl0LXRyZWUgIiRAIiA8L2Rldi9udWxsCn0KY2xlYW4tY29tbWl0ICR0cmVl
ID4uZ2l0L3JlZnMvaGVhZHMvbWFzdGVyCgojIFBhY2sgdGhpbmdzIHVwIG5pY2VseS4KZ2l0LXJl
cGFjayAtYSA+L2Rldi9udWxsCmZvciBpIGluIHBhY2sgaWR4OyBkbwoJbXYgLmdpdC9vYmplY3Rz
L3BhY2sve3BhY2sqLiRpLHBhY2suJGl9CmRvbmUKZ2l0LXBydW5lID4vZGV2L251bGwKCiMgV3Jp
dGUgb3V0IGdpdCByZXBvc2l0b3J5IGFzIGEgTWF0dC1zdHlsZSBmaWxlIHRyZWUuCmZ1bmN0aW9u
IHdyaXRlX2ZpbGUgewoJZWNobyAtbiAiKyAkeyMyfSAkMiAiCglzdGF0IC0tZm9ybWF0PSQnZiAl
cycgLS0gIiQxLyQyIgoJY2F0IC0tICIkMS8kMiIKCWVjaG8KfQplY2hvICd7JwoJZWNobyAnKyA0
IEhFQUQgZiAyMycKCWVjaG8gJ3JlZjogcmVmcy9oZWFkcy9tYXN0ZXInCgllY2hvCgllY2hvICcr
IDQgcmVmcyB7JwoJCWVjaG8gJysgNSBoZWFkcyB7JwoJCQl3cml0ZV9maWxlIC5naXQvcmVmcy9o
ZWFkcyBtYXN0ZXIKCQllY2hvICd9JwoJZWNobyAnfScKCWVjaG8gJysgNyBvYmplY3RzIHsnCgkJ
ZWNobyAnKyA0IHBhY2sgeycKCQkJd3JpdGVfZmlsZSAuZ2l0L29iamVjdHMvcGFjayBwYWNrLnBh
Y2sKCQkJd3JpdGVfZmlsZSAuZ2l0L29iamVjdHMvcGFjayBwYWNrLmlkeAoJCWVjaG8gJ30nCgll
Y2hvICd9JwplY2hvICd9JwoKcm0gLXJmIC5naXQK
------=_Part_202778_11919204.1156684234223
Content-Type: application/octet-stream; name=ungitar
Content-Transfer-Encoding: base64
X-Attachment-Id: f_erdfw2et
Content-Disposition: attachment; filename="ungitar"

IyEvYmluL2Jhc2gKIyB1c2FnZTogdW5naXRhciBmb28tZGlyIDxmb28uZ2l0YXIKCnNldCAtZQp0
cmFwICJlY2hvICdVbmV4cGVjdGVkIGVycm9yIScgMT4mMiIgRVJSCmlmICEgWyAtZSAiJDEiIF07
IHRoZW4KCW1rZGlyICIkMSIKZmkKY2QgIiQxIgoKaWYgWyAtZSAnLmdpdCcgXTsgdGhlbgoJZWNo
byAnVGhlIGRlc3RpbmF0aW9uIGRpcmVjdG9yeSBpcyBhbHJlYWR5IGEgZ2l0IHJlcG9zaXRvcnkh
JyAxPiYyCglleGl0IDEKZmkKdHJhcCAicm0gLXJmIC5naXQiIEVYSVQKCmZ0eCAuZ2l0CmdpdC1y
ZWFkLXRyZWUgbWFzdGVyCmdpdC1jaGVja291dC1pbmRleCAtLWFsbCAtLWZvcmNlCg==
------=_Part_202778_11919204.1156684234223--
