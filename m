Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7F2820D13
	for <e@80x24.org>; Fri,  2 Jun 2017 16:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbdFBQLN (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 12:11:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:49359 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750955AbdFBQLM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 12:11:12 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MCtut-1d8Kig0uY7-009kru; Fri, 02
 Jun 2017 18:10:57 +0200
Date:   Fri, 2 Jun 2017 18:10:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 0/8] PCRE v2, PCRE v1 JIT, log -P & fixes
In-Reply-To: <xmqqbmq74773.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1706021803460.171564@virtualbox>
References: <20170601182056.31142-1-avarab@gmail.com> <xmqqbmq74773.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1162236140-1496419857=:171564"
X-Provags-ID: V03:K0:TsoGgBkQjYw/Z9znHre8PIR+qmHvkGQF2gRurzBU1c0zZlICivE
 p48rf2KwNQmvSl6PZOO0yfZhiDOZU+tQPTSzjwJw9aJhgyEJqiqY58KUXd/7aeHHzYdvHv7
 OLQ0tEMsxkjYekyiPbeOlz4quNRARa24CidLawlWYE/7dnHq7rqqFi2mL/ve2SjbAhCNBRM
 ZEZ3DOzLCF3xNm6D74YoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K2JRQ73Ff2A=:uTK9Q6vi3oToTLs1YiapJG
 APujMGZ45NogQejKcTZRnJbq4i1JibbGq0NIbCW94yBQfKtq0omQ5N/RBwMUOenT2EiH6a8nf
 H7UqNGbyvlbZ13kavCKua+XBsuOY3GCDyeAxMPbJWCc1d/GmStUCsjpGAceVNdJXz9x18r6CT
 xiVoIVeRUT3KIh2gTMB0AVbaZhHgYzToOp8gDdZ4QnUEcNl8KV7VU3cNTTh7vtAf5sIp4vpPc
 XJ5Ojy9SxAPoTje9+Htp795Ic05J2Mz/JqseiQ72scbHBiLwrCAX5z1VVu1zU/mjQPX8UGNla
 /P52HmDgH4tT6PKk5NIAmqPktJJvtGgNmZzw6+nJ1vVIsJszjm/DTclNXfJPjwGGvNNniFOkF
 SWH/x2XjTwvQ7WkCKTk1jGdYRQGQ425OGX/h9/QnyeEg7uKh+xQOHm69jx7D+EZGjriuNjLsH
 vrpramv33kRAST2t16xlcH559y1czb498yL48CvtVDftWE8H1reLNXfRgKjrBL7/+0VWTUL4n
 oIUjFVXy7ogpdxfAP/gqo+cAOu4x/6rz8ze66E5FHFOq9kR5YUKr+tJ+VedFEnDDGTKlYUvOj
 +SyLXeR8QyBB81nddhxZ77tkpUDF0zSdHjRTQt1v5UW8YhgyfMS/+ajx72K+NQROXIF0ic/+I
 lC6h25gi3Q4RVwMhLEkgGZgF9TUZKAZKMt/FZwnRKOzXYge/DOAvOpZZ9UW19RkGke751Jb53
 sA5NpjobfrX/o2hFELrx40Lp4QCUiPBickbUm6btVMaZLsRw425N555emk44wANKdCP/P6lb3
 jJRso7R
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1162236140-1496419857=:171564
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 2 Jun 2017, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>=20
> > See <20170525200528.22037-1-avarab@gmail.com> for v3
> > (https://public-inbox.org/git/20170525200528.22037-1-avarab@gmail.com/)=
=2E
> >
> > This is on top of "[PATCH v4 00/31] Easy to review grep & pre-PCRE
> > changes".
> >
> > Changes:
> >
> > =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (8):
> >   grep: don't redundantly compile throwaway patterns under threading
> >   grep: skip pthreads overhead when using one thread
> >   log: add -P as a synonym for --perl-regexp
> >   grep: add support for the PCRE v1 JIT API
> >   grep: un-break building with PCRE < 8.32
> >   grep: un-break building with PCRE < 8.20
> >
> > No changes.
> >
> >   grep: un-break building with PCRE >=3D 8.32 without --enable-jit
> >
> > NEW: It turns out that a PCRE version that supports JIT, but is built
> > without JIT support will fail at link time since there's no
> > pcre_jit_exec symbol.
> >
> > It also turns out (contrary to what I claimed on list before, my
> > mistake) that there's no way to detect this through some macro. All
> > the pcre include files are the same with/without --enable-jit, only
> > the object file differs.
> >
> > So there's now a NO_LIBPCRE1_JIT flag to the Makefile, which is off by
> > default, but turned on on MinGW. I have not tested that
> > config.mak.uname change, but everything else I could test on Linux.
> >
> > The reason for why it's NO_LIBPCRE1_JIT not USE_LIBPCRE1_JIT is that
> > in practice pretty much everyone who builds pcre builds it with JIT
> > (I've looked through various Linux/BSD distro build files), it's MinGW
> > that's the exception here. Given the performance gain it makes sense
> > to make it the default.
> >
> >   grep: add support for PCRE v2
> >
> > Almost no changes, just:
> >
> >  * A trivial change to stop redundantly assigning to pcre2_jit_on,
> >    mistakenly left over from an earlier version.
> >
> >  * Updated commit message / perf numbers for the extra patches in the
> >    series both here and in v3.
>=20
> Nicely summarised and matches what I received; thanks, will replace.

For the record: I spent the entire development time I had today on trying
to get PCRE2 to build and to figure out which PCRE2 tests fail and why.

I hoped to get to the bottom why the JIT is disabled in PCRE1, but ran out
of time.

I seem to have gotten PCRE2 to build and figured out why the tests failed
(spoiler: all of the failures were bogus and no indication of an
incorrectly-built PCRE2).

I barely had time to build `pu` (forcing PCRE2) and to run the test
scripts whose file names contain the substring "grep". Seems to work so
far, but this is by no means comprehensive testing; it is more like hushed
and rushed testing on a Friday night when I should have stopped working 10
minutes ago.

Will continue with testing Git for Windows using PCRE2 next week and keep
you posted,
Dscho
--8323329-1162236140-1496419857=:171564--
