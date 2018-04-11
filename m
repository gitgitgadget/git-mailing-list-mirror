Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D013A1F424
	for <e@80x24.org>; Wed, 11 Apr 2018 10:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeDKKN2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 06:13:28 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:41474 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752361AbeDKKN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 06:13:26 -0400
Received: from [192.168.2.240] ([92.22.12.182])
        by smtp.talktalk.net with SMTP
        id 6Cklfyfx7lWlT6CklfJe5y; Wed, 11 Apr 2018 11:13:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1523441604;
        bh=hjbage5E4252PxOe2wq/XP732+fH5GxARPCRzGVClJA=;
        h=Reply-To:Subject:To:References:From:Date:In-Reply-To;
        b=Fk7FMt/z/eSSkGykSRyv5vqpAq/YfQLjgjb9dlQuXfn/lz/OpQOznf+VZIiJ8nDtF
         CTQ0kBcvNTRjwwKesWPSMjmVWsx11TlGG11QI9wh81EtH0uuQcW2TIbA4cR0XRnrJ2
         8DCg3OCnO6Q5GSpR0eSrdWCpU06xP4qV+S4Q/JF0=
X-Originating-IP: [92.22.12.182]
X-Spam: 0
X-OAuthority: v=2.3 cv=N4gH6V1B c=1 sm=1 tr=0 a=6E9tJQHDO+z314HI75mSew==:117
 a=6E9tJQHDO+z314HI75mSew==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=W9fWLeL9r2sVS2eDZdUA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Apr 2018, #01; Mon, 9)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <9895c7b7-eac4-28c1-90c6-443acd1131b7@talktalk.net>
Date:   Wed, 11 Apr 2018 11:13:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0z865pk.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDVwGclQ47jp8QHkA8yUbVVpaRE2VKhrrngoKyWlWI+v8DriYw4Yb3OnYYqAwAOSInsBtkAhADJCPmv3EQRfyGFMKL4pv+hUBNJPeihf6b6hW/eiXItr
 +AB7IIAqPzHO4KhXFbkqg4RrfLimhgjlvYqoMc086Fcpb2fRJqkRzBQKf86TGm5A4zAgwkl+fs2sKqGghGUw0X9Bw5RUNsevG48=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/04/18 11:21, Junio C Hamano wrote:
> * pw/add-p-select (2018-03-16) 3 commits
>    (merged to 'next' on 2018-03-30 at eae69f5ded)
>   + add -p: optimize line selection for short hunks
>   + add -p: allow line selection to be inverted
>   + add -p: select individual hunk lines
> 
>   "git add -p" interactive interface learned to let users choose
>   individual added/removed lines to be used in the operation, instead
>   of accepting or rejecting a whole hunk.
> 
>   Will kick back to 'pu'.
> 
>   There was a brief discussion about this topic not doing as good a
>   job as it is advertised as---has it been resolved, or do we want to
>   run with what we have for now?
>   cf. <878ta8vyqe.fsf@evledraar.gmail.com>

I've been working on a re-roll that has handles modified lines better. 
I'm not sure what to do about the cases where it cannot pair up the 
insertions and deletions automatically - I think I'll clean up what I've 
got, post it and see where the discussion goes from there.

Thanks

Phillip

