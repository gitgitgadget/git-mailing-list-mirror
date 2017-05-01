Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03D71FC3E
	for <e@80x24.org>; Mon,  1 May 2017 17:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbdEARp4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 13:45:56 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:36656 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753589AbdEARpM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 13:45:12 -0400
Received: by mail-it0-f52.google.com with SMTP id r185so33397680itd.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sYHDZCFzvFyAWhw4vVP5uMddZ77lb3yWa5WTQX+YFcc=;
        b=MGktx8Q8k5vhH44CAqMj6+JFnXFW88qgtvy2JMJm2g7sroSLHtyWpbfCicOuF2Hy3i
         yVCQyhE/0cdTErohbKF31c7amG3gQCU1Px6UKeW7KTdNIyF0MT/kKY029qAnqsy916CJ
         THsT4w/Bv4AOBrPcsDwqm9IyjUopi7fLCKq/iu4AhWmYmrNcLa4qb+2nLjli6q7huWxj
         OEF8D71V1AVnz/o7lvZZ5wrPxcaNuACIIFl5+ABmICIIXhXLBwjDX5FzAmUkUo6rPMME
         8U0Qgh4srAR61Qkwh/yvFLlaTNDKHZnFvpRgrZdfCJ0Y6hsN1+kdxyUutQuZTX6wX4Au
         NHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sYHDZCFzvFyAWhw4vVP5uMddZ77lb3yWa5WTQX+YFcc=;
        b=YR4yVYHaGHM+tNW6O/YoQSED5uMNab7ErFC+PxWWq/Tzxak3gsYk7tS+sDOpNyJeLA
         xrrHAfpqLxjoTSjEqrEOnXqyOHT7T4NWCnnv8IijUTvALSgICL5SbndrHZKDZOB5AQKI
         8epQk6aqgyiYSFSAya3GDnrmnn4VIWsphjMhGkyeOvUu25eos7o84qA3FR2zPIN10NKZ
         z7HVZkqKsuuz0T5EPD2K9ka+T6RXUeID5+4bYhjmprXgAgU3bfVYjs0dAVkLEk+a2zXe
         ROKUscZpyefB7vaK6DXRTwsoayZUpzv86Edre2j7EX6tRtyc6AEjHRs84NxHtn6z7wOL
         o6Ng==
X-Gm-Message-State: AN3rC/554HYrY8reW8jFZq14BF+nhZuQnlLwRj3Yr2ezWyodn3lbW6kA
        uDdFlmYADvndBf35JqfkF2nqewn4Tg==
X-Received: by 10.36.98.21 with SMTP id d21mr22252088itc.94.1493660711454;
 Mon, 01 May 2017 10:45:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Mon, 1 May 2017 10:44:50 -0700 (PDT)
In-Reply-To: <20170501162132.GA39135@google.com>
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com> <CACBZZX4ty91vh=ykMtpF0pV8Ru3BKWBXyQYsFRdPkKkxMd8pzw@mail.gmail.com>
 <20170501162132.GA39135@google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 1 May 2017 19:44:50 +0200
Message-ID: <CACBZZX6FfLEQGaCWj=vsMrOsPwKSEc2uW+bXDu4e3rhe18_VaQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #01; Mon, 1)
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 6:21 PM, Brandon Williams <bmwill@google.com> wrote:
> On 05/01, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>> On Mon, May 1, 2017 at 7:35 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
>> > * ab/clone-no-tags (2017-05-01) 3 commits
>> >   (merged to 'next' on 2017-04-30 at 601649896a)
>> >  + tests: rename a test having to do with shallow submodules
>> >  + clone: add a --no-tags option to clone without tags
>> >  + tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"
>> >
>> >  "git clone" learned the "--no-tags" option not to fetch all tags
>> >  initially, and also set up the tagopt not to follow any tags in
>> >  subsequent fetches.
>> >
>> >  Will cook in 'next'.
>>
>> Thanks for trimming off the top 2 patches. I've dropped those myself,
>> if someone (Brandon || Stefan) more interested in working on
>> submodules wants to pick them up that would be neat, but I don't need
>> it myself & doing it differently than the existing submodule options
>> would take too much of my time.
>
> Yeah we can add it to our backlog, though I'm not sure how quickly we'll
> be able to get to it.  If you end up needing this sooner just let me
> know.

I don't need it at all, I just thought it was prudent to add the
submodule part of passing clone options / config when adding a new
option since there were some existing options that did that.

Since there's outstanding debate about the interface for that sort of
thing I'll just leave that to people who care more about submodules if
they'd like to pursue it.
