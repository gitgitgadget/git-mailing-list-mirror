Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4756CD8C9F
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 15:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346776AbjJKPrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 11:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235043AbjJKPrC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 11:47:02 -0400
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2EB8F
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 08:46:58 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1697039216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whv8VKwHl1ozcon+XvljHKWEXEa+Yuf2p8xBIkCJMmY=;
        b=JXEpXYcFNkG8QV5GQXvaHfGvVU/U5A02M00KXfhSyZjXHzvxMcCdeylYPbi2ADPWQHl1XV
        ge7tJtW8HOQ+lEa9gG2QDhkIJ9TgtrJ8SUH4IBq3qMVqkzKRHhgYAqAkeU54kg7fflcyQQ
        S+CePkp3bfI12GL1SCA4jY30+OOPfWTNQ+yrDTbsCC5fzNr3xIAASlQ5dH31z/s+O3FLjj
        HY+IqiK4ja/IGR+bTeonTM1f3elhi/jMsEWK7GVt6tnI7VguUOZfmaj6+5OJHdq/U64zHe
        qwJHEsAMBu6LuUhbpsreDRpz2quky97XmwcLEqPakU5CM8pPIk4wI5PcrNslig==
Date:   Wed, 11 Oct 2023 17:46:56 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Isoken Ibizugbe <isokenjune@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Outreachy][PATCH 0/1] builtin/branch.c: ammend die() error
 message
In-Reply-To: <CAJHH8bGOSXNNYfOCkS=ck8r-=Mbq62Rs1c4NsgFWYD999kNfRw@mail.gmail.com>
References: <20231011152424.6957-1-isokenjune@gmail.com>
 <c98dd0b5988f9889ee4c2b5d4e645839@manjaro.org>
 <CAJHH8bGOSXNNYfOCkS=ck8r-=Mbq62Rs1c4NsgFWYD999kNfRw@mail.gmail.com>
Message-ID: <abf571d080e0b9785451144cb6663c4a@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-10-11 17:42, Isoken Ibizugbe wrote:
> Thanks for the feedback. How do I add the description of the patch.

Could you, please, use inline replying?  We've asked that at least four 
times already.

Regarding the description of the patch, just write it as the commit 
comment in your local git repository.  Using git-format-patch will pick 
the commit comment up and put it into the email message file you'll then 
send to the mailing list using git-send-email.  It's all rather simple 
and straightforward.


> On Wed, 11 Oct 2023 at 4:34 PM, Dragan Simic <dsimic@manjaro.org>
> wrote:
> 
>> On 2023-10-11 17:24, Isoken June Ibizugbe wrote:
>>> This patch improves the consistency and clarity of error messages
>>> across Git commands. It adheres to Git's Coding Guidelines for
>> error
>>> messages:
>>> 
>>> - Error messages no longer end with a full stop.
>>> - Capitalization is avoided in error messages.
>>> - Error messages lead with a description of the issue, enhancing
>>> readability.
>>> 
>>> Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>
>> 
>> When there's only one patch and not a series, there's no need for a
>> cover letter, and the description of the patch actually needs to go
>> into
>> the patch itself, so it can be latter pulled into the repository as
>> part
>> of the patch submission.
>> 
>>> Isoken June Ibizugbe (1):
>>> branch.c: ammend error messages for die()
>>> 
>>> builtin/branch.c | 38 +++++++++++++++++++-------------------
>>> 1 file changed, 19 insertions(+), 19 deletions(-)
