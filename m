Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F2151F404
	for <e@80x24.org>; Sat,  3 Mar 2018 18:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbeCCS1b (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 13:27:31 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46367 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbeCCS13 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 13:27:29 -0500
Received: by mail-pg0-f65.google.com with SMTP id r26so5129948pgv.13
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 10:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SfQ2kQqxybjbKfwkTxk+Ek/vzlZbZqP4Bwn7ZeuaX/g=;
        b=p9to2drSowc+8SBTrncbho7TKz1kQjOwCh8VXq8KsWij3GS0AFbKDRSjwOYH+4CIlT
         PTyCno4dPYY2kMJiJfRTGt4XH5tz09K0ZmRo9PBluDgQ0yAyEL0IvG8VCgSbwqPOb6QY
         5Y/ddXa7nO6Eq7y6eeCjPbbLpC/urpRrtYwZcr5L9J12buUjEnHs5TboIGugHW2LCzas
         ncfy8qY3f9N2mlwc+feOnVhJPj/L4trCSYGF066Jfryd4pnJDaoBT/GEpmag+MUwfmlQ
         XdnyVzKhgwV6EaKApD8k31v1vlsDjaSTQQqD1eOiFKhaIu3OsPkOr8USbs8Nh3+mmuIl
         aZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SfQ2kQqxybjbKfwkTxk+Ek/vzlZbZqP4Bwn7ZeuaX/g=;
        b=qxkR4FydU88hzflsmZJX2WJL5/wkbfISRU4vBZEV8pOGwSuyA6y3SEK1dYlEzLo8o6
         VYDsg6fk0KZpQzN/v8BAm6XTOwJ/F/XyA8kwN3Z7M3wbMCvRnk5P7W+sfHlwHlYelB66
         jpi0XMRTeZdXy9+StMk1Bmln0+e+n6jkNhz62gWr+8E/f42rfGCS2t9ShQN56eeI5tv1
         anKMc6onlVmssUyzc3gadO9UDp2PgbF5xSkh8g51s6FGCOxZ8nL4W5PgreJJyML1K2eF
         oEMT4AHL8zyzkE94IddM9Ialj+Fzg3F6rRX9vRsB9NBbl2HZ0GYYsrZj/zVpZc5ELE82
         qAHQ==
X-Gm-Message-State: APf1xPBXBQGEfsyIMIGmDkK+2bt0KPkhDvxYDzRTghOhD01vYoLB/hiP
        v1lDQCys4SiSt1Cf63FOuQE=
X-Google-Smtp-Source: AG47ELvqhUVN+Ls/pHGVlQWeZVNAu7Fx0b1dJ1V6u7RqtqtwpU1IrZ2ak0tOxH0qmjEfcFmaCh6RtA==
X-Received: by 10.101.72.199 with SMTP id o7mr7857939pgs.303.1520101648737;
        Sat, 03 Mar 2018 10:27:28 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z79sm18559754pfa.139.2018.03.03.10.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Mar 2018 10:27:27 -0800 (PST)
Date:   Sat, 3 Mar 2018 10:27:23 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Contributing to Git (on Windows)
Message-ID: <20180303182723.GA76934@aiede.svl.corp.google.com>
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
 <20180302044409.GC238112@aiede.svl.corp.google.com>
 <xmqq606ee89v.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1803031721590.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1803031721590.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Johannes Schindelin wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> Dereck Stolee wrote:

>>>> +Test Your Changes on Linux
>>>> +--------------------------
>>>> +
>>>> +It can be important to work directly on the [core Git
>>>> codebase](https://github.com/git/git), +such as a recent commit into
>>>> the `master` or `next` branch that has not been incorporated +into
>>>> Git for Windows. Also, it can help to run functional and performance
>>>> tests on your +code in Linux before submitting patches to the
>>>> Linux-focused mailing list.
>>>
>>> I'm surprised at this advice.  Does it actually come up?
>
> Yes.
>
> I personally set up the automated builds on Windows, Linux and macOS for
> our team, and as a rule we always open an internal Pull Request on our
> topic branches as we develop them, and you would probably not believe the
> number of issues we caught before sending the patches to this list. Issues
> including
[nice list snipped]

Thanks for explaining.  I still am going to push back on the wording
here, and here is why:

 1. Approximately 1/2 of the differences you describe apply to Mac as
    well as Windows.  The advice certainly does not apply on Mac.

    You might object: Mac readers would not be reading this text!  But
    that is not how humans work: if project documentation (e.g. the
    CONTRIBUTING.md on GitHub!) says that the project is Linux-focused
    and if you don't test on Linux then you might as well not bother,
    then people are going to believe it.

 2. It is not unusual for Linux users to make portability mistakes that
    are quickly pointed out on list.  If anything, the advice to test on
    other platforms should apply to contributors on Linux even more.
    This happens especially often to new contributors, who sometimes use
    bashisms, etc that get quickly pointed out.

 3. I do not *want* Git to be a Linux-focused project; I want the code
    to perform well on all popular platforms and for people not to be
    afraid to make it so.

    If the docs say that all we care about is Linux, then people are
    likely to be too scared to do the necessary and valuable work of
    making it work well on Mac, Windows, etc.  The actual mix of
    contributors doesn't bear it out anyway: a large number of
    contributors are already on Mac or Windows.

Fortunately this is pretty straightforward to fix in the doc: it could
say something like "to the multi-platform focused mailing list", for
example.

[...]
> To my chagrin, this idea of making most of the boring stuff (and I include
> formatting in that category, but I am probably special in that respect) as
> automatable, and as little of an issue for review as possible, leaving
> most brain cycles to work on the correctness of the patches instead, did
> not really receive a lot of traction on this mailing list.

Huh?  I'm confident that this is a pretty widely supported idea within
the Git project.

I get the feeling you must have misread something or misinterpreted a
different response.

[...]
> No, this advice comes straight from my personal observation that the
> reviewers on the Git mailing list are Linux-centric.

Hopefully the clarifications and suggestions higher in this message
help.  If they don't, then I'm nervous about our ability to understand
each other.

[...]
> Now, how reasonable do I think it is to ask those contributors to purchase
> an Apple machine to test their patches on macOS (you cannot just download
> an .iso nor would it be legal to run a macOS VM on anything but Apple
> hardware)? You probably guessed my answer: not at all.

Agreed, this is something that needs to be automated (and not via a
CONTRIBUTING.md file).  As a stopgap, having a section in the
contribution instructions about testing using Windows's Linux
subsystem is a valuable thing, and thanks for that; I never meant to
imply otherwise.

[...]
> On Fri, 2 Mar 2018, Junio C Hamano wrote:

>> In fact, portability issues in a patch originally written for a platform
>> is rather quickly discovered if the original platform is more minor than
>> the others, so while it is good advice to test your ware before you make
>> it public, singling out the portability issues may not add much value.
>> The fewer number of obvious bugs remaining, the fewer number of
>> iterations it would take for a series to get in a good shape.
[...]
> For you, Junio, however, the task *now* is to put yourself into the shoes
> of a Computer Science student in their 2nd year who wants to become an
> Open Source contributor and is a little afraid to talk directly to "the
> core committers", and quite scared what negative feedback they might
> receive.
>
> "What if they say my code is not good enough?"

Sure, though there is something implied in what is Junio is saying
that is useful for such people.

It is patience.  It is the message that if you miss a portability bug,
we won't be disappointed in you, and it in fact happens all the time
to the best of contributors.

If there's a straightforward way to convey that in the text, I agree
with Junio that it's worth conveying.

[...]
>>>> +When preparing your patch, it is important to put yourself in the
>>>> shoes of the maintainer.
>>>
>>> ... and in the shoes of other users and developers working with Git down
>>> the line who will interact with the patch later!
>>>
>>> Actually, the maintainer is one of the least important audiences for a
>>> commit message.  But may 'the maintainer' is a stand-in for 'the
>>> project' here?
[...]
> Is this not missing the point of this sentence? Those "senior reviewers"
> also put themselves into the shoes of the maintainer, because considering
> future readers is kind of the typical responsibility of the maintainer.

Only in the sense that what the project does is to "maintain".
(Aside: is developing, deploying, supporting users part of
maintenance?  I don't actually think so!  We can call it that if you
like, though.).

To put this discussion on a more practical footing: I see new
contributors confusing the maintainer for the audience for their
changes all the time, and it hurts them.  They get some useful (and
some unuseful, sadly) replies from the project and none from the
maintainer and they end up confused: does this mean that the person
that matters doesn't even care about my patch?

Clarifying that the audience is *not* the maintainer can help.

I would not be surprised if the Git for Windows project works
differently: maybe you have the time, inclination, and ability to
respond to every contributor directly early in the process.  There's
nothing wrong with that, and it probably helps to make the process
easier for contributors with this particular confusion.  Having a
single person that is ready to talk to them and can stand in for what
the entire project needs can make their life easier.

But that's not sustainable in the Git project.  Larger projects either
need multiple maintainers or a decrease in scope of the maintainer's
role.  Junio uses the latter, which seems fine to me.

Even something as simple as s/maintainer/maintainers/ would make this
text less misleading for people contributing to upstream Git.

[...]
>>>> +* Make sure the commits are signed off using `git commit
>>>> (-s|--signoff)`. This means that you testify to be allowed to
>>>> contribute your changes, in particular that if you did this on
>>>> company time, said company approved to releasing your work as Open
>>>> Source under the GNU Public License v2.
>>>
>>> Can this either point to or quote the relevant legal text from
>>> Documentation/SubmittingPatches?  It feels dangerous (in the sense of,
>>> potentially leading to misunderstandings and major future pain) to ask
>>> people to sign off without them knowing exactly what that means.
>>
>> When you can point at an existing test in legal context, it is safer
>> to do so rather than attempting to "rephrase" it yourself (unless
>> you are a lawyer, of course, in which case you can assess the best
>> course of action yourself).
>
> Please note: Documentation/SubmittingPatches is not a legal text. At least
> I have not seen any accredited lawyer commenting on the validity of this
> document, or how much sense it makes.

This seems to reflect a misunderstanding of how law works, at least in
the United States.

I don't know how one would define what a legal text means.  I assume
you mean "a contract", and I certainly don't care to evaluate whether
some particular text is a contract: I am not a lawyer.

But there are all kinds of other actions or words with legal
implications:

 - promises
 - injuries
 - etc, etc, etc

Basically anything someone ever does has potential legal implications.

The developer's certificate of origin has been reviewed by plenty of
lawyers.  You can have your own lawyers review it too if you like.

That's all side-stepping what I was saying, which is that it's bad for
the project for people to be signing off without knowing what it
means.

[...]
> Even so, Git for Windows' own wiki
> (https://github.com/git-for-windows/git/wiki/Good-commits) links to a
> particular version of Documentation/SubmittingPatches so that it can
> specifically mark the DCO:
>
> https://github.com/git/git/blob/v2.8.1/Documentation/SubmittingPatches#L234-L286

Great.  That's the sort of thing I'm asking for in this new
contributors document.  Why in the world is it useful to push back
against such a request?

Confused,
Jonathan
