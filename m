Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93F21F453
	for <e@80x24.org>; Wed, 30 Jan 2019 23:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfA3XEj (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 18:04:39 -0500
Received: from e2i236.smtp2go.com ([103.2.140.236]:43043 "EHLO
        e2i236.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfA3XEj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 18:04:39 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 18:04:37 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=m1fbw0.a1-4.dyn; x=1548890378; h=Feedback-ID:
        X-Smtpcorp-Track:Date:Message-ID:From:To:Subject:Reply-To:Sender:
        List-Unsubscribe; bh=dzAZd49bCfm2L7x6bIqa9VbZgCtW2O6cJtaZK99nHVI=; b=gyIYKW49
        dwosxmNby3HoIMmVzZTnK+RnnIESs8Os+d3uqkHKCJGikMydl0Df0o6w4MSk+kJUoQ6gGgnTThcED
        IZFtgfnO2KftGWN+h4J78Kw49hxGDQyIgACvpyYMfv30LcWPfk8JlOSTuzSFYfRUUXTtjl6+Ub2e/
        AAYfyxRa28styyKww0vRx3lGF1CYcQ/IlVFn6Qzt4rJ9VeTfMVPPgIKhaxUC/6WIq13C8r0kZ2Ri8
        TOLmM1HgNF8fYvV6CYYdoY3tj898dLNigx02zojG7UD3q3KHdXo09mo1F3n/7xMuhVY+9mW5x5oqT
        i/XBBp2Nk0Rzxd2VpnmZtGBIeA==;
Received: from [10.176.58.103] (helo=SmtpCorp)
        by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <philipoakley@iee.org>)
        id 1goyhb-cp4YRd-Mn; Wed, 30 Jan 2019 22:51:27 +0000
Received: from [10.109.128.5] (helo=[10.172.29.11])
        by smtpcorp.com with esmtp (Exim 4.91)
        (envelope-from <philipoakley@iee.org>)
        id 1goyha-9EFQjD-PT; Wed, 30 Jan 2019 22:51:26 +0000
Subject: Re: Contributor Summit Topics and Logistics
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190122075027.GA29441@sigill.intra.peff.net>
 <87va253lun.fsf@evledraar.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <2015d9ea-0570-b035-dcbb-ee1865381cf1@iee.org>
Date:   Wed, 30 Jan 2019 22:51:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87va253lun.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Smtpcorp-Track: 1goyha9EFQMDeT.lppqcs6Zs
Feedback-ID: 66524m:66524aMf6O2Y:66524stUsp_gkRC
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/01/2019 20:57, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Jan 22 2019, Jeff King wrote:
>
>> There's no set agenda; we'll decide what to discuss that day. But if
>> anybody would like to mention topics they are interested in (whether you
>> want to present on them, or just have an open discussion), please do so
>> here. A little advance notice can help people prepare more for the
>> discussions.
> This is definitely a "little" advance seeing as it's tomorrow morning.
>
>> Even if you're not coming, please feel free to suggest topics (but bonus
>> points if you convince somebody who _is_ coming to lead the session).
> Things I'd be interested in hearing / talking about about that haven't
> yet been mentioned.
>
> These are in descending order of how interesting I think these will be
> to a general audience, to the point where maybe only I care about the
> bottom of this list...
>
> * "Big repos". We had discussions about this in years past. It's a very
>    spawly and vague topic. Do we mean big history, big blobs, big (in
>    size/depth/width) checkouts etc?
>
>    But regardless, many of us deal with this in one way or another, and
>    it would be good to have a top-level overview of how the various
>    solutions to this that are being integrated into git.git are doing /
>    what people see on the horizon for scalabiltiy.


I'd also like a bit of discussion about ensuring that the partial clone 
& filtering aspects of 'big repos' (if partial is needed /used then it's 
big ...) still retain the full 'distributed' nature and capability of git.


Also in some environments the filtering may want to be applied at the 
server end (based on it's knowledge of the specific user). Ultimately it 
should also pull in some of the sub-module aspects as super projects are 
just big repos in disguise.

>
> * "Structured remote logging". We had an RFC spec for turning our trace
>    format into something more structural with a way to send it to a
>    remote server. There were both implementation & privacy concernse,
>    last time at least a couple of users of git reported having in-house
>    patches for this (not ready for upstream). Where are we on this now?
>
> * "commit graph by default". I had this on my list, but Derrick Stolee
>    sent out a much better summary:
>    https://public-inbox.org/git/6d0dc2a2-120c-0d42-1910-14ffed7adaf1@gmail.com/
>
> * I've been using (but haven't yet re-rolled) my "relative SHA-1
>    abbreviation" series
>    (https://public-inbox.org/git/20180608224136.20220-1-avarab@gmail.com/)
>
>    I'm interested in seeing if anyone else is interested in this, and
>    particularly what the overlap (if any) is between this & midx.
>
> * "Making strict fsck checks on clone the default". I worked a bit on
>    this in this last year in between a couple of security issues that
>    needed fsck checks. Has caveats etc., but would give users some more
>    protections.
>
> * "The CI I set up for git on the GCC Compile Farm". Can be folded into
>    a general "state of git.git CI" topic:
>    https://gitlab.com/git-vcs/git-ci/pipelines
>
> * If people care about making the TAP mode in our test suite mandatory
>    (i.e. require "prove" or a tool like it). See
>    https://public-inbox.org/git/87zhrj2n2l.fsf@evledraar.gmail.com/


I also had some questions regarding tree walk issues for follower and 
friendly fork repos that have lots of deadheads within their tree, such 
as previous release versions in Git for Windows. It should be easier to 
filter those deadheads (or at least suggest the best way of creating 
such sentinels).

--

Philip


