Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B8BCA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 01:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjILBfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 21:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbjILBeu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 21:34:50 -0400
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4FFA3D30
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 17:32:35 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1694478370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OjUdSSPELUQ3dEvzWaCUJEavX9basELJn6prRZwdzoI=;
        b=XrNVgMO57GvRChrZtTWClk8jD7SlxrFHw1Fm4NCL+mAdC8iLLkk6CVkstpOwMib/EvTsGA
        R4w38I1d/3QZRg4peMzdUfez34GaggDBPtLkUbIJM+jBxEjuSHMqhR2gBxV13qEdbWViRD
        fTviZ7ze4RBHoVbmAU1L0S/Q0lkDPS2ugAUY6O43R/dhGPQeOg+4nubHANsPYTngIun8zA
        Kn63Fg0VQVmc04a8vO/Jp4oSrfSH0/MQkTkAHFCcNWTT9F7smQXWVLMHXKBy0TmlbLfsyy
        nbMc6KisPvLVdIkA8vYxUJS2GWjGyExuOKyBEEiZc2TA/hAnuByazXNonkSjjQ==
Date:   Tue, 12 Sep 2023 02:26:10 +0200
From:   Dragan Simic <dsimic@manjaro.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] New configuration option "diff.statNameWidth"
In-Reply-To: <xmqqo7i8s48f.fsf@gitster.g>
References: <eb8f524eca3975f086715ec32a8a1fbb@manjaro.org>
 <xmqq8r9ommyt.fsf@gitster.g> <72c114086590b9b15a3fdd9e0d6bd67e@manjaro.org>
 <xmqq4jkcmdaw.fsf@gitster.g> <a879c9c7d3b9bdae9a49f67fbe6316fc@manjaro.org>
 <261907dbfafc8d7b3b048854b663e82d@manjaro.org> <xmqqo7i8s48f.fsf@gitster.g>
Message-ID: <0d62fba447dfb1c776d3c4a3d269e974@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-09-12 01:02, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> On 2023-09-03 05:43, Dragan Simic wrote:
>>> On 2023-09-03 00:16, Junio C Hamano wrote:
>>>> Having said all the above, once we start seeing the actual patches
>>>> and its sales pitch (aka proposed commit log message), we do guide
>>>> and help polishing the patch into a better shape, so it will not
>>>> be like the contributor has to work in the dark without knowing
>>>> what level of bar their contribution has to pass.
>>> Thanks, everything sounds great and welcoming to the new
>>> contributors,
>>> who of course need to be willing to put in the required amount of
>>> skill and effort.
>> 
>> I sent a patch to the git mailing list today, about five hours ago,
>> but it hasn't appeared on the list yet.  Could something be wrong with
>> the mail server(s), as I also received no other messages from the list
>> in the last six hours or so?
> 
> It is a high-volume mailing list server and occasional hiccup is
> part of regular life.  Waiting a bit and then poking the postmater
> at vger.kernel.org may be needed from time to time, but I am seeing
> your message on the archive, so it seems "waiting" has worked fine?

Yes, remaining patient did the trick this time.  A whole lot of messages 
from the list arrived at once after the hiccup resolved itself.
