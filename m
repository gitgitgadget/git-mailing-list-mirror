Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E408200B9
	for <e@80x24.org>; Mon,  7 May 2018 01:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeEGBwu (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 21:52:50 -0400
Received: from mout.gmx.net ([212.227.15.15]:47953 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbeEGBwt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 21:52:49 -0400
Received: from [10.40.94.26] ([209.226.201.248]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LskfZ-1eDL121swD-012Kbq; Mon, 07
 May 2018 03:52:38 +0200
Date:   Sun, 6 May 2018 21:52:32 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Todd Zullinger <tmz@pobox.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 12/18] branch-diff: use color for the commit pairs
In-Reply-To: <20180505234852.GR26695@zaya.teonanacatl.net>
Message-ID: <nycvar.QRO.7.76.6.1805062146070.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <ba4791918c78770005d552856d8669648d7004f1.1525448066.git.johannes.schindelin@gmx.de> <20180505234852.GR26695@zaya.teonanacatl.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:m8tIjaCCDiQufU5t6ugK6Tj29LeKbOb69+2VvQdGFLyQJYLRGdy
 bhSH1dVA11FZeblY9RMIKWesh2/EHkvTzDQY2hk+Go0nhK9j0li0V5PuCaYLPsmgrY3MDGq
 gzFF3hTM/6A4XWcHNifeQN7CHDkdsH5NqYr1UFcg+C8uDCkjS60vDE0zCix7DA64mQ+wfEk
 GtbMrt0vGIU42LzMX/RyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kwAtjvfYW8U=:GZFhccBMi+kuXBwrOAmDQ6
 6zb5EdCgfJ2Hyucxn1YP9vuQwMlbwiHhHf+2XNVWNgu9SZm45rqR9HsOVSjfVqn668sGUM8gi
 lJ+SUVrFZ5w6HZAX1laU0V3VpmpaFntMNvWcJDqJw3Bje9r6Skygm+CrmtY4ZaNoUzaMpEKnp
 RAILpv/CZNwKLm+qh/FzD/wg7SHhqMP+mrII3teZvLw91SAX6bepg1QoM20vU06HplSq4bqrs
 TRZPegEBTri++08I1fcpOArD+bB683ZSvUHjSsx8KS0R/RwaWNhGxfIS1M/s3vd/HspP+6Qw8
 mRjKoIrrXCw9GJTWBacTymfCKEWPbvQMRlIYDjLCBYh1a65TYst+kNI+1jci1PdkOkWeDTRTO
 RcuvLpDqVikxJECnDEST9AaCM0K0/91BPnO4yBOzY4cYDIv6DWsg947ExLyVOGfYVAJ75smE4
 y57lQJCULLOvyJBqm7EZ5jaGYGw65Iv4um5ncmPGbR83RU6UnYiy9679+1Zju9cFlIl39CrjA
 nwNYmujvIoWSyJj/kTVbZyjyLy9UTjyy+RWSLMp53dGK6bx53ZSz2tFfA/NeJpIFjWBrbdJ7f
 2sxSI851O9OBHm6yNnsMQOhGpTe4LyAuPObk1aKqTyV0xkym1n2PFrUbdS+rSbYH880hiikd6
 AoZSMEUwRdrjrEhievs/9pMpslmMN69GURkWMMcB2PO9Yf3OwISrayahEQjKlG+cjMOp4jJTH
 I3T7xGQZ1l9s+iXvuc+Jb3i36KXRyQRJYu7hG/aUjTmhVZ3ZYCLNQ0u7PkaCJABhTH5SeGB71
 ppE5sP7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Todd,

On Sat, 5 May 2018, Todd Zullinger wrote:

> > @@ -430,6 +451,8 @@ int cmd_branch_diff(int argc, const char **argv, const char *prefix)
> >  	struct string_list branch1 = STRING_LIST_INIT_DUP;
> >  	struct string_list branch2 = STRING_LIST_INIT_DUP;
> >  
> > +	git_diff_basic_config("diff.color.frag", "magenta", NULL);
> > +
> >  	diff_setup(&diffopt);
> >  	diffopt.output_format = DIFF_FORMAT_PATCH;
> >  	diffopt.flags.suppress_diff_headers = 1;
> 
> Should this also (or only) check color.diff.frag?

This code is not querying diff.color.frag, it is setting it. Without
any way to override it.

Having thought about it longer, and triggered by Peff's suggestion to
decouple the "reverse" part from the actual color, I fixed this by

- *not* setting .frag to magenta,

- using the reverse method also to mark outer *hunk headers* (not only the
  outer -/+ markers).

- actually calling git_diff_ui_config()...

>  I thought that color.diff.* was preferred over diff.color.*, though
>  that doesn't seem to be entirely true in all parts of the current
>  codebase.
> 
> In testing this series it seems that setting color.diff
> options to change the various colors read earlier in this
> patch via diff_get_color_opt, as well as the 'frag' slot,
> are ignored.  Setting them via diff.color.<slot> does work.

In my tests, it did not even work via diff.color.<slot>. But I think I
fixed this (at least my local testing confirms this) by calling
git_diff_ui_config().

> The later patch adding a man page documents branch-diff as
> using `diff.color.*` and points to git-config(1), but the
> config docs only list color.diff.

In the current form (`git branch --diff`), I refrained from going into
*so* much detail ;-) But the gist still holds, and now the code should
support it, too.

The current work in progress can be pulled as `branch-diff` from
https://github.com/dscho/git, if I could ask you to test?

Ciao,
Dscho
