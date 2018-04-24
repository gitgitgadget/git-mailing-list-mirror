Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1A331F404
	for <e@80x24.org>; Tue, 24 Apr 2018 08:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932974AbeDXIda (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 04:33:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:51739 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932840AbeDXId1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 04:33:27 -0400
Received: from [10.49.234.97] ([95.208.59.141]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lbdl5-1ehppt46Rf-00lG99; Tue, 24
 Apr 2018 10:33:19 +0200
Date:   Tue, 24 Apr 2018 10:33:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Philip Oakley <philipoakley@iee.org>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v8 08/16] rebase-helper --make-script: introduce a flag
 to rebase merges
In-Reply-To: <0023E61D311849B68FECAE76613839C4@PhilipOakley>
Message-ID: <nycvar.QRO.7.76.6.1804241032030.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524139900.git.johannes.schindelin@gmx.de> <cover.1524306546.git.johannes.schindelin@gmx.de> <ff71f636d5171359d94097423b8e9e340ab2152a.1524306546.git.johannes.schindelin@gmx.de> <0023E61D311849B68FECAE76613839C4@PhilipOakley>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:m3dDY6+f8SrEqBkHhh6TpOTPqU0w8RRyeAuFChw+RZkGhwaU7cX
 2ieCjoi00OC7FlJVuhBiWX4cxruOYEKJjEliZsbEIRPT5YPTXf4rbSV2uEo3le9mRQKYyGd
 CAbgba4aGliDXHYqMCjUMc+n2VXAiRLJ+xfPKK23hS120WutQwIe3rexesIqRfHvxT5rPyc
 t0+1co389Nthda8p+HU6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bnnVRJIIWw0=:ptJSsYv9Aq0mIoTXBTwtbL
 UQBg4HdOQ7hBnuE/Rpf7/fGF9iYhr+/9Qn8/KM2PZVKPB9k5l2etjZ2X9pucZSVpPPJhPgY4+
 ro9eu8eYlq2nL/fcLk4gPuOjdl5gYxJ3BYx0fq4tabd7odK4LVCrCpHBxFxEexWbO+muROCvA
 WA0kovu6grMRxc+B5rJEeVtyceyVp1IbCzlc3T82GMO4nVUJx1DzJX0tfrau2ZHCTL4wz7XEm
 tGF63dI8QkwcqQX0ZULYFvdOnl1lLM3nA6D4i1NqdTbPB4GedPpRSE8s+MQnSikQ1VRjjfPQI
 B629Jf+x6WTdBx1GUAK7LE2QfLFW449YmSoZcsR1pUF7cRN9MEBW6uqEO1EOZKbHFbEo6Rv5T
 C9+7BnBGfgeZIay9Z9+pGaPPwsVpLGblm9XoWxF1YC13PTa1WOSWY9tgp/yyovmrWal8DBX7o
 qs8+lKtZprZrJit2sor+8OgZ23/kbTpm4gCh6dZjKGAzQcClsXWM0LuT+i9U6fTEEWq7Rg/1v
 x4e285538ihoGRkHiDACdmvj42UMsWK7Yr7bXdr50gkjjxHoDvD+gw3B2dvFwiWPWnFSfWPOl
 Etkyoi7HL59r2lLrJeW8dBUpYXfD/P3xX6BYd3U8fhwU46vchrD0WalGF60n9eHzkkt7+FbpC
 6uX0s7ZB/XLQtYy+fxlBPUA+o/jvQFgHIWM0xQT5iBGpiMZH8UQwrbSRfpP9Sxor5u2veUMqt
 5AekDUFVUWO/yt19WKxb7cKbQkWvH8Cl6MEXFVj2RXw16EgSCjbX3zmGj3tZ/KutOQmDv8SfJ
 8brj9I7HrE6H8S0aupzkxHvFbfFrGafO9QpB1E0iIjyGwrPDu8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip,

On Sun, 22 Apr 2018, Philip Oakley wrote:

> From: "Johannes Schindelin" <johannes.schindelin@gmx.de>
> 
> Sorry for the very late in the series comments..
> 
> > The sequencer just learned new commands intended to recreate branch
> > structure (similar in spirit to --preserve-merges, but with a
> > substantially less-broken design).
> >
> > Let's allow the rebase--helper to generate todo lists making use of
> > these commands, triggered by the new --rebase-merges option. For a
> > commit topology like this (where the HEAD points to C):
> >
> > - A - B - C
> >     \   /
> >       D
> >
> > the generated todo list would look like this:
> >
> > # branch D
> > pick 0123 A
> > label branch-point
> > pick 1234 D
> > label D
> >
> > reset branch-point
> > pick 2345 B
> > merge -C 3456 D # C
> >
> > To keep things simple, we first only implement support for merge commits
> > with exactly two parents, leaving support for octopus merges to a later
> > patch series.
> >
> For the first time reader this (below) isn't as obvious as may be thought.
> maybe we should be a little more explicit here.
> 
> > As a special, hard-coded label, all merge-rebasing todo lists start with
> > the command `label onto`
> 
> .. which labels the start point head with the name 'onto' ...
> 
> Maybe even:
> "All merge-rebasing todo lists start with, as a convenience, a hard-coded
> `label onto` line which will label the start point's head" ...

I changed it to

    All merge-rebasing todo lists start with a hard-coded `label onto` line.
    This makes it convenient to refer later on to the revision onto which
    everything is rebased, e.g. as starting point for branches other than
    the very first one.

Ciao,
Dscho
