From: "Besen, David" <david.besen@hp.com>
Subject: Amending merge commits?
Date: Fri, 25 Jul 2014 22:03:14 +0000
Message-ID: <22F01493C523F940B4B5E53BB6D0F5352275F207@G5W2738.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_22F01493C523F940B4B5E53BB6D0F5352275F207G5W2738americas_"
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 00:04:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAnbb-0002lu-DG
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 00:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbaGYWEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 18:04:43 -0400
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:52131 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbaGYWEm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 18:04:42 -0400
Received: from g5t1625.atlanta.hp.com (g5t1625.atlanta.hp.com [15.192.137.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id F390961D86
	for <git@vger.kernel.org>; Fri, 25 Jul 2014 22:04:41 +0000 (UTC)
Received: from G6W4001.americas.hpqcorp.net (g6w4001.atlanta.hp.com [16.205.80.210])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g5t1625.atlanta.hp.com (Postfix) with ESMTPS id CFA2C1FD
	for <git@vger.kernel.org>; Fri, 25 Jul 2014 22:04:31 +0000 (UTC)
Received: from G5W5501.americas.hpqcorp.net (16.201.144.181) by
 G6W4001.americas.hpqcorp.net (16.205.80.210) with Microsoft SMTP Server (TLS)
 id 14.3.169.1; Fri, 25 Jul 2014 22:03:15 +0000
Received: from G5W2738.americas.hpqcorp.net ([169.254.9.123]) by
 G5W5501.americas.hpqcorp.net ([16.201.144.181]) with mapi id 14.03.0169.001;
 Fri, 25 Jul 2014 22:03:15 +0000
Thread-Topic: Amending merge commits?
Thread-Index: Ac+oVDmfmjED5uGKRamOjUJHcWVPKw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [16.201.12.26]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254268>

--_002_22F01493C523F940B4B5E53BB6D0F5352275F207G5W2738americas_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Hi folks,

I think one of my coworkers has stumbled on a git bug -- if you amend a mer=
ge commit, and then pull, your amends are lost.

Is this expected behavior?

I've reproduced the problem in a script (attached).=A0 I ran it against a c=
ouple of versions of git (1.7.1, 1.7.9, 1.8.4, 2.0.0) and in each case it s=
eemed to lose the amend.

- Dave


--_002_22F01493C523F940B4B5E53BB6D0F5352275F207G5W2738americas_
Content-Type: application/octet-stream; name="amend-merge.sh"
Content-Description: amend-merge.sh
Content-Disposition: attachment; filename="amend-merge.sh"; size=1061;
	creation-date="Fri, 25 Jul 2014 22:02:20 GMT";
	modification-date="Fri, 25 Jul 2014 21:41:23 GMT"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnNldCAtZXgKCmlmIFsgLXogIiRHSVQiIF07IHRoZW4gR0lUPWdpdDsgZmkK
R0lUX01FUkdFX0FVVE9FRElUPW5vCgojIENsZWFuIHVwIGZyb20gdGhlIGxhc3QgcnVuCnJtIC1y
ZiByZXBvLmdpdCByZXBvIHJlcG8yIHx8IDoKCiMgU2V0IHVwIGEgYmFyZSAicmVtb3RlIiByZXBv
CiRHSVQgaW5pdCAtLWJhcmUgcmVwby5naXQKCiMgQ2hlY2sgb3V0IHRoZSAicmVtb3RlIiByZXBv
CiRHSVQgY2xvbmUgcmVwby5naXQgcmVwbwoKIyBBZGQgYSBjb21taXQKY2QgcmVwbwplY2hvICJm
aWxlIiA+IGZpbGUudHh0CiRHSVQgYWRkIGZpbGUudHh0CiRHSVQgY29tbWl0IC1tICJBZGQgZmls
ZS50eHQiCiRHSVQgcHVzaCBvcmlnaW4gbWFzdGVyCgojIE1ha2UgYSBicmFuY2gKJEdJVCBjaGVj
a291dCAtYiBteWJyYW5jaAoKIyBBZGQgYSBjb21taXQgb24gdGhlIGJyYW5jaAplY2hvICJteWJy
YW5jaCIgPj4gZmlsZS50eHQKJEdJVCBhZGQgLgokR0lUIGNvbW1pdCAtbSAiQWRkICdteWJyYW5j
aCcgbGluZSIKCiMgR28gYmFjayB0byBtYXN0ZXIKJEdJVCBjaGVja291dCBtYXN0ZXIKCiMgTWVy
Z2UgaW4gbXlicmFuY2ggdG8gY3JlYXRlIGEgbWVyZ2UgY29tbWl0CiRHSVQgbWVyZ2UgLS1uby1m
ZiBteWJyYW5jaAoKIyBQdXNoIHRoYXQgYmFjawokR0lUIHB1c2gKCiMgQW1lbmQgdGhlIG1lcmdl
IGNvbW1pdAplY2hvICJhbWVuZGVkIiA+PiBmaWxlLnR4dAokR0lUIGFkZCAuCiRHSVQgY29tbWl0
IC1DIEhFQUQgLS1hbWVuZAoKY2QgLi4KCiMgTWFrZSBhIHNlY29uZCBjaGVja291dAokR0lUIGNs
b25lIHJlcG8uZ2l0IHJlcG8yCmNkIHJlcG8yCgojIEFkZCBzb21lIHVucmVsYXRlZCBjaGFuZ2Vz
IHRvIGJlIHB1bGxlZAplY2hvICJyZXBvMiIgPiBmaWxlMi50eHQKJEdJVCBhZGQgLgokR0lUIGNv
bW1pdCAtbSAiQWRkIGZpbGUyIgokR0lUIHB1c2gKCmNkIC4uCmNkIHJlcG8KCiMgUHVsbAokR0lU
IHB1bGwgLS1yZWJhc2UKCiMgTm93LCB3ZSBleHBlY3QgdGhlIHRleHQgImFtZW5kZWQiIHRvIGJl
IGluIGZpbGUudHh0CmdyZXAgYW1lbmRlZCBmaWxlLnR4dAo=

--_002_22F01493C523F940B4B5E53BB6D0F5352275F207G5W2738americas_--
