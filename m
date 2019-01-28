Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96CFF1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 16:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfA1QCe (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 11:02:34 -0500
Received: from mout.gmx.net ([212.227.15.15]:32809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730072AbfA1QCd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 11:02:33 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfEZG-1gYIGp3feU-00OqoR; Mon, 28
 Jan 2019 17:02:25 +0100
Date:   Mon, 28 Jan 2019 17:02:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 04/21] ci: inherit --jobs via MAKEFLAGS in
 run-build-and-tests
In-Reply-To: <20190125132545.GD6702@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1901281701030.41@tvgsbejvaqbjf.bet>
References: <pull.31.v3.git.gitgitgadget@gmail.com> <pull.31.v4.git.gitgitgadget@gmail.com> <83b92a87e7698cee1e2c44252b934ad436d75a90.1548254412.git.gitgitgadget@gmail.com> <xmqqtvhz54gz.fsf@gitster-ct.c.googlers.com> <20190125132545.GD6702@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-329022632-1548691345=:41"
X-Provags-ID: V03:K1:JD94fMlT3v6KVTe6s0w2f6qH+tA4rd5+G7ZAjzpCqKFGrloOLur
 PPr4EpMmYXS5lkFX3HDI579x1mtCs0jEg3kcE4Ya9AlMjmdu8PNEoBJAve6hSosZE+wsiNJ
 hPurzJDATcMUPFhhuuDawemePASYlIuil/A/se3i3iq54kcMOFHggOm6QXxgclzXD13UUUL
 4wYH1H1tckucU/UciJIJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xt3AgZwgZXg=:Nh7vZ2h6B0vpklZ/fvD/Z0
 0Bk6CK51b6gRIBGCSpko9VLXLgeMMyJItzSkp5YuZ/hLg9s+wbOpYly4lMffJRAl1Pq0tpSnV
 RXf2RrvFpH79dZRYrXknXHgrl3Z/VG4Cp2nRwGHAqoTInTT4Nf1S1hlknyPsJ5X/TMb1SwuLA
 4MT0mdq/VaybUKNC4LDsc3oYlhhvT0JrbcNLZCFzdVVOaxCZyjZCj6zK3dV505NIwL9QqGl5g
 9sTvjY8mKd9cc0RvSEZbcIUMw+h1fP2Zf9rOU8DpSvJndmj6NVbgrelMIr4c8B9s2JqkZ4GwS
 TnWtYtghw02+XyuKk/3NdhuOhYCt2quRauTe+tosiuMF/YzDig1o8nhAj+MhBgoy9f8OT/FFM
 e8HL4XfWcP9WBplnkUi2tQUWdkkmV0nuP1uT4aj61FsbN78x10nD3qpwWFFl7d5mKexpBGCTa
 NBKsyJyGfl30LL9vCNNH7uVEoux5aO1v/nqk0OO8q+N1+IdmEypTmTzR07Ml2qgkbiaiyUOGV
 33F6hG8/KciX6wlOpQiDTNJqmKLUm4JOFYROEBPomXVFzRW3sMU3VM53VA44cyNZOJRhbOaMq
 k9CW5KdXw/sPwPZFYPQB4Z6Kc5CfzZ19SKv59Z9M4ZhHudJsGDmEB5HQd70Tn3fzEYlqop+kM
 x4nS6j4afMMzCWLswLrwx/g6gJKGTBlmUCvbuVugyKV24/cCetI14gxN8UUybjAimy/DV0kjd
 mcOdtIHk0M/c77GLVlvU39qt4b9O1hIB3er4QLJ/1otGqVOa9CKDdiXKbBlm4GAA68UrZFGWh
 XYhemw568M6K8gF8w1bwiJeiByceUvN63Dl4gjKlDRj0m6ax0lZWyTlULgTDN8U/sLbvNcoS7
 aUf6XExdKO/GAIvK83t6+MwYg+zU+/MMzcpnmCgF9r/x1IHdviz02qeHAjtyh91N6t5g/LJ/w
 NnYLkk2eXTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-329022632-1548691345=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Fri, 25 Jan 2019, SZEDER Gábor wrote:

> On Wed, Jan 23, 2019 at 02:22:10PM -0800, Junio C Hamano wrote:
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> > 
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > Let's not decide in the generic ci/ script how many jobs to run in
> > > parallel; it is easy enough to hand that information down via the
> > > `MAKEFLAGS`.
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  ci/run-build-and-tests.sh | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > > index db342bb6a8..80d72d120f 100755
> > > --- a/ci/run-build-and-tests.sh
> > > +++ b/ci/run-build-and-tests.sh
> > > @@ -7,7 +7,7 @@
> > >  
> > >  ln -s "$cache_dir/.prove" t/.prove
> > >  
> > > -make --jobs=2
> > > +make
> > >  make --quiet test
> > >  if test "$jobname" = "linux-gcc"
> > >  then
> > 
> > As there is no assignment to MAKEFLAGS in this patch, is it intended
> > for this step to change behaviour (possibly with the intention to
> > add "default 2 jobs at least under travis" back later in the
> > series)?  Not that it matters too much, but it is unnerving to see
> > that the proposed log message promising "it is easy enough" while
> > not actually doing so, without expressing an intention.
> 
> Furthermore, there are several other 'ci/run-<something>.sh' scripts
> that still run 'make -j N'.

Indeed. I removed those `--jobs=2` options from those.

Granted, I did not audit whether there were `make` calls that did not have
any `-j` option, but I think it would be safe to parallelize all of them
via `MAKEFLAGS`.

Ciao,
Dscho
--8323328-329022632-1548691345=:41--
