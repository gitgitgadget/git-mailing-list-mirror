Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEE08201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 22:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbdBSWOH (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 17:14:07 -0500
Received: from [195.159.176.226] ([195.159.176.226]:35946 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdBSWOH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 17:14:07 -0500
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1cfZjx-0004gn-Ov
        for git@vger.kernel.org; Sun, 19 Feb 2017 23:13:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Damien Regad <dregad@mantisbt.org>
Subject: Re: [PATCH] git-check-ref-format: fix typo in man page
Date:   Sun, 19 Feb 2017 23:13:56 +0100
Message-ID: <o8d5au$fqu$1@blaine.gmane.org>
References: <c27d7861-b161-a3eb-fcfc-bf766fc7b20b@gmail.com>
 <2116CBFFB78A482D8FA176BC680B3B9C@PhilipOakley>
 <20170219022756.pwxhjluxizuedf46@sigill.intra.peff.net>
 <8147218721BE4F239D00CBFAFD9B495D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
In-Reply-To: <8147218721BE4F239D00CBFAFD9B495D@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks all for the feedback.

On 2017-02-19 21:40, Philip Oakley wrote:
> For those not familiar with 'iff', then a change to the doc is worthwhile.

Exactly. Not being a native English speaker, I had never seen 'iff' used
before. Now that you guys have pointed me to its meaning I guess it
makes sense in this context.

That being said, IMHO software documentation is not a mathematics
textbook, and should be written in "plain" English, so

On 2017-02-19 03:27, Jeff King wrote:
> So maybe an overall improvement would be something like:
>
>   If the normalized refname is valid then print it to standard output
>   and exit with a status of 0. Otherwise, exit with a non-zero status.

I'll submit a revised patch shortly, following your suggestion.

Cheers
Damien


