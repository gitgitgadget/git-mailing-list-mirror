Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB4341FBB0
	for <e@80x24.org>; Sun, 27 Nov 2016 11:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbcK0LKf (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 06:10:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:51649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753640AbcK0LKd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 06:10:33 -0500
Received: from virtualbox ([37.24.142.44]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mh5h7-1cOTtj0q6D-00MLii; Sun, 27
 Nov 2016 12:10:26 +0100
Date:   Sun, 27 Nov 2016 12:10:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 2/2] difftool: implement the functionality in the
 builtin
In-Reply-To: <2994b0d6-4b6c-84e7-d0d5-257bcae3be98@gmail.com>
Message-ID: <alpine.DEB.2.20.1611261407520.117539@virtualbox>
References: <cover.1479938494.git.johannes.schindelin@gmx.de> <cover.1480019834.git.johannes.schindelin@gmx.de> <ac91e4818cfb5c5af6b5874662dbeb61cde1f69d.1480019834.git.johannes.schindelin@gmx.de> <2994b0d6-4b6c-84e7-d0d5-257bcae3be98@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-97940366-1480245026=:117539"
X-Provags-ID: V03:K0:NzW5Ie9QMd5USM8/szxXqs/dYrARNwn398moCNNfGnGFziK+0dg
 g7QVlg+7VsX9G7UyxOI8KPPg0xOR8IuE4MhOMwzqRqZROWQgdzse1hYz/1za5sgb75GGLUG
 jg0oMgeZpc72IA2BU3UHyKu8G5L9P3yxmVFfZilUX/iHrKjEi2FeUJyXEfM6V9GO7gXUFw7
 izAqi6mBRRNr/faNqbkGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zDy1hCFYJSo=:F/AjPqicsfZBTO2Zeq5rvO
 pi3Dlzstm93DE9rTUTsXS8JBXInI+91EYqY3aFren4sqvX8U0O17NJ103YHEEDnTJ8k0QiEZ1
 wJ/UKc61h76v7MJ/6QThnoLhM4naCWBr5cGvZVvrpCp+Z4B+JoZboRQLhdDfvVybv21hkqXvX
 BvKOQXlpBuefOE7TKscNLO+mly/+CfNtAdI6s9UeAu3umkk6NY90EWuZOsyJHet+olR/CSq5e
 3PKdh20gzW5IGITJrXziJmcdRipnfYy0PJAXwScRYYI2D7jewE/+caKO0FuSwdOO2ivp1EGFh
 2eJj0zaFm4zpdoyN2vJWYtVuldt9tBQJTtDezeRZeozv3auBoLCYNJ9cwJsyG1lOrzmdESGCS
 0WF62QM6UvwLp+Vwe/2zJo5r6zyNQrWB7H0ZyJ8wVg0DOwPRgCr7d66Tqu8Ofsw9pHr6MKVPq
 AiTuq72/M2/flcthBuR1nCwn04Ps8cUCsmwRo3h2pxI0lSM94G3c3DLWUe2uW099bmm1+Jz57
 bM+v/cemiOalOGrXcaUiAWcKkIS8yYtolxRHiElmOOEVasfudoSeLkt5auY/1TVuzooUj2DKW
 KQVGQmW8ZolUYeXYbhOrvmgtON11BRJymUi/BamU4ClEuqW3W+RGA69qAe3VRxqTg7qBUicRw
 3BCf/wciqCqgVBfSOLVVpz5oo3z9qPPHsDROrh68kaF7mH7y/9N+WDiw2gGtck677BiuXbfRI
 wLd32vsvyHe9aPfPPEcAhjQOf9ZrvNtc+aAqQSAMXZHlKCz1KbWBupX6S+v6X0sbUf1b+Lt8P
 nteBELv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-97940366-1480245026=:117539
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Jakub,

On Fri, 25 Nov 2016, Jakub Nar=C4=99bski wrote:

> W dniu 24.11.2016 o 21:55, Johannes Schindelin pisze:
>=20
> > The current version of the builtin difftool does not, however, make
> > full use of the internals but instead chooses to spawn a couple of Git
> > processes, still, to make for an easier conversion. There remains a
> > lot of room for improvement, left for a later date.
> [...]
>=20
> > Sadly, the speedup is more noticable on Linux than on Windows: a quick
> > test shows that t7800-difftool.sh runs in (2.183s/0.052s/0.108s)
> > (real/user/sys) in a Linux VM, down from  (6.529s/3.112s/0.644s),
> > while on Windows, it is (36.064s/2.730s/7.194s), down from
> > (47.637s/2.407s/6.863s). The culprit is most likely the overhead
> > incurred from *still* having to shell out to mergetool-lib.sh and
> > difftool--helper.sh.
>=20
> Does this mean that our shell-based testsuite is not well suited to be
> benchmark suite for comparing performance on MS Windows?

It is quite likely the case that shell-based testing will always be
inappropriate for performance testing. Even on Linux.

> Or does it mean that "builtin-difftool" spawning Git processes is the
> problem?

At the moment I would have to guess, and I'd rather not.

> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/difftool.c | 670 +++++++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  1 file changed, 669 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/builtin/difftool.c b/builtin/difftool.c
> > index 53870bb..3480920 100644
> > --- a/builtin/difftool.c
> > +++ b/builtin/difftool.c
> > @@ -11,9 +11,608 @@
> >   *
> >   * Copyright (C) 2016 Johannes Schindelin
> >   */
> > +#include "cache.h"
> >  #include "builtin.h"
> >  #include "run-command.h"
> >  #include "exec_cmd.h"
> > +#include "parse-options.h"
> > +#include "argv-array.h"
> > +#include "strbuf.h"
> > +#include "lockfile.h"
> > +#include "dir.h"
> > +
> > +static char *diff_gui_tool;
> > +static int trust_exit_code;
> > +
> > +static const char *const builtin_difftool_usage[] =3D {
> > +=09N_("git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]=
"),
> > +=09NULL
> > +};
> > +
> > +static int difftool_config(const char *var, const char *value, void *c=
b)
> > +{
> > +=09if (!strcmp(var, "diff.guitool")) {
>=20
> Shouldn't you also read other configuration variables, like "diff.tool",
> and it's mergetool fallbacks ("merge.guitool", "merge.tool")?

No, as those configuration variables are not used by the builtin difftool
directly but read by subsequently spawned commands separately. There would
be no use reading them here, for now.

> > +static int print_tool_help(void)
> > +{
> > +=09const char *argv[] =3D { "mergetool", "--tool-help=3Ddiff", NULL };
> > +=09return run_command_v_opt(argv, RUN_GIT_CMD);
>=20
> This looks a bit strange to me, but I guess this is to avoid recursively
> invoking ourself, and { "legacy-difftool", "--tool-help", NULL }; isn't
> that much better.

This is obviously a straight translation of the Perl script (see
https://github.com/git/git/blob/v2.10.2/git-difftool.perl#L40-L46):

=09sub print_tool_help
=09{
=09=09# See the comment at the bottom of file_diff() for the reason
=09=09# behind
=09=09# using system() followed by exit() instead of exec().
=09=09my $rc =3D system(qw(git mergetool --tool-help=3Ddiff));
=09=09exit($rc | ($rc >> 8));
=09}

I read the rest of your review, but it appears that it is more about
style than about substance, while I am only willing to address the latter
issues at the moment. You see, I want to focus on getting difftool correct
first before attempting to make it pretty.

Ciao,
Dscho
--8323329-97940366-1480245026=:117539--
