Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E08F5202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 16:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932326AbdJZQo6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 12:44:58 -0400
Received: from avasout08.plus.net ([212.159.14.20]:53775 "EHLO
        avasout08.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932127AbdJZQo6 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2017 12:44:58 -0400
Received: from [10.0.2.15] ([147.147.86.16])
        by smtp with ESMTPA
        id 7lH4ePFhTufWk7lH6eS36e; Thu, 26 Oct 2017 17:44:56 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=WfJ8UwpX c=1 sm=1 tr=0
 a=dubYQqM3tRRTmV8xSh8cXQ==:117 a=dubYQqM3tRRTmV8xSh8cXQ==:17
 a=IkcTkHD0fZMA:10 a=oVJrbnLui3IB4O3C7uYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: What's cooking in git.git (Oct 2017, #05; Tue, 24)
To:     Junio C Hamano <gitster@pobox.com>
References: <xmqqk1zlktbc.fsf@gitster.mtv.corp.google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Message-ID: <7b40d574-c6e3-d824-5e2f-b7cf18dadeb5@ramsayjones.plus.com>
Date:   Thu, 26 Oct 2017 17:44:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqk1zlktbc.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI9s288mzH5A8BrQiKnScccyHwwxyW119mmVpqmF09gvZNAlLxWRbke0May9mwePtXk99P4s5iWVpzHDmbfWVvRYPKiNyydgL93aYN54o8lDs1QnkDCA
 /ilvnUz8Q7AEP94+HZTCvY1hBWM5QyUYg+Y5jZlijHHleMcqLPR0QYLuWYMJCk1lymVmSBqHlM+AHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 24/10/17 06:28, Junio C Hamano wrote:
[snip]> 
> * tg/deprecate-stash-save (2017-10-23) 3 commits
>  - stash: remove now superfluos help for "stash push"
>  - mark git stash push deprecated in the man page
>  - replace git stash save with git stash push in the documentation
> 
>  "git stash save" has been deprecated in favour of "git stash push".
> 
>  Will merge to 'next'.

If you don't intend to include this in v2.15.0, when re-building
the next branch after release (the above is now in 'next'), could
we please remember to update one of the commit message subject line.

In particular, commit 742d6ce35b ("mark git stash push deprecated
in the man page", 22-10-2017), is marking 'git stash *save*' as
deprecated, not *push*.

[Sorry for not spotting this earlier; I only noticed when doing an
'git log --oneline' display which, naturally, puts focus on the
subject lines. ;-) ]

ATB,
Ramsay Jones


