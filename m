Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C581F42D
	for <e@80x24.org>; Thu,  5 Apr 2018 13:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeDENfE (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 09:35:04 -0400
Received: from mout.gmx.net ([212.227.15.19]:40613 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751165AbeDENfC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 09:35:02 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LtIdP-1eOBjv0zf9-012r3s; Thu, 05
 Apr 2018 15:34:56 +0200
Date:   Thu, 5 Apr 2018 15:34:55 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Christian Couder <christian.couder@gmail.com>
cc:     Joel Teichroeb <joel@teichroeb.net>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] stash: convert apply to builtin
In-Reply-To: <CAP8UFD3SM9e+_VGpxVNzMoEYnyzkF0EzjAPjvbFakr9t9Z-muQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804051528560.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405022810.15796-1-joel@teichroeb.net> <20180405022810.15796-3-joel@teichroeb.net> <CAP8UFD3SM9e+_VGpxVNzMoEYnyzkF0EzjAPjvbFakr9t9Z-muQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7xINikT8LtGuZxoFMoJa6xtCrVjY8ntByldhMQAc7ZYzh43c5SL
 EIgvbu6XcITtyxqijw20l/FuWUSIcMx7IelczN2AVQbZ//v2ahpv6c20CjSI20vWHz3NrYk
 RgglnpSVa6wxBc0q37NRv86GztE/j/Z20kCyJgHyujkqjWxzttnlnoNTRyv6toFT1DiWUhk
 KDTTVLIpvh4VlpSzBnX+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AM6c8z/5ErE=:wtQE+zmh305rP47K68eHGa
 ibOYRK4LOIoZVnIGT95LrWeKA84Nv51rXOau8oCWElciOPH6enb18h7SYwi15cf1SmUsgBdoA
 sLdQ6fErQsrNbJKuI+clu1nh7v+n4VAXuxlzryH4DcyIm4GLI8aIjvLtrB2YVzPPTBAqsy3Sy
 3PeOfUnANK84ec6yM+IaaO0uEhOoDwiO37ttYrhK/GiPlDUdNkeTv8uY4r/IRsHwpOk59UEAg
 HYFCadS+mW0C+gBPCqa4La6AIf78G6VZUogv2VOQ7IDtV6I+fHf6ruT7zoOYLhSdN3STp9yFG
 lc1V7peVxPLvWu+Ssl7sXJUISea+cj5cKrC4Tw2X8ZwXw1fE7oof61DGVr1fZi0d7rLMZ1PcA
 zLfpopZcw2GFDoZ53g75gPBGDk9SnU1OKa/UHqIQq+rNH3QmzzrKUMWvBBoj/+VYBN5aeDi+L
 cQbAahbrQ6aPhO9B2WwVIuk0e/ZJtk9r52eFNGEuKW/E7EurdgX95+BDgaSIYpjK3WNAZR0kN
 2l2UD8a8laan9lI7/KK9fxoUDta8bZxDIoPCYpGB90QJFg1++SQWgCuy85GWa76OHyRq+XtGY
 8FqPBmEhRrjB15WihGq4+LLz0Z9/kgxBF6jOCO+Mz1lRh+uo9xDQzzU5ahBACO0Ph55czlzRK
 Vaz3zg7WZhSxHRu5jN38A9LAQM6PcaYKPw4pyqYnmcZmJixy3xKxItAF3RMTPS6RE27dfS/Pp
 PzomH6Avi63JPIbdsdm55N9niHiz6/v3P70jxCIIJJ+83Um4V8RlZlIbNOC5I0qYprgjmsfNC
 X5t3qNuH0iWcaPQ56XmDPdtwawuBtM+3WV19NBUu6bRcl2Qc3M9BnxJ72yP/yblN3/uzXiD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

[please cull a *lot* more of the quoted mail when you do not reference any
of it... Thanks]

On Thu, 5 Apr 2018, Christian Couder wrote:

> On Thu, Apr 5, 2018 at 4:28 AM, Joel Teichroeb <joel@teichroeb.net> wrote:
> >
> > [...]
> > +
> > +       revision = info->revision.buf;
> > +
> > +       if (get_oid(revision, &info->w_commit)) {
> > +               error(_("%s is not a valid reference"), revision);
> > +               free_stash_info(info);
> > +               return -1;
> 
> Maybe:
> 
>                free_stash_info(info);
>                return error(_("%s is not a valid reference"), revision);
> 
> to save one line and be more consistent with above.

No. The parameter `revision` of the `error()` call is assigned just above
the `if()` block and clearly points into the `info` structure. So you must
not release that `info` before printing the error. The order of statements
is correct.

> > +       if (grab_oid(&info->b_commit, "%s^1", revision) ||
> > +               grab_oid(&info->w_tree, "%s:", revision) ||
> > +               grab_oid(&info->b_tree, "%s^1:", revision) ||
> > +               grab_oid(&info->i_tree, "%s^2:", revision)) {
> > +
> > +               error(_("'%s' is not a stash-like commit"), revision);
> > +               free_stash_info(info);
> > +               return -1;
> 
> Here also.

Yes, here, too, `revision` points at a field inside `info`, so we must not
release it before using it.

> > +       if (info->has_u) {
> > +               if (restore_untracked(&info->u_tree))
> > +                       return error(_("Could not restore untracked files from stash"));
> > +       }
> 
> Maybe:
> 
>        if (info->has_u && restore_untracked(&info->u_tree))
>                return error(_("Could not restore untracked files from stash"));

I agree with this, as it avoids an unncessary indentation level.

> So maybe we can get rid of `result` and have something like:
> 
>        if (argc < 1) {
>                error(_("at least one argument is required"));
>                usage_with_options(git_stash_helper_usage, options);
>        }
> 
>        if (!strcmp(argv[0], "apply"))
>                return apply_stash(argc, argv, prefix);

... except we have to use !!apply_stash() here: apply_stash() probably
returns -1 in case of error (at least that would be consistent with our
coding conventions), and the return value from cmd_*() is handed to exit()
as exit status. The `!!` trick turns any non-zero value into a 1, also
consistent with our coding conventions where we set exit code 1 upon error
in the "business logic".

> 
>        error(_("unknown subcommand: %s"), argv[0]);
>        usage_with_options(git_stash_helper_usage, options);
> }

Ciao,
Dscho
