Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCCC6207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 22:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1952409AbdDYWW3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 18:22:29 -0400
Received: from mout.gmx.net ([212.227.17.22]:51237 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952387AbdDYWWU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 18:22:20 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzpWx-1byAcu2DFj-0154KL; Wed, 26
 Apr 2017 00:22:15 +0200
Date:   Wed, 26 Apr 2017 00:22:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5 0/8] Introduce timestamp_t for timestamps
In-Reply-To: <7a2271ff-1386-18a6-5f6d-7eb13dc92509@web.de>
Message-ID: <alpine.DEB.2.20.1704260005310.3480@virtualbox>
References: <cover.1492771484.git.johannes.schindelin@gmx.de> <cover.1493042239.git.johannes.schindelin@gmx.de> <7a2271ff-1386-18a6-5f6d-7eb13dc92509@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-795258594-1493158935=:3480"
X-Provags-ID: V03:K0:1YxGgm8hs3z+EBnCeXU+SQ48vKmtKtK4fWkPU5JXnTqsNjGpPcU
 4cBejoOHFtF2zMzXATiJJZ2HJyP21i3ubIax6HiTITD+8iJ7bekPQbcOYbTx/2K3Uf/DC4s
 nrk3jAn7RNy83BHYrnhR0aKYkeOpYQZLeVSZMb2N2lPTwFynSE9NLg0csFDRwDxULYAjy04
 uK1WBiG95rG7uehKF+K+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4xuNO65seRM=:aYIg2RVNeG+ZbzjrfbC10J
 UZbR6iTZqnR69nm704StRDng4ruhCBQ0qJYVo4eMnKgwsiu2UYXMYcQv8P75tmMcCY5rRQK0V
 PAVU6yHO1wuzVNhIW+I/52uk1LdJuV+M3v03MFnOhSLBANs9yfzwxtbtrp+JqVh73ZL66ouy/
 cAQ2Q/qVb5B8EQRJDpDhrIUs16n1bziBJ7tuq0Kyi9Ve/HhubYF25LIJKvaPhoDfAQ4t6Uz6U
 J5XEroNo7D3D+kLXogS97UfXVkxFJAnInRZ70FWYF1g3jtZPU3XyWfp9PjYdYUNHrFgFCT6oI
 5quFUQl5J2VeJKzSo2jZCW8hiucY+FI7LbAw1ndO1eXDrA4/Q1qotaa6oiCS37tgwRpsohnw8
 QeKUyhLJenxj0IZvAiVSGRX/qnRMG63lxXgvMfqNhVXUeG7eHWTvw+43WRKRZbPTQSEKF366v
 +yyOdPr57APMWpk8k4tC+CcggMTn8LdL8bcpF3EdmiurA/R1568DUDijrDVkyrZpneO08Gx37
 19HtYcey6ZJfmz5mhpyDMZnTzJN2u6cFkAlYaTY9UPBtq1mBViS9ZT+69VKinKGMyb1u17pks
 f2yVqtNtuz3P8IjxOiGjVifZ9ssfZ2RTW9DR5kny7mBGGmFNmWMsaQsez7eMJRjaR9JfHJxID
 c6cCndbXlOZcjqJI207Edg28/SIBDBoU1amLfVKuj8PG37tLOxMDE3/4gIe8pfE/ze7WRvvJx
 dJcTGYfWOPmCI++/9vB1pNvXU2L/zb+vgum3+30gOHN/GEEcJ0mI5tZ02+edJumbQ5WN+jrsd
 aaK4YW0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-795258594-1493158935=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Tue, 25 Apr 2017, Ren=C3=A9 Scharfe wrote:

> Am 24.04.2017 um 15:57 schrieb Johannes Schindelin:
> > Git v2.9.2 was released in a hurry to accomodate for platforms like
> > Windows, where the `unsigned long` data type is 32-bit even for 64-bit
> > setups.
> >=20
> > The quick fix was to simply disable all the testing with "absurd"
> > future dates.
> >=20
> > However, we can do much better than that, as we already make use of
> > 64-bit data types internally. There is no good reason why we should
> > not use the same for timestamps. Hence, let's use uintmax_t for
> > timestamps.
> >=20
> > Note: while the `time_t` data type exists and is meant to be used for
> > timestamps, on 32-bit Linux it is *still* 32-bit. An earlier iteration
> > used `time_t` for that reason, but it came with a few serious
> > downsides: as `time_t` can be signed (and indeed, on Windows it is an
> > int64_t), Git's expectation that 0 is the minimal value does no longer
> > hold true, introducing its own set of interesting challenges. Besides,
> > if we *can* handle far in the future timestamps (except for formatting
> > them using the system libraries), it is more consistent to do so.
>=20
> time_t is signed on Linux and BSDs as well.

s/is/happens to be/.

The point is: we must not rely on time_t to be signed just because it
*happens* to be the case on the setups to which we have access. We want
Git to be portable, not only "portable to our own setups".

> Using an unsigned type gives us the ability to represent times beyond
> the 292 billion years in the future that int64_t would give us, but
> prevents recording events that occurred before the Epoch.  That doesn't
> sound like a good deal to me -- storing historical works (e.g. law
> texts) with real time stamps is probably more interesting than fixing
> the year 292277026596 problem within this decade.

It sounds like a good deal to me, if the alternative is that *I* have to
patch Git's source code to support signed timestamps, when *I* am probably
the only one in this entire thread who does not even want them.

So could y'all please just stop talking about signed timestamps to me? I
feel that they are really, really start to irritate the hell out of me.

> > The upside of using `uintmax_t` for timestamps is that we do a much
> > better job to support far in the future timestamps across all
> > platforms, including 32-bit ones. The downside is that those platforms
> > that use a 32-bit `time_t` will barf when parsing or formatting those
> > timestamps.
>=20
> IIUC this series has two aims: solving the year 2038 problem on 32-bit
> Linux by replacing time_t (int32_t), and solving the year 2106 problem
> on Windows by replacing unsigned long (uint32_t), right?

No. The series has one aim: to stop using `unsigned long` (which is
ill-defined to begin with) for timestamps.

> The latter one sounds more interesting, because 32-bit platforms would
> still be unable to fully use bigger time values as you wrote above.
>=20
> Can we leave time_t alone and just do the part where you replace
> unsigned long with timestamp_t defined as uint64_t?  That should already
> help on Windows, correct?  When/if timestamp_t is later changed to a
> signed type then we could easily convert the time_t cases to timestamp_t
> as well, or the other way around.

This patch series leaves time_t alone already, so your wish has been
fulfilled preemptively.

> > This iteration makes the date_overflows() check more stringent again.
> >=20
> > It is arguably a bug to paper over too-large author/committer dates and
> > to replace them with Jan 1 1970 without even telling the user that we d=
o
> > that, but this is the behavior that t4212 verifies, so I reinstated tha=
t
> > behavior. The change in behavior was missed because of the missing
> > unsigned_add_overflows() test.
>=20
> I can't think of many ways to get future time stamps (broken clock,
> broken CMOS battery, bit rot, time travel), so I wouldn't expect a
> change towards better error reporting to affect a lot of users.  (Not
> necessarily as part of this series, of course.)

If you want to suggest that we should stop verifying overflows when a
complex reasoning can prove that the overflow is not happening in a
billion years, I disagree. Not only is it unnecessarily time-consuming to
ask readers to perform the complex reasoning, and not only is there enough
room for bugs to hide in plain sight (because of the complexity), it also
makes the same code harder to reuse in other software where a different
timestamp data type was chosen (or inherited from previous Git versions).

I'd much rather have easy-to-reason code that does not cause head
scratching (like the "why do we ignore a too large timestamp?" triggering
`if (date_overflows(date)) date =3D 0;`) than pretending to be smart and
clever and make everybody else feel stupid by forcing them through hoops
of thinking bubbles until they also reached the conclusion that this
actually won't happen. Unless there is a bug in the code.

> >   Documentation/technical/api-parse-options.txt |   8 +-
> >   archive-tar.c                                 |   5 +-
> >   archive-zip.c                                 |  12 ++-
> >   archive.h                                     |   2 +-
> >   builtin/am.c                                  |   4 +-
> >   builtin/blame.c                               |  14 ++--
> >   builtin/fsck.c                                |   6 +-
> >   builtin/gc.c                                  |   2 +-
> >   builtin/log.c                                 |   4 +-
> >   builtin/merge-base.c                          |   2 +-
> >   builtin/name-rev.c                            |   6 +-
> >   builtin/pack-objects.c                        |   4 +-
> >   builtin/prune.c                               |   4 +-
> >   builtin/receive-pack.c                        |  14 ++--
> >   builtin/reflog.c                              |  24 +++---
> >   builtin/rev-list.c                            |   2 +-
> >   builtin/rev-parse.c                           |   2 +-
> >   builtin/show-branch.c                         |   4 +-
> >   builtin/worktree.c                            |   4 +-
> >   bundle.c                                      |   4 +-
> >   cache.h                                       |  14 ++--
> >   commit.c                                      |  18 ++--
> >   commit.h                                      |   2 +-
> >   config.c                                      |   2 +-
> >   credential-cache--daemon.c                    |  12 +--
> >   date.c                                        | 113
> >   ++++++++++++++------------
> >   fetch-pack.c                                  |   8 +-
> >   fsck.c                                        |   2 +-
> >   git-compat-util.h                             |   9 ++
> >   http-backend.c                                |   4 +-
> >   parse-options-cb.c                            |   4 +-
> >   pretty.c                                      |   4 +-
> >   reachable.c                                   |   9 +-
> >   reachable.h                                   |   4 +-
> >   ref-filter.c                                  |  22 ++---
> >   reflog-walk.c                                 |   8 +-
> >   refs.c                                        |  14 ++--
> >   refs.h                                        |   8 +-
> >   refs/files-backend.c                          |   8 +-
> >   revision.c                                    |   6 +-
> >   revision.h                                    |   4 +-
> >   sha1_name.c                                   |   6 +-
> >   t/helper/test-date.c                          |  18 ++--
> >   t/helper/test-parse-options.c                 |   4 +-
> >   t/helper/test-ref-store.c                     |   4 +-
> >   t/t0006-date.sh                               |   4 +-
> >   t/t5000-tar-tree.sh                           |   6 +-
> >   t/test-lib.sh                                 |   3 +
> >   tag.c                                         |   6 +-
> >   tag.h                                         |   2 +-
> >   upload-pack.c                                 |   8 +-
> >   vcs-svn/fast_export.c                         |   8 +-
> >   vcs-svn/fast_export.h                         |   4 +-
> >   vcs-svn/svndump.c                             |   2 +-
> >   wt-status.c                                   |   2 +-
> >   55 files changed, 260 insertions(+), 219 deletions(-)
>=20
> How did you find all the pieces of code that need to be touched?

Pain and suffering.

Seriosly, for v1 of this patch series, I went painstakingly through `git
grep -Ovi "unsigned long"`. I determined for every single use of `unsigned
long` whether it referred to a timestamp and changed it accordingly.

In subsequent iterations, I went the cheaper route of compiling with
DEVELOPER=3D1 on Windows and once I even went through replacing the 64-bit
libraries and compiler/linker in my Linux VM with 32-bit ones to imitate
the 32-bit Linux Travis coordinate (because I failed to get the Docker
setup to run in the VM). These build runs identified new callers of
functions whose signature I had to change to avoid `unsigned long` for
timestamps.

This was no fun.

> Is there a regex or something that can be used to spot new such places
> that sneak in, e.g. through in-flight merges?

No, a regex would only work if we already had converted all `unsigned
long` uses to semantically meaningful data types.

Ciao,
Dscho

P.S.: Please remove the quoted interdiff when there is no reason to keep
it around.
--8323329-795258594-1493158935=:3480--
