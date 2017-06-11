Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ADB420282
	for <e@80x24.org>; Sun, 11 Jun 2017 17:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751823AbdFKR5k convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 11 Jun 2017 13:57:40 -0400
Received: from elephants.elehost.com ([216.66.27.132]:20065 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdFKR5k (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jun 2017 13:57:40 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.238.41.215])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id v5BHvXdw061423
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 11 Jun 2017 13:57:34 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'liam Beguin'" <liambeguin@gmail.com>,
        "'Jeff King'" <peff@peff.net>, "'Samuel Lijin'" <sxlijin@gmail.com>
Cc:     "'Houston Fortney'" <houstonfortney@gmail.com>,
        <git@vger.kernel.org>
References: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com> <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net> <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com> <20170610102217.vxf6tsrdfp6srupr@sigill.intra.peff.net> <1c04d689-6796-17d1-e058-18874768c22a@gmail.com>
In-Reply-To: <1c04d689-6796-17d1-e058-18874768c22a@gmail.com>
Subject: RE: Feature Request: Show status of the stash in git status command
Date:   Sun, 11 Jun 2017 13:57:25 -0400
Message-ID: <000b01d2e2dc$327c11c0$97743540$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHZQ29ArhOS7YAPjT7jPvdwYR36LAFpCkanAbqFlqUCB25i+wFkDR0/od64DAA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 11, 2017 1:07 PM liam Beguin wrote:
>There is one thing I've noticed though. When using 'git stash pop', it shows the the number of stashes before dropping the commit and I'm not quite ?>sure how to address this.
<snip>
On 10/06/17 06:22 AM, Jeff King wrote:
> On Sat, Jun 10, 2017 at 06:12:28AM -0400, Samuel Lijin wrote:
>> On Sat, Jun 10, 2017 at 4:25 AM, Jeff King <peff@peff.net> wrote:
>>> On Wed, Jun 07, 2017 at 06:46:18PM -0400, Houston Fortney wrote:
>>>
>>>> I sometimes forget about something that I stashed. It would be nice 
>>>> if the git status command would just say "There are x entries in 
>>>> the stash." It can say nothing if there is nothing stashed so it is 
>>>> usually not adding clutter.
>>>
>>> I think the clutter issue would depend on your workflow around stash.
>>>
>>> Some people carry tidbits in their stash for days or weeks. E.g., I 
>>> sometimes start on an idea and decide it's not worth pursuing (or 
>>> more likely, I post a snippet of a patch as a "how about this" to 
>>> the mailing list but don't plan on taking it further). Rather than 
>>> run "git reset --hard", I usually "git stash" the result. That means 
>>> if I really do decide I want it back, I can prowl through the stash list and find it.
>>>
>>> All of which is to say that if we had such a feature, it should 
>>> probably be optional. For some people it would be very useful, and 
>>> for others it would be a nuisance.
>>
>> Perhaps there should be a flag for this if it is implemented, say 
>> status.showStash?

Random thought: what if a stash id could be used in the same way as any other ref, so diff stash[0] stash[1] would be possible - although I can see this being problematic for a merge or rebase.

Cheers,
Randall

