Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76E7C1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeAEUsn (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:48:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:51223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752849AbeAEUsm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:48:42 -0500
Received: from ggw-xinxiao-xx.fareast.corp.microsoft.com ([37.201.193.20]) by
 mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0McEI3-1eDy8B2gB5-00JZXM; Fri, 05 Jan 2018 21:48:36 +0100
Date:   Fri, 5 Jan 2018 21:48:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Anthony Ramine <n.oxyde@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH v4 7/7] wildmatch test: create & test files on disk in
 addition to in-memory
In-Reply-To: <87r2r4azt5.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801052133380.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <20180104192657.28019-1-avarab@gmail.com> <20180104192657.28019-8-avarab@gmail.com> <nycvar.QRO.7.76.6.1801051622010.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <87r2r4azt5.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-556223849-1515185316=:1337"
X-Provags-ID: V03:K0:bGy1ESajoOp/7+KYfcGzDMf0E9p65TYcPwuxMeM/CsC8xf+kg2G
 J6Rg7gbZtRjN7hSf6H/rU98Ecm4fBaS6jXLNUNQ0YLtgav0nQ8Iu+gfspg5DyFmYDSsYYpF
 aZT7W7Rh2L0jAabJ2ftOGqE7hTzV9lL/lfwg1QLG30wTLb1y/RfV1RmC+DKfKQJvPfv6D9v
 GNMExGJjV3L+TTaj2EC+w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+QGvZFD5XuI=:HnjPkpx3+F86APp63gnUut
 xeKtiWHS0dtR7mD2a0ADMteM+oWDOCCGYPiG9vvaYHVdWBvbphJfoKgIHbyXaRO7eWIsTsVW7
 y9L6x6snFDYpA+T6DjLMv6Qg9+sUXIYePS3C0r0AFa7PXdTE2ukcOeYm815kCnibOvg1/H2N2
 QYRv8E/Pc+xFEUepcA+aMlGmn5f/TaHOBEUSIYzwk+7Mm46KET4oH5OdfAKwDks//2aaHG3zD
 OJCTp7izZNAYslxYpSIXOMEHXizFS/2GBkfRvyHHVE8yUVExk45iJwXC8JFYW2oNZanpSviEp
 ar9tVxQhVN3S3hEAMLacNPcxvXly/2hOiwW5M0+Qo/K4mnWgaidqRygORX4ywnCH+6EpTtO7K
 uV+3Zx+ypubOqwR5nvpHjfgj6J1IRyTeul/MLmx2AiCdt14paYeEZOQhiS0cPrj0yE2e2F/CH
 9/gg+Sq8mmsdBUG9qvax2fhKWnpssN2QBnoxu2zaY7zKfWPseWFn59kQFfRMOyfMRN/qZcZ5T
 SvsqQOVyTZ443RzsBtuhzp9QIOP1HigPBjxdUJwYupfleh+D2YUlyTQDUo1QyG+dFR+NsBk3a
 o6eNy+yPJhk2T6f6mfXJB0PJiY10d5+M/Fu1jFb49nx4QN+TNjdIJYteBSu1/i7oFSyjA/DbZ
 lYxxBQ6dTeCjnyzfBfzhDqO4D+/1dbDz7Y5uGX4CUAVFqMRVmza3ZoBO50xh3luQNHLS59tiI
 rpgjYISEnsYkcY/MyPINCZowCDuO77buQU1mxFexMliqdK/PCXq26ieVCpzc6ROWBlHWBmBPP
 A7QXU7K+BKtSA/8xclmWHDwvZTECXcgMpDfWuj/z9BR+eCbe3HOhHIU4yoNOXkhIFI0NOJC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-556223849-1515185316=:1337
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Fri, 5 Jan 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Jan 05 2018, Johannes Schindelin jotted:
>=20
> > [...]
> >
> > In short: the Unix shell script t3070 manages to write what it thinks i=
s a
> > file called 'foo*', but Git only sees 'foo<some-undisplayable-character=
>'.
> >
> > I tried to address this problem with this patch:
>=20
> ...I don't see any particular value in trying to do these full roundtrip
> tests on platforms like Windows. Perhaps we should just do these on a
> whitelist of POSIX systems for now, and leave expanding that list to
> some future step.

I don't think so. Windows is already handled as a second-class citizen, as
if nobody developed on it. As a consequence, only very few of the
gazillions of Windows developers... develop Git. We could worsify the
situation, of course, but why? Shouldn't we at least pretend to try the
opposite?

> > -- snip --
> > diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> > index f606f91acbb..51dcb675e7b 100755
> > --- a/t/t3070-wildmatch.sh
> > +++ b/t/t3070-wildmatch.sh
> > @@ -4,6 +4,14 @@ test_description=3D'wildmatch tests'
> >
> >  . ./test-lib.sh
> >
> > +if test_have_prereq !MINGW && touch -- 'a*b' 2>/dev/null
> > +then
> > +=09test_set_prereq FILENAMESWITHSTARS
> > +else
> > +=09say 'Your filesystem does not allow stars in filenames.'
> > +fi
> > +rm -f 'a*b'
> > +
> >  create_test_file() {
> >  =09file=3D$1
> >
> > @@ -28,6 +36,17 @@ create_test_file() {
> >  =09*/)
> >  =09=09return 1
> >  =09=09;;
> > +=09# On Windows, stars are not allowed in filenames. Git for Windows'
> > +=09# Bash, however, is based on Cygwin which plays funny names with a
> > +=09# private Unicode page to emulate stars in filenames. Meaning that
> > +=09# the shell script will "succeed" to write the file, but Git will
> > +=09# not see it. Nor any other, regular Windows process.
> > +=09*\**|*\[*)
> > +=09=09if ! test_have_prereq FILENAMESWITHSTARS
> > +=09=09then
> > +=09=09=09return 1
> > +=09=09fi
> > +=09=09;;
> >  =09# On Windows, \ in paths is silently converted to /, which
> >  =09# would result in the "touch" below working, but the test
> >  =09# itself failing. See 6fd1106aa4 ("t3700: Skip a test with
> > -- snap --
> >
> > This gets us further. But not by much:
>=20
> Okey, that's very weird. So you can:
>=20
>     touch "./*"; echo $?
>=20
> And it'll return 0 but then the file won't exist?

Almost. The file exists, but it won't have the name '*'. It will have as
name a Unicode character that is in a private page, not standardized by
the Unicode specification.

> How about this:
>=20
>     touch "./*" && test -e "./*"; echo $?

Would return 0. Why? Because *you are still in a Unix shell script, so the
Cygwin cuteness still applies*.

> The reason this latest version stopped creating files with "\" in them
> unless under BSLASHPSPEC is because Cygwin would silently translate it,
> so it would create the file but it would actually mean something the
> tests didn't expect.

I understand that. And I would wish that the test would be designed in a
more cross-platform-aware mindset.

> For anything else, such as stars not being allowed in filenames I was
> expecting that "touch" command to return an error, but if that's not the
> case maybe we need the "test -e" as well, unless I'm missing something
> here.

This is one of the many bad consequences of Git relying so much on Unix
shell scripting. Despite what many, many, many Git developers think: shell
scripting is not portable.

Cygwin does a good job of pretending that it is, and MSYS2 exacerbates
that notion, but it comes back to haunt you right here and right now. The
`touch` invocation will *report success*, but it will have done something
different than you wanted. It's like the Thinking: Fast and Slow.

> > fatal: Invalid path '\[ab]': No such file or directory
> >
> > You see, any path starting with a backslash *is* an absolute path on
> > Windows. It is relative to the current drive.
>=20
> Right, which I was trying to avoid by not actually creating \[ab], but
> "./\[ab]", is that the same filename on Windows?

Whoops. I managed to copy-paste the *wrong* command's error message. Sorry
about that. The correct one:

$ git --glob-pathspecs ls-files -z -- '\[ab]'
fatal: \[ab]: '\[ab]' is outside repository

Note how it is Git reporting that you asked for a path that is outside?
That's because it thinks you are referring to C:\[ab] (if your current
directory is on the C: drive).

And it would be correct to complain on Windows: the `\[ab]` parameter
refers to an absolute path.

> > This affects *quite* a few of the test cases you added.
> >
> > And even if I just comment all of those out, I run into the next proble=
m
> > where you try to create a file whose name consists of a single space,
> > which is also illegal on Windows.
>=20
> Okey, but ditto above about touch not catching it, does:
>=20
>     touch "./ "; echo $?
>=20
> Not return an error? Then how about:
>=20
>     touch "./ " && test -e "./ "; echo $?

Again: as long as you stay within the bounds of the Unix shell script (did
I point out enough yet how non-portable this design is? Even Subversion
knew better than to implement parts of its operations as Unix shell
scripts. I mean, for PoCing, okay, but for production code?) you fall prey
to Cygwin's emulation of POSIX-y filenames. As soon as you leave that
bubble (e.g. by calling git.exe), you're not going to see those illegal
file names, but the ones with the unprintable Unicode characters.

> > These woes demonstrate one problem with the approach of overzealously
> > testing *everything*[...]
>=20
> I think the rest of this gets into topics I've covered above. I.e. that
> this increased test coverage has caught bugs.

That's all good and dandy, but what about regressions? I know how much I
will curse in your vague direction when I encounter the next
wildmatch-related bug in, say, half a year and have to wade through the
jungle of unintuitive tests in t3070.

Can't we do a lot better than this? Shouldn't it be a lot more obvious
what the heck went wrong when running t3070 with -i -v -x?

Ciao,
Johannes
--8323328-556223849-1515185316=:1337--
