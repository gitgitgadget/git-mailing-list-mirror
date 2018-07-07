Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B5121F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 11:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753940AbeGGLeY (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 07:34:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:49091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753937AbeGGLeX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 07:34:23 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LkOaJ-1gDrNq161z-00cP7p; Sat, 07
 Jul 2018 13:34:17 +0200
Date:   Sat, 7 Jul 2018 13:34:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 01/20] linear-assignment: a function to solve least-cost
 assignment problems
In-Reply-To: <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1807071320110.75@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com> <xmqqtvpcgf40.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2L4qUVns+t2elXf+ebr1qrfmNjmBOA9eoQI+OnLmhRYsqjTdKcW
 TjBfnBknfsBqrcNaAa+84GKv3dqX7f1KVbvnW6vUakrKKE/JnqN6ODKkz6gdMwFjCdIaFLi
 T551PXlhw8en6bwXurZoc3Q/uNaWY5/4nzT1xvX7uBPO1uP0P5VDJvv3MvA/cLEUT10Xnds
 NQ50dAS8jyEIVGs5sc12Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ID197j5a3wM=:jbohhsYOWQRjTY2i6AZwUy
 Z4ClSlzVH3AkQL201k2lRPOnMnEpat9po7ZF6Bl2P2FLGcAxYK4W+IBb0fHnctPPjA8F0gqec
 XKPmBOri2VSVWMky/6DgXeX/2rpa1j6dkLvCrNfXmzsHIKIkixfDzMGDC9EA+qMPoDxvVxVTq
 bdjWjBww5CPYKEarsMR+Rvcb7tL0GdeVU+JFuNFzZyKcQR49RsTK1BF9sWIuLLYt7v4W8lGdp
 T9ISWgxhG1/YBfIU4uwujwcwxnTuUa1bfH0pkAf9Srstw6TGnTJlGee7TL8QbCsieltwXx7u9
 m1rxagRPmlai/Gvldszx7cN/ZfuuDihGNpYZiYdaTu+ILmlcFi7dgyX9j9/511CLtsFf5TFqE
 BsXbodmuPsqiq/DssK07skLIhLSD+C3v3gDFEoG8Z/kiv6sGSnR6ZibgT52ng4j11PByvcCpV
 +RpBGMzK8VYd79RN9k9pni9i+XV3Bu3a4DxeOhZnua77hJ1Nzg0LqdGEJ79SpIAeKMx6FF5YZ
 Ra9ih7xAoyUj4IR/0JqeJ2eaDR2HcgLCR06pSldHJi31T+y/lHEJ12X8aYow7nNB0mSZZi19v
 +LZPG3DdM1KjM4XobAU9BNp4T2dCHsKSAicR6cNMo4IjXpRDoUg8FgBCjG5mzRctxWFTGpeMm
 2To+Lz2xG5J/77ItaslO/h9In4NyCdTGXiA75VZdhT26cC8UclE5vjtBrFvOyH5C/G0hDiZnU
 UP9R6mGWIbgDvBu4/dh7aENFZ6XLiiWKegS/RgDhR+DhYOM0rOdGdRRYu0vayvCq7YQyS4Mct
 LH5k9UU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 6 Jul 2018, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The problem solved by the code introduced in this commit goes like this:
> > given two sets of items, and a cost matrix which says how much it
> > "costs" to assign any given item of the first set to any given item of
> > the second, assign all items (except when the sets have different size)
> > in the cheapest way.
> >
> > We use the Jonker-Volgenant algorithm to solve the assignment problem to
> > answer questions such as: given two different versions of a topic branch
> > (or iterations of a patch series), what is the best pairing of
> > commits/patches between the different versions?
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> Does the "gitgitgadget" thing lie on the Date: e-mail header?

No, GitGitGadget takes the literal output from `git format-patch`, as far
as I can tell. So if at all, it is `format-patch` that is lying.

You can compare the mail's date to the commit date:

https://public-inbox.org/git/39272eefcfe66de3ca1aa2ee43d6626ce558caae.1530617166.git.gitgitgadget@gmail.com/
https://github.com/dscho/git/commit/39272eefcfe66de3ca1aa2ee43d6626ce558caae

(the nice thing about GitGitGadget is that you can rely on its mails to
reflect *precisely* what the commit is like, the user does not have any
opportunity to interfere with the code that generates the mails:
https://github.com/gitgitgadget/gitgitgadget/blob/c4805370f/lib/patch-series.ts#L605-L611).

> Postdating the patch with in-body header is fine, but mailbox tools
> often use and trust the Date: timestamp when sorting and finding
> messages etc. so sending a new patch to add linear-assignment.c that
> is different from what was added 9 weeks ago with "Date: Mon, 30 Apr
> 2018" header can easily cause me to miss that message when I look
> for things that happened within the past few weeks, for example.

Well, isn't it too bad that we use emails to transport commits, then.

Seriously, I have very little sympathy here, as all I am doing is to
automate *the suggested usage* of `git format-patch` and `git send-email`
(the latter of which I cannot even use due to its limitations).

So if you want to see this "fixed", you should think how you want to see
`git format-patch` fixed.

Or maybe you want to write a script that re-orders the patches on top of
the cover letter according to the `[PATCH M/N]` order, to reinstate the
order of the original commits that got somewhat lost via emailing them.

Of course, you could also save yourself a lot of trouble and use Git:

	git fetch https://github.com/gitgitgadget/git \
		pr-1/dscho/branch-diff-v3
	git cherry-pick -s ..FETCH_HEAD

(This is assuming that you insist, as you did in the past, on changing the
base commit from what the original author chose. If you are fine with my
choice, which is the current `master`, then you could save yourself *even
more* trouble by just pulling my branch, and merely signing off on the
merge commit. Which would be totes okay with me.)


Ciao,
Dscho
