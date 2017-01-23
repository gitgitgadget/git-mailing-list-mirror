Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 713CE1F89C
	for <e@80x24.org>; Mon, 23 Jan 2017 11:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbdAWL5e (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 06:57:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:54709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbdAWL5d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 06:57:33 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LzGV3-1cQjU60ABV-014VkH; Mon, 23
 Jan 2017 12:57:19 +0100
Date:   Mon, 23 Jan 2017 12:57:18 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Philip Oakley <philipoakley@iee.org>
cc:     Git List <git@vger.kernel.org>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Subject: Re: Idea: Add a filter option to 'git rebase'
In-Reply-To: <7EEBBEA4046743C9AE04AE50EE30D72A@PhilipOakley>
Message-ID: <alpine.DEB.2.20.1701231214190.3469@virtualbox>
References: <8AED6D90D2B64AE3A63C6195CA983FE8@PhilipOakley> <0bd00cda-65d0-eeba-d8b9-a839e76d8e88@virtuell-zuhause.de> <7EEBBEA4046743C9AE04AE50EE30D72A@PhilipOakley>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:l+9syHYMckkUUGouW4mvtGi4m5dS0KIFo4ndgCBw6Cv3nHsdy/g
 vtM2f4GBCBzKo6KUVT5yRa8yjmKu4pMI5fUi09YRd7d3bbzuCU73ekK80Vth1Yk6TJE1yeU
 ebnygipB+2b/ntX56t3N6TfmleTkuwIW3mgsY2Ls95cm/JWk9gfvLaSGKTkuE+Gisw0uITJ
 gZWGA38QZ/oRow2WGY/yg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q9Y4gICzCTA=:MZ4MkHIPaJPl8a1oS9QXwf
 2HD1C7PnUt4McYb1nVaEZ46qwH9kH6g5qYNdEeu7nDYqEy2EQcTF6EECECp+LvPLBKEsrr+YL
 gU5YOp7qPMFvT6vJmih1V6T/tPfk9eyExEPgdECeiKCY0dyFLyyatCAIaR/D1UiFL1RUDWVO/
 soxoxDYeF2qQEEOFiqa6lGcYmEbUu3U1i/bM6FwkybYM8PMJWtikrrAWvtlCdbCeqoI26RVrl
 gYYu6/U5TX7ZmRGQzCYvvCyhkSRmNMOUS/knTDYWi04wTeJsmZ3cl2PTyU1gG4uoIocLLv1zx
 vE7tJfnhfALCqSiu5Sz1RQqBS+CS11RRaHQOQ7Nqif96B27p9jKQft8HjYlRIWLrZLUuTj9LV
 2sb4wT22+DfTAt9pgXejUR3yYdFhunBPcvFau/ofMQADFEP/kR8qP0ysKn3+cK/i+Hk/Wkjk8
 owFVIHx3Xt4ZIj8VIgJfY/TOaMy0Zrw5evKyBaOidX5h2vNQoMkx5UkVwFwIUbRz71JZN8eYG
 6Lu/qBYt2nbO9ao3+dC6tx7lDcRjqqJrczojjG9EnbJOFwguFhfsGT7wbKglIFSLhpeRaDmZs
 VjDlyeowdkevBToMb+QxfBeIpDJTV+24HUPd16smgwlQWL643NZ6Xjw0c0EcwdvneELSlkWqT
 +jYHVB0mTpZCehKMFt/IVK7drWMvpqqMnnylqCML0Uj9+Yep0ZFxkB19fxFjl9lTzGPUQGnvQ
 tywphGS85AOd+WJR3Cw3D+A2OR1GS4tHJzui0Dsfg4jCnu4HRdU4YrAbWgG79DEjuegtSrCNJ
 CjlsLQ2rRYPN/QTLANtZUGxGToiVxQSg7z3X3wbQHWA2J3fRRqLJQYXBvFiiIMk7/xKDjddYt
 coX42TUz8yjjUVxW/+9ArDOPbx/Lfki26usYLYbkuqwnS7Momr8R0wFkBrHFQRNB3q3Y5mgT9
 oaaq5cTHRgZ/A4i7x0w19PlMJ06P4/BzdMkPNWV/xRxAqmdmomcaHDjAUehpw4PuLuuwRlFuc
 sRccVMPjT7+fCZYAD4yOR7C7XUvvqWKgvrumE/0WfO8EseUwNhGFwVDEBKjp2ZzYFQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 21 Jan 2017, Philip Oakley wrote:

> From: "Thomas Braun"  Friday, January 20, 2017 11:35 PM
> > Am 20.01.2017 um 23:28 schrieb Philip Oakley:
> > > A recent question on stackoverflow
> > > http://stackoverflow.com/questions/41753252/drop-commits-by-commit-message-in-git-rebase
> > > sought to remove automatically commits that could be identified by
> > > relevant words in the commit message.

Interesting. As long as those magic words appear in the oneline, I would
simply call the command ":%s/^pick.*<magic-word>/#&/".

But that is neither scripted nor does it work with magic words elsewhere
in the commit message (let alone more sophisticated filtering based on,
say, authorship or magic words in the diff's "+" lines).

> > > I had thought that the ubiquitous `git filter-branch` should be able
> > > to do this sort of thing. I was wrong. (It was pointed out to me
> > > that...) The man page notes that removing a commit via filter-branch
> > > does not remove the changes from following commits and directs
> > > readers to using `git rebase(1)`.

Right, filter-branch never cherry-picks patches, but instead complete
trees.

> > > However the rebase command does not have any filter option to allow
> > > the automatic population of its TODO list with the appropriate
> > > pick/edit/drop/etc. values.
> >
> > Well you can use an arbitrary shell command as editor, so something
> > like
> >
> > $ GIT_SEQUENCE_EDITOR="sed -i -re 's/^pick /edit /'" git rebase -i master
> >
> > will change pick to edit of all commits.
> >
> > Maybe that can be mentioned in the man page of rebase?

Please note that using a script instead of a command, you can do really
sophisticated things including sophisticated re-writing of the edit script
as well as calling the GIT_EDITOR in the end to re-establish
interactivity. I do exactly that in my Git garden shears [*1*].

> I had been more thinking of a process that passed single sha1's to the
> filter on each pass through the rebase list, so that the coding was
> simpler, plus the --interactive could be used, if required, for final
> refinement (gitk being handy for that).
> 
> However, a mention in the man pages would be zero code cost, and could
> help.

In the (frustratingly) long run, we will want to add a command-line option
that allows overriding the edit script generation, paired with a
command-line option that generates the current version of the edit script
(in my rebase--helper work that is still under review, the latter option
already exists).

That way, you have full flexibility and could even generate the entire
edit script from scratch, rather than letting rebase -i generate one and
then filtering it.

Ciao,
Johannes

Footnote *1*:
https://github.com/git-for-windows/build-extra/blob/master/shears.sh
