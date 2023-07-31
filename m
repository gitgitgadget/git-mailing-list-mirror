Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BF5C001DF
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 13:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjGaNiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jul 2023 09:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjGaNiU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 09:38:20 -0400
Received: from mail.zombino.com (c2.zombino.com [IPv6:2a01:4f9:c010:1e4d::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA01709
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 06:38:18 -0700 (PDT)
Received: from [10.168.4.12] (unknown [81.95.8.244])
        by mail.zombino.com (Postfix) with ESMTPS id 0CA5C3E98A;
        Mon, 31 Jul 2023 13:38:15 +0000 (UTC)
Message-ID: <d8ba032f-51bc-0bab-fd24-25dea0d56966@zombino.com>
Date:   Mon, 31 Jul 2023 15:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: SHA256 support not experimental, or?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
 <ZLlNtbAbVcYH7eFb@adams> <xmqqr0p230rj.fsf@gitster.g>
From:   Adam Majer <adamm@zombino.com>
In-Reply-To: <xmqqr0p230rj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/20/23 20:18, Junio C Hamano wrote:
> Adam Majer <adamm@zombino.com> writes:
> 
>>  From 90be51143e741053390810720ba4a639c3b0b74c Mon Sep 17 00:00:00 2001
> 
> Remove all the above lines (including the "From <commit object
> name>").  If you want to add a note that should not be recorded in
> the message of the resulting commit, write it _after_ the three-dash
> line after your sign-off.

Will do. I think the problem was `git format-patch` and then basically 
pasting that inline instead of using it for basis of an email.

I will try again.

> So, the body of the message usually should start from here (below).

+1

> In general, please follow [[describe-changes]] part of the
> Documentation/SubmittingPatches document, and also "git log
> --no-merges" of recent contributions by others.  "The purpose of
> this patch is" is not how we usually talk about our work.

+1

> And the message about SHA-256's non-experimental status can probably
> be a lot stronger, after the discussion we had recently.  How about
> saying something like:
> 
>      Note: there is no interoperability between SHA-256 repositories
>      and SHA-1 repositories right now.  We historically warned that
>      SHA-256 repositories may need backward incompatible changes
>      later when we introduce such interoperability features, but at
>      this point we do not expect that we need to make such a change
>      when we do so, and the users can expect that their SHA-256
>      repositories they create with today's Git will be usable by
>      future versions of Git without losing information.
> 
> which would probably be much closer to what you wanted to hear?

Thanks, I've included additional context now, rebased on top of next 
branch and will attach it as reply to this message.

- Adam
