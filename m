Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01BA20401
	for <e@80x24.org>; Tue, 13 Jun 2017 03:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbdFMDms (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 23:42:48 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34790 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751811AbdFMDmr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 23:42:47 -0400
Received: by mail-it0-f65.google.com with SMTP id 201so11236402itu.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 20:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tDmoiqF6RxoxlvkotqtPgWLMAtaz1QopKErxYQHJrK4=;
        b=ErxgA0OQ/UwYQigitZEUwUvgsxn8m7RSBM3t+k37arkWDfkNgVnLWU7EW9+T4NXQKi
         sLksCPP6VsF+ManZylbLEqTZrixV8K1orqR1wy7pTQcqNFFAPWU2tFf9XKLVHfAHKwp6
         SpVf5GzcMzeww3JspGIddDpRN7vT18XaPcGCURdxQer020MVbidD0dlmZW1HXClpVH1U
         bXijBqvaXYU9J/Og79cuS3farxEpybGbOPrHYEM6n/1RTzkbVXI7/LYjxFs3hd9ttQyM
         u0imo8YiSTqZkMQZ9OKJZKbOJrZnZbUp5eDfr9nW6a64k/YOEJuF7XHb0fZmj4R8GVR+
         rZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tDmoiqF6RxoxlvkotqtPgWLMAtaz1QopKErxYQHJrK4=;
        b=osgMOkcQ4Jvj0uZVq+qBbxcgDSHc6MfIyD3dUXw4AVJWZKSLA5Z/YzGme9MdhuBQ9G
         wZa3dteCuE5VPmrgEGb9/igxTKw/K2G2x/y2Jp9bfAk66MnweCWYaLh6wyO1YPgWe+1q
         MhECs86XHRYEf2eguVXbNg3XYD02GY9KqFKfYA93P0b5N3RG5DR4/Lv6RK3Tuio8p17e
         Pb3SRfvmFpURflC/JUA7iaqgu6HOTxikkDHz4PELD6wl4VjUqFbH8jxRoLZMDeeuNtgq
         BrI+i5lZMPqS56l9nBtfvszIxsCcgjIr6GtmIVnnSDvju2jb//I/qYFW+i22qAqHwSEt
         cgXw==
X-Gm-Message-State: AKS2vOwYFelYqW3lFmlXpcVGwZ6sevCukd/V5mrt1b7TkazYmmbuAm7o
        C3Q2HuDgqiYdOCrg4EK9ww==
X-Received: by 10.36.54.18 with SMTP id l18mr1367838itl.55.1497325366084;
        Mon, 12 Jun 2017 20:42:46 -0700 (PDT)
Received: from [192.168.2.102] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id w65sm5010726ita.21.2017.06.12.20.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Jun 2017 20:42:45 -0700 (PDT)
Subject: Re: Feature Request: Show status of the stash in git status command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Samuel Lijin <sxlijin@gmail.com>,
        Houston Fortney <houstonfortney@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CA+B9myHRahTd+FDgzK5AhXW+hq_Y_czMX9X6MXYBcr9WSPeiDw@mail.gmail.com>
 <20170610082534.6437ifexzly4oqg6@sigill.intra.peff.net>
 <CAJZjrdXCHVKQOxR=+z5cOkieKzE-iSMta--kHVjSYXuansb34Q@mail.gmail.com>
 <20170610102217.vxf6tsrdfp6srupr@sigill.intra.peff.net>
 <1c04d689-6796-17d1-e058-18874768c22a@gmail.com>
 <xmqqpoe9p6bn.fsf@gitster.mtv.corp.google.com>
From:   liam Beguin <liambeguin@gmail.com>
Message-ID: <2217b9a1-dc8c-635a-649e-eae2dec5aaa5@gmail.com>
Date:   Mon, 12 Jun 2017 23:42:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <xmqqpoe9p6bn.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

Thanks for the feedback. I'll be sending a patch with the updates shortly!

On 12/06/17 11:35 AM, Junio C Hamano wrote:
> liam Beguin <liambeguin@gmail.com> writes:
> 
>> +static int stash_count_refs(struct object_id *ooid, struct object_id *noid,
>> +			    const char *email, timestamp_t timestamp, int tz,
>> +			    const char *message, void *cb_data)
>> +{
>> +	int *c = cb_data;
>> +	(*c)++;
>> +	return 0;
>> +}
> 
> Count up, and tell the caller to keep going by returning 0.  That
> sounds sane.
> 
>> +static void wt_longstatus_print_stash_summary(struct wt_status *s)
>> +{
>> +	int stash_count = 0;
>> +
>> +	for_each_reflog_ent("refs/stash", stash_count_refs, &stash_count);
> 
> And do so with a counter initialized to 0.  Also sane.
> 
>> +	if (stash_count > 0)
>> +		status_printf_ln(s, GIT_COLOR_NORMAL,
>> +				 Q_("Your stash currently has %d commit",
>> +				    "Your stash currently has %d commits", stash_count),
>> +				 stash_count);
> 
> Conceptually, the contents of the stash are *not* commits, even
> though the implementation happens to use a commit to represent each
> stash entry.  Perhaps "has %d entry/entries" is an improvement, but
> a quick scanning of an early part of "git stash --help" tells me
> that

what's different between a stash and a commit? 

> 
> 	You have 1 stash / You have 4 stashes
> 
> would be the best, as the documentation calls each entry "a stash".
> E.g. "list" is explained to list "the stashes", and "show <stash>"
> is explained to show the changes recorded in "the stash".
> 
>> +}
>> +
>>  static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncommitted)
>>  {
>>  	struct child_process sm_summary = CHILD_PROCESS_INIT;
>> @@ -1536,6 +1557,7 @@ static void wt_longstatus_print(struct wt_status *s)
>>  	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
>>  	const char *branch_status_color = color(WT_STATUS_HEADER, s);
>>  	struct wt_status_state state;
>> +	int show_stash = 0;
>>  
>>  	memset(&state, 0, sizeof(state));
>>  	wt_status_get_state(&state,
>> @@ -1641,6 +1663,8 @@ static void wt_longstatus_print(struct wt_status *s)
>>  		} else
>>  			printf(_("nothing to commit, working tree clean\n"));
>>  	}
>> +	if (!git_config_get_bool("status.showStash", &show_stash) && show_stash)
>> +		wt_longstatus_print_stash_summary(s);
>>  }
> 
> Try to get "status.showstash" as a boolean, and only when it
> succeeds and the value is true, give this extra info (i.e. when the
> variable does not exist, do not complain and do not show).  Sounds
> sensible.
> 
> Overall the logic looks good to me; just the phrasing is
> questionable, relative to the existing documentation.
> 
> Thanks.
> 

Thanks,

 - Liam 
