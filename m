Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B51591F404
	for <e@80x24.org>; Thu, 26 Apr 2018 09:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755040AbeDZJv5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 05:51:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:54833 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754889AbeDZJvx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 05:51:53 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MEKZg-1f9QdK3h2e-00FQGN; Thu, 26
 Apr 2018 11:51:43 +0200
Date:   Thu, 26 Apr 2018 11:51:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/4] rebase -i: avoid stale "# This is a combinationof"
 in commit messages
In-Reply-To: <949b5749-d721-31ea-77a1-ec6406f3083a@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1804261135530.4978@tvgsbejvaqbjf.bet>
References: <CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com> <cover.1524296064.git.johannes.schindelin@gmx.de> <CAGZ79kbK7j0njrZ8-d_Da6+XyH_RVRhBu=hcpzr7EFsOCSFJVQ@mail.gmail.com> <12fa9a1f-9dc2-9108-132f-48b75ae5a8d3@talktalk.net>
 <nycvar.QRO.7.76.6.1804251442510.4978@tvgsbejvaqbjf.bet> <949b5749-d721-31ea-77a1-ec6406f3083a@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:EGXaKDFjRk54PSsLaou7uFzSIKomCgLwWgKjvTQ/WENpxi3eYU9
 6G1THOLK836JW38tPUpBeNzsbBPjZ/gVifzI7C1lkVKT5xfwUDHen1ktDy62ebONGzorInc
 JO7i0dOCbDXFmbSvQx0NqL2maWdBJ3OcEqAJcUWcVM5EFzEGT/jghxZTv33UytBnv+tx+HG
 gV+fuoYlsRY4MxPqG5nVA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Gnhl6gWIutc=:4sNHb5AxZnaswCvFjMqhLc
 wOOdwM3Lft6izJ8P6hHqagyz1pnHQoxT2YEdyNc5eBUSCGjhHkVJbJ7bv0WjhVkZeMeZ4+8Pu
 5f74t3r8WNIr9uHwNf6h1Xb7FD2ki6JQfnIdw72hoSZKaXQiUdAFKgNQ3Ibd3Pg2Bfba7wQNa
 Kna6WOdEuKkxT/TgnuwBnvpPa9fBn1czDB0drmAieqrmCZahhgV1It6fEj+bT2M/EDUamOMj6
 jfQoH6DfGUrsIC60riIymDacYewmAB007AX6G0QYvfVozNf1ITuHQHB1LwMWi7+Yp9lTxIR5n
 Tk+MsSHLwwG327qNTbLbEInrukR8221NJLhTcViiYqL0CaCMMkAxvpwHXDvvrOT9qzbqrGY6W
 0uAi65ZLEpbNI9IENp+/Pb5VJnsw4MFtHDkR9hNVbOj84WI2vBnVvEoVzBhYBLPXPsjSq7V3e
 rs3RtXLGSfwmzCzNsvZjiWoN4rbz4sHnAYSCYxQGE3D/z+XLBoYl5Pn5XHOQfz8YAiRQq9IKn
 GHx7S6uZAFhbq2GpnwTBNjZ1ZW3LvuLW3uXtNp1YBaRpkJ1K7CqPTrHV0h3QbPpWeAwIN3XcP
 wCGMuT5ZMJFNaIBzczSaDKe88h2BNCDh0g9azkyTtm2UpAYHZCLZkEg9a/QduLubeF9Ai61sG
 i6hKkpd41WcICsMCRYlEeheXpcjqERzzjWz8vZ/SYqdQNd+1x54QYy8Gqs7GUE719ezcl8mIF
 Of35kyM45PIPSb7mfeMYZwH2Oum3utsAEFZWrw+uExLfu6YJyMOUE4IoMJoQPAxXo+QqAVP8k
 FEezuTb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 25 Apr 2018, Phillip Wood wrote:

> On 25/04/18 13:48, Johannes Schindelin wrote:
> > 
> > On Mon, 23 Apr 2018, Phillip Wood wrote:
> > 
> > > On 23/04/18 19:11, Stefan Beller wrote:
> > > >
> > > > On Sat, Apr 21, 2018 at 12:34 AM, Johannes Schindelin
> > > > <johannes.schindelin@gmx.de> wrote:
> > > > > Eric Sunshine pointed out that I had such a commit message in
> > > > > https://public-inbox.org/git/CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com/
> > > > > and I went on a hunt to figure out how the heck this happened.
> > > > >
> > > > > Turns out that if there is a fixup/squash chain where the *last*
> > > > > command fails with merge conflicts, and we either --skip ahead
> > > > > or resolve the conflict to a clean tree and then --continue, our
> > > > > code does not do a final cleanup.
> > > > >
> > > > > Contrary to my initial gut feeling, this bug was not introduced
> > > > > by my rewrite in C of the core parts of rebase -i, but it looks
> > > > > to me as if that bug was with us for a very long time (at least
> > > > > the --skip part).
> > > > >
> > > > > The developer (read: user of rebase -i) in me says that we would
> > > > > want to fast-track this, but the author of rebase -i in me says
> > > > > that we should be cautious and cook this in `next` for a while.
> > > >
> > > > I looked through the patches again and think this series is good
> > > > to go.
> > >
> > > I've just realized I commented on an outdated version as the new
> > > version was posted there rather than as a reply to v1. I've just
> > > looked through it and I'm not sure it addresses the unnecessary
> > > editing of the commit message of the previous commit if a single
> > > squash command is skipped as outlined in
> > > https://public-inbox.org/git/b6512eae-e214-9699-4d69-77117a0daec3@talktalk.net/
> > 
> > I have not forgotten about this! I simply did not find the time yet,
> > is all...
> 
> I wondered if that was the case but I wanted to check as I wasn't sure
> if you'd seen the original message as it was on an obsolete version of
> the series
> 
> > The patch series still has not been merged to `next`, but I plan on
> > working on your suggested changes as an add-on commit anyway. I am not
> > quite sure yet how I want to handle the "avoid running commit for the
> > first fixup/squash in the series" problem, but I think we will have to
> > add *yet another* file that is written (in the "we already have
> > comments in the commit message" conditional block in
> > error_failed_squash())...
> 
> I wonder if creating the file in update_squash_messages() rather than
> error_failed_squash() would be a better approach as then it is easy to
> only create rebase_path_amend_type() when there has already been a
> squash or fixup.  The file is removed in the loop that picks commits in
> pick_commits() so it would be cleaned up at the beginning of the next
> pick if it's not needed.

That would be a good idea in general, but I think we have to take care of
the following scenario:

	pick	<- succeeds
	squash	<- succeeds
	fixup	<- fails, will be skipped

In this case, we do need to open the editor. But in this scenario, we do
not:

	pick	<- succeeds
	fixup	<- succeeds
	squash	<- fails, will be skipped

If we write the amend-type file in update_squash_messages(), we would
write "squash" into it in both cases. My hope was to somehow avoid that.

I just realized that the current iteration does not fulfill that goal, as
the message-fixup file would be long gone by the time
error_failed_squash() was called in the latter example.

Also, I realized something else: my previous work-around for the
GETTEXT_POISON case (where I fail gently when a commit message does not
contain the "This is a combination of #<count> commits" count in ASCII)
would be much superior if it simply would not abuse the comment in the
commit message, but had a robust, non-l18ned way to count the fixup/squash
commits.

My current thinking is to reconcile both problems by shunning the
amend-type and instead just record the sequence of fixup/squash commits
that went into HEAD, in a new file, say, current-fixups.

To answer the question how many commit messages are combined, I then
simply need to count the lines in that file.

To answer the question whether a skipped fixup/squash requires the editor
to be launched, I can simply look whether there is a "squash" line
(ignoring the last line).

Oh, and I also forgot to test whether this is the "final fixup". If we are
skipping a "fixup" in the middle of a chain, there is no need to clean the
commit message to begin with.

This will take a while... ;-)

Ciao,
Dscho
