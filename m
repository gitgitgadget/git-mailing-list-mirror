From: Stephan Hugel <urschrei@gmail.com>
Subject: Re: Error when verifying tags signed using 1.7.3.1
Date: Tue, 5 Oct 2010 16:19:55 +0100
Message-ID: <AANLkTinqZddKc5ikVBnm+rqFFWtSy7DuByuPK58B4UEt@mail.gmail.com>
References: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>
	<201010041851.46838.ComputerDruid@gmail.com>
	<AANLkTin1Ysn7Fp32Eoyjo3jjhHwVrc=hMuq+okgKNfmr@mail.gmail.com>
	<201010041959.48336.ComputerDruid@gmail.com>
	<AANLkTinA9K6BQ_gmNE8H02nGTSduhZWjujj6NiGDRALy@mail.gmail.com>
	<4CAADB19.30707@drmicha.warpmail.net>
	<AANLkTikVYSwGjJUgA8KUdNrkHL3+1mSjv8efLwO5+C9E@mail.gmail.com>
	<4CAB3F1F.4030108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 17:20:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P39JE-0007Ka-DC
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 17:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab0JEPT5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 11:19:57 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40461 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab0JEPT5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 11:19:57 -0400
Received: by wyb28 with SMTP id 28so6124625wyb.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pmYZpI6NYHCW+haG3t+OCbcc6WFbGi0l8ODzqEFloWk=;
        b=CvgWpdnhNLjFHHqjElfpnYYjbmRZW5/TSz3l6qHUyOtqxq1JHRuaEIDPo5m+kBRJS+
         tGeIMlKshJ334jdSxgMjKhsPxp8Us2PhdA8Y1uC7hMogFIurno+80DKBKPpJyrnI68cj
         EaauBXm7PMHH6cM/QicIZxgaCoqsNYRRIxLEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VCTRi+yhM2QpAuOmu7TE2+NPPbbD9yeGZHHUDrA6+UeF0ZsdwvFkltGAeeCXtoIlGW
         7FqViCkN86sRLBVAicTUd4Ac98SRSNIVzyiNdUzw9//qgu1VPTPPbyPaPhyF15FBIV3+
         bsc/X9xIMW0pYE7+tjN/eTuvwsU9uVWl5rrp4=
Received: by 10.227.143.143 with SMTP id v15mr9171506wbu.157.1286291995620;
 Tue, 05 Oct 2010 08:19:55 -0700 (PDT)
Received: by 10.216.230.232 with HTTP; Tue, 5 Oct 2010 08:19:55 -0700 (PDT)
In-Reply-To: <4CAB3F1F.4030108@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158201>

On 5 October 2010 16:07, Michael J Gruber <git@drmicha.warpmail.net> wr=
ote:
> Stephan Hugel venit, vidit, dixit 05.10.2010 15:28:
>> On 5 October 2010 09:00, Michael J Gruber <git@drmicha.warpmail.net>=
 wrote:
>>> Stephan Hugel venit, vidit, dixit 05.10.2010 02:17:
>>>> On 5 October 2010 00:59, Daniel Johnson <computerdruid@gmail.com> =
wrote:
>>>>> On Monday 04 October 2010 19:04:51 Stephan Hugel wrote:
>>>>>> Daniel,
>>>>>> Those are the exact steps I'm using.
>>>>>>
>>>>>> When I run tag -v on existing tags, I don't see the
>>>>>>
>>>>>> -----BEGIN PGP MESSAGE-----
>>>>>> Version: GnuPG v1.4.9 (Darwin)
>>>>>>
>>>>>> iD8DBQBMqlpo8Y2TgZsQ1pARAmBQAJ9NV0IX7jlzeB8ogddlutFKAjyWJwCfSI5A
>>>>>> yZeXw/EddYrfdad/VvOrL1o=3D
>>>>>> =3D/0PJ
>>>>>> -----END PGP MESSAGE=E2=80=94=E2=80=94
>>>>>>
>>>>>> block. It's only present on tags created using the current versi=
on.
>>>>>> I've also just upgraded to GnuPG 1.4.10, but the result is the s=
ame.
>>>>>> I'm not sure how else I can determine where the problem arises; =
I'm
>>>>>> using the git and GnuPG versions for OS X built by homebrew, and=
 GnuPG
>>>>>> is happy to use the same key for en/decryption and signing. I've=
 also
>>>>>> verified that none of the subkeys are expired, and that the trus=
t db
>>>>>> is OK.
>>>>>
>>>>> If you have the tests available, can you try running t7004 to see=
 if it fails
>>>>> there too?
>>>>>
>>>> I rebuilt and installed from source
>>>> Passed all 105 tests in t7004-tag.sh
>>>> Problem remains with tags I create
>>>>
>>>> This would seem to imply a problem with my key, even though nothin=
g
>>>> else is complaining about it.
>>>
>>> Here's a very basic way to check: If foo is your tag, do
>>>
>>> git cat-file tag foo > a
>>> git cat-file tag foo > a.sig
>>>
>>> From the file "a", delete the signature (everything lines between a=
nd
>>> including "-----BEGIN/END PGP SIGNATURE-----"), invoking an editor =
or
>>> your favorite sed/awk/perl magic.
>>>
>>> a is the data on which git invoked gpg for signing the tag. (I'm no=
t
>>> sure why gpg can't notice the inline sig directly but that doesn't
>>> matter; maybe because it is none ;))
>>>
>>> Now, gpg --verify a.sig should check the signature a.sig for a. Doi=
ng
>>> that, maybe with --verbose, you may find out whether the tag object=
 is
>>> bogus or git misunderstands gpg's response. If your key is on a key
>>> server you can also share the file a.sig with us so that we can che=
ck.
>>>
>>> Michael
>>>
>> Michael,
>> When I do this, gpg is able to verify the signature. So does this me=
an
>> that gnupg is failing to ignore the PGP block (possibly because it
>> expects "SIGNATURE", not "MESSAGE"?)
>
> Do you have "MESSAGE" in there???
>
> Can you share the output of "git verify-tag --verbose yourtag" with u=
s?
> In any case, this command should give the same as the edited "a" abov=
e
> on stdout, and gpg's repsonse on stderr. It should not contain any
> "----BEGIN/END...".
>
> You haven't tinkered with your gpg options lately, have you? ;)
>
> Michael
>

Michael,
Yes, it's "MESSAGE".
Here's the complete process:

$ git --version
git version 1.7.3.1

$ git tag -s test_tag

[editor opens, I enter message, save, close]

You need a passphrase to unlock the secret key for
user: "Stephan Hugel <urschrei@gmail.com>"
1024-bit DSA key, ID 9B10D690, created 2008-09-06

[I enter passphrase]

[process completes]

$ git verify-tag --verbose test_tag
object 791abd4848d86ea98071f35bbce4d4b274ef0788
type commit
tag test_tag
tagger Stephan H=C3=BCgel <urschrei@gmail.com> 1286291263 +0100

Test tag
-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.4.10 (Darwin)

iD8DBQBMqz9G8Y2TgZsQ1pARAh2bAJ0WuNWsNa+eJq3aYMlwvOFX5eRUngCfZAcM
hnt1Aomaz5SY0yofv9BwGWg=3D
=3D+AKs
-----END PGP MESSAGE-----
gpg: Signature made Tue  5 Oct 16:07:50 2010 IST using DSA key ID 9B10D=
690
gpg: BAD signature from "Stephan Hugel <urschrei@gmail.com>"


Now, if I manually append the tag contents to a file:

$ git cat-file tag test_tag > a
$ git cat-file tag test_tag > a.sig
$ less a.sig

object 791abd4848d86ea98071f35bbce4d4b274ef0788
type commit
tag test_tag
tagger Stephan H=C3=BCgel <urschrei@gmail.com> 1286291263 +0100

Test tag
-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.4.10 (Darwin)

iD8DBQBMqz9G8Y2TgZsQ1pARAh2bAJ0WuNWsNa+eJq3aYMlwvOFX5eRUngCfZAcM
hnt1Aomaz5SY0yofv9BwGWg=3D
=3D+AKs
-----END PGP MESSAGE=E2=80=94=E2=80=94

[remove PGP block (identical to the above block) from a]

$ gpg --verify a.sig
gpg: Signature made Tue  5 Oct 16:07:50 2010 IST using DSA key ID 9B10D=
690
gpg: Good signature from "Stephan Hugel <urschrei@gmail.com>"

I've also just had a look at my gnupg.conf: the only options in it are:
default-key 9B10D690
charset utf8
keyserver hkp://keyserver.ubuntu.com
auto-key-locate hkp://keyserver.ubuntu.com
utf8-strings
rfc1991

Nothing else.
--=20

steph
