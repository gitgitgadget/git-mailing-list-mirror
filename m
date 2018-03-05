Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01C81F404
	for <e@80x24.org>; Mon,  5 Mar 2018 14:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932447AbeCEOu7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 09:50:59 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:37423 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932443AbeCEOuy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 09:50:54 -0500
Received: by mail-qt0-f172.google.com with SMTP id r16so20589959qtm.4
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 06:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FwJ5f39P9MdkwaOdyleI1IDOCru9fySeWxWQcLGzupI=;
        b=uQcuE/fUeUmDpd/ysWvqlI4nQGo5FT6QxibRHj3LoREutnbWsZrEFqDsfESmvX4Ue0
         DThuBIVfrSwtMd5xMooo+FRUg6+7Wpw8DX2wGWRkGQU1iLQHF/e21WtiZtXSh7VOLMuj
         GE82MQG/T6CwsISLgYjtBpESSfxPLaFs/pwPkHtWnv1BqWaKiihOCnPDGde+YDS9y4Jm
         oSDy4bOOyKNNVS2Zuf6LfcjBfTivlfTOuEDUEisCJVZodzJXMV/DfdGRnPq6UPJkcB9f
         chZbu6RG9+uBQJQouOH+z2N2OVh/sW4Ie6mtRmiS4L06ROiL5iCsNgxaPfOji30D/62V
         KNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FwJ5f39P9MdkwaOdyleI1IDOCru9fySeWxWQcLGzupI=;
        b=Ih78PpvKlTkGExq7l3tIv1UCtPnjTbp9OSnafmYJbukWcyGWVqHzMMV2ViJpwRd1dH
         azEgLT9FGyeV5mWszvDwOQak1RObywQgHTziaZ33+WSLSuPlUI+Cvb3N0VKlU7zgRo7f
         oICEc0cQVVIL28lWG0JNlo4ApSyaXtSSNqpqXhoF4MflTALaDR+QgL/uJ6olNFjJTYF7
         CIeM0s3Q15/KoarAtQ5KxqNXrO7o6+XbmkWweh0QMsoeXHqVcOyQbNGTF/Oe4Jg/fAJT
         yGx9Zoar7kvzZ3mfXK44LxpONPdHPiYZ3bkzYs+1ABWw4X/W8hZWsNOElMI8HGOjEnxN
         dFMA==
X-Gm-Message-State: AElRT7Ed7Ww0n3HEKJnm7fDsf0ruF9Q5iIWziOCUhoXH2h2QKtzjpPho
        w7PsKQJS5ujQyApE4Av2uZI=
X-Google-Smtp-Source: AG47ELtaI6Hj77ARh0D4DoWryaWwnVClTR4YDDeMg2K7U0n9Ol7jKJmH4Lmm/LEv1jlWAhMUSdzkhA==
X-Received: by 10.237.53.98 with SMTP id b31mr24018718qte.230.1520261453611;
        Mon, 05 Mar 2018 06:50:53 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id d36sm9290050qtk.47.2018.03.05.06.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 06:50:53 -0800 (PST)
Subject: Re: [RFC] Contributing to Git (on Windows)
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
 <20180302044409.GC238112@aiede.svl.corp.google.com>
 <xmqq606ee89v.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1803031721590.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <20180303182723.GA76934@aiede.svl.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <663f3fef-30bc-8900-6070-80ac96cccff0@gmail.com>
Date:   Mon, 5 Mar 2018 09:50:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180303182723.GA76934@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I really appreciate the feedback on this document, Jonathan.

On 3/3/2018 1:27 PM, Jonathan Nieder wrote:
> Hi Dscho,
>
> Johannes Schindelin wrote:
>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>>> Dereck Stolee wrote:

nit: s/Dereck/Derrick/ Is my outgoing email name misspelled, or do you 
have a misspelled contact info for me?

>>>>> +Test Your Changes on Linux
>>>>> +--------------------------
>>>>> +
>>>>> +It can be important to work directly on the [core Git
>>>>> codebase](https://github.com/git/git), +such as a recent commit into
>>>>> the `master` or `next` branch that has not been incorporated +into
>>>>> Git for Windows. Also, it can help to run functional and performance
>>>>> tests on your +code in Linux before submitting patches to the
>>>>> Linux-focused mailing list.
>>>> I'm surprised at this advice.  Does it actually come up?
>> Yes.
>>
>> I personally set up the automated builds on Windows, Linux and macOS for
>> our team, and as a rule we always open an internal Pull Request on our
>> topic branches as we develop them, and you would probably not believe the
>> number of issues we caught before sending the patches to this list. Issues
>> including
> [nice list snipped]
>
> Thanks for explaining.  I still am going to push back on the wording
> here, and here is why:
>
>   1. Approximately 1/2 of the differences you describe apply to Mac as
>      well as Windows.  The advice certainly does not apply on Mac.
>
>      You might object: Mac readers would not be reading this text!  But
>      that is not how humans work: if project documentation (e.g. the
>      CONTRIBUTING.md on GitHub!) says that the project is Linux-focused
>      and if you don't test on Linux then you might as well not bother,
>      then people are going to believe it.
>
>   2. It is not unusual for Linux users to make portability mistakes that
>      are quickly pointed out on list.  If anything, the advice to test on
>      other platforms should apply to contributors on Linux even more.
>      This happens especially often to new contributors, who sometimes use
>      bashisms, etc that get quickly pointed out.
>
>   3. I do not *want* Git to be a Linux-focused project; I want the code
>      to perform well on all popular platforms and for people not to be
>      afraid to make it so.
>
>      If the docs say that all we care about is Linux, then people are
>      likely to be too scared to do the necessary and valuable work of
>      making it work well on Mac, Windows, etc.  The actual mix of
>      contributors doesn't bear it out anyway: a large number of
>      contributors are already on Mac or Windows.
>
> Fortunately this is pretty straightforward to fix in the doc: it could
> say something like "to the multi-platform focused mailing list", for
> example.

I like the "multi-platform" wording, and I'll try to use it as often as 
possible. I'll keep the Linux instructions because it is free to set up 
a Linux environment and testing in Windows and Linux will catch most of 
the cross-platform issues.

>
> [...]
>> To my chagrin, this idea of making most of the boring stuff (and I include
>> formatting in that category, but I am probably special in that respect) as
>> automatable, and as little of an issue for review as possible, leaving
>> most brain cycles to work on the correctness of the patches instead, did
>> not really receive a lot of traction on this mailing list.
> Huh?  I'm confident that this is a pretty widely supported idea within
> the Git project.
>
> I get the feeling you must have misread something or misinterpreted a
> different response.
>
> [...]
>> No, this advice comes straight from my personal observation that the
>> reviewers on the Git mailing list are Linux-centric.
> Hopefully the clarifications and suggestions higher in this message
> help.  If they don't, then I'm nervous about our ability to understand
> each other.
>
> [...]
>> Now, how reasonable do I think it is to ask those contributors to purchase
>> an Apple machine to test their patches on macOS (you cannot just download
>> an .iso nor would it be legal to run a macOS VM on anything but Apple
>> hardware)? You probably guessed my answer: not at all.
> Agreed, this is something that needs to be automated (and not via a
> CONTRIBUTING.md file).  As a stopgap, having a section in the
> contribution instructions about testing using Windows's Linux
> subsystem is a valuable thing, and thanks for that; I never meant to
> imply otherwise.
>
> [...]
>> On Fri, 2 Mar 2018, Junio C Hamano wrote:
>>> In fact, portability issues in a patch originally written for a platform
>>> is rather quickly discovered if the original platform is more minor than
>>> the others, so while it is good advice to test your ware before you make
>>> it public, singling out the portability issues may not add much value.
>>> The fewer number of obvious bugs remaining, the fewer number of
>>> iterations it would take for a series to get in a good shape.
> [...]
>> For you, Junio, however, the task *now* is to put yourself into the shoes
>> of a Computer Science student in their 2nd year who wants to become an
>> Open Source contributor and is a little afraid to talk directly to "the
>> core committers", and quite scared what negative feedback they might
>> receive.
>>
>> "What if they say my code is not good enough?"
> Sure, though there is something implied in what is Junio is saying
> that is useful for such people.
>
> It is patience.  It is the message that if you miss a portability bug,
> we won't be disappointed in you, and it in fact happens all the time
> to the best of contributors.
>
> If there's a straightforward way to convey that in the text, I agree
> with Junio that it's worth conveying.
>
> [...]
>>>>> +When preparing your patch, it is important to put yourself in the
>>>>> shoes of the maintainer.
>>>> ... and in the shoes of other users and developers working with Git down
>>>> the line who will interact with the patch later!
>>>>
>>>> Actually, the maintainer is one of the least important audiences for a
>>>> commit message.  But may 'the maintainer' is a stand-in for 'the
>>>> project' here?
> [...]
>> Is this not missing the point of this sentence? Those "senior reviewers"
>> also put themselves into the shoes of the maintainer, because considering
>> future readers is kind of the typical responsibility of the maintainer.
> Only in the sense that what the project does is to "maintain".
> (Aside: is developing, deploying, supporting users part of
> maintenance?  I don't actually think so!  We can call it that if you
> like, though.).
>
> To put this discussion on a more practical footing: I see new
> contributors confusing the maintainer for the audience for their
> changes all the time, and it hurts them.  They get some useful (and
> some unuseful, sadly) replies from the project and none from the
> maintainer and they end up confused: does this mean that the person
> that matters doesn't even care about my patch?
>
> Clarifying that the audience is *not* the maintainer can help.
>
> I would not be surprised if the Git for Windows project works
> differently: maybe you have the time, inclination, and ability to
> respond to every contributor directly early in the process.  There's
> nothing wrong with that, and it probably helps to make the process
> easier for contributors with this particular confusion.  Having a
> single person that is ready to talk to them and can stand in for what
> the entire project needs can make their life easier.
>
> But that's not sustainable in the Git project.  Larger projects either
> need multiple maintainers or a decrease in scope of the maintainer's
> role.  Junio uses the latter, which seems fine to me.
>
> Even something as simple as s/maintainer/maintainers/ would make this
> text less misleading for people contributing to upstream Git.

I really like the suggestion to swap "maintainer" for "community". It's 
something I've learned by being on the list since I first wrote that 
paragraph about "the maintainer" in October. Back then, I was new to the 
list and my main way of understanding what was going on was by reading 
Junio's "What's Cooking" emails.

> [...]
>>>>> +* Make sure the commits are signed off using `git commit
>>>>> (-s|--signoff)`. This means that you testify to be allowed to
>>>>> contribute your changes, in particular that if you did this on
>>>>> company time, said company approved to releasing your work as Open
>>>>> Source under the GNU Public License v2.
>>>> Can this either point to or quote the relevant legal text from
>>>> Documentation/SubmittingPatches?  It feels dangerous (in the sense of,
>>>> potentially leading to misunderstandings and major future pain) to ask
>>>> people to sign off without them knowing exactly what that means.
>>> When you can point at an existing test in legal context, it is safer
>>> to do so rather than attempting to "rephrase" it yourself (unless
>>> you are a lawyer, of course, in which case you can assess the best
>>> course of action yourself).
>> Please note: Documentation/SubmittingPatches is not a legal text. At least
>> I have not seen any accredited lawyer commenting on the validity of this
>> document, or how much sense it makes.
> This seems to reflect a misunderstanding of how law works, at least in
> the United States.
>
> I don't know how one would define what a legal text means.  I assume
> you mean "a contract", and I certainly don't care to evaluate whether
> some particular text is a contract: I am not a lawyer.
>
> But there are all kinds of other actions or words with legal
> implications:
>
>   - promises
>   - injuries
>   - etc, etc, etc
>
> Basically anything someone ever does has potential legal implications.
>
> The developer's certificate of origin has been reviewed by plenty of
> lawyers.  You can have your own lawyers review it too if you like.
>
> That's all side-stepping what I was saying, which is that it's bad for
> the project for people to be signing off without knowing what it
> means.
>
> [...]
>> Even so, Git for Windows' own wiki
>> (https://github.com/git-for-windows/git/wiki/Good-commits) links to a
>> particular version of Documentation/SubmittingPatches so that it can
>> specifically mark the DCO:
>>
>> https://github.com/git/git/blob/v2.8.1/Documentation/SubmittingPatches#L234-L286
> Great.  That's the sort of thing I'm asking for in this new
> contributors document.  Why in the world is it useful to push back
> against such a request?
>

I have a habit of being too loose in language around lawyer-speak. I 
should not have attempted to summarize what "Signed-off-by:" means and 
will use that helpful link for the description instead.

Thanks,
-Stolee

