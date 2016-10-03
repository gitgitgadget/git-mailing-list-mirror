Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED007207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 17:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbcJCRpA (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 13:45:00 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35348 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcJCRo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 13:44:59 -0400
Received: by mail-pf0-f169.google.com with SMTP id s13so66022657pfd.2
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=VM3rBfN2ECa6rS6El4Q2SHKFxNpekV8t0CCC1xTDxMk=;
        b=eWUCionvm/FPlXelrKHhN0/bj7kilYp5/kj7bew+lPX3+jlQnKAiL7lE8MdK2Ww+p6
         MmGw429GSIi6L9PBM9rxb4fvG2+bMSgZp3yqb1PeCTYmD6g5CKYnC3fJTbKKREwtFcSK
         gq4LLNhHkyQq/0N8vrzcTWp4N02ndDCHak80yCOtSoy7TcRLlhnyWJGybiTAHiIpZHol
         28xb+F3Wy6B2aqEA7JgrsyNxyd70OJz8jWtx/HR+yoJXdTZE7yjFzJjSd1Lgudr+eAK4
         Q6lryMdkuJRFjzYFYLMm9ECZEHEgTSJjQlzsTa1gGOXuXlu3c2RmAZTnWqq803tqkpsa
         uOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=VM3rBfN2ECa6rS6El4Q2SHKFxNpekV8t0CCC1xTDxMk=;
        b=DsPoxCm//ZsV+34+aDkYUem4q/mfXmletY6fJumeT/elWbIMLmVN/pr+MPfJ8SmuFs
         CvnmUPCLN3UJfobhqsPJuqkkGRokbEk7KA1ONTYJGtjzYuHT3tRXzd2icnEKPwocnzTC
         RbCijTX1WnyDia2Z53z9I06+BQEr+vA86ivFdlGNnUidl8aD6c/Fcia9cwVec6ZcWBgU
         bLoWJwAW02Xk7IeAnoeO8OmA7d1Uei+ujmj1YGCjndhGIBQnTRw6ve4bw4YFZlVemGlm
         iMVdxzBrTw9qXcIE81Ki79RaVIpAiuaNmMZR8we+0X8y3qv+i3N5eZWBLiggrjfeQrVX
         Y28Q==
X-Gm-Message-State: AA6/9RngRZhmZGWQ1x1LdajhUkgCvLcDIuzfOvsprxAuVln7XcVy86yBdeAHIQsQ98k+hFGs
X-Received: by 10.98.66.205 with SMTP id h74mr29321394pfd.92.1475516696126;
        Mon, 03 Oct 2016 10:44:56 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:a8c4:ef1c:855a:28ff])
        by smtp.gmail.com with ESMTPSA id u19sm48789981pfa.40.2016.10.03.10.44.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2016 10:44:55 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1475176070.git.jonathantanmy@google.com>
 <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
 <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
 <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
 <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <e03fdabd-6690-5244-5f79-1715b0364845@google.com>
Date:   Mon, 3 Oct 2016 10:44:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/30/2016 01:49 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>>> I vaguely recall that there were some discussion on the definition
>>>> of "what's a trailer line" with folks from the kernel land, perhaps
>>>> while discussing the interpret-trailers topic.  IIRC, when somebody
>>>> passes an improved version along, the resulting message's trailer
>>>> block may look like this:
>>>>
>>>>     Signed-off-by: Original Author <original@author.xz>
>>>>     [fixed typo in the variable names]
>>>>     Signed-off-by: Somebhody Else <somebody@else.xz>
>>>>
>>>> and an obvious "wish" of theirs was to treat not just RFC2822-like
>>>> "a line that begins with token followed by a colon" but also these
>>>> short comments as part of the trailer block.  Your original wish in
>>>> [*1*] is to also treat "a line that begin with a whitespace that
>>>> follows a line that begins with token followed by a colon" as part
>>>> of the trailer block and I personally think that is a reasonable
>>>> thing to wish for, too.
>>>
>>> If we allowed arbitrary lines in the trailer block, this would solve
>>> my original problem, yes.
>
> Here is an experiment I ran during my lunch break.  The script
> (attached) is meant to run in the kernel repository and
> for each log messages of each non-merge commit:
>
>  * find its last paragraph, where the definition of paragraph is
>    simply "a blank/empty line";
>
>  * inspect if there is at least one RFC2822-header-looking line, or
>    a line that begins with "(cherry picked from";
>
>  * dump the ones that do not pass the above criteria.
>
> My cursory look of the output did not spot a legitimate trailer
> block that we should have identified.  The output lines shown were
> ones that are not signed off at all (e.g. af8c34ce6ae32add that says
> "Linux 4.7-rc2"), ones that has three-dash line "---" in them
> (e.g. 133d558216d9), ones that has diffstat that should have been
> after "---" (e.g. 259307074bfcf1f).
>
> The story is the same if you run it in git.git; the "do we have at
> least one rfc2822-header-looking line or '(cherry picked from' line
> in the last paragraph? if so, then that is an existing trailer
> block" seems to be a good heuristics to cover many cases like
> these:
>
>     d0196c8d5d3057c5c21a82f3d0113ca8e501033b
>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>     [tomi.valkeinen@ti.com: resolved conflicts]
>     Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>
>     59f0aa9480cfef9173a648cec4537addc5f3ad94
>     Link 1: https://bugzilla.kernel.org/show_bug.cgi?id=9916
>             http://bugzilla.kernel.org/show_bug.cgi?id=10100
>             https://lkml.org/lkml/2008/2/25/282
>     Link 2: https://bugzilla.kernel.org/show_bug.cgi?id=9399
>             https://bugzilla.kernel.org/show_bug.cgi?id=12461
>             https://bugzilla.kernel.org/show_bug.cgi?id=11880
>     Link 3: https://bugzilla.kernel.org/show_bug.cgi?id=11884
>             https://bugzilla.kernel.org/show_bug.cgi?id=14081
>             https://bugzilla.kernel.org/show_bug.cgi?id=14086
>             https://bugzilla.kernel.org/show_bug.cgi?id=14446
>     Link 4: https://bugzilla.kernel.org/show_bug.cgi?id=112911
>     Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>     Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

That sounds reasonable to me. Would a patch set to implement this new 
trailer block heuristic (in both sequencer and trailer) be reasonable? 
And if yes, should trailer know about the "(cherry picked from" prefix? 
(I can see it both ways - knowing about the "(cherry picked from" prefix 
would make it consistent with sequencer, but it seems like a detail that 
it shouldn't know about. Writing "Cherry-picked-from:" instead probably 
wouldn't solve our problem because, for backwards compatibility, we 
would still need to support reading the old format.)
