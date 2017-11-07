Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 630C6202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 17:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbdKGRFy (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 12:05:54 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:43870 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdKGRFx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 12:05:53 -0500
Received: by mail-qt0-f175.google.com with SMTP id j58so16118405qtj.0
        for <git@vger.kernel.org>; Tue, 07 Nov 2017 09:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2OLSIzmDV2xyv/uhEFLUGaSCTlqVfWe5li640Hy5cA8=;
        b=BhOclZEG9OVVqFa9+0sFTryw8Ld82/UfIQd6nNBPJlOKHC2RcEvAuMeIJExpw85Loe
         RgpmGPbyHOAbVTu4aHXwSwxTh4qKbsdD8d9KKYqyHz1wpdcCha8N3urn/qTKjqJVv4R5
         P4fy+L0zKGgIHmGT7uJ+FhayU0dnrIuUeAEMaqofu3gGQIrVwII1DPc5XO7VpYpNxQdv
         xLpQDZNofvDr+d0em/3Zw+DRW/3g8bOl6ccY0SsbRSLK37pQwk8jvG9gZ9KWcuf1Cvnk
         fWtwCUgVaK+c0p6qKoedfn4ZhD1HOIGHpoKkWLQ3v/cLB2x+wJjSS0SOIoOzZujiJH3r
         syDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2OLSIzmDV2xyv/uhEFLUGaSCTlqVfWe5li640Hy5cA8=;
        b=BJL1mF5v+k90L2C6XY2ZgBn0ELj//mNqdgrgGeheFxalAU08jTZgj6n4aaRykVvsDn
         DEj2KOjIXxUvi31hkOaG03vVk+snCj3S+fee7Gfmvd2Adpj8QEio7RwzC9pzlGxgRZKq
         c4iZFq3v7yZ0I3Q1XDnZU6sXeIGvZU3QN4ZTRJc5coC7veiP+03wEcWD3ysZLcDhbOSm
         o+C4K1QCCkkCcg3k+GHfX7BPJ9RT5MyZshU/x9zxU1t5UHhewSAFBSqhYMYBimd7xhAO
         FOViPe6HhyGkSBuEq+vzXSwiWLrbgnjzu/sbcvO3yO4fwZQAQ5k5pg1gkJjGCGygNDQZ
         MEig==
X-Gm-Message-State: AJaThX4uU5wI8TA1YF5Rm6xge2ZaTPf0Ux33AtceLyexwhHS+Tjm2lS/
        nz8DTCJ4Hxc78KY3UNqN2oeDFA6CGSlWBIV2UMZLNQ==
X-Google-Smtp-Source: ABhQp+TQCDRNlQesK/ehtrftmRlr4m7O5MFb8qss9qrLv5/6RGol8bFfdu+6GCuK90kYQeZ0E+ca7vHrrjPJ8IM9hVg=
X-Received: by 10.237.53.137 with SMTP id c9mr31189912qte.125.1510074352310;
 Tue, 07 Nov 2017 09:05:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Tue, 7 Nov 2017 09:05:51 -0800 (PST)
In-Reply-To: <xmqq4lq6hmp2.fsf_-_@gitster.mtv.corp.google.com>
References: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com> <CAGZ79kYUZv0g+3OEMrbT26A7mSLJzeS-yf5Knr-CnARHqVB=aQ@mail.gmail.com>
 <xmqq4lq6hmp2.fsf_-_@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 7 Nov 2017 09:05:51 -0800
Message-ID: <CAGZ79kY=WWTzwyz8t21RghEWAgPphhvUO5ut0O+rL0YhbqeGxQ@mail.gmail.com>
Subject: Re: sb/submodule-recursive-checkout-detach-head
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 6, 2017 at 6:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> * sb/submodule-recursive-checkout-detach-head (2017-07-28) 2 commits
>>>   (merged to 'next' on 2017-10-26 at 30994b4c76)
>>>  + Documentation/checkout: clarify submodule HEADs to be detached
>>>  + recursive submodules: detach HEAD from new state
>>>
>>>  "git checkout --recursive" may overwrite and rewind the history of
>>>  the branch that happens to be checked out in submodule
>>>  repositories, which might not be desirable.  Detach the HEAD but
>>>  still allow the recursive checkout to succeed in such a case.
>>>
>>>  Undecided.
>>>  This needs justification in a larger picture; it is unclear why
>>>  this is better than rejecting recursive checkout, for example.
>> ...
>> Detaching the submodule HEAD is in line with the current thinking
>> of submodules, though I am about to send out a plan later
>> asking if we want to keep it that way long term.
>
> Did this "send out a plan" ever happen?

No. (Not yet?)

>  I am about to rewind 'next'
> and rebuild on top of v2.15, and wondering if I should keep the
> topic or kick it back to 'pu' so that a better justification can be
> given.

Feel free to kick back to 'pu'.

Thanks,
Stefan
