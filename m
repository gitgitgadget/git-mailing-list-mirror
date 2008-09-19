From: AI <ai0867@gmail.com>
Subject: git-am strips final ')' character from author name
Date: Fri, 19 Sep 2008 19:58:14 +0200
Message-ID: <2f54d7a20809191058w558f3a28nc1537dc82f4a6ec2@mail.gmail.com>
References: <2f54d7a20809191057t76c405e7q643912388efe2f01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42303_2744055.1221847094333"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 19 19:59:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgkGQ-0005sY-Mv
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 19:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbYISR6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 13:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbYISR6R
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 13:58:17 -0400
Received: from rn-out-0910.google.com ([64.233.170.186]:53336 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbYISR6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 13:58:16 -0400
Received: by rn-out-0910.google.com with SMTP id k40so191429rnd.17
        for <git@vger.kernel.org>; Fri, 19 Sep 2008 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type:references;
        bh=bqVhK1IsJUIej51YZeFito/eAUNZdWVq+5wdH9bqfd4=;
        b=YLZUMiQVS2DFnm5IMhULwCsuS9cwMKzmsU+rgXk50+UCh1uuhBNyKmtJ7ZiFM8cVAc
         3VQ+n6r4lWBvF9IX+1ukn4U51N4DVMfLTosxqUIvjH7Rs4jbkuwN2dNqsKeRF9JPtXIw
         leprt/IxJJ8PVtGc4/Oy2mmnzOP5vkAuga0N4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:references;
        b=EWnr/Xjx4E1KcT/40+MhA1CEndU37NqyP1r/HTjQWQRKAqepBhYM2FNKsPnQt2Vk69
         o2y7La0x3ZmBvypqDiwUj0JXqrcIUIvOiYvgtmRoAWL13fwYjyGxkmXVrulfRQ0GJO6h
         CmZ8wNPjKlCBtZzhEnkDg/TRzKwiMJ0kTxlgw=
Received: by 10.151.155.12 with SMTP id h12mr3529044ybo.136.1221847094353;
        Fri, 19 Sep 2008 10:58:14 -0700 (PDT)
Received: by 10.150.148.3 with HTTP; Fri, 19 Sep 2008 10:58:14 -0700 (PDT)
In-Reply-To: <2f54d7a20809191057t76c405e7q643912388efe2f01@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96304>

------=_Part_42303_2744055.1221847094333
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---------- Forwarded message ----------
From: AI <ai0867@gmail.com>
Date: Fri, Sep 19, 2008 at 19:57
Subject: git-am strips final ')' character from author name
To: git@vger.kernel.org


Applying attached patch with git-am strips the ')' character from the name.

Running git-cat-file on the commit gives the following result:
author Alexander van Gessel (AI/AI0867 <AI0867@gmail.com> 1221846001 +0200
committer Alexander van Gessel (AI/AI0867) <AI0867@gmail.com> 1221846254 +0200

------=_Part_42303_2744055.1221847094333
Content-Type: text/x-diff;
 name=0002-Check-in-environment-and-Makefile-for-opdracht-4.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_flb3pwgb1
Content-Disposition: attachment;
 filename=0002-Check-in-environment-and-Makefile-for-opdracht-4.patch

RnJvbSA0OWZiZTEzYjM3NzYwMjdlNjIwN2Q0NmQ0NzM1ODZkYTllNGNhMmJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4YW5kZXIgdmFuIEdlc3NlbCAoQUkvQUkwODY3KSA8QUkw
ODY3QGdtYWlsLmNvbT4KRGF0ZTogRnJpLCAxOSBTZXAgMjAwOCAxOTo0MDowMSArMDIwMApTdWJq
ZWN0OiBbUEFUQ0hdIENoZWNrIGluIGVudmlyb25tZW50IGFuZCBNYWtlZmlsZSBmb3Igb3BkcmFj
aHQgNC4KCi0tLQogc3JjL29wZHJhY2h0NC8uZ2l0aWdub3JlICAgICAgICB8ICAgIDMgKysrCiBz
cmMvb3BkcmFjaHQ0L0JhbmtBY2NvdW50LmNsYXNzIHwgIEJpbiAwIC0+IDcyOSBieXRlcwogc3Jj
L29wZHJhY2h0NC9FYXN5U2Nhbm5lci5jbGFzcyB8ICBCaW4gMCAtPiA3NzEgYnl0ZXMKIHNyYy9v
cGRyYWNodDQvTWFrZWZpbGUgICAgICAgICAgfCAgIDIzICsrKysrKysrKysrKysrKysrKysrKysr
CiBzcmMvb3BkcmFjaHQ0L09ibG9uZy5jbGFzcyAgICAgIHwgIEJpbiAwIC0+IDY2MyBieXRlcwog
NSBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IHNyYy9vcGRyYWNodDQvLmdpdGlnbm9yZQogY3JlYXRlIG1vZGUgMTAwNjQ0
IHNyYy9vcGRyYWNodDQvQmFua0FjY291bnQuY2xhc3MKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzcmMv
b3BkcmFjaHQ0L0Vhc3lTY2FubmVyLmNsYXNzCiBjcmVhdGUgbW9kZSAxMDA2NDQgc3JjL29wZHJh
Y2h0NC9NYWtlZmlsZQogY3JlYXRlIG1vZGUgMTAwNjQ0IHNyYy9vcGRyYWNodDQvT2Jsb25nLmNs
YXNzCgpkaWZmIC0tZ2l0IGEvc3JjL29wZHJhY2h0NC8uZ2l0aWdub3JlIGIvc3JjL29wZHJhY2h0
NC8uZ2l0aWdub3JlCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjI5NDMyMjMK
LS0tIC9kZXYvbnVsbAorKysgYi9zcmMvb3BkcmFjaHQ0Ly5naXRpZ25vcmUKQEAgLTAsMCArMSwz
IEBACishQmFua0FjY291bnQuY2xhc3MKKyFFYXN5U2Nhbm5lci5jbGFzcworIU9ibG9uZy5jbGFz
cwpkaWZmIC0tZ2l0IGEvc3JjL29wZHJhY2h0NC9CYW5rQWNjb3VudC5jbGFzcyBiL3NyYy9vcGRy
YWNodDQvQmFua0FjY291bnQuY2xhc3MKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMC4uMTg3ZWJjMmI2MDliZjlhODc5M2Y5
OWRhMDg5ODBmYjFiZWEzNjNiMApHSVQgYmluYXJ5IHBhdGNoCmxpdGVyYWwgNzI5CnpjbVpgJCVU
Ql5UNmd8QGRoNEsmO3BaSWB7S3J0SEU4V1lqREJEJW5eQTQtRW9FQyEyeW1ZUFVSVD0pVGdsPGBi
fgp6aEBoSyRyKzNjZCZndGpaYHYtc248Vns0ZDl6eiZlUlc/LUZHX1lsMFRPY1dJeVc5OHRpfmVv
SD0/TkBVK3d3dX4KemNjajxhdWxZVUtZYUkmMiN+XnZAMnBBMj9ZbnZ4PUNKO0d0Sj1aQExDPV9S
QHZ5KU8/QWF2U29sMDg+LUohan45CnpCXnc9MVFaMl9uOFNOOFRXczBSKTM0IXprWm5VP19RRHda
QlVNejdscXZfbXI/X0htVSNXVXBfZVJUY25XPX1vfQp6bjYrLWRYRktQdnZRMVp7Y1FmK2NRX29L
emZte0x4cTZ4JVFGJWY0OTZFS29+YT1MN145aCl8XnRzfkVMQmd8Y2cKenJVWkQ+bHQkMWcheWJY
NGV2Jm9DdU9sTExfS2Z1Z1ZVLThhdGxhXjBEPlhwcWc+JllfeD1kQSY2Q3grWk5lWEUhCnpWeEc2
QHBlbShKZWhLIWxeJFB1JmhhcHdqREZPYzVLY1UoKkcpdzNyR09SO1lFZjckdXB7RlU7OUl1dUZa
M1FpRwpsTiVmU3RyTFlEMio5JVBNMFBIWnowIWJfWGt5P0x7JHxVV1F2YFBVRFl1YFZQY3xgeUsK
CmxpdGVyYWwgMApIY21WP2QwMDAwMQoKZGlmZiAtLWdpdCBhL3NyYy9vcGRyYWNodDQvRWFzeVNj
YW5uZXIuY2xhc3MgYi9zcmMvb3BkcmFjaHQ0L0Vhc3lTY2FubmVyLmNsYXNzCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAu
LjIzZDgyMGU4NTgwN2ZhM2Q5ZGJkOGVhZmI4MzZiYzlhYzU5MjlhODMKR0lUIGJpbmFyeSBwYXRj
aApsaXRlcmFsIDc3MQp6Y21adlpUfjhCSDVRZzg9RSMwPVA8I1Fgdk1lcVoqTU9wUjI4d20rMThY
NmtCQ143TUpUVGdJRmR1bzxsQm1jPzcKemp8KWdOQGR4OyRqUEduNEQzI3IwX1V6MCZHeE5eKl5Z
YGEoME1HRVdoKUZFalNUMH0lbF9EfSY2PzBGX253V0psCnpfbHRPZGhjK0pCKmlndnJnZUh1NDYp
ZG0lUnZ9eU96dDsqPSZDdXdocX1TSGJhblNENFY7bFdCWmtSWXRZJHoxdgp6ZjRgcmtMOStXcFMx
WFB9YkR9V3NSaHleNXJALSQ5PUVOVShVbj1BVXRBN1podmAoRSt0RGkoMntXX0U7KTMxV0YKel5I
d0o/TW5+STFKOCpERVZKNUFWIzlgTVRNcn58NUBLQlk2bnVCU35JR0R3cGdEdG9ZOT5jWnEjS0FV
dmd+XmVrCnpZO2lyKm9BIztoUHwlMzBiJCVBPm88YiV4M2hxRWEqIUxVZVYtaXo/NHRtdEU7TjJS
S15gLUo7Y2lmflh5OyojPwp6bnB9dGFfWlo4MWpjT2gxa1pZND8wIXNBS21pU2xVU0JiWkYzSDYt
XlVKR3E1YnlfSGhYcjNrWUlWQGYqRiM4TGMKemNSeWZWQjcwYzd6e0prLW1uKktzOUtkRilKam51
ST9yVmdYPW9wX24qISgpaW0maXwlbWtSVDZOQkNSJStzJjxTCnBXNHVlZ08hX1lRR1ZOZ2c3c0w2
Pkh8Tmg9N2J5SSVWVENtKz83bThSZiVQKzN7MEJpfWd7YzRsCgpsaXRlcmFsIDAKSGNtVj9kMDAw
MDEKCmRpZmYgLS1naXQgYS9zcmMvb3BkcmFjaHQ0L01ha2VmaWxlIGIvc3JjL29wZHJhY2h0NC9N
YWtlZmlsZQpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi4yNmVhYmY0Ci0tLSAv
ZGV2L251bGwKKysrIGIvc3JjL29wZHJhY2h0NC9NYWtlZmlsZQpAQCAtMCwwICsxLDIzIEBACisj
ICBQcmFjdGljdW0gSU4xMjA1UCwgICAgICBPcGRyYWNodCAyCisjICBBdXRldXIgQS4gdmFuIEdl
c3NlbCwgICBTdHVkaWVudW1tZXIgMTI4Nzk3NAorIyAgRGF0dW0gMjAwOC0wOS0xOQorSkMgPSBq
YXZhYworSlIgPSBqYXZhCitSTSA9IHJtIC1mCisuU1VGRklYRVM6IC5qYXZhIC5jbGFzcworLmph
dmEuY2xhc3M6CisgICAkKEpDKSAkKi5qYXZhCisKK0NMQVNTRVMgPSBcCisKKworYWxsOiBjbGFz
c2VzCisKK2NsYXNzZXM6ICQoQ0xBU1NFUzouamF2YT0uY2xhc3MpCisKKyNPcGRyYWNodDRfMTog
T3BkcmFjaHQ0XzEuY2xhc3MKKyMgICQoSlIpIE9wZHJhY2h0NF8xCisKK2NsZWFuOgorICAgQGVj
aG8gIlJlbW92aW5nIGNsYXNzZmlsZXMgZXhjbHVkaW5nIEJhbmtBY2NvdW50LCBPYmxvbmcgYW5k
IEVhc3lTY2FubmVyLi4uIgorICAgQGZpbmQgLiAtaW5hbWUgJyouY2xhc3MnfGdyZXAgLUV2ICco
QmFua0FjY291bnR8T2Jsb25nfEVhc3lTY2FubmVyKVwuY2xhc3MnfHhhcmdzICQoUk0pCmRpZmYg
LS1naXQgYS9zcmMvb3BkcmFjaHQ0L09ibG9uZy5jbGFzcyBiL3NyYy9vcGRyYWNodDQvT2Jsb25n
LmNsYXNzCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAuLjNmMGUzZDhiOTEyZTQwZjlhZDkwYzI1MjlkMDU2NjY2MWVmNDYz
MDMKR0lUIGJpbmFyeSBwYXRjaApsaXRlcmFsIDY2Mwp6Y21adlktQWNuaTVRV2IrWD0tQkhZT1Iw
dS07M0g3UVBmKXojVWZyNUQ9Nk5sYVk+X1QzTmlKeUx7SjFUZDtsTHgKekpSNTUmWUw/OUklelFJ
KmNIY2k8LXZJMWojWD03QUNKYT1SU3VoUzZSJG1UX0lWPWVuZmVnTDREPEdQNXkzK1QkCnpGJVNF
Rz0qSV5GKjs9eiV6WUBAb2BgMSNTKnohWXBIdDJPXmJtPz5nTW9kcX10emlxVFIlYTZ4SVVWKmY/
P3pkQAp6bVVMMn4/e3dhRTAoVEhOdXs/XlRCVCEySGF+YihQOE91bih5NjZ1Z1NEeUg0KzwzYmFe
aDBtISM8X1FGakFQbHgKejcpJT0kT3NmNyQzUVZaPGNIbzVHY0RyKlVVRVlZPXVDVEBAJG5vK1NF
fHcpSFJ3bUVFLW1vRSVyPyY/VVM/PE5nCnozcSloJThKUn0/OFFMUjUwdE1PPGJYdUQ+JistQ1Nr
KG5ZVWg3RmNESyM8NWJveylKKyVad3lncmsoczMpcWJORAp6cTlzaHhEcH44NHJFeGJCTmgzOERy
dmE7IXloZ0o4S21TQWg3aGZnNkw0Rz13dmQ7U2Apc3xBdFUlVU9TWE9zRHYKWWwmfHRSNjw7VnJ8
MU5SPSlhO1UoQzYmUzRDdkw3O0l7Kkx4CgpsaXRlcmFsIDAKSGNtVj9kMDAwMDEKCi0tIAoxLjUu
NC4zCgo=
------=_Part_42303_2744055.1221847094333--
