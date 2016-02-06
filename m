From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: git archive should use vendor extension in pax header
Date: Sat, 6 Feb 2016 14:23:11 +0100
Message-ID: <56B5F3BF.7080601@web.de>
References: <20160124155909.GA16847@fuz.su> <56A7EDE1.1020909@web.de>
 <20160127114634.GA1976@fuz.su> <56A92913.3030909@web.de>
 <20160127234512.GA5453@fuz.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: fuz@fuz.su
X-From: git-owner@vger.kernel.org Sat Feb 06 14:23:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aS2pc-00059W-Aj
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 14:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbcBFNXQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2016 08:23:16 -0500
Received: from mout.web.de ([212.227.15.14]:50299 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbcBFNXO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 08:23:14 -0500
Received: from [192.168.178.36] ([79.237.57.80]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LyUha-1ZwRNB2u4k-015p7f; Sat, 06 Feb 2016 14:23:11
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160127234512.GA5453@fuz.su>
X-Provags-ID: V03:K0:9Js2HrB3uDqRfCHQDdOBLG0zFpaKltL2V0iV28Fv6fRVLOK8F4K
 8HHzonT6V3WVcjGALHSBBkdXBMG/vwD9+rYIh8qellI29Kgkv5neH3KYd3Nj4ltQtRKQzjw
 HMVoOXBSisBaVu3E6lavUeFx6Z8QixlYWmECN9fxzjXjyDs47ZmMd9Wy6QK+dKLn4+5QTAu
 zXc8aFFyDwJDkorgt0izA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xk93n4+9Fck=:87quV/hI3I1seQzUGNPQZk
 lZRoxxpWCTzfd2Q4hQjaMen2L7ZkrpAbRaJDcppA7PIM/PbcERX6bCjI1JtTIP0LNr4NL2aH8
 0BaUAjZiqQJ0QuMCNntHP1B6NKtFTyWn5UpTHShRBa2JJlrxX1pnfbWaaOEf8PBoOSehWk0SA
 7oCFI+KTKGUC+90rzBDpr/w2D9VUYdbD688X5zdtJH5Ph4zZj8yXtsN8GbjBrEiDjN4IDaQbR
 HzoCtGqCPCrEX6EaTLmgTFaSqiXz1D9xSAhSJvt1CqbUTIu3Fb87hZ3BbUAAfnTUT2P9rExc0
 f2Xcx/TLOswh1dn1Wn4sTQKe2+Avvj8XE7XFfnT6SG//eDOCn4m5vNamsBU4oGXbtqmm05R+h
 3uWvDib2QhAhzCM/GUCv5DCnJNeM7vdvyDK5QxvSJWPaz1CWaEy3Fl+cYpyVEPcAd0yGvYWoH
 C3k1qvZbohA/F8LCz0UNJpRz+o7ntY2Df8zSuApDReG0jNajCew5p+1iC28vYpJ2MBWoY+kF7
 mLO5Kz6ow8bkfu+DiBhENjqrH2ViEb12OQJXZ88n9kfitZgIviEov+sbJNUQpPD3lgA/N/Ffg
 zWEOZyhjZUlhHY08ObiG7G+qFgRZU0xPbD5/CsCEtt7SeSRZM4oLG66MWHlynsTXZfe2BZdrM
 KzzKpQSDgZO73jZ258mm5pRhm8k4InfhCGykAJo/6tlfKsGHpPl8e2wy2ULoDMTF4uik489Ej
 h7zyqxOr/LtfSHU23FBA4rzYIH+Bj6p00nUNW/aNEDNsx6P7IEfCap7ijbleZI0H/HH7HJ3R 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285687>

Am 28.01.2016 um 00:45 schrieb fuz@fuz.su:
>> There is git get-tar-commit-id, which prints the commit ID if it
>> finds a comment entry which looks like a hexadecimal SHA-1 hash.
>> It's better than a hex editor at least. :)
>
> This is incredibly fuzzy and can get wrong for a pleothora of reasons=
=2E
> I hope you agree though that the situation is suboptimal, git is doin=
g
> the equivalent of using a custom file format without an easily
> recognizable magic number.

It is fuzzy in theory. But which other programs allow writing a comment=
=20
header?  I'm not aware of any, but I have to admit that I didn't look=20
too hard.

>> But I'm still interested how you got a collection of tar files with
>> unknown origin.  Just curious.
>
> Easy: Just download the (source) distribution archives of a distribut=
ion
> of choice and try to verify that the tarballs they use to compile the=
ir
> packages actually come from the project's public git repositories.

OK, that's easier than calculating checksums and comparing them with=20
those published by the respective projects, but also less trustworthy.

> There are other reasons why an easily detectable git hash might be
> useful.  For example, file(1) could show that the archive comes from
> git.  Other utilities could use this to work around git-specific bugs=
=2E
> An unpacker could add corresponding meta-data when unpacking the file=
=2E

file(1) could use the same heuristic as git get-tar-commit-id.=20
Something like this would work (the first line is already shipped with=20
file):

	257	string	ustar\0 POSIX tar archive
	>156	string	g
	>>512	string	52\ comment=3D
	>>>523	regex	[0-9a-f]{40}	\b, git commit %s

NB: With Ian Darwin's file you need to use -e tar in order to turn off=20
its internal tar test.

I'm very interested in hearing about any git specific bugs.

>>>>> It would be much more useful if git created a
>>>>> custom key. As per POSIX suggestions, something like this would b=
e
>>>>> appropriate:
>>>>>
>>>>>      GIT.commit=3D57ca140635bf157354124e4e4b3c8e1bde2832f1
>>>>
>>>> This would be included in addition to the comment in order to avoi=
d
>>>> breaking existing users, I guess.
>>>
>>> Good point.  I'm not sure how many user use the comment header at a=
ll.
>>
>> Apart from git get-tar-commit-id I don't know any program for
>> extracting pax comments.  And I don't know how widely used that is,
>> but I assume there is *someone* out there, extracting commit IDs
>> with it.
>
> Neither do I.  But remember, POSIX explicitly specifies that programs
> that parse pax file must ignore pax comments so an unpacker that
> interpretes the content of such a comment in any way is in violation =
of
> the pax specification.

Almost right: The spec says that *pax* shall ignore comments.  Which is=
=20
good -- we can use this field to transport anything without pax complai=
ning.

>>>> If you have a random archive and want to know if it was generated =
by
>>>> git then your next question might be which options and substitutio=
ns
>>>> were used.  That reminds me of this thread regarding verifiable
>>>> archives:
>>>>
>>>>      http://article.gmane.org/gmane.comp.version-control.git/24024=
4
>>>
>>> Good point.  Something like this should be enough to be enough to h=
ave
>>> reproducable archives if archives with a tree ID were to have a tim=
e
>>> stamp of 0 (1970-01-01) instead of the current date:
>>>
>>>      comment=3D...    (for compatibility)
>>>      GIT.commit=3D... (like comment)
>>>      GIT.umask=3D...  (tar.umask)
>>>      GIT.prefix=3D... (--prefix=3D)
>>>      GIT.path=3D...   (see below
>>>      GIT.export-subst=3D1 (in extended header instead of global hea=
der)
>>>
>>> A different key such as GIT.treeish might be appropriate.  The
>>> GIT.export-subst key should be set only for those files where a
>>> substitution has taken place.
>>
>> What would GIT.export-subst contain? There can be multiple
>> replacements in a file.
>
> GIT.export-subst would only contain a 1 if substitution is turned on.
> The goal is to have reproduceable archives, not the ability to turn a=
n
> archive back into a git repository.

OK.

>>> Maybe there should also be an
>>> GIT.original-name key.
>>
>> What would it be used for?
>
> In case an export substition changes the file name so the implementat=
ion
> can verify that the original file could plausibly have been substitut=
ed
> into the current name.  Also for the case where multiple files
> substitute into the same name to tell which file git should check
> equivalency with.

Stupid question: Could you please provide an example?  The only=20
possibility for name changes that I'm aware of is using --prefix.

>>> An option GIT.export-ignore is not required.  Instead it would be m=
ore
>>> useful to have a special file type G (for git) with the convention =
that
>>> the file name .gitattributes means =E2=80=9Cattributes that apply t=
o this git
>>> archive.=E2=80=9D
>>
>> That would be a non-standard extension.  Archivers would extract
>> these as regular files.  Storing a list of excluded paths (in
>> GIT.exclude or so) might be a better idea.
>
> No, that's not a good idea as pax headers are interpreted as =E2=80=9C=
attributes
> pertaining to a file.=E2=80=9D  A file doesn't have the attribute tha=
t other
> files have been omitted.  Making this a special file type is useful a=
s
> it allows archivers that don't implement git extensions to recover th=
is
> information in a useful way (after all, the .gitattributes file took
> part in creating the archive) and, more importantly, reserves a file
> type for future git extensions.

We can interpret our own keywords as we see fit.  Other programs will=20
ignore them (or at most print a warning).  There are precedents for=20
global headers pertaining to the whole archive, e.g. SCHILY.archtype of=
=20
star by J=C3=B6rg Schilling.

Letting archivers extract meta data as regular files is annoying to=20
those that are not interested in it.  Extended headers themselves (type=
=20
g) are bad enough already in this regard for those stuck with old tar=20
versions.

>>> The GIT.path option holds the paths that are being archived. It is =
a bit
>>> tricky to get right.  The intent of POSIX pax headers is that each =
key
>>> is an attribute that applies to a series of files.  In the case of =
a
>>> global header, each key applies until it is overridden with a new
>>> header or with a local header.  A GIT.path key should only apply to=
 the
>>> files that correspond to this path operant to git archive.  Thus, a=
 new
>>> GIT.path should be written frequently.  There should always be at l=
east
>>> one GIT.path.
>>
>> That's for the optional path parameters of git archive, right?  A
>> list of included paths (GIT.include) would be simpler and should
>> suffice, no?
>
> No.  Again: An attribute in a pax header pertains a file.  It's metad=
ata
> attached to a file, not metadata attached to the whole archive, even =
when
> part of a global header.  Thus each file should have attached what pa=
th
> operand it came from.  A file doesn't have the attribute what other p=
ath
> operands git received, only the path operand that caused the inclusio=
n of
> that one file is an attribute of the file.

Not an issue; we can make our own rules for our own keywords.

>>> It might be a good idea to be able to control the kind of metadata =
git
>>> adds to the archive as to be able to not leak any confidential
>>> information with git archive.  If you are interested I can try to m=
ake a
>>> specification for these headers.
>>
>> Which of the field might be sensitive?
>
> The existence of a git-specific pax header is sensitive as it proves
> that a git archive of the source code exists.  This can be a problem =
if
> you want to plausibly deny the possession of other versions of the
> source code you distribute.  The existence of export-ignore meta data
> leaks information about what other files are in the repository the
> archive was created from and can be critical.  The existence of
> path-operand meta data can show what path structure the repository ha=
s
> which can be sensitive.  Basically the existence of any information
> besides the information you want to add itself is sensitive.

OK..

>> Users can always go back to the original format.  At least I don't
>> expect this new format becoming the default too quickly.
>
> Sure thing.  If this is going to be implemented, I would add options
> to choose what / what style of metadata to include.

Alright.  (An environment requiring these options sounds scary, though.=
)

Ren=C3=A9
