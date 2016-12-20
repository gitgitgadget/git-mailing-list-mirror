Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94DC61FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 23:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbcLTXBk (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 18:01:40 -0500
Received: from smtp74.ord1c.emailsrvr.com ([108.166.43.74]:40606 "EHLO
        smtp74.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754033AbcLTXBj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Dec 2016 18:01:39 -0500
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Dec 2016 18:01:39 EST
Received: from smtp10.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp10.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 0B6F4402E8;
        Tue, 20 Dec 2016 17:53:06 -0500 (EST)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp10.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D48B3402E0;
        Tue, 20 Dec 2016 17:53:05 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 20 Dec 2016 17:53:06 -0500
Subject: Re: [PATCH 00/13] gitk: tweak rendering of remote-tracking references
To:     Paul Mackerras <paulus@ozlabs.org>
References: <cover.1482164633.git.mhagger@alum.mit.edu>
 <97d97bc6-54f1-2ef2-fe04-7e7f144d7e51@xiplink.com>
 <20161220221719.GB22566@fergus.ozlabs.ibm.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <b19e76cb-8584-186b-512b-e53ef263f7a7@xiplink.com>
Date:   Tue, 20 Dec 2016 17:53:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161220221719.GB22566@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-12-20 05:17 PM, Paul Mackerras wrote:
> On Tue, Dec 20, 2016 at 10:01:15AM -0500, Marc Branchaud wrote:
>> On 2016-12-19 11:44 AM, Michael Haggerty wrote:
>>> This patch series changes a bunch of details about how remote-tracking
>>> references are rendered in the commit list of gitk:
>>
>> Thanks for this!  I like the new, compact look very much!
>>
>> That said, I remember when I was a new git user and I leaned heavily on gitk
>> to understand how references worked.  It was particularly illuminating to
>> see the remote references distinctly labeled, and the fact that they were
>> "remotes/origin/foo" gave me an Aha! moment where I came to understand that
>> the refs hierarchy is more flexible than just the conventions coded into git
>> itself.  I eventually felt free to create my own, private ref hierarchies.
>>
>> I am in no way opposed to this series.  I just wanted to point out that
>> there was some utility in those labels.  It makes me think that it might be
>> worthwhile for gitk to have a "raw-refs" mode, that shows the full
>> "refs/foo/bar/baz" paths of all the heads, tags, and whatever else.  It
>> could be a useful teaching tool for git.
>
> Do you think we should have a checkbox in the preferences dialog to
> select whether to display the long form or the short form?

Mmmm, more knobs!

No, I don't think that's necessary.  Such a setting would probably just 
confuse people.  Plus it's not something anyone is likely to want to 
change anyway.  Maybe if there were an "Advanced" tab in the settings 
dialog, but even then it seems like overkill.

I suspect there are better ways to teach people about the refs hierarchy 
than cluttering up gitk.  These may even already exist -- I've been a 
git user for 8 years now, so I'm sure my perspective of the learning 
curve is skewed.

		M.

