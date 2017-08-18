Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BB601F667
	for <e@80x24.org>; Fri, 18 Aug 2017 06:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751616AbdHRG4K (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 02:56:10 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:52377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbdHRG4J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 02:56:09 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue101 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0MWiwF-1e6dDC22V1-00XxIa; Fri, 18 Aug 2017 08:56:05 +0200
Subject: Re: Weirdness with git change detection
To:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Peter Eckersley <peter.eckersley@gmail.com>, git@vger.kernel.org
References: <CAOYJvnJ1FxevnWf+Aj0-5r6WfmfPkzWhOk_n4y4Yz7HvvfvaBQ@mail.gmail.com>
 <d047a884-b698-c25b-59e9-3a2704f79fb3@web.de>
 <20170711070618.dq52o67ixvjudafg@sigill.intra.peff.net>
 <CAOYJvnLCwR7CkG32E_r5BcVm5tFt5zsgYe7TUW3hVGBtQBHzGw@mail.gmail.com>
 <20170711073433.ghcz3lku3ux54fib@sigill.intra.peff.net>
 <decbd316-5194-120d-824e-b5cee1f0822c@web.de>
 <20170711082435.a53iuw26oxawcfyq@sigill.intra.peff.net>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <fa4b367d-a984-6f42-a2bd-6bfcabed7c2a@grubix.eu>
Date:   Fri, 18 Aug 2017 08:56:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170711082435.a53iuw26oxawcfyq@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:QH4L2ZsLYi8CO5JCxOLXsSqwuu893XEeD/PXSG1aKjwLvjl1C4+
 wIhZZQJtiEwFg+c2Ui6nBIG6hyBmlMapNfUNIY5VwKQOXz98QUPi/EZse4v3n0FnKycf231
 birh2CvrCdHLuesv2Rz5e+7MJsVZ1/dfm2JMB5D6Le0zPj0SIYbKTgelRZLyVi/s7qvk1Mc
 rzMaLWKFASGqM7fseE9lQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PenE4ACpusE=:zrDlO02mUA6leIGwh2P8Q9
 CdPjwgq92EJ1qYVLlTd6ORXt4TJRUGNl3T6dGZN0CitkFxs2APyKmlFubvyfwxIOu93tOlxsv
 QzOB1Q68AR5DP+ORb2td2t+b7CXaGGoCfiIdSNUMIAy+2PqFBg29jRqnu5XXj6ZVRnbQBFMeT
 cswR3rzs6B31dCcJaov6djtNdytUntVi1QjdU+6YQOujnVlWQFwPZaM0H4n29w2/i8Uk9g3H7
 SQ+e84k5D1e4fHgqe1fIYsY6gMSDsjiJsboEK+4Xb+ep5r18/ndhq8XvY86BsdrsH2ezyxano
 nFFcxIxwwn+kLpdb227XXEu9i85XiHbfeDkWaP1BNh68L10rz5f1gNwXVAEQYYSFS1+FkZZCC
 epXIzTIHBXqiY9MVP7ktM+F9G59QPOC8ticNyoJ08kAhKJWsEkTDwNLWa7QjwWUv8wtRIFdLA
 5E5N7q9UDts6VgxSqnm8+1tcsaKXf0XaEpTbrhmvqnkawMjogRU9Q0v8CXBCYrh2KWD2WCtvw
 Y7PvQ9sqpbHt1ec90ug3LWkvLNlNGtCzDCpqJFE68HnFDIioXdlQQ4yzNKkNFQPJsSYGa2OMq
 Gq+khK+pHDtxJ0qQPYLGKgCeBEvLCc+dUzdnwrY3i6BbgMzT8G8utoj9SX/4vq45F4lOQDqLy
 fcWh8aukt/SEXn+y+Xx1N92tnY5iyt0A9SW1CmAg4uNvKeh3rNZAgoZT5aye8vU6oolaQDjRX
 8Hes6rF3JuiApIvDiIDgPJgKcN+L0KIPDqYsoh2QJw9iZOk6jEKAdbrl8YE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King venit, vidit, dixit 11.07.2017 10:24:
> On Tue, Jul 11, 2017 at 10:20:43AM +0200, Torsten Bögershausen wrote:
> 
>>> No problem. I actually think it would be interesting if Git could
>>> somehow detect and warn about this situation. But the obvious way to do
>>> that would be to re-run the clean filter directly after checkout. And
>>> doing that all the time is expensive.
>>
>> Would it be possible to limit the round-trip-check to "git reset --hard" ?
>> If yes, possibly many users are willing to pay the price, if Git tells
>> the "your filters don't round-trip". (Including CRLF conversions)
> 
> Anything's possible, I suppose. But I don't think I'd want that feature
> turned on myself.
> 
>>> Perhaps some kind of "lint" program would be interesting to warn of
>>> possible misconfigurations. Of course people would have to run it for it
>>> to be useful. :)
>>
>> What do you have in mind here ?
>> Don't we need to run some content through the filter(s)?
> 
> I was thinking of a tool that could run a series of checks on the
> repository and nag about potential problems. One of them could be doing
> a round-trip repo->clean->smudge for each file.
> 
> Another one might be warning about files that differ only in case.
> 
> The idea being that users could run "git lint" if they suspect something
> funny is going on. I dunno. It may be a dead-end. Most such
> oddities are better detected and handled during actual git operations if
> we can. So this would really just be for things that are too expensive
> to detect in normal operations.
> 
> -Peff
> 

Typically, that problem arises when you turn a filter on or off at some
point in your history. Since "attributes" can come from various sources,
especially the versioned ".gitattributes" file, unversioned per-repo
.git/info/attributes, and global attributes, "git diff" may apply
different attributes depending on what you diff (versioned blob, workdir
file, out-of-tree file).

This is not made easier by the fact that unversioned config (per repo,
per user, global) defines the filter action, and that even upgrades of
your filter tools may change the output. So, "filter off/on" is by no
means the only possible source of discrepancies.

I've found that when I decide to use a filter like that, the best
approach is to either apply it retroactively (filter-branch,
unversionsed attributes, that is clean all stored blobs) or make a
commit where I specifically note the switch (versioned .gitattributes
plus affected blob changes) and what config should go along with it.

All of this is difficult to check or correct automatically, since it
depends on user decisions.

About the only thing we could do is checking that
"clean(smudge(foo))=clean(foo)" at a specific "point in time"
(attributes, config) for specific foo, but that wouldn't catch the case
above, even if we iterated over all commits which affect files that the
filter (currently) applies to.

Keep in mind that filters are a killer feature, so if you shoot yourself
in the foot: it could have come worse ;)

Michael
