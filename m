From: Stephan Hugel <urschrei@gmail.com>
Subject: Re: Error when verifying tags signed using 1.7.3.1
Date: Tue, 5 Oct 2010 16:45:01 +0100
Message-ID: <AANLkTimW89OxR-ahPL9htEWotK6sN+8G9E6_6=gvSjW9@mail.gmail.com>
References: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>
	<201010041851.46838.ComputerDruid@gmail.com>
	<AANLkTin1Ysn7Fp32Eoyjo3jjhHwVrc=hMuq+okgKNfmr@mail.gmail.com>
	<201010041959.48336.ComputerDruid@gmail.com>
	<AANLkTinA9K6BQ_gmNE8H02nGTSduhZWjujj6NiGDRALy@mail.gmail.com>
	<4CAADB19.30707@drmicha.warpmail.net>
	<AANLkTikVYSwGjJUgA8KUdNrkHL3+1mSjv8efLwO5+C9E@mail.gmail.com>
	<4CAB3F1F.4030108@drmicha.warpmail.net>
	<AANLkTinqZddKc5ikVBnm+rqFFWtSy7DuByuPK58B4UEt@mail.gmail.com>
	<4CAB46C0.9000807@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 17:45:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P39hX-0006Ui-8P
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 17:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab0JEPpE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 11:45:04 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44856 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab0JEPpD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 11:45:03 -0400
Received: by wwj40 with SMTP id 40so5770707wwj.1
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aftwyYg+VaQQV95Dc4BQYn5xffel7JfCPsXYD/91rTo=;
        b=fUYW8wtkO6rY3eWYZAlrlIM5ks7NY77AKAlBhyytqrFKIGpQqZzNskDqdBFgFWLgQL
         IvXGpXRhY+wLoo5BQX+tM2sezzGYLVSeTOliDm8QtxNsb0bdXmUy/XzEN/ST2X5OPLFf
         QZxh17i8dBB1gO50vc27QGqTw8t7AIJHjxNDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pWElrk+9g6w/4Dnxr1gI8zkyHcYP6jAVAguWg5XEj+8MMqixeZ2qJTM5xIlM+kFnBy
         3bt8CE4Kf13XQ1p2aan/cUHp9Vw0CuMk6eVvpP2VVWxMeigJrnWy3zlNgSEOc/HKKaJQ
         f9SXFhFyA9UUaHBqfr2q2qtBS1p0dc8pHA/Os=
Received: by 10.227.157.213 with SMTP id c21mr9270787wbx.194.1286293501595;
 Tue, 05 Oct 2010 08:45:01 -0700 (PDT)
Received: by 10.216.230.232 with HTTP; Tue, 5 Oct 2010 08:45:01 -0700 (PDT)
In-Reply-To: <4CAB46C0.9000807@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158209>

On 5 October 2010 16:39, Michael J Gruber <git@drmicha.warpmail.net> wr=
ote:
> Stephan Hugel venit, vidit, dixit 05.10.2010 17:19:
>> On 5 October 2010 16:07, Michael J Gruber <git@drmicha.warpmail.net>=
 wrote:
>>> Stephan Hugel venit, vidit, dixit 05.10.2010 15:28:
>>>> On 5 October 2010 09:00, Michael J Gruber <git@drmicha.warpmail.ne=
t> wrote:
>>>>> Stephan Hugel venit, vidit, dixit 05.10.2010 02:17:
>>>>>> On 5 October 2010 00:59, Daniel Johnson <computerdruid@gmail.com=
> wrote:
>>>>>>> On Monday 04 October 2010 19:04:51 Stephan Hugel wrote:
>>>>>>>> Daniel,
>>>>>>>> Those are the exact steps I'm using.
>>>>>>>>
>>>>>>>> When I run tag -v on existing tags, I don't see the
>>>>>>>>
>>>>>>>> -----BEGIN PGP MESSAGE-----
>>>>>>>> Version: GnuPG v1.4.9 (Darwin)
>>>>>>>>
>>>>>>>> iD8DBQBMqlpo8Y2TgZsQ1pARAmBQAJ9NV0IX7jlzeB8ogddlutFKAjyWJwCfSI=
5A
>>>>>>>> yZeXw/EddYrfdad/VvOrL1o=3D
>>>>>>>> =3D/0PJ
>>>>>>>> -----END PGP MESSAGE=E2=80=94=E2=80=94
>>>>>>>>
>>>>>>>> block. It's only present on tags created using the current ver=
sion.
>>>>>>>> I've also just upgraded to GnuPG 1.4.10, but the result is the=
 same.
>>>>>>>> I'm not sure how else I can determine where the problem arises=
; I'm
>>>>>>>> using the git and GnuPG versions for OS X built by homebrew, a=
nd GnuPG
>>>>>>>> is happy to use the same key for en/decryption and signing. I'=
ve also
>>>>>>>> verified that none of the subkeys are expired, and that the tr=
ust db
>>>>>>>> is OK.
>>>>>>>
>>>>>>> If you have the tests available, can you try running t7004 to s=
ee if it fails
>>>>>>> there too?
>>>>>>>
>>>>>> I rebuilt and installed from source
>>>>>> Passed all 105 tests in t7004-tag.sh
>>>>>> Problem remains with tags I create
>>>>>>
>>>>>> This would seem to imply a problem with my key, even though noth=
ing
>>>>>> else is complaining about it.
>>>>>
>>>>> Here's a very basic way to check: If foo is your tag, do
>>>>>
>>>>> git cat-file tag foo > a
>>>>> git cat-file tag foo > a.sig
>>>>>
>>>>> From the file "a", delete the signature (everything lines between=
 and
>>>>> including "-----BEGIN/END PGP SIGNATURE-----"), invoking an edito=
r or
>>>>> your favorite sed/awk/perl magic.
>>>>>
>>>>> a is the data on which git invoked gpg for signing the tag. (I'm =
not
>>>>> sure why gpg can't notice the inline sig directly but that doesn'=
t
>>>>> matter; maybe because it is none ;))
>>>>>
>>>>> Now, gpg --verify a.sig should check the signature a.sig for a. D=
oing
>>>>> that, maybe with --verbose, you may find out whether the tag obje=
ct is
>>>>> bogus or git misunderstands gpg's response. If your key is on a k=
ey
>>>>> server you can also share the file a.sig with us so that we can c=
heck.
>>>>>
>>>>> Michael
>>>>>
>>>> Michael,
>>>> When I do this, gpg is able to verify the signature. So does this =
mean
>>>> that gnupg is failing to ignore the PGP block (possibly because it
>>>> expects "SIGNATURE", not "MESSAGE"?)
>>>
>>> Do you have "MESSAGE" in there???
>>>
>>> Can you share the output of "git verify-tag --verbose yourtag" with=
 us?
>>> In any case, this command should give the same as the edited "a" ab=
ove
>>> on stdout, and gpg's repsonse on stderr. It should not contain any
>>> "----BEGIN/END...".
>>>
>>> You haven't tinkered with your gpg options lately, have you? ;)
>>>
>>> Michael
>>>
>>
>> Michael,
>> Yes, it's "MESSAGE".
>> Here's the complete process:
>>
>> $ git --version
>> git version 1.7.3.1
>>
>> $ git tag -s test_tag
>>
>> [editor opens, I enter message, save, close]
>>
>> You need a passphrase to unlock the secret key for
>> user: "Stephan Hugel <urschrei@gmail.com>"
>> 1024-bit DSA key, ID 9B10D690, created 2008-09-06
>>
>> [I enter passphrase]
>>
>> [process completes]
>>
>> $ git verify-tag --verbose test_tag
>> object 791abd4848d86ea98071f35bbce4d4b274ef0788
>> type commit
>> tag test_tag
>> tagger Stephan H=C3=BCgel <urschrei@gmail.com> 1286291263 +0100
>>
>> Test tag
>> -----BEGIN PGP MESSAGE-----
>> Version: GnuPG v1.4.10 (Darwin)
>>
>> iD8DBQBMqz9G8Y2TgZsQ1pARAh2bAJ0WuNWsNa+eJq3aYMlwvOFX5eRUngCfZAcM
>> hnt1Aomaz5SY0yofv9BwGWg=3D
>> =3D+AKs
>> -----END PGP MESSAGE-----
>> gpg: Signature made Tue =C2=A05 Oct 16:07:50 2010 IST using DSA key =
ID 9B10D690
>> gpg: BAD signature from "Stephan Hugel <urschrei@gmail.com>"
>>
>>
>> Now, if I manually append the tag contents to a file:
>>
>> $ git cat-file tag test_tag > a
>> $ git cat-file tag test_tag > a.sig
>> $ less a.sig
>>
>> object 791abd4848d86ea98071f35bbce4d4b274ef0788
>> type commit
>> tag test_tag
>> tagger Stephan H=C3=BCgel <urschrei@gmail.com> 1286291263 +0100
>>
>> Test tag
>> -----BEGIN PGP MESSAGE-----
>> Version: GnuPG v1.4.10 (Darwin)
>>
>> iD8DBQBMqz9G8Y2TgZsQ1pARAh2bAJ0WuNWsNa+eJq3aYMlwvOFX5eRUngCfZAcM
>> hnt1Aomaz5SY0yofv9BwGWg=3D
>> =3D+AKs
>> -----END PGP MESSAGE=E2=80=94=E2=80=94
>>
>> [remove PGP block (identical to the above block) from a]
>>
>> $ gpg --verify a.sig
>> gpg: Signature made Tue =C2=A05 Oct 16:07:50 2010 IST using DSA key =
ID 9B10D690
>> gpg: Good signature from "Stephan Hugel <urschrei@gmail.com>"
>>
>> I've also just had a look at my gnupg.conf: the only options in it a=
re:
>> default-key 9B10D690
>> charset utf8
>> keyserver hkp://keyserver.ubuntu.com
>> auto-key-locate hkp://keyserver.ubuntu.com
>> utf8-strings
>> rfc1991
>>
>> Nothing else.
>
> The last one is the trouble maker, and you must have added it around =
the
> time of upgrading git...
>
> Now, git should be able to cope with that, of course.
>
> Michael
>
I can confirm that disabling that option in gpg.conf results in a tag
using "SIGNATURE" being written, which can be subsequently verified.


--=20

steph
