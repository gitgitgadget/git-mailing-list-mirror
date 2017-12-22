Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8171F404
	for <e@80x24.org>; Fri, 22 Dec 2017 10:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756086AbdLVKrr (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 05:47:47 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:3764 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755906AbdLVKrn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 05:47:43 -0500
Received: from ms26nec.int.opaltelecom.net ([10.103.251.104])
        by smtp.talktalk.net with SMTP
        id SKrbedUJ4CbAZSKrbeKneo; Fri, 22 Dec 2017 10:47:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1513939660;
        bh=UJW5HgHMnHsoHDBur6ulRwUDXbW+y2NiHqQJoOZmNNQ=;
        h=Date:From:To:Subject:Cc:In-Reply-To:References;
        b=oF7y2HvXzNnZLcs6nAApKWg5QhassMTR9QJ5L3YEn4Kus86virt1w9Ht3yHwpiD7v
         8gzy379ohaOoRK2Gb23TnzV+RSYkONdt5X2v4FoZcfPAtMXkPfdTsNmyFCiR0A/7X3
         HSyRLK9IoHyQjBGcLItIlVlzc0F0pQ3/Ky34crZk=
X-Spam: 0
X-OAuthority: v=2.2 cv=JvuBlIwC c=1 sm=1 tr=0 a=gCN1RMym0MIDZSr+K0TJSQ==:117
 a=wcpVQE0W4qLcfTC1YB9uxQ==:17 a=9Ui_ZxslVaMA:10 a=IkcTkHD0fZMA:10
 a=ocR9PWop10UA:10 a=pGLkceISAAAA:8 a=nN7BH9HXAAAA:8 a=evINK-nbAAAA:8
 a=KPMBK_wALK_Xt_9ds-MA:9 a=QEXdDO2ut3YA:10 a=RfR_gqz1fSpA9VikTjo0:22
Received: from (82.10.83.37) by webmail.talktalk.co.uk;  Fri, 22 Dec 2017 10:47:39 +0000
Message-ID: <23359630.1065831513939659692.JavaMail.defaultUser@defaultHost>
Date:   Fri, 22 Dec 2017 10:47:39 +0000 (GMT)
From:   "phillip.wood@talktalk.net" <phillip.wood@talktalk.net>
To:     <kaartic.sivaraam@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Error in `git': free(): invalid pointer (was Re: [PATCH]
 sequencer: improve config handling)
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <1513876450.9646.6.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset="UTF-8"
Content-Transfer-Encoding: 7bit
References: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
         <20171213114621.30250-1-phillip.wood@talktalk.net>
         <1513794792.9785.2.camel@gmail.com>
         <25620501.1048091513875229038.JavaMail.defaultUser@defaultHost> <1513876450.9646.6.camel@gmail.com>
X-Originating-IP: 82.10.83.37
X-Username: phillip.wood@talktalk.net
X-CMAE-Envelope: MS4wfGLEbWDt0RgdPvEE6JIpTJBc0ixU/fA+WW9gE2oWe3tmp0pI6EqH5XgzhPdVzWSgHLr+QQn8/ByRE9SMOghYWmllLclDw6tVe/eKLMHGVewOSoLPjbat
 Hl5z1BVFlGxqvNEVsZAH8XVilvGc+oOJIVq8CF9IwPeuKh9Q2yMsCVUrgY/S3w7OVnWcq4kZIwQ0M4X8r71E4g5+VbtKqyRKTzDqa4uFW7QyN5xYAbVd4yzO
 UohgTX3o0kGFkZu/SbWhXMBUWP6pnDRSFlkajTdLt4yIdYbtTMNo2JqV7N+yyhCx6WHEN7l2U6YrEOpDmDh+pw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>----Original Message----
>From: kaartic.sivaraam@gmail.com
>Date: 21/12/2017 17:14 
>To: "phillip.wood@talktalk.net"<phillip.wood@talktalk.net>, "Phillip 
Wood"<phillip.wood@dunelm.org.uk>, "Git Mailing List"<git@vger.kernel.
org>
>Cc: "Johannes Schindelin"<Johannes.Schindelin@gmx.de>
>Subj: Re: Error in `git&#39;: free(): invalid pointer (was Re: [PATCH] 
sequencer: improve config handling)
>
>On Thu, 2017-12-21 at 16:53 +0000, phillip.wood@talktalk.net wrote:
>> Hm, There is a problem with sequencer_remove_state() which does 
>> 
>> free(opts->gpg_sign)
>> 
>> however unless a gpg key was given on the commandline, opts->gpg is 
>> initialized to "" which is statically allocated. 
>> 
>> This untested diff should fix that,
>
>It did seem to. I don't get that error any more.

That's good, thanks for testing it

>>  but I'm not sure if you're problem 
>> is related to it
>
>As the fix you suggested did work, I think the problem is related. Did
>you have anything else in mind when you said you're not sure whether 
or
>not it's related?

I didn't have anything else in mind, but at that point I hadn't noticed 
that one of your previous messages said you had gpg signing turned on - 
as you do it makes sense that the patch fixed it.


Thanks again for reporting this and testing the fix - it seems the test 
suite has a bit of a blind spot when it comes to gpg signing, I guess 
it's difficult to set up a key for tests

I'll send a proper patch when I have time in a few days

Best Wishes

Phillip
