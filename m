Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469C71FA21
	for <e@80x24.org>; Tue, 10 Oct 2017 08:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbdJJIUB (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 04:20:01 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:54581 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755693AbdJJIUA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 04:20:00 -0400
Received: by mail-qt0-f176.google.com with SMTP id z19so3362278qtg.11
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 01:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0QJvtJtm2GHkPpKSu7ob5GVF4qv+i7HXO4T8oDhP/0Q=;
        b=Z3dvOLtAXGlvZDhWe4cWGMwuYS4q8sUKA8w1gqwmwFPm3OXkBGgYVTBVinp6xXDXeh
         u4opHAcJrnnAVYjv5T60+YMCOxmm6XOh3bw/zVjbsaKz7jODLqYuoNkJ+QqG+gElJDi8
         nAZmEBCHXq8lToAKrLp9LBrklkruKNUDHVrjWSX/HJcjeEJq1u4X7ALqSAv6VkyTSy4W
         PRzbSj91TjHqaBmMteVDDw4Ov3p1d4lAJwoEBSFxwzq6JkO/jc0AbqvC81tJbRz8RRs5
         n0I7ev14EsjzrzKMrPNRtSubx195ZH4Xt5uBiY+Hcjcea8D4LoL8WH4jMszPaPBLirE+
         uqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0QJvtJtm2GHkPpKSu7ob5GVF4qv+i7HXO4T8oDhP/0Q=;
        b=Ouy0Zchqr43lNyMOv/GQOD2Xw2DatzZQWfLIuEwxckazg+5+6HrWVbt6fD2Byndz+M
         S6/C1OVw7yMOjU9b0hYCLm4ZP9BFra+jusphWesiaZ3OowwVVLKL4Iw5fe+ugedF7R+P
         4B9gUw8hhlR4UoxP1oS68KNj4ICl/mMvlvm1WnIcB9XgMIwYJwJOS2tLxSMmdAp3Ij7B
         mrZ/AR2rkBagm3LvQ8kXSUBNMU0MjhVGcgC44hj1j0Dk4umLWBIanqFloQ0ONUxQZefb
         2SyZuIGEhCKPgcRr9R/OFUDMAlkiRDlS5EvCOyT2fhMU/GyjLVifaEbz9yg6JObLMC5r
         f8Zg==
X-Gm-Message-State: AMCzsaWfjDT7T62l3O/JZ4JZSiZbzHsUI6uh0QCzUeHTxWsBXiQ2uv1P
        iZyXhYCgWBo2A7nyh7qoOcltbV6tLTKzUh8oSXai0Q==
X-Google-Smtp-Source: AOwi7QCD4Xh4QVdvORY1zkdPbBv/MIwUFz5zk/0mplAM1dFsBuEbKd31h6wWsTSgC9vU89L1i6ncliDewnNlwyoq2+w=
X-Received: by 10.129.112.208 with SMTP id l199mr1575390ywc.480.1507623599762;
 Tue, 10 Oct 2017 01:19:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.43.214 with HTTP; Tue, 10 Oct 2017 01:19:59 -0700 (PDT)
In-Reply-To: <CAPc5daVKM9PXYfKb3zMmCH3F8DeGcLHNtTCLDxMogOTH8uxWzg@mail.gmail.com>
References: <20171005081733.18529-1-nathan.payre@etu.univ-lyon1.fr> <CAPc5daVKM9PXYfKb3zMmCH3F8DeGcLHNtTCLDxMogOTH8uxWzg@mail.gmail.com>
From:   Nathan PAYRE <second.payre@gmail.com>
Date:   Tue, 10 Oct 2017 10:19:59 +0200
Message-ID: <CAGb4CBUaQJOskTiXm0w+3V7E8kkaA5EiG1w0s39WDCVH-5AVoA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-config.txt: reword missleading sentence
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        daniel.bensoussan--bohm@etu.univ-lyon1.fr,
        timothee.albertin@etu.univ-lyon1.fr,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        matthieu.moy@univ-lyon1.fr,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thanks you for the this complete answer,
we take note of your comments.

We would like to reword something else in the same line
and we don't know what is the best way to do that properly.
Should we do a [PATCH v2] or revert the last commit and
commit a new one?

2017-10-05 12:13 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> On Thu, Oct 5, 2017 at 5:17 PM, PAYRE NATHAN p1508475
> <second.payre@gmail.com> wrote:
>> Change the word "bla" to "section.variable" to make it clear that it's a placeholder for a variable name.
>
> Please make sure that your log message shows without wrapping and is a
> confortable read on a 80-column terminal by wrapping long lines.
>
>>
>> See discussion at: https://public-inbox.org/git/20171002061303.Horde.SL92grZCqTRV9oQkBFPELQ7@crashcourse.ca/
>
> I do not think it matters that much in this particular case, but please
> make it a habit to assume that time of people who run "git log" to
> find out why the change was done is 100x more valuable than the
> time you need to leave a good summary of the discussion in the
> log message. A URL at the end _in addition to_ a summary in your
> words is OK; just a URL without any effort to summarize why you
> did this change is not.
>
> I often find myself understanding the issues a lot better _only_
> after I try to summarize the argument for a change in the log
> message--it forces me to _think_. And (this probably does not
> apply to this patch, as it is not a code change) it often results
> in a better code. First I come up with a solution, write a quick
> patch, try to explain the approach in the log message and then
> realize there is a better solution _only_ after doing so. It is a
> good habit to get into to try explaining the thought process in
> the log message.
>
>> Noticed-by: rpjday@crashcourse.ca
>> ---
>
> Here, after "Reported-by:" before the three-dash line, we need
> your "Signed-off-by:" line. See Documentation/SubmittingPatches
> for details. The name and address should match what appears
> on the "From:" field from your e-mail.
>
> Ah, one more thing. Do you want to be known as somebody
> with ALL CAPS first and last name, with student number? ;-)
> If it is cumbersome to convince your MUA to use your real
> name spelled in normal way on the "From:" header, you could
> start the body of your message with
>
>     From: Payre Nathan <second.payre@gmail.com>
>
> followed by an empty line, followed by the body of the log
> message.
>
>
>>  Documentation/git-config.txt | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
>> index 83f86b923..f9808d7ad 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>> @@ -177,8 +177,8 @@ See also <<FILES>>.
>>         'git-config' will expand leading '{tilde}' to the value of
>>         '$HOME', and '{tilde}user' to the home directory for the
>>         specified user.  This option has no effect when setting the
>> -       value (but you can use 'git config bla {tilde}/' from the
>> -       command line to let your shell do the expansion).
>> +       value (but you can use 'git config section.variable {tilde}/'
>> +       from the command line to let your shell do the expansion).
>>
>
> The new text proposed by the patch looks good.
>
> Note that I am not in front of a real computer, and I cannot
> verify if there is a whitespace breakage in the patch to make
> it unusable. I am guessing this one is OK (it seems there
> is only one SP followed by HT on the context lines).
>
> Thanks, and welcome to Git development community.
