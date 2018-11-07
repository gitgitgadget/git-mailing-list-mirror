Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526451F453
	for <e@80x24.org>; Wed,  7 Nov 2018 11:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeKGUia (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 15:38:30 -0500
Received: from mout.gmx.net ([212.227.15.15]:51515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeKGUia (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 15:38:30 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7HGA-1fYJ3M303q-00x3US; Wed, 07
 Nov 2018 12:08:26 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7HGA-1fYJ3M303q-00x3US; Wed, 07
 Nov 2018 12:08:26 +0100
Date:   Wed, 7 Nov 2018 12:08:24 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, lucas.demarchi@intel.com,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
In-Reply-To: <nycvar.QRO.7.76.6.1811071144140.39@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet>
References: <20181105200650.31177-1-avarab@gmail.com> <CAPig+cThS8959jW9+X7bJHy5RG9Uoj4=V8ahjf2zGetTNw03SA@mail.gmail.com> <87efbz6xys.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811061140560.45@tvgsbejvaqbjf.bet> <874lcu6vr4.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1811071130570.39@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1811071142100.39@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1811071144140.39@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1035248804-1541588906=:39"
X-Provags-ID: V03:K1:uFs+6/9omUeGwESmFja45jJB57EreBR1/Kaza4ih20RFT6OFn9H
 wWbP4OXRUECGMYZGkQeSRSMflbI82GU0AHcLYbLibjpHGL9t0laQONE0+NuH9CJPN9EABLT
 Jof/dx1r8fcIwCVBT5VNpYhD9KyuVKP49uoyytQXM7gDS7dh0639MdTkkey7dwNWwWoDbof
 JjQc7WqT6r34MwCxw4yLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xlF9nC3YMws=:jE1d4X568vTgienv/uDits
 nDU2+dWhJ1qVVRD0Qo3Kv8vFIU4m2pjWcYtnjPeGLEgBQPHmcwHMJXpNlQ48kACo+Wtw3zmio
 yNaUiGp95a8wLY+25EmmQJnvbYS1yARlVPxobNnEWpsJQRZOKpOCfhVejX21BvfJAxLkQUnQj
 WohTvU2roMsO85z4mpt7ZiJHYX7nKZTUveevQJO0YCmu6vF5sqVRDUUt7g42YzILLXFkSPrAl
 DZtZiad/PVDmSxV9snwq8UTaZFoDz5/DdtsxhDiryts1vfJiMECultP96zQPbsz1hVtZFTla1
 c659ENI0LoQQS/QmYgWH5eAXhuN78OMIc+XDwWicH3NM5PQh+tcQso3VmHGD7AYVxdDG0sF1V
 SgJFFHOHr6KBB++tUYgFeiJgGfbwv8SADshdvYSLQbi+WARowXjTihcvn2DC15eFDAMub/SOT
 npkQHf854rDwtg5YYxNXGDoenHqqt8i6mFc9cubuYRp4GeHZI+ndAtgJLYY36aRx05ixLXqSo
 UFwINI7+hd/KMabqacGR/JUY5h3DqaHQIlsOWddTXvt/sAcoO0U/vsYMQz3kIgTQ7t0wOh7gp
 U8DDqdSDnWPtT6/Mfs4p9D505YI74EiwI3qMcvPeP8Csmcbw3kuV9UEyi8rk+q8AH1YjnbF86
 oX5HMyClIwF2wYYbt6Q08wWRi1afuDyyTgxKkXhG5e4+9eM7rkbZhOJB/2OezhJ5wDhs00wRG
 543Tc+CdeBJD3wqBrAXtdUHBUJ7uOUqqJk4T+LbfdCSj3tq99GC8lfg8fvrDx95cac1AdgYwf
 HgMRJOVWvClS/alQhMeq01CfQurlqj6WVBIIPmLNwYyFrCFzC8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1035248804-1541588906=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Me again,

On Wed, 7 Nov 2018, Johannes Schindelin wrote:

> On Wed, 7 Nov 2018, Johannes Schindelin wrote:
> 
> > On Wed, 7 Nov 2018, Johannes Schindelin wrote:
> > 
> > > On Tue, 6 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> > > 
> > > > On Tue, Nov 06 2018, Johannes Schindelin wrote:
> > > > 
> > > > > On Mon, 5 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> > > > >
> > > > >> On Mon, Nov 05 2018, Eric Sunshine wrote:
> > > > >>
> > > > >> > On Mon, Nov 5, 2018 at 3:07 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> > > > >> >> Add a --no-patch option which shows which changes got removed, added
> > > > >> >> or moved etc., without showing the diff associated with them.
> > > > >> >
> > > > >> > This option existed in the very first version[1] of range-diff (then
> > > > >> > called branch-diff) implemented by Dscho, although it was called
> > > > >> > --no-patches (with an "es"), which it inherited from tbdiff. I think
> > > > >> > someone (possibly me) pointed out that --no-patch (sans "es") would be
> > > > >> > more consistent with existing Git options. I don't recall why Dscho
> > > > >> > removed the option during the re-rolls, but the explanation may be in
> > > > >> > that thread.
> > > > >>
> > > > >> Thanks for digging. Big thread, not going to re-read it now. I'd just
> > > > >> like to have this.
> > > > >
> > > > > In my hands, the well-documented `-s` option works (see e.g.
> > > > > https://git-scm.com/docs/git-diff#git-diff--s), although I have to admit
> > > > > that the `git-range-diff` manual does not talk about the diff-options.
> > > > >
> > > > > And for the record, for me, `git range-diff A...B --no-patch` *already*
> > > > > works.
> > > > 
> > > > Neither of those works for me without my patch. E.g.
> > > > 
> > > >     ./git-range-diff -s 711aaa392f...a5ba8f2101
> > > >     ./git-range-diff --no-patch 711aaa392f...a5ba8f2101
> > > >
> > > > This is on current next, 2.19.1.1182.g4ecb1133ce. What version are you
> > > > on?
> > > 
> > > I tried it with git version 2.19.0.windows.1.
> > > 
> > > To verify, I repeated this with `next` (git version
> > > 2.19.1.1215.g8438c0b2453a):
> > > 
> > > ./git range-diff -s 711aaa392f...a5ba8f2101
> > > fatal: unrecognized argument: --output-indicator-new=>
> > > error: could not parse log for 'a5ba8f2101..711aaa392f'
> > > 
> > > Which means that something broke rather dramatically between
> > > v2.19.0.windows.1 and 8438c0b2453a.
> > 
> > Nevermind, this was solved by passing `--exec-path=$PWD`. And *now* I can
> > reproduce your finding.
> 
> I've bisected this breakage down to 73a834e9e279 (range-diff: relieve
> callers of low-level configuration burden, 2018-07-22). Eric, that's one
> of your commits.

Okay, so I would really like to point you to this particular paragraph in
the manual page of `git range-diff` (just below
https://git-scm.com/docs/git-range-diff#git-range-diff-ltbasegtltrev1gtltrev2gt):

	`git range-diff` also accepts the regular diff options (see
	linkgit:git-diff[1]), most notably the `--color=[<when>]` and
	`--no-color` options. These options are used when generating the "diff
	between patches", i.e. to compare the author, commit message and diff of
	corresponding old/new commits. There is currently no means to tweak the
	diff options passed to `git log` when generating those patches.

So this was quite intentional, in particular with an eye on `--no-patch`.
Note also the commit message of c8c5e43ac3f9 (range-diff: also show the
diff between patches, 2018-08-13):

    Note also: while tbdiff accepts the `--no-patches` option to suppress
    these diffs between patches, we prefer the `-s` (or `--no-patch`)
    option that is automatically supported via our use of diff_opt_parse().

This was very, very intentional, as you can see, and it was pretty broken
by 73a834e. This here patch papers over that breakage, sadly I have too
much on my plate as it is, so I cannot wrap it up in a nice commit (nor
add a regression test, but you did that, nor investigate what else is
broken) and therefore I would be indebted if you could take this in your
custody:

diff --git a/range-diff.c b/range-diff.c
index 3dd2edda0176..014112ee401f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -433,7 +433,8 @@ int show_range_diff(const char *range1, const char *range2,
 		struct strbuf indent = STRBUF_INIT;
 
 		memcpy(&opts, diffopt, sizeof(opts));
-		opts.output_format = DIFF_FORMAT_PATCH;
+		if (!opts.output_format)
+			opts.output_format = DIFF_FORMAT_PATCH;
 		opts.flags.suppress_diff_headers = 1;
 		opts.flags.dual_color_diffed_diffs = dual_color;
 		opts.output_prefix = output_prefix_cb;

Ciao,
Dscho
--8323328-1035248804-1541588906=:39--
