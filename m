Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA2922018E
	for <e@80x24.org>; Sun,  7 Aug 2016 11:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbcHGLJd (ORCPT <rfc822;e@80x24.org>);
	Sun, 7 Aug 2016 07:09:33 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34889 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbcHGLJc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Aug 2016 07:09:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so10501141wmg.2
        for <git@vger.kernel.org>; Sun, 07 Aug 2016 04:09:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=38gNfogKvy9bGIACujv8r6ZS7BAeAdM9yFB7YALsHdY=;
        b=qLlUsSQZMmrYs8w8CTC/YjqmKMwaFvi7gHlkXfM/DvjLuEZ4LJwUjBfBD3rhzqtvKw
         lN4pYnNAcN7oIW/4y99kx8c0tYhF8jAYoYRd8iTmsCaT3zk2AHUoZJl6Ip9DlJPnjLtj
         jKtv0F6+FqEps2AvS5n+ptxdziVL5h3Sn7aIArAmVZE6ICGfIJeGekJ+xDEpHoFzn4/H
         AUJ1dS+B+TGj8rhVOI0hYYXdzn/sEThTxKHbwtIF8I46IGhRryZL6VD6lOhRA/qI9erk
         pTCZGgPvK5cVGugxhhgf+GJ9YIGq0L2uAxg5nqvgvOXIAaJeqktbS7/QWioxMAgLBM83
         oYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=38gNfogKvy9bGIACujv8r6ZS7BAeAdM9yFB7YALsHdY=;
        b=hDzZNss+MTKzaMgkRoKBMO/p9V1o2LhcAgj5AUCfJ9sldNE3ZimMosAUhyDyB+thLF
         tb/zm29zQcoDzCNwyPGY6nd3QYpJOHAXQP8M7U1qvpg5v9vKMwTm2+RpxivraiEy0L7f
         rG0Pi2OENMiUmu5LSzqQf3aMktrR7a7UtK0LGcylyKvDfsrgEBzfwsT8COKHyyN5DROj
         irjQb4evYSeIIo/KxkF/uktaDnUAHDYTJfsGLWWfqGK/PBv9KaQ6TlkA6JZfNqAyrdcG
         O0tydQi3omV/LrKXETAsxEXJVdJlG1nfd6AkzGnDqIj7YLW22SqxJSkxNxJLzP/JbhrZ
         EC0A==
X-Gm-Message-State: AEkoouuxDO/m8T3eH39MA8mUqaJsGMWCkUOqeU6LyAvVIVkQztKQcXFCppgIgCmGgPlMyg==
X-Received: by 10.28.166.1 with SMTP id p1mr10638491wme.85.1470568170558;
        Sun, 07 Aug 2016 04:09:30 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB7442.dip0.t-ipconnect.de. [93.219.116.66])
        by smtp.gmail.com with ESMTPSA id al10sm27255931wjc.12.2016.08.07.04.09.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Aug 2016 04:09:29 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive: abort properly upon errors
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1608061045240.5786@virtualbox>
Date:	Sun, 7 Aug 2016 13:09:28 +0200
Cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Eric Wong <e@80x24.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <CFDF5DDE-C5D9-489E-B099-6D0D2479B331@gmail.com>
References: <cover.1469547160.git.johannes.schindelin@gmx.de> <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com> <alpine.DEB.2.20.1608041730130.5786@virtualbox> <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com> <alpine.DEB.2.20.1608050925240.5786@virtualbox> <CAGZ79ka5OknKYo_CgBpB16EQjwU5B35yNFWx569K-LPmHuSqWA@mail.gmail.com> <alpine.DEB.2.20.1608061045240.5786@virtualbox>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 06 Aug 2016, at 10:58, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:
> 
> Hi Stefan,
> 
> just quickly (i.e. addressing only one point, will try to address more at
> a later date) because I want to be mostly offline this weekend:
> 
> On Fri, 5 Aug 2016, Stefan Beller wrote:
> 
>> On Fri, Aug 5, 2016 at 1:20 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>> 
>>> I also hate to break it to you that git-send-email is not going to be
>>> part of any solution.
>> 
>> It's written in perl, so it's not one of the core parts of Git that you
>> mentioned above. I do use it though for my submission process.
> 
> The problem is not Perl, but how fiddly it is to set up. And that you lose
> all the niceties of an email client (e.g. when you want to add a comment
> before the diff stat that is not intended to become a part of the commit
> message).
> 
> But I had an apostrophe last night. I might have been a bit overzealous to
> claim that git-send-email won't be a part of the solution. It cannot be
> a *user-visible* part of any solution, that still holds true.
> 
> So here is the apostrophe: why not implement a bot that listens to the PRs
> on GitHub, and accepts commands such as "@<whatever>bot please send this
> upstream" via comments on the PR. It would then send the patches to the
> list, from its own email address, on behalf of the contributor.
> 
> Lots of things to kink out, such as: does it need to be moderated? Record
> what was submitted in its own git.git fork? Accept replies and attach them
> to the correct PR? Maybe annotate those replies with the commits whose
> patches were discussed? Maybe send out replies on the PR as emails? Maybe
> try to auto-apply suggested patches? Cc: people who commented on earlier
> iterations of the patch series? Maybe make interaction smarter using an AI
> bot framework?
> 
> If only I had lots of time on my hand, I'd start by prototyping a node.js
> server and hooking it up via webhooks, then show it off so others can
> tinker with it.
> 
> This is not completely unlike submitGit, which was a good first attempt,
> but I never used it because I needed it to do so much more than it already
> did, *and* it complicated everything by requiring users to register with
> an extra step to allow submitGit to send email on their behalf. It also
> made contributing to it harder by choosing some non-standard web app
> framework. Also, I really do not like having to go to a different website
> just to send a GitHub PR to the list.
> 
> Anyway, that was my brain fart for the day.

Great discussion! I would like to share my perspective a someone who is
a (relatively speaking) new Git contributor and who has never interacted
on mailing lists before Git:

1.) "git format-patch" and "git send-email" work great for me. It took some
    time to learn how they work but now I have my own "submit.sh" based
    on those tools and posting a new series is a piece of cake.

2.) Initially it was hard for me to ensure that my patches don't break build or 
    tests on Linux and OS X. Travis CI helps me a lot. I just wished we could
    get Windows support, too.

3.) I noticed that I get two types of reviews. The first kind points out things
    in my patch that are obviously wrong. The second kind are things that require
    a discussion. When I get feedback of the first kind, then I am always super
    eager to send out a new roll just because I don't want any other reviewer
    to waste time on obviously wrong patches. However, I have the impression
    that frequent re-rolls are frowned upon. If we would use Git for the patches
    instead of email, then I could add "squash" patches to indicate changes in
    the current roll that will be squashed in the next roll (I know I could
    send squash patches as email, too... but for me that gets confusing quickly).

4.) Reviewing patches is super hard for me because my email client does not
    support patch color highlighting and I can't easily expand context or look at
    the history of code touched by the patch (e.g via git blame). I tried to setup
    Alpine but I wasn't happy with the interface either. I like patches with a GitHub
    URL for review but then I need to find the right line in the original email to
    write a comment.

Again, this is just my point of view as a "newbie" and I definitively don't expect
the Git community to change their established workflows.

Cheers,
Lars