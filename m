Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44AA20954
	for <e@80x24.org>; Tue, 28 Nov 2017 12:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbdK1MkC (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 07:40:02 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:36502 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752665AbdK1Mj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 07:39:59 -0500
Received: by mail-wr0-f177.google.com with SMTP id y42so207195wrd.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 04:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KCjwiklOrpyTh00saXGEM/HWhTi0Pep5nBFLQJhKYAI=;
        b=Wcd0je+adVQ4tBJkxN9fRsA/by7Ww0P64XKOvvyPcS/34Ef5Fw1k5VSHsfMBQNvdqs
         IATnuwvtRlpAAKWurfcEIGvJOTriXhfsiRvBoRfoot1oahbjNzABLZTLIIhzXgQHAlgr
         pLmkUs5WbX5oz9CrgzzVkTvLqXQVRnbR4qVL8v+eZF4+A/pV4JtlJh8iHfIjzOrrul06
         gWgS6xn2S6skyPxnwX/0mn7yVGnu6cAO4Y9KXnhdAFfH50/Ol54aO4Aq+8bhfRo6vIH5
         l9lqku1DTscSb9HRTg8AiD0bnsg9yb/zPKDvBc+GlhKI/pSIWnd+iqLvp8AAZgpIrLPv
         M/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KCjwiklOrpyTh00saXGEM/HWhTi0Pep5nBFLQJhKYAI=;
        b=GAfPwXfts+TI/hgvjYzVsF6PpiQoLTsyDfeLmJgqckwD1kSXObOpyiAu9p5y0mNA3R
         l1c6VN9/1IEQnLQ2h72jWNHKUqAypjaQ7mJp0c+d7Zfvo5G36NGcKAkPdK3zuqiNh/6s
         J2Cr6iNFaFW+VGH3E7Bb3a8xsYVhuigqyifRIjYiVheO4p46ISuO3VmNLqFS5MzCbXPt
         cklU823Yqm6znpVohTFfQ1DWuiIJqeG5zlj1Uyw00Ic3qNBtKczQb4anbXuwn+rO7MGF
         JIpkUCEGuahK6RpvZUGD3esSZkk8Sm6fBCDXkraHh+NaNVZMzoBvx2eSw6H762a3nQlw
         0iow==
X-Gm-Message-State: AJaThX6N4QoRb2+oHIEwFn2gWeTJznoDtbLK23wiVuL7R0inPRND8QU/
        2Va27xcdxf/SMygDa3IVISo=
X-Google-Smtp-Source: AGs4zMYv/hr7H6xEj++TR7jTYvM178sId+0zu/Q28EFF4H74gXA5IKxAKA/IiZNcwfzp2ENOqCWi5A==
X-Received: by 10.223.165.4 with SMTP id i4mr37544033wrb.158.1511872798410;
        Tue, 28 Nov 2017 04:39:58 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id b78sm8706758wmi.18.2017.11.28.04.39.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Nov 2017 04:39:57 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3] launch_editor(): indicate that Git waits for user input
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqefojb9a1.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 28 Nov 2017 13:39:57 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <B7DA73AD-CD9E-4EB1-AD6D-AAF2B11F93D8@gmail.com>
References: <20171127134716.69471-1-lars.schneider@autodesk.com> <xmqqefojb9a1.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 28 Nov 2017, at 00:18, Junio C Hamano <gitster@pobox.com> wrote:
> 
> lars.schneider@autodesk.com writes:
> 
>> diff to v2:
>>    - shortened and localized the "waiting" message
>>    - detect "emacsclient" and suppress "waiting" message
> 
> Thanks for moving this forward.
> 
> 
>> +		static const char *close_notice = NULL;
> 
> Because this thing is "static", the variable is NULL when the first
> call to this function is made, and the value left in the variable
> when a call returns will be seen by the next call.
> 
>> +		if (isatty(2) && !close_notice) {
> 
> Declaring a "static" variable initialized to NULL and checking its
> NULL-ness upfront is a common pattern to make sure that the code
> avoids repeated computation of the same thing.  The body of the if
> statement is run only when standard error stream is a tty (hinting
> an interactive session) *and* close_notice is (still) NULL.
> 
>> +			char *term = getenv("TERM");
>> +
>> +			if (term && strcmp(term, "dumb"))
>> +				/*
>> +				 * go back to the beginning and erase the
>> +				 * entire line if the terminal is capable
>> +				 * to do so, to avoid wasting the vertical
>> +				 * space.
>> +				 */
>> +				close_notice = "\r\033[K";
>> +			else if (term && strstr(term, "emacsclient"))
>> +				/*
>> +				 * `emacsclient` (or `emacsclientw` on Windows) already prints
>> +				 * ("Waiting for Emacs...") if a file is opened for editing.
>> +				 * Therefore, we don't need to print the editor launch info.
>> +				 */
>> +				;
>> +			else
>> +				/* otherwise, complete and waste the line */
>> +				close_notice = _("done.\n");
>> +		}
> 
> It assigns a non-NULL value to close_notice unless the editor is
> emacsclient (modulo the bug that "emacsclient" is to be compared
> with EDITOR, GIT_EDITOR, core.editor etc. -- git_editor() can be
> used to pick the right one).  For a user of that particular editor,
> it is left as NULL.  Because it is unlikely that EDITOR etc. would
> change across calls to this function, for them, and only for them,
> the above is computed to yield the same result every time this
> function is called.
> 
> That feels a bit uneven, doesn't it?
> 
> There are two possible solutions:
> 
> 1. drop "static" from the declaration to stress the fact that the
>   variable and !close_notice in the upfront if() statement is not
>   avoiding repeated computation of the same thing, or
> 
> 2. arrange that "emacsclient" case also participates in "avoid
>   repeated computation" dance.  While at it, swap the order of
>   checking isatty(2) and !close_notice (aka "have we done this
>   already?)--because we do not expect us swapping file descriptor
>   #2 inside this single process, we'd be repeatedly asking
>   isatty(2) for the same answer.
> 
> The former may be simpler and easier, as an editor invocation would
> not be a performance critical codepath.
> 
> If we want to do the latter, a cleaner way may be to have another
> static "static int use_notice_checked = 0;" declared, and then
> 
> 	if (!use_notice_checked && isatty(2)) {
> 		... what you currently have, modulo the
> 		... fix for the editor thing, and set
> 		... close_notice to a string (or NULL).
>                use_notice_checked = 1;
> 	}
> 
> The users of close_notice after this part that use !close_notice
> as "do not give the notice at all" flag and also as "this is the
> string to show after editor comes back" can stay the same if you go
> this route.  That would be solution 2a.
> 
> Of course, you can instead use close_notice = "" (empty string) as a
> signal "we checked and we know that we are not using the notice
> thing".  If you go that route, then the users after this if statement
> that sets up close_notice upon the first call would say !*close_notice
> instead of !close_notice when they try to see if the notice is in use.
> That would be solution 2b.
> 
> I personally think any one of 1., 2a., or 2b. is fine.

Thanks for your thoughts! I will go with 1. I also think that this is 
no performance critical codepath and therefore we should go with the
simplest/most maintainable solution.


Thanks,
Lars
