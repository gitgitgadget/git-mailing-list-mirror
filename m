From: Eric Anholt <eric@anholt.net>
Subject: [PATCH] Fix paths on FreeBSD by processing gitk like other scripts
Date: Fri, 07 Apr 2006 14:03:51 -0700
Message-ID: <1144443831.7017.72.camel@leguin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1HlOy4emlp6JYwnjwhJi"
X-From: git-owner@vger.kernel.org Fri Apr 07 23:04:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRy7i-0007po-FY
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 23:04:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWDGVED (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 17:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWDGVED
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 17:04:03 -0400
Received: from 69-30-77-85.dq1sn.easystreet.com ([69.30.77.85]:10751 "EHLO
	leguin.anholt.net") by vger.kernel.org with ESMTP id S964847AbWDGVEB
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 7 Apr 2006 17:04:01 -0400
Received: from leguin.anholt.net (localhost [127.0.0.1])
	by leguin.anholt.net (8.13.4/8.13.1) with ESMTP id k37L3r4g024831
	for <git@vger.kernel.org>; Fri, 7 Apr 2006 14:03:53 -0700 (PDT)
	(envelope-from eric@anholt.net)
Received: (from anholt@localhost)
	by leguin.anholt.net (8.13.4/8.13.1/Submit) id k37L3qR5024830
	for git@vger.kernel.org; Fri, 7 Apr 2006 14:03:53 -0700 (PDT)
	(envelope-from eric@anholt.net)
X-Authentication-Warning: leguin.anholt.net: anholt set sender to eric@anholt.net using -f
To: git@vger.kernel.org
X-Mailer: Evolution 2.4.2.1 FreeBSD GNOME Team Port 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18506>


--=-1HlOy4emlp6JYwnjwhJi
Content-Type: multipart/mixed; boundary="=-R3GQ5WOvgiTLpYIzzaLe"


--=-R3GQ5WOvgiTLpYIzzaLe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The paths for python and tk are not /usr/bin for FreeBSD, so I moved
gitk to gitk.tk and added a rule to sed in the proper path to "wish" in
making gitk, and also added the appropriate default path for python.

--=20
Eric Anholt                     anholt@FreeBSD.org
eric@anholt.net                 eric.anholt@intel.com

--=-R3GQ5WOvgiTLpYIzzaLe
Content-Disposition: attachment; filename=git-freebsd.diff
Content-Type: text/x-patch; name=git-freebsd.diff; charset=us-ascii
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhLy5naXRpZ25vcmUgYi8uZ2l0aWdub3JlDQppbmRleCBiNTk1OWQ2Li5lOWQ1
YTdiIDEwMDY0NA0KLS0tIGEvLmdpdGlnbm9yZQ0KKysrIGIvLmdpdGlnbm9yZQ0KQEAgLTEyMSw2
ICsxMjEsNyBAQCBnaXQtdmVyaWZ5LXRhZw0KIGdpdC13aGF0Y2hhbmdlZA0KIGdpdC13cml0ZS10
cmVlDQogZ2l0LWNvcmUtKi8/Kg0KK2dpdGsNCiB0ZXN0LWRhdGUNCiB0ZXN0LWRlbHRhDQogY29t
bW9uLWNtZHMuaA0KZGlmZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUNCmluZGV4IDMzNjdi
OGMuLmRlMjhkZWMgMTAwNjQ0DQotLS0gYS9NYWtlZmlsZQ0KKysrIGIvTWFrZWZpbGUNCkBAIC0x
MzYsNiArMTM2LDkgQEAgU0NSSVBUX1BFUkwgPSBcDQogU0NSSVBUX1BZVEhPTiA9IFwNCiAJZ2l0
LW1lcmdlLXJlY3Vyc2l2ZS5weQ0KIA0KK1NDUklQVF9USyA9IFwNCisJZ2l0ay50aw0KKw0KIFND
UklQVFMgPSAkKHBhdHN1YnN0ICUuc2gsJSwkKFNDUklQVF9TSCkpIFwNCiAJICAkKHBhdHN1YnN0
ICUucGVybCwlLCQoU0NSSVBUX1BFUkwpKSBcDQogCSAgJChwYXRzdWJzdCAlLnB5LCUsJChTQ1JJ
UFRfUFlUSE9OKSkgXA0KQEAgLTE3NCw2ICsxNzcsMTUgQEAgIyBCYWNrd2FyZCBjb21wYXRpYmls
aXR5IC0tIHRvIGJlIHJlbW92ZQ0KIFBST0dSQU1TICs9IGdpdC1zc2gtcHVsbCRYIGdpdC1zc2gt
cHVzaCRYDQogDQogIyBTZXQgcGF0aHMgdG8gdG9vbHMgZWFybHkgc28gdGhhdCB0aGV5IGNhbiBi
ZSB1c2VkIGZvciB2ZXJzaW9uIHRlc3RzLg0KK2lmZXEgKCQodW5hbWVfUyksRnJlZUJTRCkNCisJ
aWZuZGVmIFBZVEhPTl9QQVRIDQorCQlQWVRIT05fUEFUSCA9IC91c3IvbG9jYWwvYmluL3B5dGhv
bg0KKwllbmRpZg0KKwlpZm5kZWYgV0lTSF9QQVRIDQorCQlXSVNIX1BBVEggPSAvdXNyL2xvY2Fs
L2Jpbi93aXNoOC40DQorCWVuZGlmCQ0KK2VuZGlmDQorDQogaWZuZGVmIFNIRUxMX1BBVEgNCiAJ
U0hFTExfUEFUSCA9IC9iaW4vc2gNCiBlbmRpZg0KQEAgLTE4Myw2ICsxOTUsOSBAQCBlbmRpZg0K
IGlmbmRlZiBQWVRIT05fUEFUSA0KIAlQWVRIT05fUEFUSCA9IC91c3IvYmluL3B5dGhvbg0KIGVu
ZGlmDQoraWZuZGVmIFdJU0hfUEFUSA0KKwlXSVNIX1BBVEggPSB3aXNoDQorZW5kaWYNCiANCiBQ
WU1PRFVMRVMgPSBcDQogCWdpdE1lcmdlQ29tbW9uLnB5DQpAQCAtNDg0LDYgKzQ5OSwxMiBAQCBj
b21tb24tY21kcy5oOiBEb2N1bWVudGF0aW9uL2dpdC0qLnR4dA0KIAkgICAgLWUgJ3N8QEBHSVRf
UFlUSE9OX1BBVEhAQHwkKEdJVF9QWVRIT05fRElSX1NRKXxnJyBcDQogCSAgICAtZSAncy9AQEdJ
VF9WRVJTSU9OQEAvJChHSVRfVkVSU0lPTikvZycgXA0KIAkgICAgJEAucHkgPiRADQorCWNobW9k
ICt4ICRADQorDQorJChwYXRzdWJzdCAlLnRrLCUsJChTQ1JJUFRfVEspKSA6ICUgOiAlLnRrDQor
CXJtIC1mICRADQorCXNlZCAtZSAic3xleGVjIHdpc2h8ZXhlYyAkKFdJU0hfUEFUSCl8IiBcDQor
CSAgICAkQC50ayA+JEANCiAJY2htb2QgK3ggJEANCiANCiBnaXQtY2hlcnJ5LXBpY2s6IGdpdC1y
ZXZlcnQNCmRpZmYgLS1naXQgYS9naXRrIGIvZ2l0ay50aw0Kc2ltaWxhcml0eSBpbmRleCAxMDAl
DQpyZW5hbWUgZnJvbSBnaXRrDQpyZW5hbWUgdG8gZ2l0ay50aw0K


--=-R3GQ5WOvgiTLpYIzzaLe--

--=-1HlOy4emlp6JYwnjwhJi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (FreeBSD)

iD8DBQBENtO3HUdvYGzw6vcRAmpvAJ9RmZRjwDDCf1tHap7L+BEUZyHBWQCfeBbO
yKq30L/D7csWUnuBd3EZaoQ=
=SoU+
-----END PGP SIGNATURE-----

--=-1HlOy4emlp6JYwnjwhJi--
