From: Marius Storm-Olsen <marius@trolltech.com>
Subject: 'git format-patch' on older commits, and mailinglist
Date: Tue, 10 Jun 2008 12:09:34 +0200
Message-ID: <484E52DE.1070100@trolltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA8F405A53A4C176175958F3F"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 12:10:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K60oY-0008G9-NU
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 12:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759983AbYFJKJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 06:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759993AbYFJKJl
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 06:09:41 -0400
Received: from hoat.troll.no ([62.70.27.150]:41509 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759812AbYFJKJk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 06:09:40 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 9781E20A63
	for <git@vger.kernel.org>; Tue, 10 Jun 2008 12:09:33 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 8D3F1203BA
	for <git@vger.kernel.org>; Tue, 10 Jun 2008 12:09:33 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
X-Enigmail-Version: 0.95.6
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84491>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8F405A53A4C176175958F3F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

Recently, I sent out patches which were fixed up with --amend on older=20
commits. When I sent them out, the patches contained
     Date: <more than 2 days old datestamp>
in the headers. Now, sending these mails is fine, and mail clients=20
generally handles it perfectly fine. However, after doing this I got=20
an email from postmaster@vger.kernel.org, basically telling me to not=20
do this, since they get a lot of bounces where the return is marked with
     Diagnostic Code: smtp; 550 (4.5 DATE_IN_PAST_48_96 Date: is 48 to=20
96 hours before Received: date)

This is understandable. The question is, do we fix the tools to handle=20
this, so that emails are always generated with now() date, and the=20
commit content contains a tag for the original commit; or do we simply=20
say, always send patches to the mailing list with a current timestamp?

Maybe my workflow is incorrect too. I don't mind pointers on this.

I guess rebasing before generating the patch series would have fixed=20
this, but I really didn't need to. I simply reset HEAD~2, fixed with=20
--amend, then cherry-picked the other on top again; then created the=20
patch series.

--=20
=2Emarius
- simply wondering what others on the git mailinglist do..


--------------enigA8F405A53A4C176175958F3F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFITlLeKzzXl/njVP8RAnNAAKDU6bBd4K8bxwiMdGjHEAlNc4ov/QCgji3U
D6T5/X+r1b+mJoHLU6cXvpY=
=OTnx
-----END PGP SIGNATURE-----

--------------enigA8F405A53A4C176175958F3F--
