Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5242A200B9
	for <e@80x24.org>; Thu,  3 May 2018 20:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeECUZi (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 16:25:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:51913 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbeECUZg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 16:25:36 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhTjQ-1eap6740mm-00mfXq; Thu, 03
 May 2018 22:25:28 +0200
Date:   Thu, 3 May 2018 22:25:28 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
In-Reply-To: <71b00bbf-07e7-11e1-046b-f0241b82ebd3@ramsayjones.plus.com>
Message-ID: <nycvar.QRO.7.76.6.1805032224150.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de> <71b00bbf-07e7-11e1-046b-f0241b82ebd3@ramsayjones.plus.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:WhyCqOP8abXV0klslFgMohNS2VEK08hfZIil7vvCtT36TiWNSq/
 7C4XNs22XjPHzkKFblXqlH5QuRBOXQj6bQ+lDlTMqdwng6CZXK/v/Vj9cAjIrjuzaRmWE1D
 BNgso6eMGsBD5MqTh3DVYnuWFjcMj5aokjpkYuvDEK+mN4ziVDGVEvlwuiIZ3fIy3i1NDPL
 FOWypgt7Mc7FIq+IAtJVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PpFFgN3aeSo=:rB/+1vCbMry43jcPZ3uUtJ
 CH12KuNp6AxJanRP4Wi8qS0YFmCWiC/S73fiqOCcNivWRjAgYBf5fN2CTftD+2HKRADrYxX3z
 tb5yi0P4WNxMkUwkgECFBeEPJP7W4NVs6yEmAjbn5DElUKJaNI9SHOO0Ocdogtu0PmZw4hOrJ
 LudPT0/ZhDdL/bHaiEzu7wQ+S+m4o8Afl9bKFNk0ww/+fDryIoBi12c6FTO+b47QV/Hvuh1Jk
 UR5GUeiVcBXtyJBYhY+RP8ZdjCHaki/EyLXZ+s+H2bcDVggbVUfgWJS/6zy9gH4c2/wpc7l89
 p6P1dfb34do2ubpHyvn991RLz6PH30cXsDDudUQy7jTCdRW6VRGeYB9MmJP+SbPhwHkhOOc/r
 f6XvwVboiAZIVpzDc7qHHk2GtzbrY/dShhlTOzj6/laATeECeK567yIvuGHY+IL4kpOT+SRu6
 ikicM3qNmQrYuO5dEH9PwU+U8m1z/ww3gX2Nru0jpwpIk6I0nDiD5nEQwP1aVKUkaRtb1pgel
 YrI72DO/0Lc1/BNTJIvJV2a/KQv+XM+5Pg2sjv5f1LOpIMX+d45a3rQTATPno0KaLP5ZI/F3f
 IhZHLi8GEZln1jf+ZjoNsFPsP3wDc9r8Eww08/ar/Y8wzHy23WZA315BwL+7iwUamK5gzqviu
 ssFpym4Z//tmVe8BqDc3Ul5zI+GMxGkSVKypeKJsJDvQWl5Qc3O/C3Yh60B+Ih8bNSGSp/51S
 2Yid0g5On4vRlVl9whvbCmMzjK1NlRv4RUIAni8zPgti51e4MwBL4v6Dek+La6SfdQjTRCyJR
 M3no01d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay,

On Thu, 3 May 2018, Ramsay Jones wrote:

> On 03/05/18 16:30, Johannes Schindelin wrote:
> > This builtin does not do a whole lot so far, apart from showing a usage
> > that is oddly similar to that of `git tbdiff`. And for a good reason:
> > the next commits will turn `branch-diff` into a full-blown replacement
> > for `tbdiff`.
> > 
> > At this point, we ignore tbdiff's color options, as they will all be
> > implemented later and require some patches to the diff machinery.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  .gitignore            |  1 +
> >  Makefile              |  1 +
> >  builtin.h             |  1 +
> >  builtin/branch-diff.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >  command-list.txt      |  1 +
> >  git.c                 |  1 +
> >  6 files changed, 45 insertions(+)
> >  create mode 100644 builtin/branch-diff.c
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 833ef3b0b78..1346a64492f 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -20,6 +20,7 @@
> >  /git-bisect--helper
> >  /git-blame
> >  /git-branch
> > +/git-branch-diff
> >  /git-bundle
> >  /git-cat-file
> >  /git-check-attr
> > diff --git a/Makefile b/Makefile
> > index 96f2e76a904..9b1984776d8 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -953,6 +953,7 @@ BUILTIN_OBJS += builtin/archive.o
> >  BUILTIN_OBJS += builtin/bisect--helper.o
> >  BUILTIN_OBJS += builtin/blame.o
> >  BUILTIN_OBJS += builtin/branch.o
> > +BUILTIN_OBJS += builtin/branch-diff.o
> >  BUILTIN_OBJS += builtin/bundle.o
> >  BUILTIN_OBJS += builtin/cat-file.o
> >  BUILTIN_OBJS += builtin/check-attr.o
> > diff --git a/builtin.h b/builtin.h
> > index 42378f3aa47..e1c4d2a529a 100644
> > --- a/builtin.h
> > +++ b/builtin.h
> > @@ -135,6 +135,7 @@ extern int cmd_archive(int argc, const char **argv, const char *prefix);
> >  extern int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
> >  extern int cmd_blame(int argc, const char **argv, const char *prefix);
> >  extern int cmd_branch(int argc, const char **argv, const char *prefix);
> > +extern int cmd_branch_diff(int argc, const char **argv, const char *prefix);
> >  extern int cmd_bundle(int argc, const char **argv, const char *prefix);
> >  extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
> >  extern int cmd_checkout(int argc, const char **argv, const char *prefix);
> > diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
> > new file mode 100644
> > index 00000000000..97266cd326d
> > --- /dev/null
> > +++ b/builtin/branch-diff.c
> > @@ -0,0 +1,40 @@
> > +#include "cache.h"
> > +#include "parse-options.h"
> > +
> > +static const char * const builtin_branch_diff_usage[] = {
> > +	N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
> 
> s/rebase--helper/branch-diff/

Whoops!

BTW funny side note: when I saw that you replied, I instinctively thought
"oh no, I forgot to mark a function as `static`!" ;-)

Thank you for helping me improve the patches,
Dscho
