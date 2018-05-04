Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9224B1F42E
	for <e@80x24.org>; Fri,  4 May 2018 07:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750880AbeEDHDK (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 03:03:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:59625 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbeEDHDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 03:03:09 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MJjUO-1fDOHc0iQ8-0018eq; Fri, 04
 May 2018 09:03:04 +0200
Date:   Fri, 4 May 2018 09:03:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 03/18] branch-diff: first rudimentary implementation
In-Reply-To: <CAPig+cSvHWvb0dsGkjL69yzbBvgaT7oJm6nFuGWeA6Jw0NpYUw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805040900570.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <ec51c71779a325263c1b705a6b1bfb003fcd528a.1525361419.git.johannes.schindelin@gmx.de> <CAPig+cSvHWvb0dsGkjL69yzbBvgaT7oJm6nFuGWeA6Jw0NpYUw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZQbEN4+j4MNKjfVZpFA6s0fANdIPkGAlIdHD58imhEhwuqq9toQ
 XL6mmOhjaz0Yg1nENu629YrWb7twCfohOGXD1BESNqTbyUvGesWLcHifQtZFpJXATyB3C3X
 iqMsKUJAL8WDXVmZ2w5lu2Zy70IX/Uov627KChi8I5s9EeW5UQrtBY7QC9EBUXi0emlnhV8
 B356mksBW4M8T0pepBeDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YWtw60JNoIA=:wixWm8Ih5EobhyOQS3t99L
 8QhlQcGkmxCXRymgDMSS6ATei3wiFJZplbsQeLc707WQUHd9YpXbK7LtlK7PM+cgJbSVmpJmd
 Th+jIw7j/PBsgQO5CyysLce/n11cPsWQRKT4FFFhXQtIYvO0czicpgDxB5OwT46lcwP9NNUHA
 G8UybIPXqma8Z12MPrTXqFOB/PUO6Q428SPFErGSOUfZFkN7FgBgu/5a7felTjm7aMTUe4o0T
 me0ZkYcdoplSJvoz0Lq5ZJoZvPRjCll66SLjHIcYekETn5PzFb3FAbtM4646kLYaPlcgJIezp
 2ra+TGWwxIjHHFs3wdJlrrKD9vcl1Kkha8w5JJElZ1jGf4yvPngjxNN9jtb/kphhN6GBunYBS
 WLilIfWcVvVAIhO5gWRYx9A2oTk7Yel6iV1I3/H7v3jLK7HcFzM3nzHWY831h1oSX+f9KtQCK
 c0Zr/R5qF1deOVv9SVIvBfwtHHkjhoOGOBaJ3sKsayh+OrXzYtsQEz9wfkSVklyixIMJkQUpk
 IW5i8vB7rp4JGLydJb5lFch/S/9xRqvUQ82MPw3i9O57zWYzwlPTs++XB3YEX26tDk8bOI+6l
 7jDzHlTnApq8Irgjg2vivZWSJQTK1fE5ke96J850uf+TaZP7TPVoauVZwWlt10ivdSLyFMASC
 R305HEx8ENjfk5j1zG031utRPfgKeoC4Tpxaa7ylW7z8DF45EAOszfz4o6BH3lTvj+2asxONe
 v/Z8j4E3ckC2+gp9jeCbhgw8+hFBob1VVCRN49U8ZsaHCcph7MBTCZCyxD/BdYn/wzHJipLJv
 XdWEpkE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, 3 May 2018, Eric Sunshine wrote:

> On Thu, May 3, 2018 at 11:30 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > At this stage, `git branch-diff` can determine corresponding commits of
> > two related commit ranges. This makes use of the recently introduced
> > implementation of the Hungarian algorithm.
> >
> > The core of this patch is a straight port of the ideas of tbdiff, the
> > seemingly dormant project at https://github.com/trast/tbdiff.
> >
> > The output does not at all match `tbdiff`'s output yet, as this patch
> > really concentrates on getting the patch matching part right.
> >
> > Note: due to differences in the diff algorithm (`tbdiff` uses the
> > Pythong module `difflib`, Git uses its xdiff fork), the cost matrix
> 
> s/Pythong/Python/

Yep!

> > calculated by `branch-diff` is different (but very similar) to the one
> > calculated by `tbdiff`. Therefore, it is possible that they find
> > different matching commits in corner cases (e.g. when a patch was split
> > into two patches of roughly equal length).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
> > @@ -19,6 +23,279 @@ static int parse_creation_weight(const struct option *opt, const char *arg,
> > +static int read_patches(const char *range, struct string_list *list)
> > +{
> > +       [...]
> > +       struct strbuf buf = STRBUF_INIT, line = STRBUF_INIT;
> > +       [...]
> > +                       } else if (starts_with(line.buf, "    ")) {
> > +                               strbuf_addbuf(&buf, &line);
> > +                               strbuf_addch(&buf, '\n');
> > +                       }
> > +
> > +                       continue;
> 
> Unnecessary blank line above 'continue'?

Sure.

> > +               } else if (starts_with(line.buf, "@@ "))
> > +                       strbuf_addstr(&buf, "@@");
> > +               [...]
> > +       }
> > +       fclose(in);
> > +
> > +       if (util)
> > +               string_list_append(list, buf.buf)->util = util;
> > +       strbuf_release(&buf);
> 
> strbuf_release(&line);

Yes!

> > +       if (finish_command(&cp))
> > +               return -1;
> > +
> > +       return 0;
> > +}
> > @@ -32,9 +309,63 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
> > +       if (argc == 2) {
> > +               if (!strstr(argv[0], ".."))
> > +                       warning(_("no .. in range: '%s'"), argv[0]);
> > +               strbuf_addstr(&range1, argv[0]);
> > +
> > +               if (!strstr(argv[1], ".."))
> > +                       warning(_("no .. in range: '%s'"), argv[1]);
> > +               strbuf_addstr(&range2, argv[1]);
> > +       } else if (argc == 1) {
> > +               if (!b)
> > +                       die(_("single arg format requires a symmetric range"));
> > +       } else {
> > +               error("Need two commit ranges");
> 
> Other warning/error messages emitted by this function are not
> capitalized: s/Need/need/

Right. And it is also not translated. Fixed both.

Thank you for helping me make this patch series better!

Ciao,
Dscho
