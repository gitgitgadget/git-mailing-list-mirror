Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B8D203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 22:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751505AbcHKW0R (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 18:26:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53008 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbcHKW0P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 18:26:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234C9203BD;
	Thu, 11 Aug 2016 22:26:15 +0000 (UTC)
Date:	Thu, 11 Aug 2016 22:26:15 +0000
From:	Eric Wong <e@80x24.org>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	git@vger.kernel.org
Subject: Re: Mapping old gmane numbers to existing amil servers?
Message-ID: <20160811222615.GA5607@starla>
References: <73FC8DE87D24466EBEE0A5B96CBDFFBF@PhilipOakley>
 <20160811075628.GA24690@starla>
 <95848D06D55D4633A686DD892D12F501@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95848D06D55D4633A686DD892D12F501@PhilipOakley>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> wrote:
> The raw download works. My home ISP is currently blocking your email for
> some reason, though I do see it at my work - my iee.org alias is via my
> professional body which duplicates the email when it relays it.

Hmm, do other emails from other users get blocked?
I wonder if it's lack of DKIM (which gets invalidated by the
list sig vger appends) or something else...

> On thing I did note on the web display of the threads is that it would be
> good to have a leader of " . . . . . `" so that one can count the level of
> indent, and see the alignments via the columns of dots.
> 
> When looking at
> https://public-inbox.org/git/0648000B273C412AB7140AE959EBC99A%40PhilipOakley/
> I had difficulty working out which email the last 4 were replying to.

https://public-inbox.org/git/0648000B273C412AB7140AE959EBC99A%40PhilipOakley/
So, right now, it's:

2016-07-20 21:10               ` [PATCH v4 8/8] doc: revisions - clarify reachability examples Philip Oakley
2016-07-20 22:22               ` Junio C Hamano
2016-08-11 21:50               ` [PATCH v5 00/12] Update git revisions Philip Oakley
2016-08-11 21:50                 ` [PATCH v5 01/12] doc: use 'symmetric difference' consistently Philip Oakley
2016-06-25 19:49       ` Junio C Hamano
2016-06-27 13:37         ` Philip Oakley
2016-06-27 15:08           ` Junio C Hamano
2016-06-27 15:39             ` Philip Oakley

And you would rather see something like:

2016-07-20 21:10       .       ` [PATCH v4 8/8] doc: revisions - clarify reachability examples Philip Oakley
2016-07-20 22:22       .       ` Junio C Hamano
2016-08-11 21:50       .       ` [PATCH v5 00/12] Update git revisions Philip Oakley
2016-08-11 21:50       .         ` [PATCH v5 01/12] doc: use 'symmetric difference' consistently Philip Oakley
2016-06-25 19:49       ` Junio C Hamano
2016-06-27 13:37         ` Philip Oakley
2016-06-27 15:08           ` Junio C Hamano
2016-06-27 15:39             ` Philip Oakley

?

Actually, my initial inclination was to use the '|' character
which is what mutt does

2016-07-20 21:10       |       } [PATCH v4 8/8] doc: revisions - clarify reachability examples Philip Oakley
2016-07-20 22:22       |       } Junio C Hamano
2016-08-11 21:50       |       ` [PATCH v5 00/12] Update git revisions Philip Oakley
2016-08-11 21:50       |         ` [PATCH v5 01/12] doc: use 'symmetric difference' consistently Philip Oakley
2016-06-25 19:49       ` Junio C Hamano
2016-06-27 13:37         ` Philip Oakley
2016-06-27 15:08           ` Junio C Hamano
2016-06-27 15:39             ` Philip Oakley

It should be doable, and the '`' immediately following the last
'|' probably ought to be a link to the parent, too.

I would also like to use '}' (as above) or '+' where mutt would
use "├─>" or just '├', but I don't think I can introduce multibyte
chars without causing problems for some users.

Anyways, it's definitely on my ever-growing todo list.


(Wow, it is refreshing to be a "web designer" who can live
 entirely in a terminal without relying on screenshots :D)
