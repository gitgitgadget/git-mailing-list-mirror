From: Fairuzan Roslan <fairuzan.roslan@gmail.com>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Tue, 17 Feb 2015 13:54:24 +0800
Message-ID: <4051C354-C16E-49D3-8824-38882F68F61E@gmail.com>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com> <vpqtwyl90mx.fsf@anie.imag.fr> <340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com> <vpqiof14qu8.fsf@anie.imag.fr> <13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com> <54E2D2F3.5080800@web.de>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: multipart/signed; boundary="Apple-Mail=_11DC8BC6-B97B-4AA9-BD9E-494943F5E66F"; protocol="application/pgp-signature"; micalg=pgp-sha1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, gitster@pobox.com,
	git@vger.kernel.org
To: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 06:54:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNb7B-0005gv-Ht
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 06:54:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbbBQFy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 00:54:28 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:45427 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267AbbBQFy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 00:54:27 -0500
Received: by pablf10 with SMTP id lf10so3808910pab.12
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 21:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :message-id:references:to;
        bh=D/s/d0+IB7+K3voh5LhVBfUG+hsYAiQ1nsQbIF5mWQg=;
        b=WNQ3BddX2VmD2JmSX+sWKtuYMaVwSWuPuw6Vl3ZU4I5dDKt+S/sfU4srx/clQQQgmH
         Kr3n4L1ER+BF1c5k/zsOKeAy1zdSq/ohHsG7mDS/nynv1nmDxbATtEsxMnp9imKcr+fb
         afeeGy0bgUKK85768sc2oii0sXyE4wsgXwcxVxxlAQe+FyeSKrOkdUmqd1CCtPVrqT7C
         QlllCETwfhHeQAZAqP0Idiu8tTiXTPLp5joz4fNMykOYNBH3IhSAIDohOmCZlfC41b1w
         LdsviRCZ2BAgmyRxjLSrU7nMuMwheV8EPgAKo/ZdgX5RIFADiRUFVmaAJcl/DbRowSEq
         NHoQ==
X-Received: by 10.66.140.39 with SMTP id rd7mr45470789pab.25.1424152466879;
        Mon, 16 Feb 2015 21:54:26 -0800 (PST)
Received: from ?IPv6:2001:e68:5422:4c50:9d82:230d:f357:e77e? ([2001:e68:5422:4c50:9d82:230d:f357:e77e])
        by mx.google.com with ESMTPSA id ph7sm16416949pbb.6.2015.02.16.21.54.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Feb 2015 21:54:25 -0800 (PST)
X-Pgp-Agent: GPGMail 2.5b5
In-Reply-To: <54E2D2F3.5080800@web.de>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263934>


--Apple-Mail=_11DC8BC6-B97B-4AA9-BD9E-494943F5E66F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 17, 2015, at 1:34 PM, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On 02/17/2015 04:22 AM, Fairuzan Roslan wrote:
>>> On Feb 17, 2015, at 3:08 AM, Matthieu Moy =
<Matthieu.Moy@grenoble-inp.fr> wrote:
>>>=20
>>> [ Please, don't top post on this list ]
>>>=20
>>> Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:
>>>=20
>>>> I don=E2=80=99t see the issue for the owner of his/her own file to =
have write
>>>> access.
>>> Object and pack files are not meant to be modified. Hence, they are
>>> read-only so that an (accidental) attempt to modify them fails.
>>>=20
>>>> Setting tmp idx & pack files to read-only even for the file owner =
is
>>>> not a safety feature.
>>> Yes it is. If you do not think so, then please give some arguments.
>>>=20
>>>> You should at least give the user the option to set the permission =
in
>>>> the config file and not hardcoded the permission in the binary.
>>> This is the kind of thing I meant by "investigate alternate =
solutions".
>>> I have no AFP share to test, so it would help if you answered the
>>> question I asked in my previous message:
>>>=20
>>>>> On Feb 17, 2015, at 2:23 AM, Matthieu Moy =
<Matthieu.Moy@grenoble-inp.fr> wrote:
>>>>>=20
>>>>> Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:
>>>>>=20
>>>>>> Hi,
>>>>>>=20
>>>>>> Somehow the =E2=80=9Cint mode =3D 0444;=E2=80=9D in odb_mkstemp =
(environment.c) are
>>>>>> causing a lot of issues (unable to unlink/write/rename) to those
>>>>>> people who use AFP shares.
>>>>> Is it a problem when using Git (like "git gc" failing to remove =
old
>>>>> packs), or when trying to remove files outside Git?
>>> (BTW, why did you try to write/rename pack files?)
>>>=20
>>> --
>>> Matthieu Moy
>>> http://www-verimag.imag.fr/~moy/
>> I think its easier if I just show you=E2=80=A6
>>=20
>> OS : OS X 10.10.0 - 10.10.2
>> Client :  git version 1.9.3 (Apple Git-50) and git version 2.2.1
>> AFP share : //user@hostname._afpovertcp._tcp.local/installer on =
/Volumes/installer (afpfs, nodev, nosuid, mounted by user)
>>=20
>> 1. git clone example
>>=20
>> $ git clone https://github.com/robbyrussell/oh-my-zsh.git
>> Cloning into 'oh-my-zsh'...
>> remote: Counting objects: 11830, done.
>> remote: Total 11830 (delta 0), reused 0 (delta 0)
>> Receiving objects: 100% (11830/11830), 2.12 MiB | 481.00 KiB/s, done.
>> Resolving deltas: 100% (6510/6510), done.
>> warning: unable to unlink =
/Volumes/installer/oh-my-zsh/.git/objects/pack/tmp_pack_zjPxuc: =
Operation not permitted
>> error: unable to write sha1 filename =
/Volumes/installer/oh-my-zsh/.git/objects/pack/pack-cceafdc9ef02bc58844138=
ba543ec6cc38252bb1.pack: Operation not permitted
>> fatal: cannot store pack file
>> fatal: index-pack failed
>>=20
>> $ ls -l oh-my-zsh/.git/objects/pack
>> total 5008
>> -rw-------  1 user  staff       32 Feb 17 09:59 =
pack-cceafdc9ef02bc58844138ba543ec6cc38252bb1.keep
>> -r--r--r--  1 user  staff   332312 Feb 17 09:59 tmp_idx_oUN1sb
>> -r--r--r--  1 user  staff  2223007 Feb 17 09:59 tmp_pack_zjPxuc
>>=20
>> $ rm -rf oh-my-zsh/.git/objects/pack/tmp_*
>> rm: oh-my-zsh/.git/objects/pack/tmp_idx_oUN1sb: Operation not =
permitted
>> rm: oh-my-zsh/.git/objects/pack/tmp_pack_zjPxuc: Operation not =
permitted
>>=20
>> Detail Errors:
>> 1. delete_ref_loose (refs.c) -> unlink_or_msg (wrapper.c) -> "unable =
to unlink %s: %s"
>> 2. move_temp_to_file (sha1_file.c ) -> =E2=80=9Cunable to write sha1 =
filename %s: %s=E2=80=9D
>>=20
>> 2. git pull example
>>=20
>> Textual git:master $ git pull
>> remote: Counting objects: 435, done.
>> remote: Compressing objects: 100% (398/398), done.
>> remote: Total 435 (delta 219), reused 18 (delta 12)
>> Receiving objects: 100% (435/435), 1.22 MiB | 756.00 KiB/s, done.
>> Resolving deltas: 100% (219/219), done.
>> warning: unable to unlink .git/objects/pack/tmp_pack_vDaIZa: =
Operation not permitted
>> error: unable to write sha1 filename =
.git/objects/pack/pack-977a2dc0f4be3996dc1186e565a30d55d14b5e87.pack: =
Operation not permitted
> I'm somewhat unsure how this is connected to 0444 ?
>=20
> It seems as if you don't have write permissions for some reasons.
> (on the higher directory), what does
> ls -ld  .git/objects/pack/
> ls -ld  .git/objects/
> give ?
>=20
> can you run
> rm =
.git/objects/pack/pack-977a2dc0f4be3996dc1186e565a30d55d14b5e87.pack
>=20
> on the command line ?

No. I have write permission on all of the folders.
drwxr-xr-x  1 user  staff       264 Feb 17 11:05 .
drwxr-xr-x  1 user  staff       264 Jan 30 12:52 ..

It has nothing to do with my folder permissions. Like I said earlier =
this only happened to people who use AFP shares.

When odb_mkstemp being called and sets the tmp idx & pack files to 0444 =
and later functions like unlink_or_msg or finish_tmp_packfile tries to =
unlink or rename those files, it will fail

It would be much faster and easier if you can try it on a AFP shares or =
I can talk you through it over irc @freenode #git (riaf^)

Regards,
Fairuzan


--Apple-Mail=_11DC8BC6-B97B-4AA9-BD9E-494943F5E66F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJU4teQAAoJEKrU1IvC77KVW9gH/1b8AHSi/3hgeKSx8R/YDE2P
qkjn+4/SeznsZUrYOJ6YXsk3YlAc9kBoilq1UkTW/gYHvk3nm6tCa9VaPD1F+06E
gsuu7j5xIIX9l0lhi/8mc4CFA1ZSJkT39uQR+Ntu273ZMAQU6pJ3jjS0Xzdn1Ho8
PbydmhHf/VkPbjwcrcWozKok6Nq5Kn/kEXwACk3xFeVUDLQ+lBl8S4lcGEKTygdo
thIi6bdV0JRWp7L/xU4e03Ec9ZRRXr0CTlHV401wOxBiN7nzrxQdtIyxcSdh0XBM
HD8LwohYSdJnvHLgeZbl+xCe9ATeUG0LqaHxPFEUcvVtLpNgVg/KAsJOcRCqYNc=
=1M1X
-----END PGP SIGNATURE-----

--Apple-Mail=_11DC8BC6-B97B-4AA9-BD9E-494943F5E66F--
