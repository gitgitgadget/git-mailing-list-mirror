Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 762CC1F4C1
	for <e@80x24.org>; Tue, 15 Oct 2019 17:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388506AbfJORjf (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 13:39:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:42675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfJORjf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 13:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571161170;
        bh=oeVIriFraFVcRlqWQxCA024A/i2r4zfHUF86sBEj9JA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fFcNK0oL3IYqHirDY7QAfbcWbpcSt9w6NhSEzv9UYopfQ6xoVKeeJToNRH44uPBkb
         6FiRjr3SiJvoXExup3xTvD4KUDGKNSSknm2Tjia6xANcpA9tK68gLdhWAm/++TSoYx
         Ks655XyfUS9P9I9yl8otoZnvzjlnrsONYcdrXwOU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2f5Z-1iLGPO3Gj1-004AyQ; Tue, 15
 Oct 2019 19:39:29 +0200
Date:   Tue, 15 Oct 2019 19:39:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2019, #04; Tue, 15)
In-Reply-To: <CABPp-BHnSG+PtnU=jKHW2_hfLtBK1Sib_W+nqY08gGj8yHGCgw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910151938280.46@tvgsbejvaqbjf.bet>
References: <xmqqh84abmjm.fsf@gitster-ct.c.googlers.com> <CABPp-BHnSG+PtnU=jKHW2_hfLtBK1Sib_W+nqY08gGj8yHGCgw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6CFemBxAOhflq0zvP7g7zuqR375pDrllrKA3s2v7f4Z3mKtxQVa
 UINGbaz3pXqSawPf9asC9W4+bUIbAejsyZv6XXn4GK1yo429XUUOwyPIdRuvzTwoeFdBRwX
 qbH0WVSjDYBeGl24drpRbXiYPEDynMbRMkSUfftSeu1Ja90jQntLZk1zRWzAzpui21s+2u3
 fkMFbgyrs3vf0FFFUyYDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zr1szmVqIck=:DdGcRBzZZI0DES8nWWCsth
 4OIiZfmRtI85+nGIJ8P5CCHVxYXEdXZFnBSlQdXITddEdJc6TAqZH2HMS6YW9n8gKICRr1m+I
 45LtjfhN8X38KWWr5iOqmToUwgWao1LiyZrzp4Y1L5RPBQ0JdWEF3azpUm8KIzY4pem3X40bZ
 KEp3zXxYYVeUIL5qGkGCgYXSx+VHoHRPk/E1/GfORgulAnWs5Os7PIrkXDTNskvyGFjYAqBYF
 2pZsGN/7xgeQzleK5L9O9QsZ/NOmsMpuZiEWfzoDDQi5ZSW9L30NFeuUw8gpiWWRk3dOwgZnp
 h8hXRTt/Y5sdYcRW7Xk8bWtf/VUoAh/OF8xavHxfp8iXMoZibLfKOPXjvmVJ2bZlYSdn2Ujq9
 f9MgZkmSJJj0CvgpnQImgwAwymhrIialoEhIMfbJFfQhRuNJUY6HCbvdh7yjThiDKT+Uz63Yd
 7gpaFQBmjKBHetBKs7fvyprESZ1afMkHceIGadOiOuNpAXQwtJ1fvLnl9CKwg6HCCniaNht8x
 IJ9RM2pYM/X8neKja25Y7t9APa5fLeaeorj4w3xIqU14iLI8FafUZEJkmm1yOx0C078tiv/3I
 WKGzH8O3GZhU4Cv/0+Y6kdt3Eek5IIbj3mNIObHIwF/uRsGwZI8mLJKQJuIoYRh6Wp6WE3S6O
 YkwGrghjg7aGuicXbb7WjzypK5LjIctBFip1MkB4TYiogRWZjDvDkbPrXXYb5Q0lrQ/gDs9H5
 GGf9fxYkpvNvm8v+KN0pGOmjAAVHFTe2K1t1+JHPXoYXc7vOxcnM349mP2TJwEXMSl1xqmq/S
 S3FFGcPkofuTlIb8FF3mG9Y33u1qtPft/7qzx6Qjz4Kvcp4w0/X89iftKdVLHG/tGhLV7TDhY
 vG2mpVtJzJOWdN/Dpjkq+cWI4VpVmOp2QPY5U2qNim/gnGB5VZtDqhiOyJ+WQs1+8PnI/tC+n
 BPYqCTz46j/35Ip9ITYfPiqXr9VvI7AL/R5/+dENp0Xo0Aa9xhJDuAW7h8rozwldMwa2IcZ2d
 H6ln4mj62OptTBXQiUa/qeXlcQ1Cnr8Dl3t86ystmFCUDKmwIxS6b5nQUMnUnUF3OVFLYEzBl
 AFjEWoRZYzL1NgItUA/0ZeZzYtxR/dh6ZK8WbHUqasNJsejAOJxaa5gJaTdt0Pot5Nz0X3M1y
 /EzKH/5ltVenOaKXdWUovjDlrsYaAtIsqVcXTOg4Mvr8+Bn+kgVGeFUwcV6fuElRGHYzCWZ2p
 3r3GQp+mjsa4h4DkWZv4e2TpXKIKFUWV4mK26boXrNskh6a5CvQQBno5ww4A=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 15 Oct 2019, Elijah Newren wrote:

> On Tue, Oct 15, 2019 at 2:04 AM Junio C Hamano <gitster@pobox.com> wrote=
:
> > * en/fast-imexport-nested-tags (2019-10-04) 8 commits
> >   (merged to 'next' on 2019-10-07 at 3e75779e10)
> >  + fast-export: handle nested tags
> >  + t9350: add tests for tags of things other than a commit
> >  + fast-export: allow user to request tags be marked with --mark-tags
> >  + fast-export: add support for --import-marks-if-exists
> >  + fast-import: add support for new 'alias' command
> >  + fast-import: allow tags to be identified by mark labels
> >  + fast-import: fix handling of deleted tags
> >  + fast-export: fix exporting a tag and nothing else
> >
> >  Updates to fast-import/export.
>
> Thanks!
>
> > * en/merge-recursive-directory-rename-fixes (2019-10-12) 2 commits
> >   (merged to 'next' on 2019-10-15 at ebfdc3ff7b)
> >  + merge-recursive: fix merging a subdirectory into the root directory
> >  + merge-recursive: clean up get_renamed_dir_portion()
> >
> >  A few glitches in the heuristic in merge-recursive to infer file
> >  movements based on movements of other files in the same directory
> >  have been corrected.
> >
> >  Will merge to 'master'.
>
> I'm surprised this one was merged straight down to next; perhaps I
> should have highlighted my plans a bit clearer in the thread?  I did
> mention (at the end of an email) at [1], that
>
> "Oh, and I think there's another place in the code that needs to be
> tweaked to make sure we handle renaming subdirectories into the root
> directory that I missed (and just wasn't tested by this testcase), so
> I'll check into it and if so fix the code and add another testcase,
> and include the fixups I agreed to above and send out a v2.  Probably
> won't get to it until the middle of next week, though."
>
> So, I guess I'll submit a fixup patch on top instead, either later
> today or tomorrow.
>
> Also, a very minor point but "glitches" may be misleading; it suggests
> (to me at least) a malfunction rather than a failure to trigger, and
> it's really only the special case of renaming/merging of a directory
> into the root directory that the previous heuristics failed to detect.
> The rest of the fixes were make-the-code-clearer (there were a couple
> places in the code that were technically correct but quite misleading
> and hard to reason about).

I also offered several comments that the regression tests could be
condensed into easier-to-understand ones.

Ciao,
Dscho

> [1] https://public-inbox.org/git/CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4Z=
PjcHmwS=3DkuFw@mail.gmail.com/
>
