Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914BA20437
	for <e@80x24.org>; Tue, 31 Oct 2017 17:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbdJaRJL (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:09:11 -0400
Received: from mout.gmx.net ([212.227.15.19]:52071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752177AbdJaRJK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:09:10 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M08eS-1dHbR11UUO-00uM9M; Tue, 31
 Oct 2017 18:08:59 +0100
Date:   Tue, 31 Oct 2017 18:08:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] mingw: document the experimental standard handle
 redirection
In-Reply-To: <CAPig+cQs+6xCn=OR_Mw8vbEwEJ0c=sqnaEChOxuVw=kV4PQwsw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710311807420.6482@virtualbox>
References: <cover.1509382976.git.johannes.schindelin@gmx.de> <436f0fb010709fe0d90460dc7bc1b3482237b192.1509382976.git.johannes.schindelin@gmx.de> <CAPig+cQs+6xCn=OR_Mw8vbEwEJ0c=sqnaEChOxuVw=kV4PQwsw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kBDvFzaPhuRjU478GKnVE+uPlrYsWKbWqt0JVJ5/de6xMIn9jn1
 E8SLjVrQARg5xkrzWS266cEfq1oCvEwSy0yrVnPCDSy8FNW5egrbMI/f8KDkbPcvDURUeXI
 moqIxShXxY3hWrt9PmIGh8GEQ9fYj2dpvkHDTpE66ujMdr2tep/vNoHiUOQcystCAGKEXKH
 qnBzG2DFQglqj36MHiYcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LlNSMdkLIY0=:LCiZk5jk4s7IijRX5IKLyY
 8J8qAYIGEDEkT40o2SPYVnnFWiF/1GoC/DYs2o6PFjCWoSdgsTtdhPyr7vv2FnuTVF7Amjv15
 hZjMKlHTbG4PpRYTMW3g65w61EZOm4XtNd54FwrSJXLEwjW0nBM35U9rs7bou0HxiKdea7aPL
 gW50YG9xVstMYn1t1uDdYT60eIyMg6HcQaFj/lsPivOoZhZRp+QkrEr3tReZhSqjUsbxw94FB
 OWn7dmX+aTVGwZv1v+78M0naRAoyTorhSDJERMgKk7DMRyGF1AOr9QxV0mWY7N11kgYsmtL11
 b39J0Z5VR+kUhbiuLTTsQEaGaK6ECaRhvMP9EZeFtMHbAxPAri6qFwijCUJilkGqC5pG45Nlv
 4QxcYHlNV70K6UZYghjpxpQM3uVmU++JiGwIqj9RcqcRDCE8++wxwYSVrAEUK9LVWs06wi1FN
 N8IMD18WoTeyPrjTZcCR65ZIeMInvTDyPWhKFEAptiWYivKJzSbz07F5iyEYdLwzJexpzwbuZ
 VNkeNuYHUH/S1ZTrMcE/IHtpedG0JXfKU7469bdjvS8ChSsfZtEnIr39mM1MTF8kMxT2r4ymX
 guQIsCOS/v7f6N4oXF935LU7VI0uZTgSQR1DfXdsYpwwpUaMrHbyID3Wac7jlmZmuMeFIxdSf
 UTF8It7OoqMTVWx1GXb2Z28l/8oADcjK3Qr31wOM5c6M/PoAcHzWMSyWOHKabyGrVQ2Jkv58r
 TMQukyK4XAPzl0P4DscznE9vfVtKlLI1rPl7RdMQx8qTY1HFYZJpdRFqQ8ivIvFEhgC/h6zXo
 502VGhirjfKCfOGbu8uWTrSpcgjKd0u5mw/wVb3dHs16y0krH87Fw2I6wOGff+eDhsnjcqF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 30 Oct 2017, Eric Sunshine wrote:

> On Mon, Oct 30, 2017 at 1:10 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > This feature is still highly experimental and has not even been
> > contributed to the Git mailing list yet: the feature still needs to be
> > battle-tested more.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > +`GIT_REDIRECT_STDIN`::
> > +`GIT_REDIRECT_STDOUT`::
> > +`GIT_REDIRECT_STDERR`::
> > +       (EXPERIMENTAL) Windows-only: allow redirecting the standard
> > +       input/output/error handles. This is particularly useful in
> > +       multi-threaded applications where the canonical way to pass
> > +       standard handles via `CreateProcess()` is not an option because
> > +       it would require the handles to be marked inheritable (and
> > +       consequently *every* spawned process would inherit them, possibly
> > +       blocking regular Git operations). The primary intended use case
> > +       is to use named pipes for communication.
> > ++
> > +Two special values are supported: `off` will simply close the
> > +corresponding standard handle, and if `GIT_REDIRECT_STDERR` is
> > +`2>&1`, standard error will be redirected to the same handle as
> > +standard output.
> 
> Consistent with the Unixy special-case for '2>&1', I wonder if the
> 'off' case would be more intuitively stated as '>/dev/null' or just
> '/dev/null'...

I feel this is the wrong way round. `>/dev/null` may sound very intuitive
to you, but this feature is Windows only. Guess three times how intuitive
it sounds to Windows developers to write `>/dev/null` if you want to
suppress output...

:0)

Ciao,
Dscho
