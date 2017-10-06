Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9FD02036C
	for <e@80x24.org>; Fri,  6 Oct 2017 11:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751932AbdJFLLx (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 07:11:53 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:43142 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdJFLLw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 07:11:52 -0400
Received: by mail-wr0-f174.google.com with SMTP id p46so10339661wrb.0
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 04:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kKkgcke3CRmJSgVs9UR6a5uTZsNhCGtwa9NgBeWXyzU=;
        b=KW3ysxtx+ddPIYGUGSjXw4wcJrI5d5Y1t46apmLKI5NuFacei8xReeW8HGeRvPuGXF
         L7rK9jcTfqN0n5GzrrFrPNokVMtrUgRMJxqN7EzxWX1ngdXlGrTMtP5alp3pGu/MMLd1
         uvbem0fibTJ0KWz6wT5W1XSuODISpzesTvfAp3yvncH/ZtKNKNoeQBUMU/k3RBQoj5TT
         T3j7Ei+AUBFF9yiu1BQVcslbl01AbBN7W+dqIYIWVMmo1tFGvfNx3OC52eKfj1t2wbyZ
         uuFj6ujGif4upzgBvyVuh4NHBkS7flOGgUflmIwK2F/q+PE/YoGN72hANkwq2ySJjUll
         /OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kKkgcke3CRmJSgVs9UR6a5uTZsNhCGtwa9NgBeWXyzU=;
        b=Mmp2Ua4V/mtaGyW2xi0xIoueC5Rb1oedq/hZmADKZQWc2rr6yioA89XkS5hdEk01t3
         PgKyKYw7lgp28T5mYcoWn4ubVDPpXK6Fp4NJJhcZqJOwYlxcksinBqqJhnPMR6PQT3F9
         G9gdaqdYTXRkouyy3eFQJE9GZ3ZEPy3w3dJeAE+tPTTslh8d7qh/Bbk9LLVX+UxYQ1yt
         Gv8ITkA/y2Su1dXxV6PFYLuP+y85Jj20Xyr0FTrklAoBhtEai1fDgK8Mk23V4VO605ts
         BRdJRzI0nXFe/yH7L0QvdemyHRELQsq5YgEkHiAhe4z7WfZfIWilDiDKYcbXMu26g7+4
         G1uQ==
X-Gm-Message-State: AMCzsaV1GYb8pYYX/zahcNMi6Q1mt37Tzz/DU7UVu+tSXYChK8jKhDR+
        I7h1iIF6xES6drCqXmhZNvrcmL+rZns9LHEFMAiC3ouZ6GQ=
X-Google-Smtp-Source: AOwi7QAViTBrPwT0eO0By4WS6GmMRGZx6nN70qf6+L+oY63aiRgSV/T2474S3nKPQpvmwRfwgen4YXleVFySDh3BYF4=
X-Received: by 10.223.159.6 with SMTP id l6mr1829059wrf.156.1507288311016;
 Fri, 06 Oct 2017 04:11:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.129.41 with HTTP; Fri, 6 Oct 2017 04:11:50 -0700 (PDT)
In-Reply-To: <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com>
References: <20170926235627.79606-1-bmwill@google.com> <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-4-bmwill@google.com> <20171006090907.gbsgygulzj3bgqrg@ruderich.org>
 <xmqq4lrcwr5c.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 6 Oct 2017 13:11:50 +0200
Message-ID: <CAN0heSrWekXdzqzhL3Lk37YOGPHUdKCDU85t3hJgqK7PSVBZ_g@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] protocol: introduce protocol extention mechanisms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        bturner@atlassian.com, Jeff Hostetler <git@jeffhostetler.com>,
        jonathantanmy@google.com, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 October 2017 at 11:40, Junio C Hamano <gitster@pobox.com> wrote:
> Simon Ruderich <simon@ruderich.org> writes:
>
>> Did you consider Stefan Beller's suggestion regarding a
>> (white)list of allowed versions?
>>
>> On Mon, Sep 18, 2017 at 01:06:59PM -0700, Stefan Beller wrote:
>>> Thinking about this, how about:
>>>
>>>   If not configured, we do as we want. (i.e. Git has full control over
>>>   it's decision making process, which for now is "favor v0 over v1 as
>>>   we are experimenting with v1". This strategy may change in the future
>>>   to "prefer highest version number that both client and server can speak".)
>>>
>>>   If it is configured, "use highest configured number from the given set".
>>>
>>> ?
>>
>> It would also allow the server operator to configure only a
>> specific set of versions (to handle the "version x is
>> insecure/slow"-issue raised by Stefan Beller). The current code
>> always uses the latest protocol supported by the git binary.
>
> If we do anything less trivial than "highest supported by both" (and
> I suspect we want to in the final production version), I'd prefer
> the configuration to list versions one side supports in decreasing
> order of preference (e.g. "v3 v0 v2"), and take the earliest from
> this list that both sides know how to talk, so that we can skip
> insecure versions altogether by omitting, and we can express that we
> would rather avoid talking expensive versions unless there is no
> other version that is understood by the other side.

Maybe I'm missing something Git-specific, but isn't the only thing that
needs to be done now, to document/specify that 1) the client should send
its list ordered by preference, 2) how preference is signalled, and 3)
that the server gets to choose?

Why would a server operator with only v0 and v1 at their disposal want
to choose v0 instead of v1, considering that -- as far as I understand
-- they are in fact the same?

Different server implementations and different server configurations
will be able to apply whatever rules they want in order to decide which
version to use. (It's not like the client can verify the choice that the
server makes.) And Brandon's "pick the highest number" will do for now.

There are many possible rules that the server could apply and they
shouldn't affect other servers or what the client does. For example, the
server can go "You seem to know lots of versions, including X and Y.
Those are the two that I really prefer, but between those two I'm not
picky, so I'll use whichever of X and Y that you seem to prefer." Unless
I've missed something, we'll never need to implement -- nor specify --
anything like that before we have learned both v2 and v3.

I guess my thinking is, there's a difference between the protocol and
the implementation.

Martin
