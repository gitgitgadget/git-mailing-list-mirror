From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH] Add an optional <mode> argument to commit/status -u|--untracked-files
 option
Date: Fri, 06 Jun 2008 08:56:22 +0200
Message-ID: <4848DF96.3010007@trolltech.com>
References: <7viqwvk04y.fsf@gitster.siamese.dyndns.org> <c9062d05cabcbd45657e89b03eac9715a46f8b79.1212498900.git.marius@trolltech.com> <20080606063206.GA4181@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBD1F541664AC69E7FFF0A45E"
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 08:57:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4VtV-0004pA-FJ
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 08:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbYFFG43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 02:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbYFFG43
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 02:56:29 -0400
Received: from hoat.troll.no ([62.70.27.150]:60889 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753182AbYFFG42 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 02:56:28 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id B565120A67;
	Fri,  6 Jun 2008 08:56:22 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id AA0CB2038E;
	Fri,  6 Jun 2008 08:56:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <20080606063206.GA4181@steel.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84032>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBD1F541664AC69E7FFF0A45E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Alex Riesen said the following on 06.06.2008 08:32:
> Marius Storm-Olsen, Tue, Jun 03, 2008 15:09:10 +0200:
>> Determining untracked files can be a very slow operation on large tree=
s.
>> This commit adds a <mode> argument, which allows you to avoid showing =
the
>> untracked files in a repository. Possible options are:
>>     none   - Show no untracked files
>>     normal - Show untracked files and directories
>>     all    - Show all untracked files
>>
>> If the optional argument is not specified, the option defaults to 'all=
'.
>=20
> Looks very familiar:
>=20
>     http://thread.gmane.org/gmane.comp.version-control.git/66183

Similar, but not quite. This patch doesn't care about the index, just=20
providing the option to avoid looking for untracked files.

Improving the index handling was done in the other patch
     Add shortcut in refresh_cache_ent() for marked entries.
(which is already in master, aa9349d4), so the core.ignoreStat option=20
is more effective.

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enigBD1F541664AC69E7FFF0A45E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFISN+WKzzXl/njVP8RAiOIAJ99z9igXiSIDa9BkzhwNF687GwHRQCdE9Tx
sMqoQrAVV+M38vLTUZ97rM8=
=5OG1
-----END PGP SIGNATURE-----

--------------enigBD1F541664AC69E7FFF0A45E--
