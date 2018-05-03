Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1646D200B9
	for <e@80x24.org>; Thu,  3 May 2018 22:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeECWAh (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 18:00:37 -0400
Received: from mout.gmx.net ([212.227.17.21]:51619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750829AbeECWAh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 18:00:37 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MK0bZ-1fFBDk3IzF-001Pod; Fri, 04
 May 2018 00:00:29 +0200
Date:   Fri, 4 May 2018 00:00:29 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 03/18] branch-diff: first rudimentary implementation
In-Reply-To: <CAGZ79kZQ+mq1O_sL11jC4_Lt18nO6b_6pSPBahOqyZ+izrRm7w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805032352380.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de> <CAGZ79kYzZkdZKdR4hMK0V6D6=cm4damct01MGidGA0g-dtW+gQ@mail.gmail.com> <nycvar.QRO.7.76.6.1805032246040.77@tvgsbejvaqbjf.bet>
 <CAGZ79kZQ+mq1O_sL11jC4_Lt18nO6b_6pSPBahOqyZ+izrRm7w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1251477679-1525384831=:77"
X-Provags-ID: V03:K1:aMx+V0E2rnRZu78grvT2TNBedtjasq2dzPiftNP+SqtC7f4hwQw
 oXiL8bxVyAtpVIzJ4UV/lwpfibn6AOHXe4maOlQHxMSKvItSdGYKjygKGdLjz93NdyhY/WM
 LsQOAgdsfkjSaLeE+Y9fBxM1YNKKieIRU/uUGEGX4E01kIBApeAo/NOhL+7PWvKsXwfIXwe
 F5N+aHmEfpfNQDSIA6buA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ccpOmG2kOV8=:DlJRo3BEzUWnW/xrAPkr5E
 mCW4QC5DyteMxJfAr+fJwUXxWdvBVQ9o6nx60DW0ugP58WjsKwZkrbMEhaYVsOkTU/WqjA3rO
 ZH5rP71LwD6T5ERXwyTItqIMNeEJNNSaouj7mYCd7BWGwghM6pue26jFcqIHbWnKg8Lgdr3/S
 mthRnCT+SOgUJV1XdbvLMJlUsGw0991GfvuIz/ar/1pAQ4Z0IrLbwpgYKoV+cPgL+MOK80CE9
 ejs6c+TremZmLJ9Eu6/h1UG6Boj+jjaICV09ypolb0/fR5DYKYM/diQjWa7UOd9qIPZZR4+6Q
 Hq9QDpOI2l46dF+bUDcP+UZcN5ce42z5Vm7hUFcxEKLDMJpH6CFwHdghtVLxT+2rHGDKkROyK
 HYliGalVnw5d55lyrCEWJ0pkXtJcAiCre0aae4PQxJ1P/S2At738f3BzYldF4IOYObqvzSi1O
 ZXDvhLTylFOLyHuMVfw+6lsoLrbn6DDlNiJvx+ucbkm4ou2FC6hs694EHdqMngtcWbZcue3Ri
 P7b8T03yYHkcRSqgNmwQ+/FI0ie0i+O7bCtRKfrFkKLoMyeo0oD9XjweprDtAJ03EEiiZnivw
 CKKGbZXXnvsQ5eCx+xg9XFPDu5sCigns+6w/wFB38SZ0rp4LdYGSRcwDo2gSfFepDCLrUDefy
 QBeuiqid/xdSgPu+l4YSb6v3Jd8MesQhLC4XPGTFmG20Ho2QLJMqTkMg3N67pKjsAb6O5luE8
 C0UfTG0cNX4sjW08GUVpbAbeTYeAa4KHlna377GEJfgXp6Pwi3ng1sO6AWANFZslL9FT+dy89
 ijHlxeo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1251477679-1525384831=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Stefan,

On Thu, 3 May 2018, Stefan Beller wrote:

> >> In addition to that patch, we'd have to buffer commit messages and
> >> buffer multiple commits, as that only buffers a diff of a single
> >> commit.
> >
> > ... and make sure that the moved-code logic (which is currently the
> > only user of emitted_symbols, correct?) would never be called at the
> > same time as we generate the diff.
>=20
> The moved detection is all part of the flags of an emitted symbol.
>=20
> By design the emitted symbol has easy access to the raw line of the outpu=
t,
> which made it easy for the move detection to work on the lines. AFAICT th=
is
> is also desired here as lines are put into a hashmap for comparisons.
> (and having it colored differently would make finding the same line
> complex using hashmaps)
>=20
> I just entertain the thought of having move detection active in a
> branch-diff. That would be really cool actually.

There are two separate times when we generate a diff in branch-diff: the
first time in that `git log -p <range>` call for both ranges, and later,
when displaying the changes of old/new commits.

(There is actually a third time, when the cost is calculated, but those
diffs are not shown, only their line count is used.)

It would be relatively easy to use move detection in the diff between
old/new commits. But it would be harder to do that with the `git log -p`
diffs, as we only color-code them later, not at the time they are
generated.

In fact, =C3=86var mentioned that he was pretty happy about the fact that `=
git
branch-diff` accepts all kinds of diff options, when tbdiff emulated only
two of them. =C3=86var mentioned specifically the use of `--color-words`...

> >> The benefit would be no invocation of new processes, letting us do
> >> more in core. This would allow for tweaking revision walking
> >> internally, e.g. passing of options to this command such as rename
> >> detection factors, can be passed through easily without the need of
> >> translating it back to the command line.
> >
> > On the other hand, we can simply copy those options to the
> > command-line for `log`. Which might even be better, as e.g. `--format`
> > changes global state :-(
>=20
> ok.

I really appreciate the sanity check. It would benefit me on Windows if I
could avoid spawning... But I think in this case, it would save me 2*50ms,
which is not really worth doing the work for, so far.

> Thanks for your patience,

And thank you for yours! It *is* important to challenge beliefs during
code review, so that the choices are made for the right reasons.

Thanks,
Dscho
--8323328-1251477679-1525384831=:77--
