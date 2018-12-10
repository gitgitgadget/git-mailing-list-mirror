Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE45620A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 10:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeLJKm7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 05:42:59 -0500
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:43452 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbeLJKm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 05:42:59 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id WJ1bgoP7aoI6LWJ1cg4zNc; Mon, 10 Dec 2018 10:42:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1544438577;
        bh=QzBNCP8Dw2gW8dy+OyNCwtGm9P15f1PPBr0SFJseQMA=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZInfDVOyAwBFAIPXEqsam7j9OXROKlrT9tyqwB6vrSxbINBe3LGgYUJUzViDHbcRn
         7br+GnsjL6zbYyP4cnDwD8YdoiCR66bRnqEnYdutp6XIgMqpBApGKJjIpOY2+RtHVY
         mSS4c021lhieojigXP8QieJtzAzDCFm7OaltTeOk=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=_o6zE9ENBE-igpYBTJ8A:9
 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: pw/add-p-select, was Re: What's cooking in git.git (Dec 2018,
 #01; Sun, 9)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1812092101570.43@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <d69259ce-bc45-9201-693b-3902a6379265@talktalk.net>
Date:   Mon, 10 Dec 2018 10:42:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1812092101570.43@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIgOXfdho8pkeF0dL4FWFL5WwMCiGjDcnjqZxbAXHoSOPSM17Lo0t5MG9imsfHZy5wmRLCL+6rKMXDOv2xvEhkbiUpB/n7rP+Hksy7pTJ48ft2Zi1hFo
 Wl9j8oMQaGAWOmjfWhHWtJCx/ImLz8TNZVr7AE6zx8zstq8rr/ycW3fB/7ZkfbjEWbnd/9Va4A+MFSqwuYnCFcVaOCDbASao3BjB+IH4+YZbHtNlQwEJ1Gye
 dNxNfRMSBTS0eS3h/L0TSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 09/12/2018 20:31, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Sun, 9 Dec 2018, Junio C Hamano wrote:
> 
>> * pw/add-p-select (2018-07-26) 4 commits
>>   - add -p: optimize line selection for short hunks
>>   - add -p: allow line selection to be inverted
>>   - add -p: select modified lines correctly
>>   - add -p: select individual hunk lines
>>
>>   "git add -p" interactive interface learned to let users choose
>>   individual added/removed lines to be used in the operation, instead
>>   of accepting or rejecting a whole hunk.
>>
>>   Will discard.
>>   No further feedbacks on the topic for quite some time.
> 
> That is not quite true. I did comment that this feature

Sorry I meant to reply to that comment but never got round to it.

> (which I take as
> being inspired by Git GUI's "Stage Selected Line"),

not particularly, I don't use git gui I just wanted a way to easily 
stage a subset of lines without editing the hunk.

> and thought that it would be useful.
> 
> I could imagine, however, that it would make sense for `git add -p` to
> imitate that feature more closely: by allowing to stage a single line and
> then presenting the current hunk (re-computed) again.

that sounds like it would be quite tedious to stage more than a couple 
of lines, and it could be awkward to get it to stage modified lines 
correctly (While I was writing the feature I tried git gui, I think it 
is supposed to be able to stage modified lines correctly but I never 
persuaded it to do it for me. I also tried gitg, tig and hg commit -i 
but I couldn't get them to do modified lines either)

I'll try and re-roll in the New Year, when does the outreachy project 
for converting add -i start? - it would be good to try and get this 
pinned down before then.

Best Wishes

Phillip
> Ciao,
> Dscho
> 

