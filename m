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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5B51F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 08:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfJBIRZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 04:17:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:54761 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfJBIRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 04:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570004227;
        bh=P1BCKe0nKWcNeEwbQsPdCwwdRyjqUhH326MhbaQgkuc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JAKLD9Ir7ioc5l0Fo0cbxJMTVnt/ro5miQgdCghaHjYUYijXXaLvE0CKwPuoMXp17
         EvWdpjV89t5DMChnC+Rzc+xwLUBish0vfscQIhCwEMQfE4MGSsSBoMCT1c4zvHFeQu
         yqEuAFeiHJB4YyJfschOwK6Zc111DeKjos8JKjho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26vL-1iI2f42Na5-002Z8k; Wed, 02
 Oct 2019 10:17:07 +0200
Date:   Wed, 2 Oct 2019 10:16:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 4/5] rebase: fill `squash_onto' in get_replay_opts()
In-Reply-To: <66fcd66b-fad2-e5a1-cdd8-fd7b37c4abbf@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910021011010.46@tvgsbejvaqbjf.bet>
References: <20190925201315.19722-1-alban.gruin@gmail.com> <20190925201315.19722-5-alban.gruin@gmail.com> <66fcd66b-fad2-e5a1-cdd8-fd7b37c4abbf@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-604431256-1570004229=:46"
X-Provags-ID: V03:K1:Hw24bs1yy510HW7IWn7nwpEQnTl4yy7x3dKZf4b2dYoBF/luCJG
 5S+YEwMqMchH3zEpzDDWFvhuxCkFxo/2UUoRJF8uGIXM79SYgjKnWX8yCOmPyHrxpT4SdzH
 SL8U3ztg1XMfrfmIKyvCJq++GUWG6HzD7Qo9c9qIsaK9bDQkFyh/AXM1PXBegCsOieB92uU
 Mqk8g2U/p/H+r5U1sIukA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:84jIdVbT734=:apTyMWC27XvuvT4YWTGhcd
 /VPNicK7knuzw8E+eZrq+Enyq/oWVGNXnjDLyP0GXGGf7zfS447N7PmJS3G9/cjqKQr9jeige
 5La9KFePEQbLdGNIuNPPveWq+RMQX/SAjtJsmUuN3jX0JctUh/ei3D6X2pI2o6RN7hCjTCSVQ
 dNpvG3CE7wQg/dghcHHjgF+b8MP3QDNC1ZaKXkYva07opvtbX6uaAuskHxh3j4Ut5pl9SymYC
 CdrIZ1dwgER43GBverNASGQs6KyLAWSozdbHfPY065h0NqLfuhzGpuARC60f3+bh+YymSy5/M
 zrv7CFzReVRgzSwS5uRUx+oIlpu7TH2dhqc3FqyYOeEd32x7mc+YBG4YqqL/9zKnEZasy9r33
 n0zI9M/3V/QGA8OEUwTog+mLVjLfQ8XId6saLY0fXMxKJBRpPrLYGYBSg5iQcqDKGvcw7xtqi
 JPHKktyJYF5ZgwIBP6WUyXFtazBV/mDBC98AZSknroQpVQkDe2h7CrGy8FUOf30GcT3PsNAUp
 i7YOtrZo78NyzYIXYsPgZIuhfzTyM0f1c7qsvZozrUH+lyOXapP4b7CjDl63LaZ4Ev6eZtLm5
 zrVrG1EfjcYWqcQmZYbWGUIZLODKO1WtudE+oY+bJAUOpXqBc5uv2ax5aYkRVtHYAc5zXQBvU
 jdNXk98uvVdEKNERVaWUhXZcb4BU3bbdazAHwwdXFc4cdeEFwymDHc6hfzycdCOd3rMv7AloF
 kHbatnvNg5muWep1TICzG3CXxdrL974lvXdMB5ddl92GyB6cTkG17Va9O2TrRGFOip1p5zOeW
 Q9pCeFKk6jWGI9N+7BPeyMUG97suia0AtSEEe2V6mkPgUF2rVjyvbI1Mvmm1wqzvn4xTW9UPN
 Rg24kzFsWX6vxdwbm0t+sM8V/RUEZc3wMkI7pHFJ29kgkzgG4nzjySP867GVdeMPdbTDQapx5
 loGtX1pZGbAg5K84fvjI8/o2Mk3q0hYMrToLItcFCwQo6UXDOaesi6RUgXFKjhVtGmkjvxRCS
 SP+r/tbAsxPm21zMo4OwWO1nQW8OzIsB0ue9XFnLImAM5rgHmh12ZUUvtMwX5mjER8Yw4u1uY
 S0KPHSaq01S4NK1lRG+98ewGSeWYF/pFH+g6grkQvhwGXNJMyv9Tx+0aFVWZOngSrn+4dQk7u
 56VwTEiX/Vjon+FTm0b3gt5m8MCKljK0K1HIpUd432LdR0uIXcjIK1L2ReNrsxr/rC1SXMJ2c
 QETuXMKtUjLIVihhwsLzrnOW6gHWdocFoVM5mKQW7qBXfGxVkJJ7O/m5maSs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-604431256-1570004229=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 27 Sep 2019, Phillip Wood wrote:

> Hi Alban
>
> On 25/09/2019 21:13, Alban Gruin wrote:
> > get_replay_opts() did not fill `squash_onto' if possible, meaning that
>
> I'm not sure what you mean by 'if possible' here, I think the sentance m=
akes
> sense without that.
>
> > this field should be read from the disk by the sequencer through
> > read_populate_opts().  Without this, calling `pick_commits()' directly
> > will result in incorrect results with `rebase --root'.

I guess I would have an easier time reading the commit message if this
paragraph read like this:

	The `get_replay_opts()` function currently does not initialize
	the `squash_onto` field (which is used for the `--root` mode),
	only `read_populate_opts()` does.

	That would lead to incorrect results when calling
	`pick_commits()` without reading the options from disk first.

> >
> > Let=E2=80=99s change that.
>
> Good catch
>
> Best Wishes
>
> Phillip
>
> > Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> > ---
> >   builtin/rebase.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index e8319d5946..2097d41edc 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -117,6 +117,11 @@ static struct replay_opts get_replay_opts(const s=
truct
> > rebase_options *opts)
> >    if (opts->strategy_opts)
> >     parse_strategy_opts(&replay, opts->strategy_opts);
> >   +	if (opts->squash_onto) {

I guess it does not matter much, but shouldn't this be guarded against
the case where `replay.squash_onto` was already initialized? Like, `if
(opts->squash_onto && !replay.have_squash_onto)`?

Other than that, this patch makes sense to me.

Ciao,
Dscho

> > +		oidcpy(&replay.squash_onto, opts->squash_onto);
> > +		replay.have_squash_onto =3D 1;
> > +	}
> > +
> >   	return replay;
> >   }
> >
> >
>
>

--8323328-604431256-1570004229=:46--
