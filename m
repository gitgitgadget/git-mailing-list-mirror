Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44105C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 00:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhK3AHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 19:07:34 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:39665 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhK3AHe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 19:07:34 -0500
Received: from [192.168.178.34] ([91.64.142.220]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id 1MWAaw-1n7hRM0XSk-00XbL3
 for <git@vger.kernel.org>; Tue, 30 Nov 2021 01:04:14 +0100
Date:   Tue, 30 Nov 2021 01:04:07 +0100
From:   Anselm =?iso-8859-1?q?Sch=FCler?= <mail@anselmschueler.com>
Subject: patch: change =?UTF-8?B?4oCcRXZlcnl0aGluZyB1cC10by1kYXRl4oCd?= to
 =?UTF-8?B?4oCcQWxyZWFkeSB1cCB0byBkYXRlLuKAnQ==?= (No-op messages for git-push
 and git-pull)
To:     git <git@vger.kernel.org>
Message-Id: <VUYC3R.9YCVE0AMVVIF@anselmschueler.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-6NQroFVdOz9DpBCW+w1e"
X-Provags-ID: V03:K1:ODcqTcFQLeiSAv2raPM08FxHTMsDh2atm36CJrl20uWbFtAbBxP
 1Wq63RWce5G58tgSnTxnQgD8IyBBinktLJ9X7dMAJeaG/Ofc3EIkmZYLA09fE1nrUYwoT38
 1wBtm5xoZchvNhi9QjMyCMKWTYyINge+0sNdXHpbOXkr5Ch5PbFVgM6GHFM+/2aZWewc6pp
 esJbdM00sibjBCpNyihPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0s74Uszljjc=:qHepHq6NzeGDMrxedt4/sd
 WE+0AP1PBsnPSMpENAUG+dj5cOCWYaXezZ6sa/15t0owNbVrrJYAGYgZSxmHXa+Jmmca31eiA
 2xu1xhYLuO9aahVKzEe9piwnEwej3feppor3zv7mb7+mK82QfdFYEPjxDXSIZI7XiDNQO1m1w
 iJOEi7NVT1GfF372wFxNJlNLjP+FqMWM7oJxEBXP1gQDKoKd739zYRtFPvi+ZKorkgKfOZ9j9
 CLYf9pWMO/yNpVFiqBuvLkLGp2HkhwdtkjB1ez38OlWKbS5mD1j5+a0CLQRie3w6K91Z1Ep3f
 mzXTCbRkP1y6vOy4M/l+F6oIX0bU5SEG2D81g8a3acNOIFMynnC9q6fJmDuJkoEI7GdzUehjp
 3O1Wwm4Lxs3XW+djKzGdAZgb3oghmgr64QjzljtF2L1+8Jp+5OGaLseDZ+o7Rfwy1RerJaDHT
 7eaPe9VnJDGBgBVmR1XCmlLxGYLt4Eujh/RuzMmPvpEXWSoI1NvwDgBc2DvTmtQKN7dx1fG4f
 P3AiUdsNVEYayzlYJoApV3fWeHY6nh5Mqxrbfca/bnFtL7fdOAHnsq85ty2pvfZvDDw/PXuR6
 l37Kmd+j6n8KOtT+3Hse8DgHAefLITFlBkwmT85jWEr3tMRVeO6Ie4qLRnfqbbjHMyMWdpH6N
 aepLCuGArE7V3WqmDp0YHzE5ejCg32Jzo6lPqKV35R1HNippyObaK3+GoDr+bDdLOmYb5z/DR
 ozrUUG7wpcL6OiWP
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-6NQroFVdOz9DpBCW+w1e
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: quoted-printable

Why are the no-op messages for git-push and git-pull (i.e. when remote=20
and local are identical) so different, while describing something very=20
similar? IMO the messages should be either identical or very similar.
git-pull results in =93Already up to date.=94, while git-push results=20
in =93Everything up-to-date=94.
Note the difference in the usage of =93Already=94 vs. =93Everything=94,=20
dashes vs. spcaes, and a period vs. no period. While I understand that=20
these aren=92t saying the same thing and therefore some difference is=20
warranted, might I suggest that this difference be limited to the words=20
=93Already=94 and =93Everything=94?

I have attached a patch=97I hope this is a correct way of doing this.

It should be considered that other messages reading =93Already up to=20
date.=94 seem to use a translation system, it might be better to use=20
that system here, too. Unfortunately, I don=92t know how to do that=20
(currently). At any rate, this patch could serve as a temporary=20
=93fix=94.


--=-6NQroFVdOz9DpBCW+w1e
Content-Type: text/x-patch
Content-Disposition: attachment;
	filename=0001-Change-Everything-up-to-date-to-Already-up-to-date-f.patch
Content-Transfer-Encoding: base64

RnJvbSAwMWQyZGYxN2MwMDU1MTIwZjVlMTZmMTA1ZWZmZGVlYjVkMjg4NTY2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/QW5zZWxtPTIwU2NoPUMzPUJDbGVyPz0gPG1h
aWxAYW5zZWxtc2NodWVsZXIuY29tPgpEYXRlOiBNb24sIDI5IE5vdiAyMDIxIDAwOjQyOjM3ICsw
MTAwClN1YmplY3Q6IFtQQVRDSF0gPT9VVEYtOD9xP0NoYW5nZT0yMD1FMj04MD05Q0V2ZXJ5dGhp
bmc9MjB1cC10by1kYXRlPz0KID0/VVRGLTg/cT89RTI9ODA9OUQ9MjB0bz0yMD1FMj04MD05Q0Fs
cmVhZHk9MjB1cD0yMHRvPTIwZGF0ZT1FMj04MD05RD0yMGY/PQogPT9VVEYtOD9xP29yPTIwbW9y
ZT0yMGNvbnNpc3RlbmN5Pz0KTUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3Bs
YWluOyBjaGFyc2V0PVVURi04CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClNpZ25l
ZC1vZmYtYnk6IEFuc2VsbSBTY2jDvGxlciA8bWFpbEBhbnNlbG1zY2h1ZWxlci5jb20+Ci0tLQog
YnVpbHRpbi9zZW5kLXBhY2suYyB8IDIgKy0KIHRyYW5zcG9ydC5jICAgICAgICAgfCAyICstCiAy
IGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9idWlsdGluL3NlbmQtcGFjay5jIGIvYnVpbHRpbi9zZW5kLXBhY2suYwppbmRleCA2OWM0
MzJlZjFhLi5hZDkwZmIwMzcwIDEwMDY0NAotLS0gYS9idWlsdGluL3NlbmQtcGFjay5jCisrKyBi
L2J1aWx0aW4vc2VuZC1wYWNrLmMKQEAgLTMzOCw3ICszMzgsNyBAQCBpbnQgY21kX3NlbmRfcGFj
ayhpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKnByZWZpeCkKIAl9CiAK
IAlpZiAoIXJldCAmJiAhdHJhbnNwb3J0X3JlZnNfcHVzaGVkKHJlbW90ZV9yZWZzKSkKLQkJZnBy
aW50ZihzdGRlcnIsICJFdmVyeXRoaW5nIHVwLXRvLWRhdGVcbiIpOworCQlmcHJpbnRmKHN0ZGVy
ciwgIkFscmVhZHkgdXAgdG8gZGF0ZS5cbiIpOwogCiAJcmV0dXJuIHJldDsKIH0KZGlmZiAtLWdp
dCBhL3RyYW5zcG9ydC5jIGIvdHJhbnNwb3J0LmMKaW5kZXggZTRmMWRlY2FlMi4uMWUyMjQ3OTRj
YyAxMDA2NDQKLS0tIGEvdHJhbnNwb3J0LmMKKysrIGIvdHJhbnNwb3J0LmMKQEAgLTE0MDEsNyAr
MTQwMSw3IEBAIGludCB0cmFuc3BvcnRfcHVzaChzdHJ1Y3QgcmVwb3NpdG9yeSAqciwKIAkJaWYg
KHBvcmNlbGFpbiAmJiAhcHVzaF9yZXQpCiAJCQlwdXRzKCJEb25lIik7CiAJCWVsc2UgaWYgKCFx
dWlldCAmJiAhcmV0ICYmICF0cmFuc3BvcnRfcmVmc19wdXNoZWQocmVtb3RlX3JlZnMpKQotCQkJ
ZnByaW50ZihzdGRlcnIsICJFdmVyeXRoaW5nIHVwLXRvLWRhdGVcbiIpOworCQkJZnByaW50Zihz
dGRlcnIsICJBbHJlYWR5IHVwIHRvIGRhdGUuXG4iKTsKIAogCQlyZXR1cm4gcmV0OwogCX0KLS0g
CjIuMzMuMQoK

--=-6NQroFVdOz9DpBCW+w1e--

