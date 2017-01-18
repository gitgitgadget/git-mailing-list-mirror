Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587E11F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 19:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbdARTWh (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 14:22:37 -0500
Received: from mout.gmx.net ([212.227.17.20]:55692 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752211AbdARTWW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 14:22:22 -0500
Received: from [192.168.178.43] ([188.108.243.130]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsfrR-1ca5uh1Nu5-012H9W; Wed, 18
 Jan 2017 20:20:38 +0100
Subject: Re: [RFC] stash --continue
To:     Marc Branchaud <marcnarc@xiplink.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cd784a4e-ee99-564e-81de-9f7f6cc26c67@gmx.net>
 <alpine.DEB.2.20.1701161153340.3469@virtualbox>
 <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com>
Cc:     git <git@vger.kernel.org>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <e273c7c8-278a-061c-44fd-4808b53d0475@gmx.net>
Date:   Wed, 18 Jan 2017 20:20:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <d5456165-bdf2-e9e7-117f-aeab0ff4b417@xiplink.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:0KzE46H0fvTNkiBOXFdmbcGg6yFYEWgPVpIGLzxnW3Z6mazCXR9
 0wTx0KXQmJWn8h3yY9sMh9BRZYu28+Gzs7SXtvG9ZD9kKl2pHhbqbO8o5MANIFUxK21batV
 E1fYTi78LnSvafWilIo5JVY4RpE9t916yFU9SBRMyM/9bOrVCFfI9BluK+7iscztHXKzabN
 H+9SFi36BDYkp1L0FAQ9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9NPCInjmiX8=:l8xwoy5UMUrFws7KLjB8NE
 Rq1DGfon5jwECf9wMflUp5aq6KF5aMnpMPwm6CvOepID7LOciUaP5C6rPRaAKUxIBXrcM4E8B
 EZtgGLDfyQtpD8DZpridhBUm07pdJD33zxodf3KDGF0cKK9vsALEY5iAQtVPEDd8QgX3aWPYH
 MzC+OMXZmznNhqufr/ikXrW+PL8ydfx6wccfXghQnb9eZzluxBWgJMj9DCbxwvoyPusJgrN0D
 /DyuYphUYs9XuzxYM8Y4R5HBg/58v71IJ/BRG4/2KwqKgvxLpFhjWqeNvCLR7KdjNfZWonqsV
 aM/V8idb8/RsHIhu67iqbN9iPQQ5y2brgNPZJDWlad5f9A0FIfPMCcdRuXUBqvC2RVUHegEDm
 +L7VnhFQ1LAMUKia/aLHa/B5wNxYkMXgsaqPAftuYovjW0v3dPuYoF6CJZgF85SIwQTOVtZQs
 /9Yt+8LXsWYKgY3mSmWIb7wm4Iu9HWB2cjYbJKpb+njXnxE8T+RIeZEt5uG39tE9h/NKNjlu7
 9e9iklU2lr9vg9EFK7yf6ynkgZIiXI2RejBYMDa/0GTEyufYk4DUdghcqcyPJm5Eegn+qf7h5
 yjpyN+QXtWf8NrAhFz0vM/mcoojW3MZ7Ti4aVM25Ks6pLSNfkHtjUYPkGTls2y5KlU89d9ixV
 xCJBOyaL3GYE59ApeaErw9YPJUe46AYD1sIjaGozQIucJNpdhXcVQ9EldFoUk+yRz2ejwVj/g
 nEzyyUU//OXEKHxf7S0k3kz6koQXHN6MoAIi1+EC+Ge/f/Hs9t2GeabH4XsPEVpxNti5wIZ8a
 xs9t2YZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 01/18/2017 04:41 PM, Marc Branchaud wrote:
> On 2017-01-16 05:54 AM, Johannes Schindelin wrote:
>> On Mon, 16 Jan 2017, Stephan Beyer wrote:
>>> a git-newbie-ish co-worker uses git-stash sometimes. Last time he used
>>> "git stash pop", he got into a merge conflict. After he resolved the
>>> conflict, he did not know what to do to get the repository into the
>>> wanted state. In his case, it was only "git add <resolved files>"
>>> followed by a "git reset" and a "git stash drop", but there may be more
>>> involved cases when your index is not clean before "git stash pop" and
>>> you want to have your index as before.
>>>
>>> This led to the idea to have something like "git stash --continue"[1]
>>
>> More like "git stash pop --continue". Without the "pop" command, it does
>> not make too much sense.
> 
> Why not?  git should be able to remember what stash command created the
> conflict.  Why should I have to?

Dscho and Junio gave you a git-perspective argument.
I give you a user-perspective one:
What if you did "git stash pop" and ran into an (unexpected) conflict.
You resolve it, and you probably - for some reason - don't want to drop
the stash now, as "git stash --continue" (assuming "pop") would do. So
I'd regard it as a feature if you could now run "git stash apply
--continue" to just finish the job without dropping.

Best
Stephan

PS: I put this idea in my todo priority queue. If somebody else is
interested: I am not going to work at this idea before February.

PPS: Any opinions about the mentioned "backwards-compatibility" issue
that people are then forced to finish their commits with "--continue"
instead of "git reset" or "git commit"?
