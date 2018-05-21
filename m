Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1550F1F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeEUSLX (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:11:23 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:50718 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbeEUSLW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TyYzVmIbCdFv2KyCjGW3zPbrRrRFMCX8FLW46xjxc1w=; b=nWGoA9QNMov7Zf42eUL5r1m72
        5DMXHM34sT5L8cJirDqBlF7qvuiMMCFiTc2mu5O+KUzN81+m3d7CQFtP1IUCxaJ2TpxnRd2v5cjmU
        npygPa0e/GynD/LusP/xgd7TlCDIZk0DAbbaJO0o62DPVFvhonpFSd/AS4FesiSzE2D/5jQdvmO0N
        goAzcjmOeeNq7DPNO7/SD60vqfC3SzQmL4obhYWyIH+0Nn/gAjP3IYU11k4zqR+nMF/DkjVyJGmDx
        n6RP6m7I9cT9BWi4M2ARY3yXTgIOGVMXyjM3Tl2X1L/xfQ3TWptz78/LbYR8wfohsmnp5fpkkCqPg
        sz6r6TSdg==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:53558 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fKpHD-00GqAc-Bk; Mon, 21 May 2018 14:11:20 -0400
Date:   Mon, 21 May 2018 14:09:49 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: which files are "known to git"?
In-Reply-To: <20180521175335.GC10623@aiede.svl.corp.google.com>
Message-ID: <alpine.LFD.2.21.1805211405410.21888@localhost.localdomain>
References: <alpine.LFD.2.21.1805210717040.9926@localhost.localdomain> <CABPp-BH0bw3m5Ubz2+-XyFGwoHD96sAaSen9-SHQSBqMS-9u5w@mail.gmail.com> <alpine.LFD.2.21.1805211335250.21160@localhost.localdomain> <20180521175335.GC10623@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 21 May 2018, Jonathan Nieder wrote:

> Robert P. J. Day wrote:
> > On Mon, 21 May 2018, Elijah Newren wrote:
>
> >> Hi Robert,
> >>
> >> I had always assumed prior to your email that 'known to Git'
> >> meant 'tracked' or 'recorded in the index'...
> >
> >   i *know* i've been in this discussion before, but i don't
> > remember where, i *assume* it was on this list, and i recall
> > someone (again, don't remember who) who opined that there are two
> > categories of files that are "known to git":
>
> My understanding was the same as Elijah's.
>
> I would be in favor of a patch that replaces the phrase "known to
> Git" in Git's documentation with something less confusing.

  first, i want to apologize to everyone for opening this apparent can
of worms. (it's victoria day here in canada, and i intended to spend
it just puttering around with git-related minutiae, not encouraging
thought-provoking questions about the fundamental nature of git.)

  i did a quick search for that phrase in the current code base and
came up with:

builtin/difftool.c:		/* The symlink is unknown to Git so read from the filesystem */
dir.c:		error("pathspec '%s' did not match any file(s) known to git.",
Documentation/git-rm.txt:removes only the paths that are known to Git.  Giving the name of
Documentation/git-commit.txt:   be known to Git);
Documentation/user-manual.txt:error: pathspec '261dfac35cb99d380eb966e102c1197139f7fa24' did not match any file(s) known to git.
Documentation/gitattributes.txt:	Notice all types of potential whitespace errors known to Git.
Documentation/git-clean.txt:Normally, only files unknown to Git are removed, but if the `-x`
Documentation/RelNotes/1.8.2.1.txt: * The code to keep track of what directory names are known to Git on
Documentation/RelNotes/1.8.1.6.txt: * The code to keep track of what directory names are known to Git on
Documentation/RelNotes/2.9.0.txt:   known to Git.  They have been taught to do the normalization.
Documentation/RelNotes/2.8.4.txt:   known to Git.  They have been taught to do the normalization.
Documentation/RelNotes/1.8.3.txt: * The code to keep track of what directory names are known to Git on
t/t3005-ls-files-relative.sh:			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."
t/t3005-ls-files-relative.sh:			echo "error: pathspec $sq$f$sq did not match any file(s) known to git."

so it's not like there's a *ton* of that, but still enough to want to
get it right. should there be a precise definition for the phrase
"known to git", or should that phrase simply be banned/replaced? i
have no idea, open to suggestions.

rday
