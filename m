Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D2661F404
	for <e@80x24.org>; Mon, 12 Feb 2018 20:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932368AbeBLUrI (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 15:47:08 -0500
Received: from mout.gmx.net ([212.227.15.19]:49051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932153AbeBLUrG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 15:47:06 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx003 [212.227.17.190]) with ESMTPSA
 (Nemesis) id 0M2cYX-1eULum2V1R-00sOgQ; Mon, 12 Feb 2018 21:46:57 +0100
Date:   Mon, 12 Feb 2018 21:46:56 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 04/12] sequencer: introduce new commands to reset the
 revision
In-Reply-To: <CAPig+cRVK3r2fSM77=L0zx77oBPyia_8ju79x6WJPT2U5o8e+A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1802122145560.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1517266437.git.johannes.schindelin@gmx.de> <cover.1518307771.git.johannes.schindelin@gmx.de> <6c1e131d2eb26534869c06b714cc5cc729004a41.1518307771.git.johannes.schindelin@gmx.de>
 <CAPig+cRVK3r2fSM77=L0zx77oBPyia_8ju79x6WJPT2U5o8e+A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fTSSgQvU6i0W6nchqaw3ENjqLZXx4pavTiC/jyrqyef3Lqi3s9b
 7WS4z/omA2V31W9o9vBbXxVCIzz7vqSjJ9u7VPoa1bgf6Cn9qH9TSFtGrUbcwuNw20DjyhB
 GYWoLFVMx/97dWI6bnNcdtOu4uziC5Z3vdjp8LgC1DvweLSxNUVL6Sti9iZVfrRk0LfoMhS
 5bPPcm9+KTirAjJ7HmRJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mPNnahKuCNk=:WPgDC0CQ31qb77N55a8Dli
 Xz012oADErHNy3gxz7fEnVx+TyICB/GxxSo2uCQzRmc4m2hU2+MAYcBkAaW2hlP1vYCSPgmU4
 u2jMWE9DftKVzib4+Ed8IFyfD2tqs6GuZB2bhgSV6fmN0LcEyHWrbDUTSE25sNilMZqoRDKcL
 KyneiH1XCQTtJgyDI4CD865Rawd9ckzSFoDmn+oaV6r3j/wmCAXe9IsXLCfYKaItpHMqbo1I3
 CqJb0TSw3tx3RjLm/XPRRa48RHFgjdKoFfTJywyy8OG1MV57Pl5cp7D0PNfgUBNp1Ze5gZXqH
 kTlAQbQfvQhI2t2Kq4ZKKGU2DhrWmTNeJFd3CmniQAOVKitwRUuegSkZcL7JtPR9FjEaGiBgV
 nEkV3NTVl83gXz8pKDLcarNGCkK0pj0Jls9B8yDKdzXgYvc3cvPaDGxchzMQMB8OROX9V6DXR
 XXu7XH7jfRbD2rZEkYtNK0X30t+KiOsHJJh0l3xxFVV7Y81Qurl86MrmnW6ChN+1vUGT7L4iK
 /+PVECKZjjN/MozXU1k+r6cxTxZQER20D5UHUaTuNPsDtsJlVoULOOZamRgd7a/cl5fjLgG2m
 vAn4F1RMEfVEH1GJc7yK97rcYL3XPCj5XmTzZO9GdvwCidXdTdy4GYnH034YPoOw3V9znQ+2q
 pMQm0RLiZBDYNQJ86TWz74etNq8yGG1uDYdkiZmuB5YyPRlCBGwCukBPt7qQyuogKaffG/uZM
 Pbph3EQR6kT6K3nlY0gD/xH/nMc0AKKSf2acmDlXLtR1Ur4cegxZsNqJ8CN/FckvfcV5esThG
 j/eE/dwJu6FTUHt7XtXxWaS+ybsXsAueUd3nmYrzg0adi5yP94=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 12 Feb 2018, Eric Sunshine wrote:

> On Sat, Feb 10, 2018 at 7:10 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > [...]
> > This commit implements the commands to label, and to reset to, given
> > revisions. The syntax is:
> >
> >         label <name>
> >         reset <name>
> > [...]
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/sequencer.c b/sequencer.c
> > @@ -1922,6 +1951,151 @@ static int do_exec(const char *command_line)
> > +static int safe_append(const char *filename, const char *fmt, ...)
> > +{
> > +       [...]
> > +       if (write_in_full(fd, buf.buf, buf.len) < 0) {
> > +               error_errno(_("could not write to '%s'"), filename);
> > +               rollback_lock_file(&lock);
> 
> strbuf_release(&buf);
> 
> > +               return -1;
> > +       }
> > +       if (commit_lock_file(&lock) < 0) {
> > +               rollback_lock_file(&lock);
> 
> strbuf_release(&buf);
> 
> > +               return error(_("failed to finalize '%s'"), filename);
> > +       }
> > +
> 
> strbuf_release(&buf);
> 
> > +       return 0;
> > +}
> > +
> > +static int do_reset(const char *name, int len, struct replay_opts *opts)
> > +{
> > +       [...]
> > +       unpack_tree_opts.reset = 1;
> > +
> > +       if (read_cache_unmerged())
> 
> rollback_lock_file(&lock);
> strbuf_release(&ref_name);

Thank you very much! I fixed these locally and force-pushed the
recreate-merges branch to https://github.com/dscho/git. These fixes will
be part of v4.

Ciao,
Dscho
