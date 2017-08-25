Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07A8208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 17:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756599AbdHYRTt (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 13:19:49 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34921 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755629AbdHYRTt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 13:19:49 -0400
Received: by mail-yw0-f171.google.com with SMTP id x21so2436910ywg.2
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=334/oWpGLwN6yN871GdJpbySL7ETzg6m2UCUoIG+bWg=;
        b=PVm0RTfAgksIbV7LNinEeHEHh7YAE6wASX2bzUolNeon+3xAAgNu3QArdLSAlNormM
         OxalddNlRTr/DxVS/do584yWe7FvEBdmX7YxFr7W0IBvSCvhJZBsMoHVxfHq+icTC0pi
         QT3GajShw/e/+tZwLJuwUbk3BOpH7Fo0VE79vX/bfX9tlPmaj5rvuxO3xwEJ0bzvVWgF
         cnXX0FbOcGFXimUHDLHcJDaC+HkgFmVqh2NeOSQJQ45JQZoPzbeagEnXPtui448YI9x+
         PFDr0938JWUHIZIwdGlzm9Jobs2opNN5Ksfvqj3Jd7Mk8HNZIjt64uJ9cL+t+6l5A48o
         f5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=334/oWpGLwN6yN871GdJpbySL7ETzg6m2UCUoIG+bWg=;
        b=I9Kj7RxlDu0k3vetEbo8u4EkqoUj1GCIRQ1IBp7a0sqhqm6cDDqFGsk0ym0uSO3UWQ
         fbRUsvhTXSt2TImxykWjUHZdraqzwc7pJ33n89DUvYtfsfQhp6HEUyzfDTq6xIQhvwzE
         Px6Gr/IAPxu1GpAkit+iXrW2Kz/GEBO3zazP1yXGEr1X6EWb1O8s2pgGRr11+8vG72ow
         hE+hRbqbn324f1TVi8gOTWUEnTixBOPoi1uud+GP5b6PUhbZyvYyASpX108CM/q3EmZ0
         UuUbkn2ZcTQyxnulnwXWos1lAy2MVvbzi+Y/ig5vgcHtEUHMo8jceW5w8I6VAtUe7G+B
         zxLg==
X-Gm-Message-State: AHYfb5iouByW/cQNp2K1AYBzIJd3Ps3GXIbwckxVNs9i9/oh1t9BrORn
        zYP2naCyPYCHAT7F//0/amhu8b9rRsIAK4Y=
X-Google-Smtp-Source: ADKCNb6AstRbleclWE9fWKvK+RnIuUeAXMFAfmT4jovlul2Jyqp2GGyZUK3xdAisJ5nptHf7esTVDLwbRb0oexyLt0Q=
X-Received: by 10.37.183.130 with SMTP id n2mr8423664ybh.353.1503681588230;
 Fri, 25 Aug 2017 10:19:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.248.26 with HTTP; Fri, 25 Aug 2017 10:19:47 -0700 (PDT)
In-Reply-To: <xmqq7exrtvl1.fsf@gitster.mtv.corp.google.com>
References: <20170825164837.30118-1-sbeller@google.com> <xmqq7exrtvl1.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 25 Aug 2017 10:19:47 -0700
Message-ID: <CAGZ79ka-PSt95TjVaUVf8yTZCdP8XuSfhJjBowJmgJbV2t0Tkg@mail.gmail.com>
Subject: Re: [PATCH] usage_with_options: omit double new line on empty option list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2017 at 10:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Currently the worktree command gives its usage, when no subcommand is
>> given. However there are no general options, all options are related to
>> the subcommands itself, such that:
>>
>>     $ git worktree
>>     usage: git worktree add [<options>] <path> [<branch>]
>>        or: git worktree list [<options>]
>>        or: git worktree lock [<options>] <path>
>>        or: git worktree prune [<options>]
>>        or: git worktree unlock <path>
>>
>>
>>     $
>>
>> Note the two empty lines at the end of the usage string. This is because
>> the toplevel usage is printed with an empty options list.
>>
>> Only print one new line after the usage string if the option list is empty.
>
> Good find.  Shouldn't the last word in the sentence "non-empty", though?\

Yes.

Originally I wrote a lot more and then deleted it all, mixing up the negations
of what I was trying to say.
