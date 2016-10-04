Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCBBE207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 00:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbcJDAIG (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 20:08:06 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36726 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbcJDAIF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 20:08:05 -0400
Received: by mail-pf0-f170.google.com with SMTP id i85so17550602pfa.3
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ZbNE+y5qOUkDd4dgthop21cQk5uX46TlgWrrMGjrKys=;
        b=SBXrpZW2Oacf5Gq5EnngEui2Z2v429eJhjTSuj1Ry3PmJkJqM3Ten2I6UjxmAK2qjH
         cMz4Ls9DM89TqJ7mPSdz7vqadTIATa3uTXBHuOPw28v42jp1iq6jd65eTPFaaoT5Qip0
         48ACXgQwfiNhWxP9VoadSTQk1CUQOJbNTQNHXwgG0UA5MdpnBtREd7ABQK0EeO/q9CZm
         CELitioB2/nvyBZ0EOE88u7qAX2uQ2U5ZoIMmQd+NyXneJyjGYDHpFESBv9tZDK/oc0B
         KJ90/gEAXo92dPQRwQcq54MW9xhc64H15fMrUFjezeKZRXkhEzZ65lezZIBvJQa9h7oT
         HvOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ZbNE+y5qOUkDd4dgthop21cQk5uX46TlgWrrMGjrKys=;
        b=TUUHyChdPJgcmaDcAyJgV7VIIdJOwDy6Dq3vbCx8XqrM4QqM4FVj5SDvC2/snEqiJW
         KNa8FKP8aKLRhfdmqoL9BHjtXAvhh/NOe51cyk3etYWo5qNDHaSaZ7wFKm2LcOmNCcUr
         om9eFKnM2qhcZeTztMTXkuWu18uRni6+bPiwv6hKflZEt8ZXpt77Tcuv992e6QuFlhZI
         v1hyM+wRLX7TFhon+9nPuR2jvqa/thp2XpXcq5cL8kN3xDoj4Fc2SLIsBaZ3SjDc4i5U
         tf04fhR1FWNnFdGqJkZ6dJdlXijzZTVvJ0tNMaOA+MQ6xGbx44Yl2LId6Zagj/lIbset
         7XEw==
X-Gm-Message-State: AA6/9RmCftS87r9Ahi863RJehVLddjwRsOqsIjrCBcj6FJhNYDJeY8Yw5gzfGZyoa6YHCGTE
X-Received: by 10.98.200.153 with SMTP id i25mr1283736pfk.156.1475539684562;
        Mon, 03 Oct 2016 17:08:04 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:a8c4:ef1c:855a:28ff])
        by smtp.gmail.com with ESMTPSA id q14sm49741309pfg.63.2016.10.03.17.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2016 17:08:03 -0700 (PDT)
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1475176070.git.jonathantanmy@google.com>
 <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
 <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
 <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
 <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
 <e03fdabd-6690-5244-5f79-1715b0364845@google.com>
 <xmqqbmz16y42.fsf@gitster.mtv.corp.google.com>
 <d3df0636-1975-1d08-2f34-384984c72e5d@google.com>
 <xmqq8tu55bel.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <84f28caa-2e4b-1231-1a76-3b7e765c0b61@google.com>
Date:   Mon, 3 Oct 2016 17:08:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tu55bel.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/03/2016 03:13 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> There are other options like checking for indentation or checking for
>> balanced parentheses/brackets, but I think that these would lead to
>> surprising behavior for the user (this would mean that whitespace or
>> certain characters could turn a valid trailer into an invalid one or
>> vice versa, or change the behavior of trailer.ifexists, especially
>> "replace").
>
> Yes, that is exactly why I said that it may be necessary for the
> code to analize the lines in a block identified as "likely to be a
> trailing block" more carefully.  We can afford to be loose as long
> as the only allowed operation is to append one at the end, but once
> we start removing/replacing an existing entry, etc., the definition
> of what an entry is becomes very much relevant.

I agree, and I was trying to discuss the possible alternatives for the 
definition of what an entry is in my previous e-mail.

If you think that the alternatives are still too loose, I'm not sure if 
we can make it any tighter. As far as I know, we're dealing with 
trailers like the following:

   Signed-off-by: A <author@example.com>
   [This has nothing to do with the above line]
   Signed-off-by: B <buthor@example.com>

and:

   Link 1: a link
     a continuation of the above

and:

   Signed-off-by: Some body <some@body.xz> (comment
   on two lines)

As I stated in the quoted paragraph, one possibility is to use 
indentation and/or balanced parentheses/brackets to determine if a 
trailer line continues onto the next line, and this would handle all the 
above cases, but I still think that these would lead to surprising 
behavior. Hence my suggestion to just simply define it as a single 
physical line. But if you think that the pros (of the more complicated 
approach) outweigh the cons, I'm OK with that.

One alternative is to postpone this decision by changing sequencer only 
(and not trailer) to tolerate other lines in the trailer. This would 
make them even more divergent (sequencer supports arbitrary lines while 
trailer doesn't), but they were divergent already (sequencer supports 
"(cherry picked by" but trailer doesn't).
