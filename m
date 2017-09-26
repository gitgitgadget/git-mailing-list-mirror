Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96EA020A26
	for <e@80x24.org>; Tue, 26 Sep 2017 15:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936166AbdIZP0i (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 11:26:38 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:42757 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934460AbdIZP0h (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 26 Sep 2017 11:26:37 -0400
X-AuditID: 1207440d-86bff70000000f42-79-59ca71acd752
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 52.00.03906.CA17AC95; Tue, 26 Sep 2017 11:26:36 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCD51.dip0.t-ipconnect.de [87.188.205.81])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8QFQXbi025770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Tue, 26 Sep 2017 11:26:34 -0400
Subject: Re: RFC: Design and code of partial clones (now, missing commits and
 trees OK)
To:     Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peartben@gmail.com,
        Christian Couder <christian.couder@gmail.com>
References: <20170915134343.3814dc38@twelve2.svl.corp.google.com>
 <e6259d03-e904-8c57-73b0-2434939fba71@jeffhostetler.com>
 <20170921154214.0d2ac45f@twelve2.svl.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <c3245fd2-cff4-0266-37e9-35b307e0357b@alum.mit.edu>
Date:   Tue, 26 Sep 2017 17:26:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170921154214.0d2ac45f@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1F1TeCrS4MRTOYvbM1uYLV7sv8xq
        0XWlm8li2zkni2fzrrE4sHrsnHWX3WPBplKPu8+2M3p83iQXwBLFZZOSmpNZllqkb5fAldG4
        9TdLQadyxaR9U9gbGGfIdDFyckgImEj03fvF2sXIxSEksINJYmHnDHYI5zyTxLH9+5lAqoQF
        IiW+Xz3C3MXIwSEiECPxYLUJSJhZIFni866VUPVbGCXWX3nMCJJgE9CVWNTTzARSzytgL7Fw
        QQFImEVAVWLpf4gxogIREhs28oOEeQUEJU7OfMICYnMKOElMapvDDjFeXeLPvEvMELa4xK0n
        85kgbHmJ7W/nME9gFJiFpH0WkpZZSFpmIWlZwMiyilEuMac0Vzc3MTOnODVZtzg5MS8vtUjX
        SC83s0QvNaV0EyMk1Hl3MP5fJ3OIUYCDUYmHlyHkVKQQa2JZcWXuIUZJDiYlUV5FOaAQX1J+
        SmVGYnFGfFFpTmrxIUYJDmYlEV71WKAcb0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampB
        ahFMVoaDQ0mC90EBUKNgUWp6akVaZk4JQpqJgxNkOA/QcAuQGt7igsTc4sx0iPwpRkUpcV4d
        kIQASCKjNA+uF5aKXjGKA70izFsLUsUDTGNw3a+ABjMBDe6degJkcEkiQkqqgdG70mTZh3nb
        3zLu1Xy+8YlCT7sJn1/3zkTh4wry6SKTFfPOMZbuaVG/X7/aZUN43+b5z669P7fWq0pbZv/y
        CnMt8YycH5ybQl81aPz3Sdv/s1t+Yfd8qUeH2o/PEzXfe3D56bV8NdH7Pv+5cHvS8oVHDtyb
        efpv+JdidY0g4VWpJyJsNuzwkXVXYinOSDTUYi4qTgQAeg4yOSADAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/22/2017 12:42 AM, Jonathan Tan wrote:
> On Thu, 21 Sep 2017 13:57:30 Jeff Hostetler <git@jeffhostetler.com> wrote:
> [...]
>> I struggled with the terms here a little when looking at the source.
>> () A remote responding to a partial-clone is termed a
>> "promisor-remote". () Packfiles received from a promisor-remote are
>> marked with "<name>.promisor" like "<name>.keep" names.
>> () An object actually contained in such packfiles is called a
>> "promisor-object". () An object not-present but referenced by one of
>> the above promisor-objects is called a "promised-object" (aka a
>> "missing-object").
>>
>> I think the similarity of the words "promisOR" and "promisED" threw
>> me here and as I was looking at the code.  The code in is_promised()
>> [1] looked like it was adding all promisor- and promised-objects to
>> the "promised" OIDSET, but I could be mistaken.
>>
>> [1]
>> https://github.com/jonathantanmy/git/commit/7a9c2d9b6e2fce293817b595dee29a7eede0dddd#diff-5d5d5dc185ef37dc30bb7d9a7ae0c4e8R1960
> 
> I was struggling a bit with the terminology, true.
> 
> Right now I'm thinking of:
>  - promisor remote (as you defined)
>  - promisor packfile (as you defined)
>  - promisor object is an object known to belong to the promisor (whether
>    because we have it in a promisor packfile or because it is referenced
>    by an object in a promisor packfile)

Maybe naming has been discussed at length before, and I am jumping into
a long-settled topic. And admittedly this is bikeshedding.

But I find these names obscure, even as a developer. And terms like this
will undoubtedly bleed into the UI and documentation, so it would be
good to put some effort into choosing the best names possible.

I suppose that the term "promisor" comes from the computer science term
"promise" [1]. In that sense it is apt, because, say, a promisor object
is something that is known to be obtainable, but we don't have it yet.

But from the user's point of view, I think this isn't a very
illuminating term. I think the user's mental model will be that there is
a distinguished remote repository that holds the project's entire
published history, and she has to remain connected to it for certain Git
operations to work [2]. Another interesting aspect of this remote is
that it has to be trusted never (well, almost never) to discard any
objects [3].

Let me brainstorm about other names or concepts that seem closer to the
user's mental model:

* "backing remote", "backing repository"

* "lazy remote", "live remote", "cloud remote", "shared remote",
  "on-demand remote"

* "full remote", "deep remote", "permanent remote"

* "attached remote", "bound remote", "linked remote"

* "trusted remote", "authoritative remote", "official remote"
  (these terms probably imply more than we want)

* "upstream", "upstream remote" (probably too confusing with how
  the term "upstream" is currently used, even if in practice they
  will often be the same remote)

* "object depot", "depot remote", "depot repository", "remote
  object depot" (I don't like the term "object" that much, because
  it is rather remote from the Git user's daily life)

* "repository of record", "remote of record" (too wordy)

* "history depot", "history warehouse" (meh)

* (dare I say it?) "central repository"

* "object archive", "archival remote" (not so good because we already
  use "archive" for other concepts)

* depository (sounds too much like "repository")

* The thesaurus suggests nouns like: store, bank, warehouse, library,
  chronicle, annals, registry, locker, strongbox, attic, bunker

Personally I think "lazy remote" and "backing remote" are not too bad.

Michael

[1] https://en.wikipedia.org/wiki/Futures_and_promises

[2] I haven't checked whether the current proposal allows for
    multiple "promisor remotes". It's certainly thinkable, if not
    now then in the future. But I suppose that even then, 99% of
    users will configure a single "promisor remote" for each
    repository.

[3] For those rare occasions where the server has to discard objects,
    it might make sense for the server to remember the names of the
    objects that were deleted, so that it can tell clients "no, you're
    not insane. I used to have that object but it has intentionally
    been obliterated", and possibly even a reason: "it is now taboo"
    vs. "I got tired of carrying it around".
