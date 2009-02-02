From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH v2 2/4] Add find_insert_index, insert_at_index and clear_func
 functions to string_list
Date: Mon, 02 Feb 2009 08:49:59 +0100
Message-ID: <4986A5A7.2000900@trolltech.com>
References: <cover.1233520945.git.marius@trolltech.com> <ce94ea88e3182e97997c23f71e184e0db64fa708.1233520945.git.marius@trolltech.com> <75a7d437c1b32600c509bdef5010e6ac30b6cb08.1233520945.git.marius@trolltech.com> <7viqnto7zo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC4076A27F27D4718CA389207"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 08:51:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTtac-0005ba-7M
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 08:51:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbZBBHuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 02:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbZBBHuF
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 02:50:05 -0500
Received: from hoat.troll.no ([62.70.27.150]:48141 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbZBBHuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 02:50:03 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 2EE3B20ED3;
	Mon,  2 Feb 2009 08:50:01 +0100 (CET)
Received: from [172.24.90.95] (unknown [172.24.90.95])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id C472620A87;
	Mon,  2 Feb 2009 08:49:59 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <7viqnto7zo.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.7
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108063>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC4076A27F27D4718CA389207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Junio C Hamano said the following on 02.02.2009 04:03:
> Marius Storm-Olsen <marius@trolltech.com> writes:
>=20
>> string_list_find_insert_index() and string_list_insert_at_index()
>> enables you to see if an item is in the string_list, and to
>> insert at the appropriate index in the list, if not there. This
>> is usefull if you need to manipulate an existing item, if
>> present, and insert a new item if not.
>>=20
>> Future mailmap code will use this construct to enable complex
>> (old_name, old_email) -> (new_name, new_email) lookups.
>>=20
>> The string_list_clear_func() allows to call a custom cleanup
>> function on each item in a string_list, which is useful is the
>> util member points to a complex structure.
>=20
> What's with these overlong lines?  You do not have them in your
> other patches.

Sorry, that was my editor which wrapped them visibly at column 70, and=20
I forgot to insert manual line-breaks before saving.
I'll correct it for the next version.

--=20
=2Emarius [@trolltech.com]
'if you know what you're doing, it's not research'


--------------enigC4076A27F27D4718CA389207
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFJhqWnKzzXl/njVP8RAjz6AJ94hh+eMn/RnUX4h27uN/B+XsEWegCeP0ij
lHPSt69KKvI7hfe6lCyBhs4=
=A90i
-----END PGP SIGNATURE-----

--------------enigC4076A27F27D4718CA389207--
