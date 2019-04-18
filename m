Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5875920248
	for <e@80x24.org>; Thu, 18 Apr 2019 00:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbfDRAF3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 20:05:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34799 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfDRAF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 20:05:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id w16so588999wrl.1
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 17:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=S6/IPABnbp3w9qmJLs5jaP2+QbEiA+mi5qjruuuLpoc=;
        b=e65gFSGQ0FoRhmRVDfJzbQ0000+yTFnid74M9d2e/iioTIL9qacL6Gb/SHotKIdXT4
         yARicLJQ3h/NOJ5vzZba1LCw9yg0n2D8P1NxsObeMaaylWhE+2agg1Cc5D8gJ2C3klAl
         AO0+YvlPJL4eIOlGWIJ6MYUp7LTBj51Ro62RitDCR7HCpbb9s0KHvrfqhM//PC2GTDhL
         WH6gK9s0X+ve34XluHCtYEg3AH5QhyjfbBIhrb0b/MrKCslgyK3s3cVt7Gat0ix/agb6
         QpgT3zNGNNhhyaMjIgjmpKyRQo4DjWLfaosTIJ3Nmkx+cFclmIncUI962lKnXkMqO65S
         ZPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=S6/IPABnbp3w9qmJLs5jaP2+QbEiA+mi5qjruuuLpoc=;
        b=SH8WuI1Mz7dHOUtaXj6sg/yHhamhMTwweln4RCNEHsPaENXMmq35WlRNNmbTKZIRdZ
         H0ACR2Gq+VVnclZQVmzqYWAFj9VHf5jTsRnvZd85Y0F3aFexvcb4Yp3ut+yc+LfOB43r
         xCRwOwsJh81/dTLfwKVSEBXTVBBxMJBhlIjF65WXVaVygt8+I4J3I9tuEUx9i1uVrGtI
         IRXZEB492C4wGXwX/olYQdLZe0G2X7ObELVrst/MNHWTTLL5qoIiD5btA8Nsgg6U83vG
         gA9bMpq0RtgI2ilzxdNQT1GBsepgkI3xJSxGZrMAFPZYV1W5x9i+rifLaDHI5h9etcz5
         aY2A==
X-Gm-Message-State: APjAAAXs7ql9FHmC+SfFSIrrxZU+qXnxykDZOfCMqdhS0PdY3mquSPvC
        kbxtaIOGbjfcJpwceVjushA=
X-Google-Smtp-Source: APXvYqy411rcobj9xXZ9QtWDgGw2c+C8rEy/abKOs1aoC8CnS65EcCCr/3Sqqiqlj4pVXpJVm8Iv4A==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr16036691wrj.16.1555545926672;
        Wed, 17 Apr 2019 17:05:26 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id l19sm294120wrf.35.2019.04.17.17.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 17:05:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Emily Shaffer via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 1/1] documentation: add lab for first contribution
References: <pull.177.git.gitgitgadget@gmail.com>
        <pull.177.v2.git.gitgitgadget@gmail.com>
        <71d5ab539c8b47155f6a3c92e26c9224d8214298.1555446372.git.gitgitgadget@gmail.com>
        <xmqqbm15kxi0.fsf@gitster-ct.c.googlers.com>
        <CAPig+cS+cx+2dn+-a9nigrVJdWBba3MrthivA-QSo9d3T2nLnQ@mail.gmail.com>
Date:   Thu, 18 Apr 2019 09:05:24 +0900
In-Reply-To: <CAPig+cS+cx+2dn+-a9nigrVJdWBba3MrthivA-QSo9d3T2nLnQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 17 Apr 2019 04:07:58 -0400")
Message-ID: <xmqqmukojhyz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Apr 17, 2019 at 1:32 AM Junio C Hamano <gitster@pobox.com> wrote:
>> "Emily Shaffer via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> > +Now that you've written your manpage, you'll need to build it explicitly. We
>> > +convert your AsciiDoc to troff which is man-readable like so:
>> > +
>> > +make all doc
>> > +man Documentation/git-psuh.1
>>
>> Hmph.  I didn't know you can do that without "-l" (local) option.
>> Perhaps with "-l" spelled out, it might be more portable but I
>> dunno.
>
> It's more portable[1] to eschew the -l (local) option to 'man'.
>
> [1]: http://public-inbox.org/git/20180831063318.33373-2-sunshine@sunshineco.com/

Great. Thanks.
