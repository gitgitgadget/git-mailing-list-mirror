Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0A4C07E95
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB137613D2
	for <git@archiver.kernel.org>; Sun,  4 Jul 2021 22:52:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhGDWz0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jul 2021 18:55:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:33945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhGDWz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jul 2021 18:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1625439168;
        bh=rGNeUC53MNyLbTRPWz2X9qzDv2riuqVmqdBXBw+dDFU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QbvmNTWAlmxGZOK88K8gok63+tGZolLWk9Hf2pzYdonSC7BHxm7XrrExwvTcO1OHN
         xFfncMUeUBUwIZR7N17v4ZG2aRypc3wcZlY0wilwvUgzBZqp80OVujNFHEsoBqCpO5
         S5Pqo0F1xe2s89L2EvEwz0R6X2NBWlS0hoOWwo2E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.249.152] ([89.1.213.17]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MUGiJ-1lZX9v1iFP-00RHuV; Mon, 05
 Jul 2021 00:52:48 +0200
Date:   Mon, 5 Jul 2021 00:52:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 5/7] artifacts-tar: respect NO_GETTEXT
In-Reply-To: <878s2m8ns9.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107050038520.8230@tvgsbejvaqbjf.bet>
References: <pull.878.git.1624461857.gitgitgadget@gmail.com> <pull.878.v2.git.1625347592.gitgitgadget@gmail.com> <c31d2e7f44a8b27210dbde9bc6938ce16a9e0c17.1625347592.git.gitgitgadget@gmail.com> <878s2m8ns9.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1394615223-1625439168=:8230"
X-Provags-ID: V03:K1:K3kkR9EV0G/6TSTos0CRUfTQXrQsJsjsThYMjDHdPxZdQHZ1bhk
 bmQdkhhu/Ie4J2HcDNH0QX83q/3AFGfwa8E5A8gx0t8IfOndLBA//m/HMloKTk8yr3349k4
 6Te1vRjnh0fyW/1C2gmPWe54ycgMo+TXucLnPPeK6Q6ahtzgme9sSkUwEy52CZ17XQWT2ON
 kmOmIALVZ/KGdqfINZqfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZEw2VErQ0Lg=:OcyoQaNbcgDiU6CJT0t0AW
 suqxiwm7p5m151361trk+84ULp5QdgXhv9lXiBvjluUyeCVrAxlU2QEv1ejTQ4CCIfzalEswE
 3TOjtvpw3BfLVN0WA16QN+N6KJFur0l/bwpCbisYBxltRX2/O8aTC3im6SBjWmw/SJyxeemqB
 eEurDUd/lvR+hV9gnxpWGsmGaVpvJCxHKKYKaeu08Wn3IrZHtvcuGIG2ygjhdUQsXCnw13FA0
 ycufYhk60Vvx9LFJI3gt0svEoHApFIMpsktjsokMbawGXfSJhKkjVeC2rBWKnng/uFiGfrNCJ
 pHuy0i2uCnUGM3m9GKpomd5OqHsSIJjra8WGzZXS0k0T/KJlMQXsEZj2kVWP457z7wkCihKgV
 zQ9FSkXup2A+uXy2LrKm7zrwt4fck3jHSraTSOhcvq9UhqOWk1AzWnhKwgm5r+UsH1ZNc3Mzq
 4KykunC/kUQg20kGz+OV4E1fOl0K3fUxa7FxUAuY6BjBHntDu9qpQStVziJs+Aw0F+kYUG3M6
 qu121174fctSwqJL+o/P9q6L7DCtlE6R39PxfA+BJmIo41D+zk6WH/iGAYXRkoc6AItTvOY7m
 sm3yRd3dqy60tpfXFpBpScou1MBJsmEryyfNSDQKrLuY1n6lKIYpTXOk14x0/h92T1awT6ra2
 Rn546iwkUa0MCekpeleClg70+h/zhGpCYiYGOEuYylN/BVp95QFVer/nhifJt5WpgThFicfhY
 2QlhufsxfC0rGq55f+N0xlUKVCNnUTDW1u+fOyyd48BfqI03xtzWpA2uopRzt8lKIVa9Qi0Xr
 /JkF8VytlwSwkWZgLjqFk2FDmrDRX80D/vd6KNI583VYa7l003LWnL/OxuMCBG+R0HhKbvT6c
 z4h4hW7SSX5S6K9+naLulh6lwmloelXTc6wDQfzmXVosnyjBfNHkUMyhEbPt3LvsEsYRgXQQI
 q6RM5GHE/9Q+R+hO1mz3rzgnGYmKM8cLER6d8LsgeCR2apVZbptzy1PUWWFp1ZrAj12OLoK28
 nrfyikfyOz3sv2KkdkXO1ORzdqhgJkzH9pAoNcN4k+Zf/LoN+yiovYNHGQS7+COiWFuh2ZYAx
 OpZDG4kDOwci47HG6kgpLmfBF+ZY5zlqKfeHjAYWPYelM25Ue3a2hPCyA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1394615223-1625439168=:8230
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Sun, 4 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Sat, Jul 03 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > We obviously do not want to bundle `.mo` files during `make
> > artifacts-tar NO_GETTEXT`, but that was the case.
>
> Should be:
>
>     make artifacts-tar NO_GETTEXT=3DYesPlease
>
> (Without the =3D<something> we try to find a "NO_GETTEXT" target)

Correct. Will fix.

> > To fix that, go a step beyond just fixing the symptom, and simply
> > define the lists of `.po` and `.mo` files as empty if `NO_GETTEXT` is
> > set.
>
> How about fixing the cause instead of the symptom...

Yes, from my point of view, I did that.

> > Helped-by: Matthias A=C3=9Fhauer <mha1993@live.de>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Makefile | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index c3565fc0f8f..04e852be015 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2675,10 +2675,13 @@ po/git.pot: $(GENERATED_H) FORCE
> >  .PHONY: pot
> >  pot: po/git.pot
> >
> > +ifdef NO_GETTEXT
> > +POFILES :=3D
> > +MOFILES :=3D
> > +else
> >  POFILES :=3D $(wildcard po/*.po)
> >  MOFILES :=3D $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo,=
$(POFILES))
> >
> > -ifndef NO_GETTEXT
> >  all:: $(MOFILES)
> >  endif
>
> ...i.e. this patch just seems like odd (ab)use of Makefile logic.
>
> Later on in the artifacts-tar rule we rely on our immediate dependency
> list in $^ to feed to "tar czf", and here we're going to set $(MOFILES)
> to an empty list, just to later interpolate that empty list into that
> list of dependencies.
>
> Wouldn't the mores straightforward thing to do be the diff I've got at
> the end here, perhaps with a preceding commit just for the split-up of
> the dependency list?
>
> This matches how we do things elsewhere, i.e. we don't ifdef e.g. this a=
way:
>
>     LIB_PERL :=3D $(wildcard perl/Git.pm perl/Git/*.pm perl/Git/*/*.pm p=
erl/Git/*/*/*.pm)
>     LIB_PERL_GEN :=3D $(patsubst perl/%.pm,perl/build/lib/%.pm,$(LIB_PER=
L))
>
> rather we keep the list as-is, and ifdef the actual addition of the
> dependency, e.g.:
>
>     ifndef NO_PERL
>     all:: $(LIB_PERL_GEN)
>     [...]
>     endif
>
> One reason we do it like this is because we *don't* want to forget what
> the MOFILES were, because you want e.g. "make clean" to clean them up
> (not that it matters in this case, we rm -rf po/build).

We don't need to be careful about cleaning files we did not generate in
the first place.

Your suggestion amounts to unnecessary work. If we asked for NO_GETTEXT,
why bother generating the list of `.po` files at all? (Rhetorical
question; The answer is "we don't need to".)

> Doesn't matter much here, but following this pattern leads to subtle
> "bugs", e.g. an outstanding issue in your 179227d6e21 (Optionally skip
> linking/copying the built-ins, 2020-09-21) (which I noted on-list in
> passing before, IIRC) where during a build we end up with stale
> built-ins from a previous build in the build directory, because we
> pruned the list during definition time, as opposed to adding an inverse
> "I should remove this then" rule.
>
> ("bug" because it doesn't have any actual effect I know of other than
> bothering me that I have e.g. a git-add in my build-dir still :)
>
> diff --git a/Makefile b/Makefile
> index c3565fc0f8f..7fb1d4b6caa 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3146,9 +3146,18 @@ ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
>  OTHER_PROGRAMS +=3D $(shell echo *.dll t/helper/*.dll)
>  endif
>
> -artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRA=
MS) \
> -		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
> -		$(MOFILES)
> +ARTIFACTS_TAR =3D
> +ARTIFACTS_TAR +=3D GIT-BUILD-OPTIONS
> +ARTIFACTS_TAR +=3D $(ALL_COMMANDS_TO_INSTALL)
> +ARTIFACTS_TAR +=3D $(SCRIPT_LIB)
> +ARTIFACTS_TAR +=3D $(OTHER_PROGRAMS)
> +ARTIFACTS_TAR +=3D $(TEST_PROGRAMS)
> +ARTIFACTS_TAR +=3D $(test_bindir_programs)
> +ifndef NO_GETTEXT
> +ARTIFACTS_TAR +=3D $(MOFILES)
> +endif
> +
> +artifacts-tar:: $(ARTIFACTS_TAR)

Apart from going out of its way to retain the construction of the `.po`
file list (which is totally pointless when operating under `NO_GETTEXT`),
this is also a sore to my eyes. So I won't do that.

Thank you for trying to assist in improving this patch series,
Dscho

>  	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
>  		SHELL_PATH=3D'$(SHELL_PATH_SQ)' PERL_PATH=3D'$(PERL_PATH_SQ)'
>  	test -n "$(ARTIFACTS_DIRECTORY)"
>
>

--8323328-1394615223-1625439168=:8230--
