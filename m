Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C14A200B9
	for <e@80x24.org>; Tue,  8 May 2018 03:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753836AbeEHD0e (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 23:26:34 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:39616 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753974AbeEHD0d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 23:26:33 -0400
Received: by mail-wm0-f54.google.com with SMTP id f8-v6so18792956wmc.4
        for <git@vger.kernel.org>; Mon, 07 May 2018 20:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6u1bqUnKjFs9Iwo9hrog0sKrBOdbTMxQfnIF8QLZu/A=;
        b=WAIMRLNhqSu6kxiW2bQD/JR6rybqBmCGy1r+iR7l9F7btzu9x7XcPOXUH1TACB49Q6
         kvCrQ4ePHu4kGbCSFE+Z76hmxoS5pjSZnfNwAHEuB8fKxbp48tcfioHoVbT4csOkhOvV
         KpTUeMTOxISuocX0OWqULOj87JMaH11z7406aFbcaqOuixhslsmn9meReQQFws1JRBOR
         Wbjsb/YPRNVEnG26S8tOx567iU1zcmL8mJ+C4OBiXkrIdrAPkAnjc6dROst1c457jUb/
         1V7y+NNVQ8ORrGQQWH+jLcY6gmwNFfFJRtpBYIeknzpPUXtjrKcHb43ZnYGbPwwkORfW
         w3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6u1bqUnKjFs9Iwo9hrog0sKrBOdbTMxQfnIF8QLZu/A=;
        b=nrSHix9LWX8GRSVwWbPzjBao2z4WD0JQw2xct/Fq6Msh8GOZM13+WJboMb0ljK2trc
         hyIOq8E/mG4IOMdTT+tK+nkw7x0wHfJ2dx0huBLDkqj3VN8+myMdSEA20rPa+PWr4c0t
         JMZuJez0VUf8veuJZKs2zEg9JVvxpMOSZCHToHvic23jcIY2xWtL5FoOzX+485n7FlcF
         kYj/J+oeNf7v8m+uOOYoZjN6BMaE4xNfECinzAQVcnF2wBFUR4FIPQ9nOOrgxlgZ3jD4
         wXYcnBRydOMEpDQDTpFEiJPRk9adRr/BF4q0pjNpm90hKNO+/A8zDbjKb41uvv8ivqt7
         hJLg==
X-Gm-Message-State: ALKqPwdmY8lbw+cx49v/oqLUGv/hM6JYN3j+MecTvyAu8BCj2EHVd4zM
        g+bfgaP9stQzmPUGKDIM6vE=
X-Google-Smtp-Source: AB8JxZpw3hj4KjGfLY0GJJnmtKN9Iyr6WoYZI1pBvDiD3AB5xkIVl33bIGNGFlzUWgWJaGHbRIuqJg==
X-Received: by 10.28.175.75 with SMTP id y72mr2075867wme.148.1525749991690;
        Mon, 07 May 2018 20:26:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y6-v6sm5565262wmy.39.2018.05.07.20.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 20:26:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        git <git@vger.kernel.org>
Subject: Re: main url for linking to git source?
References: <20180507063713.GA28961@sigill.intra.peff.net>
        <CAGZ79kZVdiEOO+b_Ygrfw1D9uV1T5TYBS580zPaZeYoMRfNuUQ@mail.gmail.com>
        <20180508015130.GN953644@genre.crustytoothpaste.net>
        <20180508024658.GA4204@puremoods>
Date:   Tue, 08 May 2018 12:26:30 +0900
In-Reply-To: <20180508024658.GA4204@puremoods> (Konstantin Ryabitsev's message
        of "Mon, 7 May 2018 22:46:58 -0400")
Message-ID: <xmqqvabyn7yx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> On Tue, May 08, 2018 at 01:51:30AM +0000, brian m. carlson wrote:
>>
>> I think I would also prefer a list of available repositories over a
>> hard-coded choice.  It may be that some places (say, Australia) have
>> better bandwidth to one over the other, and users will be able to have a
>> better experience with certain mirrors.
>> 
>> While I'm sympathetic to the idea of referring to kernel.org because
>> it's open-source and non-profit, users outside of North America are
>> likely to have a less stellar experience with its mirrors, since they're
>> all in North America.
>
> I'm a bit worried that I'll come across as some kind of annoying pedant,
> but git.kernel.org is actually 6 different systems available in US,
> Europe, Hong Kong, and Australia. :)
>
> We use geodns to map users to the nearest server (I know, GeoDNS is not
> the best, but it's what we have for free).

Thanks for an update---it is nice to make those who are discussing
this topic to be aware of these facts.  Very much appreciated.
