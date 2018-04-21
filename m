Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED8811F424
	for <e@80x24.org>; Sat, 21 Apr 2018 07:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeDUHZT (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 03:25:19 -0400
Received: from mout.gmx.net ([212.227.17.20]:41683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750844AbeDUHZT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 03:25:19 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MATlG-1fFoFE0Y6k-00BcmU; Sat, 21
 Apr 2018 09:25:14 +0200
Date:   Sat, 21 Apr 2018 09:24:57 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/4] sequencer: leave a tell-tale when a fixup/squash
 failed
In-Reply-To: <CAGZ79kaQXWi0GmHH_6D_yeQU=M3W_esAy6Y7QweDzp07x7z7dQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804210922240.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524258351.git.johannes.schindelin@gmx.de> <c23608f35af1ac9b8f7e0b9c17e2fa1fdf189ab1.1524258351.git.johannes.schindelin@gmx.de>
 <CAGZ79kaQXWi0GmHH_6D_yeQU=M3W_esAy6Y7QweDzp07x7z7dQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iAYegHQ0cXiaXG6PGl4t0+tmk1uAnIHBdrF+AKA8SwvyWS4xpIw
 mkZOD/n4VR0iiWEX9USQ4Yd2/0GlF8us7c5JBcAMrkJO1WEPfi27lG+JfcDPMiUEIdUc7vS
 +UMSqC68vUgLscTtnmS64frssPFM21zkr7mcT7BNOReEPszqksSZapKTb8iBRK4wGgLO2G/
 CCZUqO5aKgfRLkprNAGBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NxhUfAK26F0=:Zj8zF+YJJtXb8PzTsjp+/4
 EZ67GVqlit/uumY8mVRhwEOjWFPPOa4VwJMx9yIcrwxVvSQsSYtiJsRb+XX5wDsHUooqxS96V
 MOVA1mbVrbBAIzdDU/0XolP+ombCz6Dob+OWcqtPTB6YKgXapz7xiuV4F/lbwA4YN30wUvBrG
 PH1cdacKuLOqA/g8grRYBpnJBxPD7nNkx1fCPpzAEMt/IaJUh3coRImVT+3IHKewe5JbafgbB
 cHMxlP4nJIS71zXn8bEPPz2vruY3K64uezSbKQPQUrGiQz7a3O1BjUGOVtWz9X9G5nbtGTD/S
 EIbbH+06Kt5gvob3lw0AMPZAoQyfIMWT20dOeGDdMg1l8dDlQw1xBLOob5kKNgMANiE40fhdQ
 J9wh0fvPEkXnxtrI0PFS/bFrmroLH49HZnWFbhKTvfHm31emZNa4uAyghAelBZwGxKIV0XcCB
 5gW3bBqPBQXHCs4nzBhkGmuhPcKXmHmVL9bzN5cCRITXqLaYYW+2p8iMBrHAQtkzcj/LCfCvP
 H8qKCgLw/alq2E1RgTPdC4riAQwU/kdBtjTLWrawszVrFHRMJCFbJX709hX+YpyXvWrrUXmiJ
 c0Xo6ApvutaNluFYkkuhSDaZ1xDmRR8nkFCNYtTE10ELC73DeL4syKgx2TJYBANjBzgtcS8mg
 f9SfvNTYsVvAErUVp1EUw4AAAX7ucKFJPIJQBqLNJbjjswLQLHx1PLzWfT0dT7uAnZnpRR1ca
 CHeoT+nyyWzXRAf1YAjun9bgpL4ovQkswl7LDGgjPnQD6TJ2QJ6jRy44L6Muev2NLLluJ3Rsv
 A1kbnUYSVy09j3pyp+pfsd9Sm/PkJeric4QTBOf4WWQ+AaksA4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 20 Apr 2018, Stefan Beller wrote:

> >  static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
> > +/*
> > + * If there was a merge conflict in a fixup/squash series, we need to
> > + * record the type so that a `git rebase --skip` can clean up the commit
> > + * message as appropriate. This file will contain that type (`fixup` or
> > + * `squash`), and not exist otherwise.
> > + */
> 
> Thanks for the documentation here, is there some other high level doc that
> describes all things to know about the internals of the rebase-merge dir
> or is this the definitive guide?
> 
> > +static GIT_PATH_FUNC(rebase_path_amend_type, "rebase-merge/amend-type")
> >  /*
> >   * When we stop at a given patch via the "edit" command, this file contains
> >   * the abbreviated commit name of the corresponding patch.
> > @@ -2400,10 +2407,20 @@ static int error_with_patch(struct commit *commit,
> >  static int error_failed_squash(struct commit *commit,
> >         struct replay_opts *opts, int subject_len, const char *subject)
> >  {
> > +       const char *amend_type = "squash";
> > +
> > +       if (file_exists(rebase_path_fixup_msg())) {
> > +               unlink(rebase_path_fixup_msg());
> > +               amend_type = "fixup";
> > +       }
> > +       if (write_message(amend_type, strlen(amend_type),
> > +                      rebase_path_amend_type(), 0))
> > +               return error(_("could not write '%s'"),
> > +                            rebase_path_amend_type());
> 
> Do we want to wait with unlinking rebase_path_fixup_msg()
> until after we are sure there is no error returned?

Actually until after the rename() of `rebase_path_squash_msg()` succeeded,
you are right. I had changed the behavior unintentionally.

> I first thought so as to preserve the state as before, but
> then it only signals the amend type. But we're downgrading the
> amend type from "squash" to "fixup", which means that if
> this error happens and the user just retries the git command
> we'll end up with a "fixup", i.e. not opening their editor?

I am actually more worried about the rename() call failing... ;-) I
changed the order back to where it was before.

Thanks,
Dscho
