Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B7B71F461
	for <e@80x24.org>; Mon,  8 Jul 2019 12:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbfGHM5d (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 08:57:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:43257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfGHM5c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 08:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562590643;
        bh=Ua32DSrGFdVsAP+7wMN/yoHXq3H2qc3OXO1WMO6iYnE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LC83/fmrsGoUZmER/upqMd7Oc3U/MtoFjYq8NGFNHQOmSHFuBdmvqrVqUTa6dMkXR
         N6fIWSVFSfV8qS0CXk7gweD0LRsrR6ePKb99a8tgIvuze0tut5Wwn7PZfEsLFUn8GB
         Fz0ebXwfVfbFtBDRN1f9icPD5xQcibEuyCyL1Jkk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbA4j-1iCszy04VN-00kgj9; Mon, 08
 Jul 2019 14:57:23 +0200
Date:   Mon, 8 Jul 2019 14:57:56 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH v2 1/1] gettext: always use UTF-8 on native Windows
In-Reply-To: <87o92976nz.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907081446030.44@tvgsbejvaqbjf.bet>
References: <pull.217.git.gitgitgadget@gmail.com> <pull.217.v2.git.gitgitgadget@gmail.com> <2d2253faef14e5157f8aac4534d9ac9640f3d5fa.1562186762.git.gitgitgadget@gmail.com> <87o92976nz.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-649694082-1562590677=:44"
X-Provags-ID: V03:K1:tg6oB5uCPit5uFcG+fOxza3Y0zik48aXBoabzCbZfcwly4btI0h
 bv1gabkE+M/ViU47zbq6ktOiDRA3z5UyXLIf4L/eK7VyV0oIaBfMKE9EkiyrHeFCpnf5PAj
 8kj+f9oYl1lFygxASFB8jcmHn5mIOh/SaWVifdpVSZ/AwXda3wHeEn81Dn28Rr0xkkoPQT6
 vLjJCMbZoK4KOM/JMMB2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i1R/8Zdz6YQ=:TMwvLnBsstPVI5Mdu30zsh
 1KVpfOrJWVq1b+D/Ziylh6/irxxaLDRuyMBPKYViyV99MFOJqf869PAh00wTJ1yu591A6LSXr
 zrIG/s/kjuAl+OsS3dEjb8Tw17eKQb0oTT74NzK8oPpLKkaKBuWic3pK3WdUXUqUlch+0RVQy
 3T52nApEUkuAMpeK6DYhcBeFNbBpan9QJGAygvjGtbCsQtcTiqRN5K6jr+sgE48WVhXwIg6rm
 2tfSUKdNnjdAD4YMecAUkAwK0JpS5NaGQqeJ394T8vK4BRLSf1JDDxBf8+3SQw14QfEuZBihN
 xQ0QmL4+t8kgJcrbv/60jxBkd2v9qPpkG5K1hQxa/0M4UenRtOJKDh6FW3yP1STJz3XmL01mh
 92E753hYjeLefB++ZubjA3yHrW2kvPz88RULGLbnFUJvlyixu017TlwpCJD1j4t0YYxsnzZpk
 IDRq3Kfb+VXEt6qxweLAAgrEHfB3SRs6pzuIdTAwi9YHLy84gP/P7OQUCBs06CwYh+0ZtY1AC
 vpvy/uez7AWvt1dBB6iJ9CgJQMTXpZtZAvB/P0HBvoWFV3TtNx9xustEDTIw1jL+fpk6y52bZ
 y5aLse2FJvWpv/fAAhRcZoq31x4M/UKL0CtHlGQTaHUx8yMFImDLpOyU3anjBfVtzY7/9UFHh
 P+klWEGWovA+yfLMVLjU7PzMhYK7P9aceZyVjEoTdWk0vnVY680c8r1kWKPU2UC2YCMqdMaDD
 gDCcZ1P4db7/1AKrBMfrwU/NtDEQjVX7INfC9iiKpr2ZLRjoM3RQfIafennM2irhJL2s3kNPH
 oMhhng1rTpeI9gbqBY68JpS1eOuiV3Yc6BDrNn1nqCjnX9gorh2wJirOtAGPKXa6b9TJ8GvIG
 nB637FTz1rMqoCOpUjZpMOjU6+6Dcjg6ejsMc2ZZ5WyIfa/vmLKw/1e+1/vW19eamOGziEdil
 8Wwjx82opF7duTLhgh2bOMyl1AA4Wx+0iv+NW3D7C0oYGy0Uaa9/mZw5oZchi2O5aQc1lBja0
 E3QzCkEZlZUTGId920CXx1AoFjICfuj5NKc9fS23YLGoLo17WVy5eLeIzsXGPUtNRrBAd5wAS
 Rt/i0RDXFFghcz6ARPbjiMK4SQcDl+IVZ+u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-649694082-1562590677=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 5 Jul 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Jul 03 2019, Karsten Blees via GitGitGadget wrote:
>
> > From: Karsten Blees <blees@dcon.de>
> >
> > On native Windows, Git exclusively uses UTF-8 for console output (both
> > with MinTTY and native Win32 Console). Gettext uses `setlocale()` to
> > determine the output encoding for translated text, however, MSVCRT's
> > `setlocale()` does not support UTF-8. As a result, translated text is
> > encoded in system encoding (as per `GetAPC()`), and non-ASCII chars ar=
e
> > mangled in console output.
> >
> > Side note: There is actually a code page for UTF-8: 65001. In practice=
,
> > it does not work as expected at least on Windows 7, though, so we cann=
ot
> > use it in Git. Besides, if we overrode the code page, any process
> > spawned from Git would inherit that code page (as opposed to the code
> > page configured for the current user), which would quite possibly brea=
k
> > e.g. diff or merge helpers. So we really cannot override the code page=
.
> >
> > In `init_gettext_charset()`, Git calls gettext's
> > `bind_textdomain_codeset()` with the character set obtained via
> > `locale_charset()`; Let's override that latter function to force the
> > encoding to UTF-8 on native Windows.
> >
> > In Git for Windows' SDK, there is a `libcharset.h` and therefore we
> > define `HAVE_LIBCHARSET_H` in the MINGW-specific section in
> > `config.mak.uname`, therefore we need to add the override before that
> > conditionally-compiled code block.
> >
> > Rather than simply defining `locale_charset()` to return the string
> > `"UTF-8"`, though, we are careful not to break `LC_ALL=3DC`: the
> > `ab/no-kwset` patch series, for example, needs to have a way to preven=
t
> > Git from expecting UTF-8-encoded input.
>
> It's not just the ab/no-kwset I have cooking (but happy to have this
> take that into account), but also anything grep-like is usually must
> faster with LC_ALL=3DC. Isn't that also the case on Windows?

Probably. I have never tested this.

> Setting locales affects a large variety of libc functions and third
> party libraries (e.g. PCRE via us setting "use UTF-8" under locale).

Yes, but as I mentioned in the commit message, setting locales in MINGW
programs is murky at best. There is the idea of gettext, and there is the
idea of Windows, and they are likely a bit different from one another.

> > Signed-off-by: Karsten Blees <blees@dcon.de>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  gettext.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/gettext.c b/gettext.c
> > index d4021d690c..3f2aca5c3b 100644
> > --- a/gettext.c
> > +++ b/gettext.c
> > @@ -12,7 +12,25 @@
> >  #ifndef NO_GETTEXT
> >  #	include <locale.h>
> >  #	include <libintl.h>
> > -#	ifdef HAVE_LIBCHARSET_H
> > +#	ifdef GIT_WINDOWS_NATIVE
> > +
> > +static const char *locale_charset(void)
> > +{
> > +	const char *env =3D getenv("LC_ALL"), *dot;
> > +
> > +	if (!env || !*env)
> > +		env =3D getenv("LC_CTYPE");
> > +	if (!env || !*env)
> > +		env =3D getenv("LANG");
> > +
> > +	if (!env)
> > +		return "UTF-8";
> > +
> > +	dot =3D strchr(env, '.');
> > +	return !dot ? env : dot + 1;
> > +}
> > +
> > +#	elif defined HAVE_LIBCHARSET_H
> >  #		include <libcharset.h>
> >  #	else
> >  #		include <langinfo.h>
>
> I'll take it on faith that this is what the locale_charset() should look
> like.

I copy/edited that code from a later code block in `is_utf8_locale()` that
is also conditional (under `NO_GETTEXT`, hence no attempt to refactor it,
as that would make the code even less readable).

So I am fairly confident that the code is _correct_.

Whether it is elegant, I cannot really say. It strikes me as ugly, in
those indented `#ifdef..#endif` guards, yet I did not find a way to make
it less ugly.

> I wonder if it wouldn't be better to always compile this function, and
> just have init_gettext_charset() switch between the two.

Based on what? If the switch is a compile time switch, then this function
must be under the same compile time guard, otherwise GCC will complain
about an unused static function.

> We've moved more towards that sort of thing (e.g. with pthreads). I.e.
> prefer redundant compilation to ifdefing platform-only code (which then
> only gets compiled there). See "HAVE_THREADS" in the code.

How does that even avoid complaints by GCC about dead code.

> It looks to me that with this patch the HAVE_LIBCHARSET_H docs in
> "Makefile" become wrong. Shouldn't those be updated too?

That comment says:

# Define HAVE_LIBCHARSET_H if you haven't set NO_GETTEXT and you can't
# trust the langinfo.h's nl_langinfo(CODESET) function to return the
# current character set. [...]

I think it still applies.

> We also still pass -DHAVE_LIBCHARSET_H to every file we compile, only to
> never use it under GIT_WINDOWS_NATIVE, but perhaps fixing that isn't
> possible with GIT_WINDOWS_NATIVE being a macro, and perhaps I've again
> gotten the "native" v.s. "mingw" etc. relationship wrong in my head and
> the HAVE_LIBCHARSET_H docs are fine.

MinGW is a really old, outdated thing. These days, mingw-w64 is the rage
(it even supports building 64-bit binaries, would you believe that?
</sarcasm>). And neither is "native", strictly, although it is as native
as you can get with GCC.

And as you say, the macro thing makes it hard/impossible to decide in
Makefile whether we want to pass HAVE_LIBCHARSET_H or not. So we should do
it independently of whether we're on Windows or not.

> It just seems wrong that we have both the configure script &
> config.mak.uname look for / declare that we have libcharset.h, only to
> at this late point not use libcharset.h at all. Couldn't we just know if
> GIT_WINDOWS_NATIVE will be true earlier & move that check up, so it &
> HAVE_LIBCHARSET_H can be mutually exclusive (with accompanying #error if
> we have both)?

I don't think that this is wrong, as it is correct in pretty much all
circumstances except Git for Windows. And even in Git for Windows it is
correct: we do have a `libcharset.h`. We just can't use it to determine
the current locale.

Ciao,
Dscho

--8323328-649694082-1562590677=:44--
