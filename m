Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E510208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 19:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbdHOTVP (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 15:21:15 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38093 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752364AbdHOTVO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 15:21:14 -0400
Received: by mail-pg0-f44.google.com with SMTP id l64so11133566pge.5
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tLjAPdKj8kIc19xCABQonhGEyTnEY+hS4kdesORWKRU=;
        b=Fho1z0SP8lLKYrf78ZmHXz+7bsuUjwRuptobsSidCTj1Ed5Nz7CuDvg97A0GZuJeng
         jBr3hYk0zlAh5M8eBayZid7rvfzS7VIkpgtZw3DPNEeBcY6CRJwYEpN7KyWAyADbbeyQ
         njlIhNTrBQMAHug56TjeZrmHKtQpjwmLk7sIbmf2e4b/3lCK1YIdLt0An0lWBTsJ/td/
         2kdbhfi4L/uByzlmdPkGr/F5QXcjhI6hXTLQa8RMtSJMApWyU/ucgVaFVBWK3HzBgGa9
         g1xzRm9B5+JZxGkY/auKKRUJbnOMxNt6rpi0RQuRUX1X+9swUVapKwXzjdckPRyQvt7g
         FBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tLjAPdKj8kIc19xCABQonhGEyTnEY+hS4kdesORWKRU=;
        b=k/dfWqn26g1aP+Uilxbit1pDgODCyaC3kx3t5+JGCNGFyNg1e6odSswCj2J2RD07pH
         niRQUClkQy7jHWhHEmkl8JsFK1jyL9t6LsjeUqpfBp3JtlWjK9oz4HdmgVghQwdeDoTc
         1QFKA7IA6hdefJHBcZte9VPohizwipoDI0MILP+yn7Yo5ezF7sKIYr+dgS7V27wUWCEK
         uo7x8nDXMicZRRJnxk/DT0hTOKVnf0H5QpZNp9Ly/PUEK/xPY7in3wBLMkzxxQekUdEW
         qIkSRg10hZTKQUl0kyg9e0xJ3ybpwdMCLlQoSakRIf6S3LyN2dcy0kuZVgVulM4kGckj
         aqgg==
X-Gm-Message-State: AHYfb5izjPgZJHuDDPoEcpD1/4J1XyxxcylQc3QVIYMWTtwnvtGYl0cg
        z4Dn7Ydid5Cx6RKqVzsgl4AlyI/erw==
X-Received: by 10.84.231.131 with SMTP id g3mr32155501plk.283.1502824873340;
 Tue, 15 Aug 2017 12:21:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Tue, 15 Aug 2017 12:21:12 -0700 (PDT)
In-Reply-To: <CAGZ79kb-1S9F4Pp0dzkDX488uiZ8Zu_1m2U=hQ1CcsgSu314rQ@mail.gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <cff383c2-ca57-caba-5a46-7dec4abc25a4@jeffhostetler.com> <CAGZ79kbf52Uu-Th9W20QZV204A81kOAPTj2x6JkEP1rN=GTYtw@mail.gmail.com>
 <CAN0heSoXysu=6E_ScfWQVLOk805V=j7AYJi=z62SmNkP5U=A9Q@mail.gmail.com> <CAGZ79kb-1S9F4Pp0dzkDX488uiZ8Zu_1m2U=hQ1CcsgSu314rQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 15 Aug 2017 21:21:12 +0200
Message-ID: <CAN0heSr-OcLJU54acTdXWx8NAo=nPD=9+DfexWZ0F7NRgRB9Dg@mail.gmail.com>
Subject: Re: tsan: t3008: hashmap_add touches size from multiple threads
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 August 2017 at 20:48, Stefan Beller <sbeller@google.com> wrote:
>>>>         /* total number of entries (0 means the hashmap is empty) */
>>>> -       unsigned int size;
>>>> +       /* -1 means size is unknown for threading reasons */
>>>> +       int size;
>>>
>>> This double-encodes the state of disallow_rehash (i.e. if we had
>>> signed size, then the invariant disallow_rehash === (size < 0)
>>> is true, such that we could omit either the flag and just check for
>>> size < 0 or we do not need the negative size as any user would
>>> need to check disallow_rehash first. Not sure which API is harder
>>> to misuse. I'd think just having the size and getting rid of
>>> disallow_rehash might be hard to to reused.
>>
>> (Do you mean "might be hard to be misused"?)
>
> yes, I do.
>
>> One good thing about turning off the size-tracking with threading is
>> that someone who later wants to know the size in a threaded application
>> will not introduce any subtle bugs by misusing size, but will be forced
>> to provide and use some sort of InterlockedIncrement().
>
> agreed.
>
>> When/if that
>> change happens, it would be nice if no-one relied on the value of size
>> to say anything about threading. So it might make sense to have an
>> implementation-independent way of accessing disallow_rehash a.k.a.
>> (size < 0).
>
> Yes, and my point was whether we want to keep disallow_rehash around,
> as when a patch as this is applied, we'd have it encoded twice,
> both size < 0 as well as disallow_rehash set indicate the rehashing
> disabled.
>
> If we were to reduce it to one, we would not have "invalid" state possible
> such as size < 0 and disallow_rehash = 0.

Agreed.

> In the future we may have more options that make size impossible to
> compute efficiently, such that in that case we'd want to know which
> condition lead to it. In that case we'd want to have the flags around.

Good point.

>> For example a function hashmap_disallow_rehash(), except that's
>> obviously taken. :-) Maybe the existing function would then be
>> hashmap_set_disallow_rehash(). Oh well..
>
> Not sure I understand this one.

Sorry. What I meant was, if we drop the disallow_rehash-field, someone
might be tempted to use size < 0 (or size == -1) to answer the question
"is rehashing disallowed?". (Or "am I threaded?" which already is a
question which the hashmap as it is today doesn't know about.)

So instead of looking at "disallow_rehash" one should perhaps be calling
"hashmap_is_disallow_rehash()" or "hashmap_get_disallow_rehash()", which
would be implemented as "return disallow_rehash", or possibly "return
size == -1".

Except such names are, to the best of my understanding, not the Git-way,
so it should be, e.g., "hashmap_disallow_rehash()".

Except ... that name is taken.... So to free that name up, the existing
function should perhaps be renamed "hashmap_set_disallow_rehash()",
again assuming I've picked up the right conventions in my recent
browsing of the Git-code.

The final "Oh well" was a short form of "it began with an observation
which currently has no practical effect, and is slowly turning into a
chain of ideas on how to rebuild the interface".
