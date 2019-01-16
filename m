Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F9CE1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 20:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfAPUl1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 15:41:27 -0500
Received: from mout.gmx.net ([212.227.17.20]:58195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbfAPUl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 15:41:27 -0500
Received: from [10.49.171.108] ([95.208.59.12]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbyUS-1h93nY3XTo-00jJlG; Wed, 16
 Jan 2019 21:41:21 +0100
Date:   Wed, 16 Jan 2019 21:41:04 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] t6042: fix breakage on Windows
In-Reply-To: <CABPp-BEXU7zbOgMK-JQJrNyyaek593okbWM10G1YCx0Gy0o=JA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901162137270.41@tvgsbejvaqbjf.bet>
References: <pull.109.git.gitgitgadget@gmail.com> <CABPp-BEXU7zbOgMK-JQJrNyyaek593okbWM10G1YCx0Gy0o=JA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xERUX5fNTL9Pnzotd+JW9HEEAUfS556H+4FirkIWlcp+4e8Muy7
 Jxpxy+p+U4Vk6O7PdbNtB2GCzlmv8Zkm1qrE/4rKNoA4WfauINSY9AGmP5rJLp2p+qKCXAh
 T906J+9gZjQSufw8vF2HT0wZtNr705aWQ1gToscibdGhMhXY4/4TkIuc8KfuffmpsXQTDwz
 MST5ukKKFTYBnIHZrl4uw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lu2dZ7/rHXM=:A1kdSHFB3VV3tlRJUDbQYj
 v1qpX9gaV0EZSHF8cTNg4PJk/jY0QU5n4aBRMNxOI1pvHGc4IujiKP5bCSPcv3Y1yUs8+kSZP
 OnlJ3WtqebjeXOyxcXcxAtRrJfhcqfNFOsotUvB5BdiXIoKUgliz11e9ycGoXR9dQ+MVeR8ex
 j6nE7dWj+t4dXJx2HGcC0MWvu+t1zcTA6YfDC+a8ULLrmTKWoPoK/Ns2PSf+CDHiSTpPaIz10
 14jMBYhMSNv0UTfn2scLZBpCgtrmNVk+xuSk09ZGvJz2OqsVX3LUkM9y4b0gUtnDlQoiqIXF7
 C1I6XhTq+gBG5pw2zIYgxWg2wqySLbaZYaKszNYpDZcixSC05WH0dU6SDdtodwgv6yvgLXWb5
 ZqdYvkStkiYJAH+cWldnQsbXEdwm4oGFCe8trX4fa8V0NbZX9b9UPrQLgd23uomHXOWVNpzem
 nYLPnidSHU9Bu98QJxNP1Q9TOYT5rOKgjn55vqJUx5yicnNun7pLwlTSFz1XLwBQ6nsUw1lFK
 f88b8/HoO5Xhq6Rr/oGJlsx0kWfTZ+G5RlOXorU2Ljl/1213y6teEQ/OMdFYrw1sMYJ/RV13r
 QshrM/7s/DJfg12YAABWbjTbPGX/O/xefgmIMs0xgOIsSRDeu2VeCs/meNFlz11IoC2EpL83J
 pSJhOuzkux87R0HBf/0wGVURydNAT1thALJ1Jfd49g5pHOB9BTvycbomA5fSxVgMiJVASZSOQ
 vN7ub37uo768usirHQGQQciONKTiIxaLulSjk/AZmn/iTQffKNEfStRRI3ccCi/ieFVcS4KZ9
 SNcn1c64iE46IKAFkObcAqcPD4AUbo6kJGBIvcU8lg/Bfxe/MXvJiayxjVrP45pEpelGl5vfd
 46MHoS742ffkaIX34G6ccklbsmKS+K+e2yh7JLiIs6kpPdCZJ7ewOnuZccTlKzf8kUgv4Ir+U
 7BHz11UGl8A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 16 Jan 2019, Elijah Newren wrote:

> Hi Dscho,
> 
> On Wed, Jan 16, 2019 at 5:37 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > Unfortunately, Travis decided to change some things under the hood that
> > affect the Windows build. As a consequence, master has not been tested in
> > quite a while, even if the test runs pretended that it had been tested :-(
> >
> > So imagine my surprise when master simply would refuse to pass the test
> > suite cleanly outside Travis, always failing at t6042, despite the fact that
> > Travis passed.
> >
> > It turns out that two files are written too quickly in succession, running
> > into the issue where Git for Windows chooses not to populate the inode and
> > device numbers in the stat data (this is a noticeable performance
> > optimization). As a consequence, Git thinks the file is unchanged, and fails
> > to pick up a modification. And no, we cannot simply undo the performance
> > optimization, it would make things prohibitively slow in particular in large
> > worktrees, and it is not like the bug is likely to be hit in reality: for
> > Git to be fooled into thinking that a file is unchanged, it has to be
> > written with the same file size, and within a 100ns time bucket (it is
> > pretty improbable that there is any real-world scenario that would run into
> > that, except of course our regression test suite).
> >
> > This patch works around this issue by forcing Git to recognize the new file
> > versions as new files (which they really are: the patch simply replaces
> >
> > git mv <old> <new> && mv <file> <new> && git add <new>`
> >
> > by
> >
> > git rm <old> && mv <file> <new> && git add <new>`
> >
> > which is not shorter, but even a performance improvement (an unnoticeable
> > one, of course).
> 
> Everything sounds good up to this final sentence.  I'm wondering if
> I'm misunderstanding or if there were some simple editing errors; in
> particular, I'm not sure what "even" means here (should it be left
> out?), and it seems like you meant "noticeable" rather than
> "unnoticeable" -- is that correct?

All I meant is that the test script now has less to do: rather than rename
a file and overwrite it, it is simply deleted and written anew. In the
filesystem layer, I would expect this to be a tiny fraction of a
millisecond faster. Not enough to matter, but conceptually it is simpler.

Since Git does not record renames (quite intentionally so, as can be
verified by reading the rather unruly arguments back in the day,
disregarding even valid arguments such as: if we *do* know better than
Git, why not provide a way to tell Git about renames?), there is no need
to use `git mv` in this instance, either.

Ciao,
Dscho
