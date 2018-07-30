Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E2E7208E9
	for <e@80x24.org>; Mon, 30 Jul 2018 16:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbeG3SE0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 14:04:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:40279 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbeG3SE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 14:04:26 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKt5A-1fkB2908em-0008U7; Mon, 30
 Jul 2018 18:28:33 +0200
Date:   Mon, 30 Jul 2018 18:28:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 05/21] range-diff: also show the diff between
 patches
In-Reply-To: <20180729214543.GD9955@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1807301826480.10478@tvgsbejvaqbjf.bet>
References: <pull.1.v3.git.gitgitgadget@gmail.com> <pull.1.v4.git.gitgitgadget@gmail.com> <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com> <20180729190359.GD2734@hank.intra.tgummerer.com> <CAPig+cTuD0+8etdMLu8FkFVxnXUM218taxU9in-fe3QXhDj5WQ@mail.gmail.com>
 <20180729214543.GD9955@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PJgFRS47iS6sOFqRfi4TmLS9a7XH66e7yBo4DAK151Ht7v7vNYZ
 /aOSLO3vCnDGA69RU9x9Qr0CpkAVu55nITNOJV1rZctXmxtsLK5s01fj4pOGu914uJQbzpd
 SoVk1IvgKY0VzZU4TfkFQgOAAHB4g0jrXwq64WgNb3CvXxq1S8nWjkL4lV1kV4julo78aTI
 OcuXaL6DuQ2YnDVngzW1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FzJgmb7SgcY=:Fy/NDIn8wdnI8KuAmVgfy/
 6elUOoNhAcQuLUl0qMCwEn2wk/aQpgL7p4NrtqxvmVGcU5tUi3+EcpnUOPcUAXn2cq3jqCMee
 XO15Pt1IIsI4Px50vumRBO9tIRbUzy4xPI17qz0Gpp7SUwLkyctd5ZSNP2pbOW5VBfNQ4jd01
 6HyRtYgzivgfwDT04ms537TYJhMoj/90XFw4Brm6lsU2S0jq8JsMGpRmvgtbYLNWkv3Kft1+u
 dxXgj2mWVhPTP4juZ6VLf8nRq8dDbQqYp+Fpo7kQrBWJMncaduVEfYqMN5shzIL0J8sBDIoP8
 Ds24JSgqJU0UAwHYZObSLy5+pIbKpxh3dGmlx5eqJ8Q341h99c3bIMbKOVn3+7qtHYblK9PnZ
 D6Cg+NQpKYJzoNgqSbk66/QJ52faWIJw9aoiaJBh4hlpTExXyf9qkvuLVCljqkHKkHLWg81J5
 4Mqo+qprNKjJRyMM+jZD0icNhGpA9aKSOcEpHn7hA7O4WiNbmAZrkRRHGHvomGk8m5/g3l9li
 Sm1ANZh0fnaFo3/gYMpotv/f+InCCy2kROOseqv5fVRTI7qcr0hzwhYkDfA6GoLYC5/UEG4W3
 bJLE9ViZe/xz0aPYRbe6BCWdkUCgJYo0Y/UBKYquX7XQbgzewHVeXMVWFCCvV+ocloky9Hhhs
 gVt4xrI1IGPqa+QZUgkbg3p+ltvWI/TBXRkggKmO9IluFQrtt0V703Yt9DrPOfaxly2CTQWVj
 kFi09JZ2c6T8imSazwhB0zMT9bRwKNbbJfPGdaUQGIQ7Ctwp92VNdEguls0u1bRKrayXSVla5
 RgFNZfH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas & Eric,

On Sun, 29 Jul 2018, Thomas Gummerer wrote:

> On 07/29, Eric Sunshine wrote:
> > On Sun, Jul 29, 2018 at 3:04 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > On 07/21, Johannes Schindelin via GitGitGadget wrote:
> > > > Just like tbdiff, we now show the diff between matching patches. This is
> > > > a "diff of two diffs", so it can be a bit daunting to read for the
> > > > beginner.
> > > > [...]
> > > > Note also: while tbdiff accepts the `--no-patches` option to suppress
> > > > these diffs between patches, we prefer the `-s` option that is
> > > > automatically supported via our use of diff_opt_parse().
> > >
> > > One slightly unfortunate thing here is that we don't show these
> > > options in 'git range-diff -h', which would be nice to have.  I don't
> > > know if that's possible in git right now, if it's not easily possible,
> > > I definitely wouldn't want to delay this series for that, and we could
> > > just add it to the list of possible future enhancements that other
> > > people mentioned.
> > 
> > This issue is not specific to git-range-diff; it's shared by other
> > commands which inherit diff options via diff_opt_parse(). For
> > instance, "git log -h" doesn't show diff-related options either, yet
> > it accepts them.
> 
> Fair enough, that makes sense.  Thanks for the pointer!
> 
> There's one more thing that I noticed here:
> 
>     git range-diff --no-patches
>     fatal: single arg format requires a symmetric range
> 
> Which is a slightly confusing error message.  In contrast git log does
> the following on an unrecognized argument:
> 
>     git log --no-patches
>     fatal: unrecognized argument: --no-patches
> 
> which is a little better I think.  I do however also thing the "fatal:
> single arg format requires a symmetric range" is useful when someone
> genuinely tries to use the single argument version of the command.  So
> I don't know what a good solution for this would be.

I immediately thought of testing for a leading `-` of the remaining
argument, but I could imagine that somebody enterprisey uses

	git range-diff -- -my-first-attempt...-my-second-attempt

and I do not really want to complexify the code... Ideas?

> > > > diff --git a/range-diff.c b/range-diff.c
> > > > @@ -300,6 +325,9 @@ static void output(struct string_list *a, struct string_list *b)
> > > >                       printf("%d: %s ! %d: %s\n",
> > > >                              b_util->matching + 1, short_oid(a_util),
> > > >                              j + 1, short_oid(b_util));
> > > > +                     if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
> > >
> > > Looking at this line, it looks like it would be easy to support
> > > '--no-patches' as well, which may be slightly easier to understand that
> > > '-s' to someone new to the command.  But again that can be added later
> > > if someone actually cares about it.
> > 
> > What wasn't mentioned (but was implied) by the commit message is that
> > "-s" is short for "--no-patch", which also comes for free via
> > diff_opt_parse(). True, "--no-patch" isn't spelled exactly the same as
> > "--no-patches", but git-range-diff isn't exactly a perfect tbdiff
> > clone, so hopefully not a git problem. Moreover, "--no-patch" is
> > internally consistent within the Git builtin commands.
> 
> Makes sense, thanks!  "--no-patch" does make sense to me.  There's
> still a lot of command line flags in git to learn for me, even after
> all this time using it ;)  Might be nice to spell it out in the commit
> message for someone like me, especially as "--no-patches" is already
> mentioned.  Though I guess most regulars here would know about
> "--no-patch", so maybe it's not worth it.  Anyway that is definitely
> not worth another round here.

Sure, but not many users learn from reading the commit history...

:-)

Ciao,
Dscho
