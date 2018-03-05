Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 941351F404
	for <e@80x24.org>; Mon,  5 Mar 2018 21:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeCEV5p (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 16:57:45 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:51394 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbeCEV5o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 16:57:44 -0500
Received: by mail-wm0-f43.google.com with SMTP id h21so18889852wmd.1
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=BhiHJksYsovD6OUv3/6c3SrMnNSTnIkmwAY4Yx3UH9E=;
        b=hSAB++7dLZpMrl8IWT2BabeMlDjrJpmSf28UutHl0LWkOVbe7BTKl8N/XWCqyCYZp4
         pMxLr7GCQyEoixk1lTof64dozYgODTZnjgPR86J1V0sybbJ9JPCzPUQapGqJG0AxHWOx
         9v73dSfzHTqkZR6GPP1/cgeih4O/DdZqKG2xuW8HRvHDio/mWBJSdv7V4euVhjOSHEsu
         0JppzQJFv+RJOXy/3079OIawDv6YTebYJHGOR3GHoF7crp7S9pfprxPYBZoPv/SQa8H1
         3jWMpq4NxBu6As2fWTd8pWuEub8CriTy8RY3Vz+3LzSkgxy1+SAQBPjmjGyyzg9yzBne
         UVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=BhiHJksYsovD6OUv3/6c3SrMnNSTnIkmwAY4Yx3UH9E=;
        b=B92vcA85E7YMzk3pOv+2suAufmGh/2LaKaO2FzIvJRsST/+S9SGsSCxh5aYXROey9M
         e2BnCD2H2iSyXm2rjQlr5zYGt2rrUkL20rnm7kRXiHRa4PxFYtZFd+f/km9aJztsvblt
         NZMt933j6M8YlrywYRrM1yCLgfJLKaDw9Q+BFFdt6O1NqAkeLquM2Q22jbMvNpzwd5N0
         KVg8UMnIBkb+aK3mqhCC0tiJe/pWndlMhNpcyYwRn+1soYD4TarXTs+a0VIT7DsIwHDv
         EcxW3sa9wABbbccqBDRu7BX64CUvyOXYNZpRDrbaegoYUtb30gF1ojmUwVcwneyI6nQZ
         3OVQ==
X-Gm-Message-State: APf1xPDUnQ4+TEapJyLIELYYGol8uuOr7yphvEvU6BWEXxqRuU+DpkMP
        M6SC8oj3sO08yE4rTWDegoo=
X-Google-Smtp-Source: AG47ELvLwp1ySuecfP756aak3+m3LS05zLUsvPR/XQZuOwOhmAb5gbrUXrDRcf4oYCrAkd3WnyVrsA==
X-Received: by 10.80.168.227 with SMTP id k90mr20203956edc.249.1520287062905;
        Mon, 05 Mar 2018 13:57:42 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id i48sm10673291ede.39.2018.03.05.13.57.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 13:57:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Contributor Summit planning
References: <20180303103010.GA21068@sigill.intra.peff.net> <20180303103957.GA24498@sigill.intra.peff.net> <CD80986F-E79B-4588-AB0F-AD5C6385836D@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CD80986F-E79B-4588-AB0F-AD5C6385836D@gmail.com>
Date:   Mon, 05 Mar 2018 22:57:41 +0100
Message-ID: <877eqqnq22.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 05 2018, Lars Schneider jotted:

>> On 03 Mar 2018, at 11:39, Jeff King <peff@peff.net> wrote:
>>
>> On Sat, Mar 03, 2018 at 05:30:10AM -0500, Jeff King wrote:
>>
>>> As in past years, I plan to run it like an unconference. Attendees are
>>> expected to bring topics for group discussion. Short presentations are
>>> also welcome. We'll put the topics on a whiteboard in the morning, and
>>> pick whichever ones people are interested in.
>>>
>>> Feel free to reply to this thread if you want to make plans or discuss
>>> any proposed topics before the summit. Input or questions from
>>> non-attendees is welcome here.
>>
>> I'll plan to offer two topics:
>>
>> - a round-up of the current state and past year's activities of Git as
>>   a member project of Software Freedom Conservancy
>>
>> - some updates on the state of the git-scm.com since my report last
>>   year
>>
>> As with last year, I'll try to send a written report to the list for
>> those who aren't at the summit in person.
>
> Thanks for starting this. I would like to propose the following topics:
>
> - hooks: Discuss a proposal for multiple local Git hooks of the same type.

I'm assuming you mean having stuff like pre-receive.d/* in addition to
pre-receive:

I had a WIP series for this that I didn't end up pursuing after getting
discouraged at:
https://public-inbox.org/git/CACBZZX6j6q2DUN_Z-Pnent1u714dVNPFBrL_PiEQyLmCzLUVxg@mail.gmail.com/

There's various bolt-on solutions that do this for subsets of the hooks,
e.g. GitLab now has this at
https://docs.gitlab.com/ee/administration/custom_hooks.html and this
stand-alone solution:
https://gist.github.com/carlos-jenkins/89da9dcf9e0d528ac978311938aade43

I still think this would be great to have, but Junio's objection being:

> Junio: And I have to say that a sequential execution that always
> Junio: short-circuits at the first failure is below that threshold.
> Junio:
> Junio: One reason I care about allowing the users to specify "do not
> Junio: shortcut" is that I anticipate that people would want to have a
> Junio: logging of the result at the end of the chain.

Got me discouraged, it would have made the implementation a bit more
complex, and I found other solutions to the problem I was trying to
solve.

Now we use Gitlab's implementation of this which has the semantics I
proposed at the time, and you just put log hooks at the beginning, but
of course that's server-side only. Having this be generally usable in
git would be great.
