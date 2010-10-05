From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Error when verifying tags signed using 1.7.3.1
Date: Tue, 05 Oct 2010 17:07:11 +0200
Message-ID: <4CAB3F1F.4030108@drmicha.warpmail.net>
References: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>	<201010041851.46838.ComputerDruid@gmail.com>	<AANLkTin1Ysn7Fp32Eoyjo3jjhHwVrc=hMuq+okgKNfmr@mail.gmail.com>	<201010041959.48336.ComputerDruid@gmail.com>	<AANLkTinA9K6BQ_gmNE8H02nGTSduhZWjujj6NiGDRALy@mail.gmail.com>	<4CAADB19.30707@drmicha.warpmail.net> <AANLkTikVYSwGjJUgA8KUdNrkHL3+1mSjv8efLwO5+C9E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Stephan Hugel <urschrei@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 17:07:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P396m-0003OM-C0
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 17:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753924Ab0JEPHB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 11:07:01 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:53421 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753557Ab0JEPHA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 11:07:00 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D7339662;
	Tue,  5 Oct 2010 11:06:59 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 05 Oct 2010 11:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=dndVEHPq51vIWAdiahuGlxwrxuk=; b=pagsdi56rCt8PLIrT8ONE/FspVCWFdJ2FGaBEZp7y9PH1VhzN2YVq1BiJ4FF+uURfgtKgQFBasF5vwEqSGimZUecw/Il6RWTZS0I+FOUYBVvAbyCwiuNtov9K0OYTmfe9opgT10PFgt4h6yeNsUTTT94jVcmS47sBObKvpaR2dA=
X-Sasl-enc: pwEXFCR8tjBfFOBmKolQMbpMIxKM108Ce+Vbpq9+EBHX 1286291219
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 352FE5E087E;
	Tue,  5 Oct 2010 11:06:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTikVYSwGjJUgA8KUdNrkHL3+1mSjv8efLwO5+C9E@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158200>

Stephan Hugel venit, vidit, dixit 05.10.2010 15:28:
> On 5 October 2010 09:00, Michael J Gruber <git@drmicha.warpmail.net> =
wrote:
>> Stephan Hugel venit, vidit, dixit 05.10.2010 02:17:
>>> On 5 October 2010 00:59, Daniel Johnson <computerdruid@gmail.com> w=
rote:
>>>> On Monday 04 October 2010 19:04:51 Stephan Hugel wrote:
>>>>> Daniel,
>>>>> Those are the exact steps I'm using.
>>>>>
>>>>> When I run tag -v on existing tags, I don't see the
>>>>>
>>>>> -----BEGIN PGP MESSAGE-----
>>>>> Version: GnuPG v1.4.9 (Darwin)
>>>>>
>>>>> iD8DBQBMqlpo8Y2TgZsQ1pARAmBQAJ9NV0IX7jlzeB8ogddlutFKAjyWJwCfSI5A
>>>>> yZeXw/EddYrfdad/VvOrL1o=3D
>>>>> =3D/0PJ
>>>>> -----END PGP MESSAGE=E2=80=94=E2=80=94
>>>>>
>>>>> block. It's only present on tags created using the current versio=
n.
>>>>> I've also just upgraded to GnuPG 1.4.10, but the result is the sa=
me.
>>>>> I'm not sure how else I can determine where the problem arises; I=
'm
>>>>> using the git and GnuPG versions for OS X built by homebrew, and =
GnuPG
>>>>> is happy to use the same key for en/decryption and signing. I've =
also
>>>>> verified that none of the subkeys are expired, and that the trust=
 db
>>>>> is OK.
>>>>
>>>> If you have the tests available, can you try running t7004 to see =
if it fails
>>>> there too?
>>>>
>>> I rebuilt and installed from source
>>> Passed all 105 tests in t7004-tag.sh
>>> Problem remains with tags I create
>>>
>>> This would seem to imply a problem with my key, even though nothing
>>> else is complaining about it.
>>
>> Here's a very basic way to check: If foo is your tag, do
>>
>> git cat-file tag foo > a
>> git cat-file tag foo > a.sig
>>
>> From the file "a", delete the signature (everything lines between an=
d
>> including "-----BEGIN/END PGP SIGNATURE-----"), invoking an editor o=
r
>> your favorite sed/awk/perl magic.
>>
>> a is the data on which git invoked gpg for signing the tag. (I'm not
>> sure why gpg can't notice the inline sig directly but that doesn't
>> matter; maybe because it is none ;))
>>
>> Now, gpg --verify a.sig should check the signature a.sig for a. Doin=
g
>> that, maybe with --verbose, you may find out whether the tag object =
is
>> bogus or git misunderstands gpg's response. If your key is on a key
>> server you can also share the file a.sig with us so that we can chec=
k.
>>
>> Michael
>>
> Michael,
> When I do this, gpg is able to verify the signature. So does this mea=
n
> that gnupg is failing to ignore the PGP block (possibly because it
> expects "SIGNATURE", not "MESSAGE"?)

Do you have "MESSAGE" in there???

Can you share the output of "git verify-tag --verbose yourtag" with us?
In any case, this command should give the same as the edited "a" above
on stdout, and gpg's repsonse on stderr. It should not contain any
"----BEGIN/END...".

You haven't tinkered with your gpg options lately, have you? ;)

Michael
