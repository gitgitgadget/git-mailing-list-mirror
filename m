Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D898D1FA14
	for <e@80x24.org>; Mon, 21 Nov 2016 23:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755002AbcKUXT6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 18:19:58 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35885 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754050AbcKUXT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 18:19:58 -0500
Received: by mail-qt0-f175.google.com with SMTP id w33so543207qtc.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 15:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=33mP1mck9/b3nFqHSobXRoVC/A8xwWIx/FAKnZQN11o=;
        b=P6N2XU7rVU/kSyhWkOUYUodk8ZhB1A/hkwynHn1UIgGmSeYc3wXC7RZsLMNZFVS+mX
         VJtkWfQ+VnCMifmjg7KV9jDmcXKZrq53vtlqLIJDQ+JxxV5M0q8+t5Hv1BwF1eAqEVw5
         7kJ/jMcC0Xk/EqwRtyfE4XHfVa0a/wxxADRDVQ1MJ+SvtqSTzFOIGmQ0mHTJWIQpvjMI
         4wPhdW/dl201EgXOZC5XaZHLgIk9hVEhEptrobmLRkDmfujO1J/6rwKbA71bysP/QH7h
         LnmHm+LrqB8MpIRMjQoRos4xkVFN15k3wBjnD4ESR3wf4W9LLVKQk75pnIaR9zShkNgV
         hEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=33mP1mck9/b3nFqHSobXRoVC/A8xwWIx/FAKnZQN11o=;
        b=BrcEZvYn8eVR7j2YgLjrjrMD0uGbH6NASAgEbXtiWjxO2uTJbW3DYlND4BINP/h/QK
         F1Xlik58S5wDiJlfhaW138rQjViwif/glqbuCFPVvOBQzfGwsz6RXzMxv/bQNsDKuP5b
         KCvC0AYG21TMrN/6iyQGgfKasvYdghQESe3NvFC2ugs7170CVwBYpukdGEZ+TwN8QTWC
         IWw/zIpCnBtijo64Fb0hQt9FDNzuyOzg+vKadwvKjFyiBI0B8ssBdXN8O3+S1f75ucHI
         koAJu5857A4KWdGR/9meABFa0bpYtXy39BB/Gi7Nuj4N29aZDLG8OfP39qGNEbX9q/bq
         Q3ZQ==
X-Gm-Message-State: AKaTC01CevGKkNArB7qVJGdDlvPix+nZUtTsvdbklsLvFDoVYPIUmWq+Bsu2vyi0hPpq2FYJjPPzWsGeTx9e1khF
X-Received: by 10.200.58.65 with SMTP id w59mr9645904qte.54.1479770397050;
 Mon, 21 Nov 2016 15:19:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Mon, 21 Nov 2016 15:19:56 -0800 (PST)
In-Reply-To: <xmqqh970h1da.fsf@gitster.mtv.corp.google.com>
References: <xmqqpoloh3xa.fsf@gitster.mtv.corp.google.com> <CAGZ79kbCebHojPDUdHn2mmjUwRe-FOcnJqtoa828PJwC6P5mNw@mail.gmail.com>
 <xmqqh970h1da.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Nov 2016 15:19:56 -0800
Message-ID: <CAGZ79kY8AUwOYAQX=PEHU3H+AhLAuxtC9+hb42da6TrSdz4BzA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2016, #04; Mon, 21)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2016 at 3:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I did review both off and on list and I think the latest version is good.
>
> I thought that there were strange mixups of two enumeration types
> that are incompatible, at least.  Is there an update that I didn't
> see, or you didn't read problems pointed out on list?

Oh right; there was no resolution to that one IIRC.

>
>>> * jt/use-trailer-api-in-commands (2016-11-02) 6 commits
..
>> From a cursory read (with the SQUASH applied)
>> this seems to be done to me.
>
> We are not all that in a hurry to move non-fix to 'next' only with a
> cursory read at this point in the cycle ;-).

But the cycle only applies to patches going to master, but when
asking for doneness I assumed you were asking for opinions on
the transition pu -> next, which I would support.

Thanks,
Stefan
