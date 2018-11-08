Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411CF1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 16:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeKICHx (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 21:07:53 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:50047 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeKICHx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 21:07:53 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id KnDSgKEhSdJAeKnDSgVf5V; Thu, 08 Nov 2018 16:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1541694695;
        bh=IYU3edqndHhB9LBnt2Eyy/sNM38KgEpYZf/nfJ9ueLo=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=ldX9YRfI+7fMzWIwCmcW5T26t4p72iz/0w/yoBm3pcJGTzdSdpagfAfJT2Fep1gtw
         qFgkm6E2IHWhDQ2ShkZzj4i8soSfDDPnJhmshaOrypXGoUjMbRFVvUOHpWyvxCUZjz
         k0AcL7hXffAe9zYbY1xVppVkK5UGuuKBeZiCQ+ug=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=LmBk-rk3AAAA:8
 a=1i1UBQkp0uoN2HncmwYA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
 a=IdEGqN_9JTMA:10 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10
 a=G48SskWDnsL46lLLIXPa:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Nov 2018, #03; Wed, 7)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqy3a5b4x2.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <96d474cf-dc40-fa40-94ae-3883e63a3cb0@talktalk.net>
Date:   Thu, 8 Nov 2018 16:31:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3a5b4x2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFb83PY+vZ7/f3XXQMUv0fepuFSCVTHmbp4PwDbKtqJk7eylkVvTDw90AVafnBFiMvOzfCKZ93ORNToIlB71mnssx99ewblHHag/mpgZA1RmWuMPZbKR
 h19xBCFMjCb9BVuqdMYzUj39e0a9NefthX6A3FdNLfevp+wE2dZqNzIqW327G8cl20wMIdOCcKRMTCwshfPr116r7IL7SbIKtgo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11/2018 09:41, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>      http://git-blame.blogspot.com/p/git-public-repositories.html
> 
> --------------------------------------------------
> 
> * pw/add-p-select (2018-07-26) 4 commits
>   - add -p: optimize line selection for short hunks
>   - add -p: allow line selection to be inverted
>   - add -p: select modified lines correctly
>   - add -p: select individual hunk lines
> 
>   "git add -p" interactive interface learned to let users choose
>   individual added/removed lines to be used in the operation, instead
>   of accepting or rejecting a whole hunk.
> 
>   Will discard.
>   No further feedbacks on the topic for quite some time.

Unfortunately I've not found time to work on this recently and don't see 
myself doing so before the new year so I think it makes sense to drop 
it. Hopefully I can come up with something next year, it would be nice 
for users to avoid having to edit patches where possible.

Best Wishes

Phillip
