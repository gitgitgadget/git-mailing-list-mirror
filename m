Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_WORDY,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E87F1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 19:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeDTTgR (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 15:36:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:34027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750858AbeDTTgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 15:36:16 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lwoiq-1eL8rZ49Oa-016M2b; Fri, 20
 Apr 2018 21:36:10 +0200
Date:   Fri, 20 Apr 2018 21:35:53 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Dan Jacques <dnj@google.com>
Subject: Re: [PATCH 1/3] gettext: avoid initialization if the locale dir is
 not present
In-Reply-To: <87lgdidt30.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804202110550.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524211375.git.johannes.schindelin@gmx.de> <6be8678b7d6b4d9116ea4666a0b28ff4dd938690.1524211375.git.johannes.schindelin@gmx.de> <87o9iedwqn.fsf@evledraar.gmail.com> <CAN0heSpda1ZnFXgoCEgxGdBk-JYUSPAV0A=mQYMtOq7w8x+5=w@mail.gmail.com>
 <87lgdidt30.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2021930697-1524252970=:4241"
X-Provags-ID: V03:K1:ROh760Zc5ssa6V2OjYSkZ9BieMxEJUcVnDdhq7LojwV8/PDqX9b
 rakqXQWDQIwbFGVK20XHyslD9fmXDBaC/0lN4SoB940d+RsUhbk4WQ5KZvcXNxdZhnKlkRj
 uWAetgePh3SquZEVNxum9IdB8hGqyQ9HqUF7hh+BtPbQsNWehfDlszAc/7yCVVTqdkV91T3
 rAZUoIN7c6PEgp17Gw66Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZmM9jT8+K2w=:uaOTiqd0+L4Z8wm/hFqx4E
 ozyMaCAFjNz81QK3O4WsIdLcOKKeRHjigoXcDmU3IqbZuljll9KA+cxE7UDADSq7RSVxqoGbd
 +XMKP6Cz/1CjllN75pTFrSUv+lwNvn1WwKrs1sc0BjBiBlXUHIhVu1cJgKMKVaKjWcbaptZq/
 Q/c/FxqoH08QHRc9DKghE4QdPceIf/iulD+zt/T6jy8rQOVU6PqqZnWz8tIivEgVgltN+eBjw
 XrjO/wI73X/mNNTOr2u2oHD2UQVso/YEKy1oJeVT913SfpKrWu1sTRup4lYZvKKIVsj0KHaSJ
 1Culgrhzw/N1y1YWE3zQ1KoXy6mxQo/QGwH1Ir0SH5MIeECrm6hgpC5qVfm9i8HzcdFQXLuW1
 gd2U5ArNLQ4gVNNPy7z8Pnh4OiJYMnjGA4vBe/wWgxEm4NTexgG4hKgtn7xmBHYBoLrv71eaa
 SZQdz6cHo16hlKD6Q3Eq+kh6il1hD8W50hmWkQqiZu2w34ivh1FXpvV5THCAxVuN4ncrpZC9J
 jC418b4CTwEEq2iR+YOgiG3iof2TT4EjGE0vcHhgZNAhj5GzxcuK5Q2U+7p8/IgU+kpiQCwlA
 838slYZU2r5/id+w/tT9I+XCzMffqxjZ4j8+7oKkAD3xZKebVi2i9JTqijFStiaFz6wvkVU5h
 3XTtNjxgYLvYGYSSuZ9Rjc0ldUPG+L7okpId7LHkyG8JpGCWvQVWQU5sfK5CJbUi04puwckV6
 HElv4e/qzEsULL1mbCq29Kol0hGqzFPu4DLEo8YnLP9xWi0viFaMJUyON0ym0SedOiZFfsgLe
 Kaa/5CKMIcoz40fRaU7PjZ340NPTV6WROJA9WMuwM7l61oaisw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2021930697-1524252970=:4241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Fri, 20 Apr 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Apr 20 2018, Martin =C3=85gren wrote:
>=20
> > On 20 April 2018 at 11:59, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> >>
> >> On Fri, Apr 20 2018, Johannes Schindelin wrote:
> >>
> >>> The runtime of a simple `git.exe version` call on Windows is currentl=
y
> >>> dominated by the gettext setup, adding a whopping ~150ms to the ~210m=
s
> >>> total.
> >>>
> >>> Given that this cost is added to each and every git.exe invocation go=
es
> >>> through common-main's invocation of git_setup_gettext(), and given th=
at
> >>> scripts have to call git.exe dozens, if not hundreds, of times, this =
is
> >>> a substantial performance penalty.
> >>>
> >>> This is particularly pointless when considering that Git for Windows
> >>> ships without localization (to keep the installer's size to a bearabl=
e
> >>> ~34MB): all that time setting up gettext is for naught.
> >>>
> >>> So let's be smart about it and skip setting up gettext if the locale
> >>> directory is not even present.
> >
> >> If you don't ship git for windows with gettext or a podir, then compil=
e
> >> with NO_GETTEXT, then we won't even compile this function you're
> >> patching here. See line 30 and beyond of gettext.h.
> >>
> >> Are you instead compiling git for windows with gettext support with an
> >> optional add-on package for i18n, so then this podir conditional would
> >> pass?
> >>
> >> In any case, if this is actually the desired behavior I think it's wor=
th
> >> clearly explaining the interaction with NO_GETTEXT in the commit
> >> message, and if you *actually* don't want NO_GETTEXT I think it's usef=
ul
> >> to guard this with something like MAYBE_GETTEXT on top, so this code
> >> doesn't unintentionally hide installation errors on other
> >> platforms. I.e. something like:
> >>
> >>         int have_podir =3D is_directory(podir);
> >>         if (!have_podir)
> >> #ifdef MAYBE_GETTEXT
> >>                 return;
> >> #else
> >>                 BUG("Broken installation, can't find '%s'!", podir);
> >> #endif
> >
> > Is it fair to say that such a broken installation would function more o=
r
> > less well before and after Dscho's patch, and that your approach would
> > render such an installation quite useless?
>=20
> Yes my thown out there for the purposes of discussion suggestion may
> break things for Dscho, or not. I'm just saying that we should document
> *what* the use-case is.

I think you underestimate the scope of your willful breakage. It is not
just "break things for Dscho". It is breaking things for every single last
user of Git for Windows. If we ever do that, I will make sure to announce
that together with your name and your postal address on it.

> Because it's not just important to massage the code so it works now, but
> to document what the use-case is, so someone down the line who things
> "oh why are we doing that" has a clear answer.

Let's face it: if gettext would ever fail to work in case of a missing
podir, then it would fail for every installation using a locale for which
we just happen not to have any translation.

So we know that your patch would not only break things, but break things
totally without reason!

> > Do we have some other similar
> > cases where we go BUG("I could not find a resource. I could manage
> > fairly well without it, but you seemed to want it when you installed
> > me.")? I wonder what other well-respected software do if they can't fin=
d
> > their translations.
>=20
> E.g. my recent 1aca69c019 ("perl Git::LoadCPAN: emit better errors under
> NO_PERL_CPAN_FALLBACKS", 2018-03-03) does similar things, we *could*
> carry on in certain cases instead of dying there (or not, depending on
> the codepath).
>=20
> But in general, I don't think there's any reasonable use-cases for git
> needing to repair from a broken or semi-broken installation that aren't
> so specific that they can be explicitly declared, e.g. in this
> hypothetical MAYBE_GETTEXT case.

=C3=86var, you need to understand one thing, and you need to understand it
right now: the vast majority of Git users will not compile their Git. Not.
Ever. Really, I am not kidding. They use whatever built version they can
get most conveniently.

It is even more true on Windows, where it may be easier to build Git for
Windows now (what with all the work I put into the Git for Windows SDK),
but it is still an expensive endeavor.

And that is even assuming that every Git user is at liberty to build their
own software, which is completely untrue in a large chunk of our business.

So in order to give users who want localization what they want, without
burdening users who do not want localization, we use the exact same build
of Git for Windows for both, and the entire difference is that one comes
with the podir, and the other without.

Okay, I am lying, at the moment we do not even have anything end-user
facing that ships with the podir. But I distinctly want to leave the door
open for that.

And if you think that this is out of sheer laziness on my part, then I
hate to break it to you that this is for *very* good reasons: maintenance
cost.

It probably has not crossed your mind that the entire Git test suite fails
to pass if you run it on Git for Windows when built with NO_GETTEXT
defined?

Yep. It fails. With a honking

=09BUG: your vsnprintf is broken (returned -1)

And if you build it without NO_GETTEXT, it passes without that error.
Crazy, huh?

So unless you acquire quite a bit more experience with maintaining Git on
a common platform, I would like to implore you to stop trying to break it.
Thank you very much.

> Otherwise if it's not conditional, e.g. my git on Debian that won't ever
> need this is going to just subtly regress because the FS is broken or
> whatever, and I don't think we should have such code in git running
> unconditionally.

I have not the faintest idea what the heck you are talking about.

If the podir exists, then it is used. No change from before.

If the podir does not exist (which is unlikely in your setup, but there
you go, it might happen), the *only* difference you might notice is that
things get slightly faster (but probably not even noticably so, on your
platform). That is literally the only difference you could possibly notice
with vs without my patch. Seriously.

> > I suppose the logic could be the other way round, i.e., with a flag
> > REALLY_REQUIRE_GETTEXT_AT_RUNTIME. But I also wonder if a user who does
> > not notice that the installation is broken without us screaming BUG in
> > their face, really minds the "brokenness" that much.
>=20
> Without the BUG(...) that user is going to spend time fiddling with his

Don't exclude half of humanity, for your own sake.

> i18n settings before finally realizing that his package is broken, much
> better to just emit an error so it's obvious that things are broken,
> rather than taking the fallback path.

And then you will also add code to output BUG BUG BUG when the actual
*language* subdirectory is missing?

You would *need* to do that, and you know this as well as I do, because
even if your Git installation is "broken" and does not bring its l18n
stuff, *another package will have it*, and therefore podir *exists*! And
therefore your suggested change would not only break Git for Windows, it
would also totally not do what you want it to do!

And even then, I totally, utterly hate to break it to you: even on Ubuntu,
it is quite, quite common to have the git package installed *without* the
language-pack-de-base or whatever you need for your locale.

The reason is the same as for Git for Windows: we want to save on space,
so you do not get localization files that you are not even interested in,
instead you get a leaner download.

And in this case -- even on Ubuntu -- your patch does not make sense, but
simply breaks things for no reason other than some well-intended but
horribly broken idea that you should force the user to have a
/usr/share/locale/ even if they may never even want it, and even if things
work very well without it, thankyouverymuch.

In short: I totally disagree with your reasoning to break things that work
very well, with a BUG() that is prone to confuse and scare end users no
less.

Ciao,
Dscho
--8323329-2021930697-1524252970=:4241--
