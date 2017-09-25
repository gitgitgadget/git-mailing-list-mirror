Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A29202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 22:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965076AbdIYWWe (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 18:22:34 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36472 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964993AbdIYWWd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 18:22:33 -0400
Received: by mail-pg0-f67.google.com with SMTP id d8so5609854pgt.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 15:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZWqbmzroQGF+qBPkgE+g4NM2Hae1VzpDPrBUyRbVS1U=;
        b=dwqKAnCPhuEFL22LkF5oFFlBS7R9UCOWaYJA9TMDsLdSYMN3LwSf64J89WWMcrGS/q
         27p/Dz5wwkHRInNvcHdCReQTR+/y5o8di9qHlBkdHvfvc9t+ryUk3AoupQ0kK3RXg/93
         xvyRxuASm/NY3bAPVZUZM4LS00ee548A3dPveGY6UAu+YdTzkSuYfqblaJLkWKhBQtpy
         64wj0brjqpwUuuK5e6yoUNzpLQAh6m7RDXvPmWSkqk9ATkNUQ0ISpF/iyx2JfP5sNgp1
         UDOEYKzBGRNtdEAkJP+X+G1WCjW6FRm56JgLvLwxZ9avMDzDIl7PVeTuYJxhJwpRCQUq
         8ZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZWqbmzroQGF+qBPkgE+g4NM2Hae1VzpDPrBUyRbVS1U=;
        b=lTb0s84xhXmzLgh9uMtpP92IKO476lAviv7dxyH4vCsK5FBsIRgjuO4Ycvxpj0pe5f
         GhasdzMZ2RlZTboedAIa1Ap8zShndGkqiqnmd3Mwzcp6Bxnh/zCbF1CGXLRZcnL3bMbt
         pYHG8WWnb+a7jj7NOK+rdejKCsqL+kvLuVHo3rej+6VeJdtQrUFuCaWBPcWEa6sE0uDR
         xW5gR6NOyHUIh66lVPuYAwvCxuG83XuWlIiUcUFURs7Sos7dZI/qubJGmKgprl88Er83
         unnnecH2wh624iu2XkxoqeweqGua6NQrKqz/vv+SW4ew6xVjIxdI7Sz67DeGqtZdP4sC
         L/+Q==
X-Gm-Message-State: AHPjjUhfj+VdFAtu2ZXvI2lVeXUQk0gLPZm05mimVD3NnnF21kkdlGbF
        Mg+e6YtIQE4xyac3phKfKnyycoOs
X-Google-Smtp-Source: AOwi7QAIC+tJ5uVBIpn5UW47lKzkTIuIa1dL98CKbrM8QPqjdcZ/FzuQ2JX56ee3R64xDowMhwmA0Q==
X-Received: by 10.99.117.30 with SMTP id q30mr8905031pgc.75.1506378152535;
        Mon, 25 Sep 2017 15:22:32 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id v10sm14364579pgf.8.2017.09.25.15.22.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 15:22:31 -0700 (PDT)
Date:   Mon, 25 Sep 2017 15:22:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation: consolidate submodule.<name>.update
Message-ID: <20170925222229.GG27425@aiede.mtv.corp.google.com>
References: <xmqq1smxj7md.fsf@gitster.mtv.corp.google.com>
 <20170925191011.29863-1-sbeller@google.com>
 <20170925191726.GE35385@google.com>
 <CAGZ79kZZJe=EYh7wecAWneVKrWoBLrPoWuMWmC219vzWVzP6mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZZJe=EYh7wecAWneVKrWoBLrPoWuMWmC219vzWVzP6mA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:
> On Mon, Sep 25, 2017 at 12:17 PM, Brandon Williams <bmwill@google.com> wrote:
>> On 09/25, Stefan Beller wrote:

>>> Have one place to explain the effects of setting submodule.<name>.update
>>> instead of two.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>>> I disagree.  Actually, I think the git-config(1) blurb could just
>>>>> point here, and that the text here ought to be clear about what
>>>>> commands it affects and how an end user would use it.
>>>>
>>>> I tend to agree with the consolidation.
>>>
>>> Something like this?
>>
>> I like the consolidation, its easier to keep up to date when its only in
>> one place.
>
> After thinking about it further, I'd like to withdraw this patch
> for now.
>
> The reason is that this would also forward point to
> git-submodule.txt, such that we'd still have 2 places
> in which it is explained. The current situation with explaining
> it in 3 places is not too bad as each place hints at their specific
> circumstance:
> git-submodule.txt explains the values to set itself.
> gitmodules.txt explains what the possible fields in that file are,
>   and regarding this field it points out it is ignored in the init call.
> config.txt: actually describe the effects of the setting.
>
> I think we can keep it as-is for now.

Sorry, I got lost.  Which state is as-is?

As a user, how do I find out what submodule.*.update is going to do
and which commands will respect it?

Maybe we should work on first wordsmithing the doc and then figuring
out where it goes?  The current state of the doc with (?) three
different texts, all wrong, doesn't seem like a good state to
preserve.

Thanks,
Jonathan
