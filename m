Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 853A0201A0
	for <e@80x24.org>; Thu, 11 May 2017 19:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756319AbdEKTWN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 15:22:13 -0400
Received: from smtp114.iad3a.emailsrvr.com ([173.203.187.114]:35457 "EHLO
        smtp114.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756275AbdEKTWM (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 May 2017 15:22:12 -0400
Received: from smtp39.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp39.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id CAE1D57DD;
        Thu, 11 May 2017 15:22:11 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp39.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 834C13D05;
        Thu, 11 May 2017 15:22:11 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Thu, 11 May 2017 15:22:11 -0400
Subject: Re: [PATCH v4 2/4] diff: have the diff-* builtins configure diff
 before initializing revisions
To:     Jeff King <peff@peff.net>
References: <f867af6f-b601-251a-86a4-ede0bb942efb@xiplink.com>
 <20170508160339.4551-1-marcnarc@xiplink.com>
 <20170508160339.4551-3-marcnarc@xiplink.com>
 <20170509032238.uvgg7sezfzlig2ko@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <c9a878df-1c3e-09ad-3b48-aa123123622b@xiplink.com>
Date:   Thu, 11 May 2017 15:22:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170509032238.uvgg7sezfzlig2ko@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-08 11:22 PM, Jeff King wrote:
> On Mon, May 08, 2017 at 12:03:37PM -0400, Marc Branchaud wrote:
>
>> This matches how the diff Porcelain works.  It makes the plumbing commands
>> respect diff's configuration options, such as indentHeuristic, because
>> init_revisions() calls diff_setup() which fills in the diff_options struct.
>
> I don't know if you want to note here that this is only _some_ options.
> I.e., ones that we handle by copying via diff_setup(). Maybe it's
> obvious from the description already (it's hard for me to tell because I
> already know it either way :) ).

(shrug)  I'm fine with the way it is, but I'd also be OK with "respect 
some of diff's configuration options".

Junio, please feel free to reword the message if you like.  Or I can 
send out a v5, if that's easier for you.

		M.

