Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D9C91F576
	for <e@80x24.org>; Tue, 20 Feb 2018 10:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751358AbeBTKqn (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 05:46:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:42751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbeBTKqm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 05:46:42 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx101 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0MCPhl-1ewZu33mtd-0096Tx; Tue, 20 Feb 2018 11:46:39 +0100
Date:   Tue, 20 Feb 2018 11:46:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
cc:     git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
In-Reply-To: <20180219220819.GA10466@helen.PLASMA.Xg8.DE>
Message-ID: <nycvar.QRO.7.76.6.1802201127140.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE> <nycvar.QRO.7.76.6.1802192257100.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <20180219220819.GA10466@helen.PLASMA.Xg8.DE>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QCj94TIU12yUEBPOCUtFCiWBn2mBj2pso49OGRCwugHhwLAcmE8
 ukFgrrlYR07ya5ncIoqFIC6jp5T9u605BMmfkL9f22bDjNuXFc0w+BiO5RUKcGY+KENyOx0
 ViwLL2dneYMkyqXidu8FblnBq5U0v4OyVxSS8b5N5fL5yvp/HPJHkiL6PmIrIc6fc4beaVO
 HqSX5hXt80TyiSLyE8uTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lZK3CshDfJo=:Jc3cfmd8JTppp+qmDp82PU
 RNSyy2kBRuLGKYCegQnM2CpdnTeEVMe7nwIhQQc4kFPIgp+1f+udiRIycsm2NuxYDA1EkJTA2
 c+Mhyjg7Fd04qCD0U07XqQK2HZ2S8o7r+Uwumgti9rw6qPeRLDjCNjx7AdgC9Tm3p1iUcnn0b
 25e6mcZz2H0JJFCmV2qWwppFZbe4Ly2CqhGTJ3BZvy2zXokQPyfX8yXM+wRfbui2/Jb8nzZEQ
 nj5e4Rae70yAim2abS0644GlNiXxk3ag5IY3QRBNyiLO1zmB6vLW+4RJrdzePmJ9eTHk/kuug
 DvEGqNDi4RyztbcLUYsZ2fYaJf47c0Fd9kF9C6UepD3vrjUzA/OfMm1DovxofODr+3U0yEum2
 DT8N/8siamCwKZQQaVwiWWqh2aX+MLJU+uaBHkUf1Rg2/N8p+/8Y0RY2rKTWSE1Qj2h9AN3eY
 BIb9S4XN5cUTn+EcnmSThDctywSWONA6/Y75PVw0W4f3FGk9aB+9fpzJbqkCn98n32JxheRD5
 fJ3G3++jbdGmQe/7PnNv5Z4KD6N1o6MwgQ2Y+QRYw1MppCUqFaIWIZwnC0kj8Tpj1N9C0hgci
 ERvd2fMXZ4XIT6e9+1XJCa/hZo7jywfiBIAUhNPUETgEJ1x7kEied07u4a8j9gaAdYni5dNTC
 wMxrfFd2kbVsMrw2pcKCgmAzM0EDqlSUcZ8qHoP5qSkr30AEbvi0a3abRoODFti/BvYd9E1kI
 DX6JU+6jxuErejd+90hFbqFV7HnAlSONBpg+M+TfjM38FEiYqkIHaV5ecnni5lgqszeeWNivS
 KfvO/QTlBpjvO82SLoYSMERagtVkLP+jAutMK3DbZM1SDuaCFQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peter,

On Mon, 19 Feb 2018, Peter Backes wrote:

> On Mon, Feb 19, 2018 at 10:58:12PM +0100, Johannes Schindelin wrote:
> > Since you already assessed that it shouldn't be hard to do, you
> > probably want to put your money where your mouth is and come up with a
> > patch, and then offer it up for discussion on this here mailing list.
> 
> Well, it would be good to discuss this a bit beforehand, since my time 
> is wasted if there's no chance to get it accepted. Perhaps there is 
> some counterargument I don't know about.

Oh, sorry. I understood your mail as if you had told the core Git
developers that they should implement the feature you desire. I did not
understand that you hinted at a discussion first, and that you would then
go and implement the feature you asked for.

> Is there some existing code that could be used? I think I read 
> somewhere that git once did preserve mtimes, but that this code was 
> removed because of the build tool issues. Perhaps that code could 
> simply be put back in, and surrounded by conditions.

I don't think that code was ever there. Maybe you heard about some file
mode being preserved overzealously (we stored the octal file mode
verbatim, but then decided to store only 644 or 755).

(This is to add to Theodore's reply, giving a bit more depth.)

As you can see from the code decoding a tree entry:

https://github.com/git-for-windows/git/blob/e1848984d/tree-walk.c#L25-L52

there is no mtime at all in the on-disk format of tree objects. There is
the hash, the mode, and the file name.

As your main use case would be stashing and unstashing (which uses tree
objects as storage format), this means you would have to find a different
way to store the information you desire.

If I were you, and if I had the time to implement this feature, I would go
about it by adding a note (using `git notes` from a script first, but only
for proof of concept, because I saw too many things go wrong with Unix
shell scripts in production) for the tree object, say, in
refs/notes/mtimes. I would probably invent a file format
(`<mtime><TAB><path><LF>`) to store the information, and for starters I
would only store the mtimes of the files that were stashed, then extend
the script into a full Git builtin with a subcommand that can generates
these notes, a subcommand to replay them, and a subcommand to inspect
them.

Then I would extend `git-stash.sh` to take an option (and later, to heed a
new config setting to do this automatically) to generate those mtime notes
for the newest stash's top-level tree object (storing only the times of
the files that were modified by the `stash` command), and to replay them
if such an mtime note is found for the stash that is being applied.

You will not be able to convince the core Git developers to make this the
default, I don't think. But if you make it an opt-in as I outlined above,
I believe your chances would be good to get that feature if you put in the
effort to implement it.

Oh, and if you implement the feature using notes, the same feature can be
used not only for stashing and unstashing. These notes are maintained in
regular Git refs, i.e. they can be shared. And since those notes would be
for tree objects, you could even apply the mtimes on a fresh clone, if
you have a use case for that.

Ciao,
Johannes
