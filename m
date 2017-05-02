Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E5D1F790
	for <e@80x24.org>; Tue,  2 May 2017 16:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbdEBQFU (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:05:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:55519 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750884AbdEBQFT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:05:19 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHH6Z-1dJaeH3mdP-00E2Mu; Tue, 02
 May 2017 18:05:15 +0200
Date:   Tue, 2 May 2017 18:05:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
In-Reply-To: <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1705021756530.3480@virtualbox>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1705021406510.3480@virtualbox> <CACBZZX5M1Pnvw01wP8id75Ja9NJ3nwVfydsX6g0Ys_QD72r6dQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1481572953-1493740824=:3480"
Content-ID: <alpine.DEB.2.20.1705021803250.3480@virtualbox>
X-Provags-ID: V03:K0:EvlcnT/wCd5mYRcZP0sN+jH8BTbDGpgIou9PMIZ//ep1zBB24s6
 cmIMREMqefVBQ3VcFdFHr+YQfBJ1P2BfFJIHi/ag2tTVpKNUvCObgr/SGZ0daxUTNMtXLcL
 tgr8r2q885Mat1gytShjW7+lWYSSzZGViHbHE6d0SZcLwIrdHLyUxkUxR+Zl/Q+8crBeab6
 OfvazZre5pNgkHPDgjdvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GIwQFSaFf0c=:Ktm4pcSzgYMqmJJGWB/aCt
 ojfyI+3ehglm9+Va1wdxWSi4rFCx33Dzr5ixwybeL0uLPTzT9ICrsk5zMPu5VRMruIVhFFJ5d
 dtjZjyV1bYOLLa/9CWgINLI4jsKZo6DIhK8Qq4J+9bH+2RSxibQ5L6A+rnG2Z94oZI5JZ823w
 OA9b8LVMzC04BedTRqjAwjrE6DD/yBOejBs15V8FWFpfNIlHqXoR/ukWo4AbtahUELmi8VEt3
 JA9dJU43PufFmozj3lFyj6SpnE1P/QJ+8tDER5lQpzjI/+3JnN6UtFKvLCBaKErkmzQlqXOdS
 TkXQP7NAxcJp9+OVbSOqclPNCCFAgm+NRetyQyMsTZ0KlMt4tbNdpr8GfNzxakLyo67yPBrN4
 BI0eeAoEFYKmCVy7Y0cUXlc7/c163bEEo3nWLc1vqb8r03fsewYT1Wv+XNRR6/mqdB6kKO8zX
 75lEqOaqWDoArW7L9t2ZD5GxpABBmy8zx7F1EARdjkUnMQryQFnWcBWPqrekLLvGaUv/TqflV
 J6zQSdGqrOAETYG6Dy0xWZwiGUfRCYCS4wlnU2jiy0STfq87NeL8Rg5uhie0zQQK0yXjlt75U
 D/XydJ1In+F7ZjA0unpjV8Q/YE1Ia5Wr9+fNE06e8npf2nS6CD3oPfVnin92AnlbA9tIVKwav
 EgZjq97fI3Oyu7XIHFGwfaqQ26O6OdvrmulTRILCmpE9f/FEa6hDrbApXvBBZw89gJ7zOx+cI
 r2n5U2MN1UnERfRDaiN3/CvslyUCOpADz3v9XZhwaVwRybMvABBdKP5fM54PHD1Pb6rYZQ7fh
 SxBm25W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1481572953-1493740824=:3480
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1705021803251.3480@virtualbox>

Hi =C3=86var,

On Tue, 2 May 2017, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, May 2, 2017 at 2:09 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Sun, 30 Apr 2017, Junio C Hamano wrote:
> >
> >> * ab/grep-pcre-v2 (2017-04-25) 20 commits
> >>  - SQUASH???
> >>  - Makefile & configure: make PCRE v2 the default PCRE implementation
> >>  - grep: remove support for concurrent use of both PCRE v1 & v2
> >>  - grep: add support for PCRE v2
> >>  - grep: add support for the PCRE v1 JIT API
> >>  - perf: add a performance comparison test of grep -E and -P
> >>  - grep: change the internal PCRE code & header names to be PCRE1
> >>  - grep: change the internal PCRE macro names to be PCRE1
> >>  - test-lib: rename the LIBPCRE prerequisite to PCRE
> >>  - grep: make grep.patternType=3D[pcre|pcre1] a synonym for "perl"
> >>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
> >>  - log: add -P as a synonym for --perl-regexp
> >>  - log: add exhaustive tests for pattern style options & config
> >>  - grep: add a test for backreferences in PCRE patterns
> >>  - Makefile & configure: reword outdated comment about PCRE
> >>  - grep: remove redundant `regflags &=3D ~REG_EXTENDED` assignments
> >>  - grep: remove redundant regflags assignment under PCRE
> >>  - grep: submodule-related case statements should die if new fields ar=
e added
> >>  - grep: add tests for grep pattern types being passed to submodules
> >>  - grep: amend submodule recursion test in preparation for rx engine t=
esting
> >>
> >>  PCRE2, which has an API different from and incompatible with PCRE,
> >>  can now be chosen to support "grep -P -e '<pattern>'" and friends.
> >
> > FWIW for quite a couple of recent builds, `pu` fails on Windows with a
> > variation of this error:
> >
> >             CC blob.o
> >         In file included from revision.h:5:0,
> >                          from bisect.c:4:
> >         grep.h:16:19: fatal error: pcre2.h: No such file or directory
> >          #include <pcre2.h>
> >                            ^
> >         compilation terminated.
> >
> > Maybe this can be fixed before hitting `next`?
>=20
> This will be due to a combination of the build machine not having pcre
> v2 (but having v1) & my "Makefile & configure: make PCRE v2 the
> default PCRE implementation" patch, which makes v2 the default for
> USE_LIBPCRE=3DYesPlease.
>=20
> Is it easy to install v2 on these build machines? Alternatively that
> patch could be ejected out of pu, or you could USE_LIBPCRE1=3DYesPlease
> to use v1, but as explained in that commit I think it makes sense to
> make v2 the default.

Let me put it this way: Installing PCRE v1 in MSYS2 is as easy as

=09pacman -Sy mingw-w64-x86_64-pcre

To install PCRE v2, you would have to copy-edit
https://github.com/Alexpux/MINGW-packages/blob/master/mingw-w64-pcre/PKGBUI=
LD,
make sure that it builds by running it through

=09makepkg-mingw -s

possibly initializing a Git repository in the
mingw-w64-pcre/src/${_realname}-${pkgver}/ directory, patching the source
until it builds, committing the changes, adding them as patch files to the
same directory as the new PKGBUILD, adjusting the PKGBUILD file to list
the patch files with their checksums and to add the commands to apply
them.

Then (and this is a one time cost, fortunately) initializing two packages
on BinTray (which we use to serve the Pacman packages of Git for Windows),
then build and upload the packages.

In short, PCRE v2 would be slightly (ahem, ahem) more involved than PCRE
v1.

I cannot imagine that MSYS2 is the only environment with that issue.

Ciao,
Dscho
--8323329-1481572953-1493740824=:3480--
