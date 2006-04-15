From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: Test fails on ubuntu breezy
Date: Sat, 15 Apr 2006 12:17:03 +0530
Message-ID: <cc723f590604142347p7646aa40r52506a0d85b7d817@mail.gmail.com>
References: <20060413115447.11819.qmail@science.horizon.com>
	 <7vpsjl1ezb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6489_11697459.1145083623857"
Cc: linux@horizon.com, "Peter Eriksen" <s022018@student.dtu.dk>,
	git@vger.kernel.org, "Carl Worth" <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Apr 15 08:47:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUeYw-0002Hx-3J
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 08:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWDOGrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 02:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWDOGrF
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 02:47:05 -0400
Received: from wproxy.gmail.com ([64.233.184.238]:45726 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750880AbWDOGrE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Apr 2006 02:47:04 -0400
Received: by wproxy.gmail.com with SMTP id i6so361110wra
        for <git@vger.kernel.org>; Fri, 14 Apr 2006 23:47:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=ehrULWuLaVO+YMaRIu8fyJwD8FqB4IVghKIHeUwHe9TU1DFVnMEWqJbzyjPw2CeAjl7J7QjvDeQRg0ctQVCTzBlwXTaDw/ILsqQS2v25Anc7rpAG3NIXfJgYdy2xl/rVMy5gr1f6DjfXqUObdP7Q2a6G05FPrRBKsHrLCoTgJS8=
Received: by 10.64.112.8 with SMTP id k8mr582577qbc;
        Fri, 14 Apr 2006 23:47:03 -0700 (PDT)
Received: by 10.64.114.4 with HTTP; Fri, 14 Apr 2006 23:47:03 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vpsjl1ezb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18728>

------=_Part_6489_11697459.1145083623857
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am still having failure with the top of the tree. I guess it is
because git rm exit with status 0.

kvaneesh@home:/tmp/test$ git rm -f a
rm: cannot remove `a': Permission denied
kvaneesh@home:/tmp/test$ echo $?
0
kvaneesh@home:/tmp/test$


I am attaching the logs below

-aneesh

------=_Part_6489_11697459.1145083623857
Content-Type: application/octet-stream; name="test2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test2"
X-Attachment-Id: f_em1l7up4

CisgdG91Y2ggLS0gZm9vIGJhciBiYXogJ3NwYWNlIGVtYmVkZGVkJyAtcQorIGdpdC1hZGQgLS0g
Zm9vIGJhciBiYXogJ3NwYWNlIGVtYmVkZGVkJyAtcQorIGdpdC1jb21taXQgLW0gJ2FkZCBub3Jt
YWwgZmlsZXMnCkNvbW1pdHRpbmcgaW5pdGlhbCB0cmVlIGU1YzU1NmU0NmFhZTYxMjRmZjRhMmE0
NjZjOTUwMDRlOTJkOWEyZTQKKyB0ZXN0X3RhYnM9eQorIHRvdWNoIC0tICd0YWIgZW1iZWRkZWQn
ICduZXdsaW5lCmVtYmVkZGVkJworIGdpdC1hZGQgLS0gJ3RhYiAgICAgICBlbWJlZGRlZCcgJ25l
d2xpbmUKZW1iZWRkZWQnCisgZ2l0LWNvbW1pdCAtbSAnYWRkIGZpbGVzIHdpdGggdGFicyBhbmQg
bmV3bGluZXMnCisgOgorIGNobW9kIGEtdyAuCisgcm0gLWYgdGVzdC1maWxlCnJtOiBjYW5ub3Qg
cmVtb3ZlIGB0ZXN0LWZpbGUnOiBQZXJtaXNzaW9uIGRlbmllZAorIHRlc3QgLWYgdGVzdC1maWxl
CisgdGVzdF9mYWlsZWRfcmVtb3ZlPXkKKyBjaG1vZCA3NzUgLgorIHJtIC1mIHRlc3QtZmlsZQor
IHRlc3QgeSA9IHkKKyBjaG1vZCBhLXcgLgorIHRlc3RfZXhwZWN0X2ZhaWx1cmUgJ1Rlc3QgdGhh
dCAiZ2l0LXJtIC1mIiBmYWlscyBpZiBpdHMgcm0gZmFpbHMnICdnaXQtcm0gLWYgYmF6JworIHRl
c3QgMiA9IDIKKyBzYXkgJ2V4cGVjdGluZyBmYWlsdXJlOiBnaXQtcm0gLWYgYmF6JworIGVjaG8g
JyogZXhwZWN0aW5nIGZhaWx1cmU6IGdpdC1ybSAtZiBiYXonCisgdGVzdF9ydW5fICdnaXQtcm0g
LWYgYmF6JworIGV2YWwgJ2dpdC1ybSAtZiBiYXonCisgZXZhbF9yZXQ9MAorIHJldHVybiAwCisg
J1snIDAgPSAwIC1hIDAgJyE9JyAwICddJworIHRlc3RfZmFpbHVyZV8gJ1Rlc3QgdGhhdCAiZ2l0
LXJtIC1mIiBmYWlscyBpZiBpdHMgcm0gZmFpbHMnICdnaXQtcm0gLWYgYmF6JworKyBleHByIDAg
KyAxCisgdGVzdF9jb3VudD0xCisrIGV4cHIgMCArIDEKKyB0ZXN0X2ZhaWx1cmU9MQorIHNheSAn
RkFJTCAxOiBUZXN0IHRoYXQgImdpdC1ybSAtZiIgZmFpbHMgaWYgaXRzIHJtIGZhaWxzJworIGVj
aG8gJyogRkFJTCAxOiBUZXN0IHRoYXQgImdpdC1ybSAtZiIgZmFpbHMgaWYgaXRzIHJtIGZhaWxz
JwoqIEZBSUwgMTogVGVzdCB0aGF0ICJnaXQtcm0gLWYiIGZhaWxzIGlmIGl0cyBybSBmYWlscwor
IHNoaWZ0CisgZWNobyAnZ2l0LXJtIC1mIGJheicKKyBzZWQgLWUgJ3MvXi8gIC8nCiAgICAgICAg
Z2l0LXJtIC1mIGJhegorIHRlc3QgJycgPSAnJworIGNobW9kIDc3NSAuCisgdGVzdF9kb25lCisg
dHJhcCAtIGV4aXQKKyBjYXNlICIkdGVzdF9mYWlsdXJlIiBpbgorIHNheSAnZmFpbGVkIDEgYW1v
bmcgMSB0ZXN0KHMpJworIGVjaG8gJyogZmFpbGVkIDEgYW1vbmcgMSB0ZXN0KHMpJwoqIGZhaWxl
ZCAxIGFtb25nIDEgdGVzdChzKQorIGV4aXQgMQprdmFuZWVzaEBob21lOn4vZ2l0LXdvcmsvZ2l0
LmJ1aWxkL3QkCg==
------=_Part_6489_11697459.1145083623857--
