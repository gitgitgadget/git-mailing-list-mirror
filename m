Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4501F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 13:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeGLNS0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 09:18:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:47781 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeGLNS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 09:18:26 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5cMq-1g1rKM1Rxg-00xdLl; Thu, 12
 Jul 2018 15:08:50 +0200
Date:   Thu, 12 Jul 2018 15:08:33 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] rebase --rebase-merges: add support for octopus
 merges
In-Reply-To: <CAPig+cS1KQseynMCGC_6FZwzB0waJX8+C7CVKNqACzOhjB4uSg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807121503220.75@tvgsbejvaqbjf.bet>
References: <pull.8.git.gitgitgadget@gmail.com> <03d0907ec61f0ea53b59659c84b8a6662e9e7607.1531312689.git.gitgitgadget@gmail.com> <CAPig+cS1KQseynMCGC_6FZwzB0waJX8+C7CVKNqACzOhjB4uSg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1884864885-1531400929=:75"
X-Provags-ID: V03:K1:yFflx7ij4zFMutIQRClMqSKcTa3ZJDjcuTglBi3d3D/2Udq+jaL
 l7AG8bOeQ7M3tSdq8Z1R8l+ex1iW3W02RzdtOyfmrzvVW2M5blweK7dmlCxogCivO+2jie7
 iqEiyZ56ZVKMZg+uTZMz9W41uAxgz1uS+89L9soaeGWOPhzNAHFYxs/0TZL9WDGBPTluCrt
 huNwChKQ1q5J9yo7/cTqg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AwP+5TLq6TU=:wJiU29wX6vMsQufbh77oKA
 BVxrTZ0lrHPIUR4jedGOnQJPdewouz69NbCiT8TFnzKpSpKgBxBUK5xUZHCQfIkiSKBRJpWBv
 HM+1iw17Gq63GZqytc2NGqV4ec30uWvJZoDI+2nkbr/nj6tpuasj59EpSlqEARg3y8mriy4Xd
 5Hpselyjd0ALIVxEjQkWe3uQXCEZGRvLj2RtJ9BTGfvsbQ/aIaVn0q7tOQG6yLSAwJ9fj2JJa
 ervT1Fms3tcF64NTjO+JL3HW5GWS/ZhRXmjWeS+Lb2LXcv9R4zGt2OInXzzUPR3wp4R6x4P9f
 5jS0vrAP+hSzRFKENy6EecF0kp0DeQiNv/6dqxgx7nklvuuCJZPajI77Q8gqMcg326mcYOTDt
 aLqAGZtE6eikcVRaer2Hya4s3OKUyENYPKdxNfNZDQFBB6wYL/91bKs7onQc91Go+FhKpLThu
 6Q7xur0Q/yAb45M3k4YEG5OowGAIic+D21CM9Owag3bh2WWbJRzqqbeQOHGwASD3x19Jn/sun
 0Gq1tc03xgv+qg1SuSAn7bfPDbhjqVnsAYXu4A/2y9fQQg+veNYA0iJBryAckVes7y6ddgZxU
 XdcEBBfudDe9GEQ+SeMoVS19mr7k8NflKy3FYBuyJHekg2BNCrf4kUxvuziJB442wkZxMNeWC
 Iipif70S6zLnGEUxlLwp0+iR8OsnoUcR6AFvROKzXq6wo/BVMUGOYrPVIRhEalc+/GnXZbicG
 rc4DhbZ8Z25W1y97KLeJLzgO8XJ73VgymYPFZBHylIg5OahtlNMgDavq82jAD47KV0/8q9R58
 iLU2bfG
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1884864885-1531400929=:75
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Eric,

On Wed, 11 Jul 2018, Eric Sunshine wrote:

> On Wed, Jul 11, 2018 at 8:38 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:

> > diff --git a/sequencer.c b/sequencer.c
> > @@ -2932,7 +2966,8 @@ static int do_merge(struct commit *commit, const =
char *arg, int arg_len,
> > -                       strbuf_addf(&buf, "Merge branch '%.*s'",
> > +                       strbuf_addf(&buf, "Merge %s '%.*s'",
> > +                                   to_merge->next ? "branches" : "bran=
ch",
>=20
> Error messages in this file are already localizable. If this text ever
> becomes localizable, then this "sentence lego" could be problematic
> for translators.

As pointed out by Junio, this is not really a message eligible for
localization, at least not right now. If it becomes localized later, it
will be very easy to change the sentence lego then.

I am just wary of making life harder for the compiler that wants to verify
that the printf() style parameters match the format.

> > @@ -2956,28 +2991,76 @@ static int do_merge(struct commit *commit, cons=
t char *arg, int arg_len,
> > +               cmd.git_cmd =3D 1;
> > +               argv_array_push(&cmd.args, "merge");
> > +               argv_array_push(&cmd.args, "-s");
> > +               argv_array_push(&cmd.args, "octopus");
>=20
> argv_array_pushl(&cmd.args, "-s", "octopus", NULL);
>=20
> which would make it clear that these two arguments must remain
> together, and prevent someone from coming along and inserting a new
> argument between them.

I use a single `argv_array_pushl()` call now, with intuitive line
wrapping.

> > +               argv_array_push(&cmd.args, "--no-edit");
> > +               argv_array_push(&cmd.args, "--no-ff");
> > +               argv_array_push(&cmd.args, "--no-log");
> > +               argv_array_push(&cmd.args, "--no-stat");
> > +               argv_array_push(&cmd.args, "-F");
> > +               argv_array_push(&cmd.args, git_path_merge_msg());
>=20
> Ditto:
> argv_array_pushl(&cmd.args, "-L", git_path_merge_msg(), NULL);
>=20
> > diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> > @@ -329,4 +329,38 @@ test_expect_success 'labels that are object IDs ar=
e rewritten' '
> > +test_expect_success 'octopus merges' '
> > +       git checkout -b three &&
> > +       test_commit before-octopus &&
> > +       test_commit three &&
> > +       git checkout -b two HEAD^ &&
> > +       test_commit two &&
> > +       git checkout -b one HEAD^ &&
> > +       test_commit one &&
> > +       test_tick &&
> > +       (GIT_AUTHOR_NAME=3D"Hank" GIT_AUTHOR_EMAIL=3D"hank@sea.world" \
> > +        git merge -m "T=C3=BCntenf=C3=BCsch" two three) &&
>=20
> Unnecessary subshell?

Yes, I agree. I don't recall why I did it that way, probably I tried
something else originally that required a subshell, or something.

Thank you for helping me make the patches better.

Ciao,
Dscho
--8323328-1884864885-1531400929=:75--
