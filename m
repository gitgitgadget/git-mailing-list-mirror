Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152241F404
	for <e@80x24.org>; Mon, 29 Jan 2018 21:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751539AbeA2VlN (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 16:41:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:63977 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751417AbeA2VlM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 16:41:12 -0500
Received: from minint-kr8j64v.europe.corp.microsoft.com ([37.201.193.1]) by
 mail.gmx.com (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MMoU7-1egXcd2s1P-008f1l; Mon, 29 Jan 2018 22:41:04 +0100
Date:   Mon, 29 Jan 2018 22:41:03 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jacob Keller <jacob.keller@gmail.com>
cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/8] sequencer: introduce the `merge` command
In-Reply-To: <CA+P7+xr4KtR4q8Y=-+pv2TzvP009zRVR6a_zh2GOZXt_LXrFOg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801292230550.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de> <b3b37af6-4b65-5a44-a395-6f75a4adc98e@talktalk.net>
 <CA+P7+xr4KtR4q8Y=-+pv2TzvP009zRVR6a_zh2GOZXt_LXrFOg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tVJEBfFVS8Cqc9VDfptcRfmA9irhiOJbeV4QSpOh1hxK5dUCFnU
 XB/YhlW0LuV/2SeDEpZ69BcyNDVWXHOt4evElGfXN0LU0EnyBFSMvV8pk0VdZYZo3/xvgIe
 GA06w3CjFQnD5r7NaKMj0XaVSzythgVzE/1YUPKbTcl2PX1T6ejuuA5UhHS+CbLu/lGhMgy
 QHvFQsmfS6eJDe2DtTmbw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wDWNvrNKXKw=:uQ2RS2L98T+/5cxxplbqaz
 zF/d6fgtMa9wcHj2jxKcGQALnnXOHvhV88uHKS+GMUZRZ7L76tZEpieHmfD3mumYse68FWiz4
 YZQmqamodxg8gC4Nvf6/86mwQdT1s40Def0A3+vKk4Mla/+P0l0fxvW1lP7riGeFYUBFa1fDc
 XUSfzYAJBfwpe5M4bexF9aSl6FOpIPUyXw49hhvaOaQ93YWNKvUCOBSFOeqMjOn/CkMCcZKbU
 ljlvgm2tuYevQqOKMWwrrF8vEoRXM0wrl9owcM6+IEcn30wxqBmzv2kSPbPoAJRHsujMPicwX
 Gop6crpKkzY7exqsuvkt/OeNgy5rv9B2Pf/N3noy8VZXIzLhWCyZQPjdxvvLaZ7TCXr42hhZR
 9xAQ+JAMx9IqFuQttad97H2l3xi8w0zJNw5kHwzgRE8pZPytMMWYpya5NdRDZfrClUd+tuYX/
 DuwFneslP1slXGHeY+NMZV5EF6DfH24uHbjQbS1sq0ILS9XUlO8m1Ixifulnq7Ll0bldv9Kh5
 HtSDMb2S3xabpAczhYhcrjrs5NApQ6v13BGdf4cffyMbI3O2hLzHUId95fZe0JXqZsv0Fu/3a
 Bgmw1rUF+cswSfogl7QrgOAWsV3+9Q4AaAaY9p4+L4IviU+YbCFUGPbkr3AFb79vawA7nH/2J
 NZeNGrkpeaSDaVO+tSFYfmV8tfRhZ6Bny4oGblok8FA61rOCNEWHpP44PRO/uulyXhFMsrIho
 LDmWxv/EqV3DP8f4YuAS8BpxOlXcDM6F6gQ0tVZqssxZtAioC32zYhNfoVQpL27PTODIt/hn+
 G5n/C1usSnj18+w4DHnAX3Wfdvsk6cdpHkVZZc4KU4F+pcxXSoSch9KqSv5FzGmw9zVWp9x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake & Phillip,

On Sat, 20 Jan 2018, Jacob Keller wrote:

> On Fri, Jan 19, 2018 at 6:45 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> > On 18/01/18 15:35, Johannes Schindelin wrote:
> >>
> >> This patch is part of the effort to reimplement `--preserve-merges` with
> >> a substantially improved design, a design that has been developed in the
> >> Git for Windows project to maintain the dozens of Windows-specific patch
> >> series on top of upstream Git.
> >>
> >> The previous patch implemented the `label`, `bud` and `reset` commands
> >> to label commits and to reset to a labeled commits. This patch adds the
> >> `merge` command, with the following syntax:
> >>
> >>       merge <commit> <rev> <oneline>
> >
> > I'm concerned that this will be confusing for users. All of the other
> > rebase commands replay the changes in the commit hash immediately
> > following the command name. This command instead uses the first commit
> > to specify the message which is different to both 'git merge' and the
> > existing rebase commands. I wonder if it would be clearer to have 'merge
> > -C <commit> <rev> ...' instead so it's clear which argument specifies
> > the message and which the remote head to merge. It would also allow for
> > 'merge -c <commit> <rev> ...' in the future for rewording an existing
> > merge message and also avoid the slightly odd 'merge - <rev> ...'. Where
> > it's creating new merges I'm not sure it's a good idea to encourage
> > people to only have oneline commit messages by making it harder to edit
> > them, perhaps it could take another argument to mean open the editor or
> > not, though as Jake said I guess it's not that common.
> 
> I actually like the idea of re-using commit message options like -C,
> -c,  and -m, so we could do:
> 
> merge -C <commit> ... to take message from commit

That is exactly how the Git garden shears do it.

I found it not very readable. That is why I wanted to get away from it in
--recreate-merges.

> merge -c <commit> ...  to take the message from commit and open editor to edit
> merge -m "<message>" ... to take the message from the quoted test
> merge ... to merge and open commit editor with default message
> 
> This also, I think, allows us to not need to put the oneline on the
> end, meaning we wouldn't have to quote the parent commit arguments
> since we could use option semantics?

The oneline is there primarily to give you, the reader, a clue when
reading and editing the todo list.

Reusing it for the `merge -` command was only an afterthought.

> > One thought that just struck me - if a merge or reset command specifies
> > an invalid label is it rescheduled so that it's still in the to-do list
> > when the user edits it after rebase stops?

It is not rescheduled, because the command already failed, so we know it
is bad.

You have to go edit the todo list, possibly after copying the faulty
command from `git status`' output.

> > In the future it might be nice if the label, reset and merge commands
> > were validated when the to-do list is parsed so that the user gets
> > immediate feedback if they try to create a label that is not a valid
> > ref name or that they have a typo in a name given to reset or merge
> > rather than the rebase stopping later.

There are too many possible errors to make this fool-proof. What if the
ref name is valid, but there was no `label` command yet?  What if there
*has* been a `label` command but it is now stuck in the `done` file (which
we do not parse, ever)? What if the user specified two label commands with
the same label?

It sounds like an exercise in futility to try to catch these things in the
parser.

And keep in mind that the parser is used

- when shortening the commit names
- when checking the todo list for accidentally dropped picks
- when skipping unnecessary picks
- when rearranging fixup!/squash! commands
- when adding `exec` commands specified via `-x`

I am not sure that I would come out in favor of trying to catch ref name
errors during parsing time if I wanted to balance bang vs buck.

Ciao,
Dscho
