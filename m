Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23358C4708D
	for <git@archiver.kernel.org>; Fri, 28 May 2021 08:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE5A613B6
	for <git@archiver.kernel.org>; Fri, 28 May 2021 08:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhE1IDH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 04:03:07 -0400
Received: from zoidberg.org ([88.198.6.61]:34723 "EHLO heapsort.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235474AbhE1ICq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 04:02:46 -0400
Received: from heapsort.de ([2a01:4f8:130:60a1::100])
  (AUTH: LOGIN jast, SSL: TLSv1/SSLv3,128bits,DHE-RSA-AES128-GCM-SHA256)
  by cthulhu.zoidberg.org with ESMTPSA; Fri, 28 May 2021 10:00:41 +0200
  id 0000000000221091.60B0A32A.00001F5A
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 28 May 2021 10:00:41 +0200
From:   =?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>
To:     "=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?=" 
        <avarab@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Subject: Re: Should we do something with #git-devel on Freenode?
In-Reply-To: <87im33ltqr.fsf@evledraar.gmail.com>
 (sfid-20210528_000327_229190_A43C0CF3)
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com> <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net> <YK6XvmrtrdkJvsnI@nand.local>
 <YK6o/j7P0JIGW0Q0@alpha> <7e9683aee2c0fea2ff77b82bfa547e15@jk.gs>
 <87im33ltqr.fsf@evledraar.gmail.com> (sfid-20210528_000327_229190_A43C0CF3)
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <b8e48d464858c0ef6da2629dab507ebc@jk.gs>
X-Sender: jk@jk.gs
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27.05.2021 23:54, Ævar Arnfjörð Bjarmason wrote:
> How have the channels been destroyed?
> 
> I'm still joined on freenode and #git has ~700ish users

#git was not affected, but many others were, including #git-devel...

> I see there was a mass action to revert topics that stated that 
> channels
> had moved

If that was all that had happened, I would totally agree. Unfortunately,
they did quite a bit more than that. They made a script that
automatically ran the following actions on channels that mentioned
"libera" in the topic:

* sent a vague message about a ToS violation to the channel;
* dropped the registration, including the full access list;
* set the channel to moderated;
* removed all ops;
* set an auto-forward to a similarly named topic channel (e.g.
   #git-devel forwarded to ##git-devel);
* made no attempt to give control of the topic channel to the previous
   community, i.e. the new channel would usually end up completely
   op-less and thus impossible to register at all. If it had been
   squatted by unrelated people beforehand, it would stay in their
   control.

This is equivalent to utter destruction in my view. #git was only not
affected because our message in the topic did not mention Libera by
name. Now of course we could just consider ourselves lucky and move on,
but personally I am deeply suspicious of a team that will do this kind
of thing seemingly on a whim, without even letting anyone know in
advance that this was considered a violation. Who knows what else they
are going to do on a whim in the future?

> I agree that ~300/~700 is quite the arbitrary quorum :)

I misspoke - it was an arbitrary quorum of the people who spend a lot of
time being active in #git, i.e. the people who are the most responsible
for keeping the channel alive. And the decision wasn't about killing the
freenode channel anyway...

> I'm not going to weigh in on whatever pissing contest is going on over
> at Freenode and related networks other than to say that it seems to me
> that the goal(s) of the new owner/team or whatever is to try to prevent
> some mass adversiting of the nature of "this network is
> deprecated". "Destroying" prominent channels seems to be
> conterproductive to that goal.

And yet that is what they did.

> In any case, I agree with Jeff King's earlier comments that our primary
> goal here should not be to pick sides, but to direct our users to 
> useful
> venues where they can get help, discuss git etc.

Sure... but several of us spoke about this and none of the particularly
active regulars I talked to want to keep being active on freenode
indefinitely. This will likely have effects on how active each channel
will be. Right now, several of us are still answering questions on
freenode, and nobody has made any attempt to shut down the channel
there. If it gets shut down, it will not be due to our actions. Maybe
due to our inaction, but even then there's nothing stopping others from
keeping the channel going.

I've updated my little page about this whole issue, to clarify that the
freenode channel is not closed or anything - but I feel like it's
relevant that several of the most active people intend on moving away
from it, and so I think it still makes sense leaving that message out
there. If it turns out that there is a significant fraction of active
"helpers" that intend to stay on freenode, I'll update again to reflect
that.
