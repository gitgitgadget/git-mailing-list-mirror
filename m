From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: git archive should use vendor extension in pax header
Date: Mon, 15 Feb 2016 21:25:40 +0100
Message-ID: <56C23444.5000405@web.de>
References: <20160124155909.GA16847@fuz.su> <56A7EDE1.1020909@web.de>
 <20160127114634.GA1976@fuz.su> <56A92913.3030909@web.de>
 <20160127234512.GA5453@fuz.su> <56B5F3BF.7080601@web.de>
 <20160206145726.GA27001@fuz.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: fuz@fuz.su
X-From: git-owner@vger.kernel.org Mon Feb 15 21:26:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVPit-000686-4L
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 21:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbcBOUZy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 15:25:54 -0500
Received: from mout.web.de ([212.227.17.11]:59729 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212AbcBOUZw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 15:25:52 -0500
Received: from [192.168.178.36] ([79.213.118.7]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MNLFd-1acHTQ3eZN-006sz8; Mon, 15 Feb 2016 21:25:49
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160206145726.GA27001@fuz.su>
X-Provags-ID: V03:K0:Zu2mxzeTqWbMjqlc/n/6+ye32B8BMszIk0O1tRHnc4JNTn3szlc
 gOBQAmSgjn3wlV0abepwhH4TV8thWI82mmLa57UnNwzhhqFXh4stS6KhzNmjrOsJGMHPT4l
 Y+bik/q7RuT60RkMZE198hNPcGSKzwCDwFYg+4vpH/61tGI8R1pbCR1LEE41eHL7x8dnykz
 gHHYW1Oe6rYMmXc8YlWpg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QWQvRjc8uBM=:owK7rp8yDLLvKiOcZgn95b
 RyearvcKbTHKgXG4N5RWdCM+HPGhPQUEWnOaffVdjasB+yMS++dWkvEKiKHziBC+6jo56oA6f
 K7g+gRI7hPT8kwDPWI0NF/cD5SGRjRZ7CdV8CoA7ix1SJBIXBnHPOQ9HkY3DxAHZ6r91VD4pp
 OxPlDDXUcU+K/6jFg6u1oK+RCzuX/wcuNLJ/R1vHmNb/lhIdG3F9933OnmCPP0zNq2l+dhGYN
 Wn5c8bz8RTe4m+BCrQ4WaZGemqE8AUKp7RZmHyLa/ua9agth5li3P+6a2usKrQYrlHY3Kd6o8
 UDsilVwEmI8As7t3pNqbiMISbhn46914cGq4oei2DMmtQkYXcDEqZAvnxc4iQpFZZPX+0RszU
 xCyDGRfEgdnK8+KCzTM80mTmkHJlKV3dxWs4Kd9Cl6bUNkFdur/OY3XX3LGUHrPhL/ZJspNuI
 nOI5moMhm22VlrG0DRUaiOhDk23ofkr00Vz8Tf2XeD4Mzttk9+3gxydH+qW3A8LW4XlaXZB/4
 lVN2tivWM9H2C18BPCnFzkecfRqtYT561WUaqcnDCXHGRv751PSbtlHa+0RewGwF2QepSn836
 GMVi1dh80T7xLMli2/irRs2W0HJ4+Pbx9KFFqeFlLKIGQfUcMFJLUN7kuIbYowtJb0JVrexva
 V0YtRmM7+odzDuPiwMiT6o6Tepzbq2nCQaOeyXaL+7qBEleqUdvdNWyLgb0QOY0aD2/qqBjZu
 Q2l8GqQcqrEbHxMS59wFqAzIy9uJeYajvgGOmdxZWIq5wJoj8i0JoDD5p3UdXvmIxHN1V6Zh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286232>

Am 06.02.2016 um 15:57 schrieb fuz@fuz.su:
> On Sat, Feb 06, 2016 at 02:23:11PM +0100, Ren=C3=A9 Scharfe wrote:
>> Am 28.01.2016 um 00:45 schrieb fuz@fuz.su:
>>>> There is git get-tar-commit-id, which prints the commit ID if it
>>>> finds a comment entry which looks like a hexadecimal SHA-1 hash.
>>>> It's better than a hex editor at least. :)
>>>
>>> This is incredibly fuzzy and can get wrong for a pleothora of reaso=
ns.
>>> I hope you agree though that the situation is suboptimal, git is do=
ing
>>> the equivalent of using a custom file format without an easily
>>> recognizable magic number.
>>
>> It is fuzzy in theory. But which other programs allow writing a
>> comment header?  I'm not aware of any, but I have to admit that I
>> didn't look too hard.
>
> Well, let's say what happens if the Mercurial folks were to implement
> the same thing? Suddenly there is a conflict. Yes, of course, right n=
ow
> there might be no program that uses the comment field for its own
> purpose but such design decisions tend to be not future proof. There =
is
> a very good reason why file formats typically have magic numbers and
> don't just rely on people knowing that the file has a certain type an=
d
> that is the same reason why git should mark its meta data in a unique
> fashion.

Chances are good that Mercurial would do it in a way that doesn't=20
conflict with git's tar comments.  I get your point, though, and agree=20
that it's not ideal.  However, so far it's just a potential problem.

>>>> But I'm still interested how you got a collection of tar files wit=
h
>>>> unknown origin.  Just curious.
>>>
>>> Easy: Just download the (source) distribution archives of a distrib=
ution
>>> of choice and try to verify that the tarballs they use to compile t=
heir
>>> packages actually come from the project's public git repositories.
>>
>> OK, that's easier than calculating checksums and comparing them with
>> those published by the respective projects, but also less
>> trustworthy.
>
> If you have a known trusted archive, you could use it directly, no ne=
ed
> for cross-verification. The intent is to be able to check if archives
> generated by someone from some sources could have plausibly been
> generated from these sources.

It's probably not too important, but I think I still don't fully=20
understand.  So you have a tar file of unknown origin.  You hand it to=20
git get-tar-commit-id or a similar tool and get back=20
a08595f76159b09d57553e37a5123f1091bb13e7.  You can google this string=20
and find out it's the commit ID for git v2.7.1.

Your tar file could have been modified in various ways, though, e.g.=20
with tar u or tar --delete.  So you try to find a download site for the=
=20
software that includes file hashes for archives of this release, like i=
n
https://www.kernel.org/pub/software/scm/git/sha256sums.asc.

If the published hash and a hash of your file match then you can be=20
reasonably sure the files are the same.  If they don't then it could be=
=20
due to variations added by the compressor.  You can download the=20
authoritative archive and compare it with yours.

Is that how it goes?

>> I'm very interested in hearing about any git specific bugs.
>
> I don't know any. Bugs tens to be known only after 1000s of buggy
> archives have been published (just as with some GNU tar bugs). It's
> great to have a way to detect that the archive might be affected by
> a bug so you know that you need to work around it.

That requires a field containing the git version which was used to=20
create the archive, no?

> Thinking about the problem a bit more and discussion with the
> aforementioned J=C3=B6rg Schilling we came to the conclusion that the=
 best
> way to deal with an =E2=80=9Cfile omitted=E2=80=9D attribute is to at=
tach it to the
> directory that would normally contain the omitted file.

Sounds sensible, but the ordering can be a bit tricky.  If d/a is=20
included and d/b is not then it would be easy to write d/, d/a and the=20
extended header that says that d/b is excluded, in that order.  Writing=
=20
the extended header first is a bit harder and I'm not sure if it's=20
needed.  And it gets tricky if more than one entry is excluded per=20
directory. (Just thinking out loud here.)

>> Letting archivers extract meta data as regular files is annoying to
>> those that are not interested in it.  Extended headers themselves
>> (type g) are bad enough already in this regard for those stuck with
>> old tar versions.
>
> I think we can safely assume that systems support pax headers 15 year=
s
> after they have been standardized. I was actually unable to find a
> non-historical version of a serious archiver that claims to support t=
ar
> archives but doesn't support pax headers.

Well, that depends on your definition of "serious".  Plan 9's tar=20
perhaps doesn't fit it, but what about 7-Zip (http://www.7-zip.org/)?

And there is no way (or did I overlook it?) to modify or display the=20
comment extended header using GNU tar.  That's actually surprising to=20
me: I'd think the ability to add a human-readable description to a=20
backup on tape is quite important.  (But I didn't touch an actual tape=20
for quite a while, and I never used tar directly with them.)

>>>>> The GIT.path option holds the paths that are being archived. It i=
s a bit
>>>>> tricky to get right.  The intent of POSIX pax headers is that eac=
h key
>>>>> is an attribute that applies to a series of files.  In the case o=
f a
>>>>> global header, each key applies until it is overridden with a new
>>>>> header or with a local header.  A GIT.path key should only apply =
to the
>>>>> files that correspond to this path operant to git archive.  Thus,=
 a new
>>>>> GIT.path should be written frequently.  There should always be at=
 least
>>>>> one GIT.path.
>>>>
>>>> That's for the optional path parameters of git archive, right?  A
>>>> list of included paths (GIT.include) would be simpler and should
>>>> suffice, no?
>>>
>>> No.  Again: An attribute in a pax header pertains a file.  It's met=
adata
>>> attached to a file, not metadata attached to the whole archive, eve=
n when
>>> part of a global header.  Thus each file should have attached what =
path
>>> operand it came from.  A file doesn't have the attribute what other=
 path
>>> operands git received, only the path operand that caused the inclus=
ion of
>>> that one file is an attribute of the file.
>>
>> Not an issue; we can make our own rules for our own keywords.
>
> Well, yes, but they should still stick to the semantic concept POSIX
> imposes for extended headers: headers pertain to files and the only
> difference between a g header and an x header is that the former appl=
ies
> until it is revoked by a new g header or overridden by an x header.
> Not sticking to this concept can lead to weird problems with programs
> that modify tar archives (like GNU-tar) and is not future proof. Bett=
er
> stick to the standard.

It's easy enough, I think: For each archive entry check if it is=20
explicity mentioned in the list of paths to archive and write an=20
extended header with GIT.path before proceeding as usual, no?  And for=20
the common case without path specification (meaning all files are=20
included) no such header would be needed.

Ren=C3=A9
