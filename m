Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FA34211B3
	for <e@80x24.org>; Tue, 11 Dec 2018 10:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLKKOq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:14:46 -0500
Received: from mout.gmx.net ([212.227.17.22]:38483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbeLKKOp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:14:45 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYcJi-1h11ms2XnW-00VMRK; Tue, 11
 Dec 2018 11:14:40 +0100
Date:   Tue, 11 Dec 2018 11:14:39 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] rebase: introduce --reschedule-failed-exec
In-Reply-To: <CABPp-BGoJxKFFu+JE9n52t8Fygzf0+mpPSOo8rftR2v0_i+eZw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1812111104561.43@tvgsbejvaqbjf.bet>
References: <pull.90.git.gitgitgadget@gmail.com> <05d8792d12e692eeefa0021e8686b7211a055593.1544468695.git.gitgitgadget@gmail.com> <CABPp-BGoJxKFFu+JE9n52t8Fygzf0+mpPSOo8rftR2v0_i+eZw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:h5k63d6Vvaq7kFr7qa7cCUFGn2olbtqMBgQ3IXjJrW2ERa2t8xg
 /SXZHRu55TryGdPvVop5YYO4ioNDnR1PNOCANJhp4AuwaRNba2Y4D37siE6i+D9dRVcbOQk
 vYz+f++2m3yyR7BQcWu9uupZZAX2AuS4QRtkvWweEmEmejFyuwZmniNCIQBiNejeWdP7g/n
 oVb+pqEQZVWTquW6Y6irw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:foFVeUbv3MQ=:DCm4FxF9HL+gRB1PkT/vlm
 X728Xs0lE/xSFLE3Vu2LTnOjvUkufqHTyJAncO4MtpQIbtVe1f46OUM4TWkRUOPdNYun8RjBR
 Hk9BxEeFLiZz3mMFx/ldZi0Ib+wZJ2lmZJ76QP4FbghFZkEC2sEwZIzXREplUPdeW61QoGC2b
 5w8hG+j3CcPycy3NNoU2B9FMsSvSUDzgWEi04sP4l3yewv/71i20s7PkWEz8AgYK3mXAHIcDw
 056kPIu35PIuZoBbA7Ytepiwi0e7jAd9R/HIc0mbc3+jjXxuTirmzOYZxcHskQo2wBW+5CwNv
 jlQpf5ufuNSW9qXlMYBoUZSCHk36pL9zUe35Fm4P609iMCp5rAyF/FHOSeEPnpfW/gmepI3Za
 wBhGDEj+5vkYqLLB1j9NdiEZq9lcZQtEMrThJTeQIG+Hy8XKHJNUS0T3D/qBbrRluGcPHcDwF
 7rO82XkxNmGUQ/fF4rThAyqhA/C/CyPYlLM3QeYLL9Fg62fE0+odBf2B5m/tAU2MxH2PCdexL
 AWGJ3GUyyDFaRLh6NMYoWn61Lifx4Nt6mHK7RG3Ai43BCmcsV+8qwUKAzB/YV+GLYbvSMZyUx
 mTMY4PW0Fy4gt/8P/bi3YlGvrx+Znb/YDiB2y/OKAI4iSWC6uy1MmzQ9yJLNGW3vN7XulpiTa
 cdQWqWIkcNTHiX1K7Og+uXhC3N0MDHjMUqRVI+nrWbdBYzNl7xB3JO5hdWz4o0F1zt/Od0ndP
 KGcVGcYgEr0lUIgiLaZteHCr7/lWSQ+7eVLeCXyBpH34VfjsT762lIgTgJ3yw/nagyaXaePVF
 d69/vZKAMhaiSzAOyrV0T795vIo+kdZrv82J+4l9mpRkH9QnCe94quElDJJlgpSO38dCtMkUs
 Bt0dvxStn7uDDToSXKM30l3hPdGOAdpjViEOs7GYldgI6YvFSRq0gFEcrHpdRzD/cv+srJYUT
 RnBXJ4w/Obw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 10 Dec 2018, Elijah Newren wrote:

> On Mon, Dec 10, 2018 at 1:18 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > @@ -1195,6 +1201,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >                 break;
> >         }
> >
> > +       if (options.reschedule_failed_exec && !is_interactive(&options))
> > +               die(_("--reschedule-failed-exec requires an interactive rebase"));
> > +
> 
> I was surprised at first that you checked is_interactive() rather than
> checking for --exec being specified.  But I guess this is because users
> can manually specify 'exec' lines.

Indeed, that is exactly the reason.

> What if the user specifies an implicitly interactive rebase (i.e. no
> editing of the todo list, such as with --rebase-merges or
> --keep-empty, or soon --strategy or --strategy-option) and also
> doesn't specify --exec?

Then the todo list won't have any `exec` lines, and the flag is irrelevant
(but does not do any harm).

... except in the case that the rebase fails at some stage, the user edits
the todo list with `git rebase --edit-todo` and inserts an `exec` line.

So I would contend that it still makes sense to allow that flag in those
cases, i.e. whenever the user asked for the interactive backend.

> > @@ -534,6 +545,9 @@ then
> >         #       git-rebase.txt caveats with "unless you know what you are doing"
> >         test -n "$rebase_merges" &&
> >                 die "$(gettext "error: cannot combine '--preserve-merges' with '--rebase-merges'")"
> > +
> > +       test -n "$reschedule_failed_exec" &&
> > +               die "$(gettext "error: cannot combine '--preserve-merges' with '--reschedule-failed-exec'")"
> >  fi
> >
> >  if test -n "$rebase_merges"
> 
> In the builtin rebase, you checked that --reschedule-failed-exec had
> to be used with an interactive rebase.  Here in the legacy rebase you
> have no such check at all.
> 
> Not sure if that's an oversight, or if we're at the point where we
> just start intentionally allowing legacy rebase to lag and soon throw
> it out.  (When do we get to that point?)

Good point. My thinking was that the legacy rebase does not matter all
that much anymore, I would expect that we get rid of it in v2.21.0.

But you're right, I should not intentionally diverge the functionality out
of sheer laziness.

Will fix.

> The rest of the patch looks good to me.

Thanks!
Dscho
