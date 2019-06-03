Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD0861F609
	for <e@80x24.org>; Mon,  3 Jun 2019 18:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbfFCSLM (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 14:11:12 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:36285 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfFCSLL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 14:11:11 -0400
Received: by mail-pf1-f180.google.com with SMTP id u22so11069540pfm.3
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vUxTFgpjzh6wgHVRDcoHwPtkRmd8fBEb6SM7URBEVIw=;
        b=RaelsnWrBBvyj3b5GF7I5nnHa5u8t7dvC+5sBKGi0Y4BZt+7dJnr8WTVDCeeVHnn8q
         PgdioQqKmqdBbrMaRUfEwI/QbJgjmJTQyLanYQbkz0OhN/s6/mdhvI2VgxKeWc8ch9MM
         gF9gMobI0+kM6seRmninj204un7mponIVnteqEc9fCoXKXcs4CkwRtqwgnmuoOTNi4I7
         b92OfHvrBH+9JLMCverEwiEFVqj8ktNLmMcZOa9gyaElQT555BjbMp3SFmswjlE8gFBq
         KeodmKL5VNZYG8Ou8WStwJbiiNBGHbGClw6xkG05UKa36RQniCa6exPhcFLP5YIY0M6k
         0shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vUxTFgpjzh6wgHVRDcoHwPtkRmd8fBEb6SM7URBEVIw=;
        b=kyXo2ioxbnipjdCr5Cf7QWPR3rfwJmv31BbyfU6t67DtPiEu2gP1jO40O1ODyIL1EU
         vgvtVSQk1FcHnJhR2ynzaWFg2II5B6n/bAryUyVR2ZwexpqPfYo9BeylXxCssSBdyrJk
         h71LR7qVZ2p6BikMZH+h9MVoA0UwVzKxoY+491sDDN5wBsFzY9AxrwcdVK77M5c8mKJZ
         k8Yyw1+nJh6c+8N7hmRot/er4eVyhnPPb1Z6OEoiHIIo9BIACWm/7z13pbcn5kWcHScL
         4gkA5i/Hr/jY6sCoABBZPzvGgnxVOb/yVK2Kq32nUwFbCdf2x6yaMwdjQLT8TTZnGVUR
         aWbQ==
X-Gm-Message-State: APjAAAWw/RaRkz/smaqJMNFAuawkzAxM8nrqsflemN8SepVRHws6kDZM
        G0gtX4oZHCYhGYkdwY88kLMB1Q==
X-Google-Smtp-Source: APXvYqwl+fF06pn/vwyB0YOfJuUzs+NF0CR71CEvYEVo86ZMS75LUm4qkM0JsGGafzl7aYaW7dRoew==
X-Received: by 2002:aa7:93a7:: with SMTP id x7mr33343698pff.196.1559585470401;
        Mon, 03 Jun 2019 11:11:10 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id y7sm28495975pja.26.2019.06.03.11.11.09
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:11:09 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thursday, May 30th)
To:     Derrick Stolee <stolee@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Cc:     michael@platin.gs, Jonathan Tan <jonathantanmy@google.com>
References: <2fb43bd3-71a7-fd92-e9b8-43e4eeed34cd@gmail.com>
 <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <b4ce9cbc-71d3-4d7f-1ee2-e4e3fc23b015@google.com>
Date:   Mon, 3 Jun 2019 14:11:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e18e4391-a574-1f4b-88c7-890ada116f51@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 5/30/19 2:24 PM, Derrick Stolee wrote:
>> 8934ac8c 1190)     ent->ignored == next->ignored &&
>> 8934ac8c 1191)     ent->unblamable == next->unblamable) {
> These lines are part of this diff:
> 
> --- a/blame.c
> +++ b/blame.c
> @@ -479,7 +479,9 @@ void blame_coalesce(struct blame_scoreboard *sb)
> 
>          for (ent = sb->ent; ent && (next = ent->next); ent = next) {
>                  if (ent->suspect == next->suspect &&
> -                   ent->s_lno + ent->num_lines == next->s_lno) {
> +                   ent->s_lno + ent->num_lines == next->s_lno &&
> +                   ent->ignored == next->ignored &&
> +                   ent->unblamable == next->unblamable) {
>                          ent->num_lines += next->num_lines;
>                          ent->next = next->next;
>                          blame_origin_decref(next->suspect);
> 
> The fact that they are uncovered means that the && chain is short-circuited at
> "ent->s_lno + ent->num_lines == next->s_lno" before the new conditions can be
> checked. So, the block inside is never covered. It includes a call to
> blame_origin_decref() and free(), so it would be good to try and exercise this region.

What is your setup for determining if a line is uncovered?  Are you 
running something like gcov for all of the tests in t/?

I removed this change, and none of the other blame tests appeared to 
trigger this code block either, independently of this change.  (I put an 
assert(0) inside the block).

However, two of our blame-ignore tests do get past the first two checks 
in the if clause, (the suspects are equal and the s_lno chunks are 
adjacent) and we do check the ignored/unblamable conditions.

Specifically, if I undo this change and put an assert(0) in that block, 
two of our tests hit that code, and one of our tests fails if I don't do 
the check for ignored/unblamable.

Thanks,
Barret



