From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Error when verifying tags signed using 1.7.3.1
Date: Tue, 05 Oct 2010 17:39:44 +0200
Message-ID: <4CAB46C0.9000807@drmicha.warpmail.net>
References: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>	<201010041851.46838.ComputerDruid@gmail.com>	<AANLkTin1Ysn7Fp32Eoyjo3jjhHwVrc=hMuq+okgKNfmr@mail.gmail.com>	<201010041959.48336.ComputerDruid@gmail.com>	<AANLkTinA9K6BQ_gmNE8H02nGTSduhZWjujj6NiGDRALy@mail.gmail.com>	<4CAADB19.30707@drmicha.warpmail.net>	<AANLkTikVYSwGjJUgA8KUdNrkHL3+1mSjv8efLwO5+C9E@mail.gmail.com>	<4CAB3F1F.4030108@drmicha.warpmail.net> <AANLkTinqZddKc5ikVBnm+rqFFWtSy7DuByuPK58B4UEt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Stephan Hugel <urschrei@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 17:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P39cB-0004iT-Tc
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 17:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754600Ab0JEPje convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 11:39:34 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:59685 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754457Ab0JEPje (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 11:39:34 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 865841C51;
	Tue,  5 Oct 2010 11:39:33 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 05 Oct 2010 11:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=Wa4SM0xsu7T8VOn6uz1ryKW0B44=; b=hYi1RKvLWSKvocuNAtgNT+Z0SK6us7zN/qcb8D/6r+QIs0wbuVeYsF9o2c02uWhbj3sC7U/u8bkD5/xA1nwA59a15dow2F7/pRtILttU1LdJka1qr0bUj+MV6IvCTWwijEOrkabSjcfZRGsTUnFlDzIqJ8TVtCkp9Ebd87CKD7g=
X-Sasl-enc: o5wvqFgcVIRe2BSfmgxVGZze1Mgp6LNduO2jRxolH/Pd 1286293173
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B8044409D40;
	Tue,  5 Oct 2010 11:39:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTinqZddKc5ikVBnm+rqFFWtSy7DuByuPK58B4UEt@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158205>

Stephan Hugel venit, vidit, dixit 05.10.2010 17:19:
> On 5 October 2010 16:07, Michael J Gruber <git@drmicha.warpmail.net> =
wrote:
>> Stephan Hugel venit, vidit, dixit 05.10.2010 15:28:
>>> On 5 October 2010 09:00, Michael J Gruber <git@drmicha.warpmail.net=
> wrote:
>>>> Stephan Hugel venit, vidit, dixit 05.10.2010 02:17:
>>>>> On 5 October 2010 00:59, Daniel Johnson <computerdruid@gmail.com>=
 wrote:
>>>>>> On Monday 04 October 2010 19:04:51 Stephan Hugel wrote:
>>>>>>> Daniel,
>>>>>>> Those are the exact steps I'm using.
>>>>>>>
>>>>>>> When I run tag -v on existing tags, I don't see the
>>>>>>>
>>>>>>> -----BEGIN PGP MESSAGE-----
>>>>>>> Version: GnuPG v1.4.9 (Darwin)
>>>>>>>
>>>>>>> iD8DBQBMqlpo8Y2TgZsQ1pARAmBQAJ9NV0IX7jlzeB8ogddlutFKAjyWJwCfSI5=
A
>>>>>>> yZeXw/EddYrfdad/VvOrL1o=3D
>>>>>>> =3D/0PJ
>>>>>>> -----END PGP MESSAGE=E2=80=94=E2=80=94
>>>>>>>
>>>>>>> block. It's only present on tags created using the current vers=
ion.
>>>>>>> I've also just upgraded to GnuPG 1.4.10, but the result is the =
same.
>>>>>>> I'm not sure how else I can determine where the problem arises;=
 I'm
>>>>>>> using the git and GnuPG versions for OS X built by homebrew, an=
d GnuPG
>>>>>>> is happy to use the same key for en/decryption and signing. I'v=
e also
>>>>>>> verified that none of the subkeys are expired, and that the tru=
st db
>>>>>>> is OK.
>>>>>>
>>>>>> If you have the tests available, can you try running t7004 to se=
e if it fails
>>>>>> there too?
>>>>>>
>>>>> I rebuilt and installed from source
>>>>> Passed all 105 tests in t7004-tag.sh
>>>>> Problem remains with tags I create
>>>>>
>>>>> This would seem to imply a problem with my key, even though nothi=
ng
>>>>> else is complaining about it.
>>>>
>>>> Here's a very basic way to check: If foo is your tag, do
>>>>
>>>> git cat-file tag foo > a
>>>> git cat-file tag foo > a.sig
>>>>
>>>> From the file "a", delete the signature (everything lines between =
and
>>>> including "-----BEGIN/END PGP SIGNATURE-----"), invoking an editor=
 or
>>>> your favorite sed/awk/perl magic.
>>>>
>>>> a is the data on which git invoked gpg for signing the tag. (I'm n=
ot
>>>> sure why gpg can't notice the inline sig directly but that doesn't
>>>> matter; maybe because it is none ;))
>>>>
>>>> Now, gpg --verify a.sig should check the signature a.sig for a. Do=
ing
>>>> that, maybe with --verbose, you may find out whether the tag objec=
t is
>>>> bogus or git misunderstands gpg's response. If your key is on a ke=
y
>>>> server you can also share the file a.sig with us so that we can ch=
eck.
>>>>
>>>> Michael
>>>>
>>> Michael,
>>> When I do this, gpg is able to verify the signature. So does this m=
ean
>>> that gnupg is failing to ignore the PGP block (possibly because it
>>> expects "SIGNATURE", not "MESSAGE"?)
>>
>> Do you have "MESSAGE" in there???
>>
>> Can you share the output of "git verify-tag --verbose yourtag" with =
us?
>> In any case, this command should give the same as the edited "a" abo=
ve
>> on stdout, and gpg's repsonse on stderr. It should not contain any
>> "----BEGIN/END...".
>>
>> You haven't tinkered with your gpg options lately, have you? ;)
>>
>> Michael
>>
>=20
> Michael,
> Yes, it's "MESSAGE".
> Here's the complete process:
>=20
> $ git --version
> git version 1.7.3.1
>=20
> $ git tag -s test_tag
>=20
> [editor opens, I enter message, save, close]
>=20
> You need a passphrase to unlock the secret key for
> user: "Stephan Hugel <urschrei@gmail.com>"
> 1024-bit DSA key, ID 9B10D690, created 2008-09-06
>=20
> [I enter passphrase]
>=20
> [process completes]
>=20
> $ git verify-tag --verbose test_tag
> object 791abd4848d86ea98071f35bbce4d4b274ef0788
> type commit
> tag test_tag
> tagger Stephan H=C3=BCgel <urschrei@gmail.com> 1286291263 +0100
>=20
> Test tag
> -----BEGIN PGP MESSAGE-----
> Version: GnuPG v1.4.10 (Darwin)
>=20
> iD8DBQBMqz9G8Y2TgZsQ1pARAh2bAJ0WuNWsNa+eJq3aYMlwvOFX5eRUngCfZAcM
> hnt1Aomaz5SY0yofv9BwGWg=3D
> =3D+AKs
> -----END PGP MESSAGE-----
> gpg: Signature made Tue  5 Oct 16:07:50 2010 IST using DSA key ID 9B1=
0D690
> gpg: BAD signature from "Stephan Hugel <urschrei@gmail.com>"
>=20
>=20
> Now, if I manually append the tag contents to a file:
>=20
> $ git cat-file tag test_tag > a
> $ git cat-file tag test_tag > a.sig
> $ less a.sig
>=20
> object 791abd4848d86ea98071f35bbce4d4b274ef0788
> type commit
> tag test_tag
> tagger Stephan H=C3=BCgel <urschrei@gmail.com> 1286291263 +0100
>=20
> Test tag
> -----BEGIN PGP MESSAGE-----
> Version: GnuPG v1.4.10 (Darwin)
>=20
> iD8DBQBMqz9G8Y2TgZsQ1pARAh2bAJ0WuNWsNa+eJq3aYMlwvOFX5eRUngCfZAcM
> hnt1Aomaz5SY0yofv9BwGWg=3D
> =3D+AKs
> -----END PGP MESSAGE=E2=80=94=E2=80=94
>=20
> [remove PGP block (identical to the above block) from a]
>=20
> $ gpg --verify a.sig
> gpg: Signature made Tue  5 Oct 16:07:50 2010 IST using DSA key ID 9B1=
0D690
> gpg: Good signature from "Stephan Hugel <urschrei@gmail.com>"
>=20
> I've also just had a look at my gnupg.conf: the only options in it ar=
e:
> default-key 9B10D690
> charset utf8
> keyserver hkp://keyserver.ubuntu.com
> auto-key-locate hkp://keyserver.ubuntu.com
> utf8-strings
> rfc1991
>=20
> Nothing else.

The last one is the trouble maker, and you must have added it around th=
e
time of upgrading git...

Now, git should be able to cope with that, of course.

Michael
