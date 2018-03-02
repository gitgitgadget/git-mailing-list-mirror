Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580D31F404
	for <e@80x24.org>; Fri,  2 Mar 2018 13:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424450AbeCBNie (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 08:38:34 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:44232 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424391AbeCBNic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 08:38:32 -0500
Received: by mail-qk0-f179.google.com with SMTP id v124so11878681qkh.11
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 05:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WaftYcQqvGlsoV30rl7mzlyMaZR5zuWAZhDlhCWoZVc=;
        b=AmiM5c3H3T5bQLqwVYhTyGHjjIuIcJKdO5FI6lCyLH0pbXVNzXIQUy4Z1iGYPkP1dq
         5i5Mdp4SF2ZDRwtx8O1IepYb3TnAm7w2GkTyf3cdfgB58dfRD9EtJrWVpqO2YISmv5tF
         TtVG640depbl9pJA0T5UBUXXAS/TOpe1FITLoEl1fhXgpXdMTnvesD+12K77N0PPfxJL
         0TnuUFJP5BWaoKz7scAwk8lHcj31iJAlGC3XzB+jN/1B8/lXQnSfgikNs6Le0TvbJTpV
         n8keDlTJsVVy3BOu7P58u/maYH/jn/7EWRPGG455g4INnQnRGdlac4Cn4Tal6wTL7k8T
         nXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WaftYcQqvGlsoV30rl7mzlyMaZR5zuWAZhDlhCWoZVc=;
        b=EbHDwDZWOW64/Yu4rkRfMp+c/cd1JzNyEQF4f122EMidF1L2xDZ3lMAlM731UBYZPs
         8u99AFdKJGeNNcpSVsZzj5FQ05Ogf1hXXRoonx8VeaEZRrpKubEt0EOTbJ8Y6dCst7Y5
         Oyp/j3Ndl/1O67DG9s8RGP1yms2WZLOTQD3uNUoxw45OTHWzqvC9/ID26KCGT4KQh1tO
         QeAKiE/nztFPIV8dy7EGpVR/tIlWxz3Uik6XzPu2epAt1lw0B+bR9ecTmRbnbCd1gxw2
         hWWX9yWWqZz9N+mhoVJXvMG5V5kl1QJ8bwMTXh3c+z3w5/ZYjWM7qRrYMgMusomgBjx4
         /3NQ==
X-Gm-Message-State: AElRT7FW8cLyco06Co0LPO8/6UdEHOuhoswdLUptR/2MG1PMmNp+kitC
        boGQvCN9pn9+PG+//zHqiQA=
X-Google-Smtp-Source: AG47ELsB7zjFT0b+SGf+EkKxAr/7KU6WIYdoLu1XZ2B0CxEpTLZOLTT7Eu8m4STtOxpiFszsgT6hDw==
X-Received: by 10.55.56.74 with SMTP id f71mr8172125qka.16.1519997911594;
        Fri, 02 Mar 2018 05:38:31 -0800 (PST)
Received: from [172.22.150.178] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id 58sm4583598qtm.51.2018.03.02.05.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 05:38:30 -0800 (PST)
Subject: Re: [RFC] Contributing to Git (on Windows)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
 <20180302044409.GC238112@aiede.svl.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c53cc179-8102-76a4-1b04-a1107e75e790@gmail.com>
Date:   Fri, 2 Mar 2018 08:38:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20180302044409.GC238112@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2018 11:44 PM, Jonathan Nieder wrote:
> Hi,
>
> Derrick Stolee wrote:
>
>> Now, we'd like to make that document publicly available. These steps are
>> focused on a Windows user, so we propose putting them in the
>> git-for-windows/git repo under CONTRIBUTING.md. I have a pull request open
>> for feedback [1]. I'll read comments on that PR or in this thread.
> Thanks!  I wonder if we can put this in the standard Documentation/
> directory as well.  E.g. the Windows CONTRIBUTING.md could say say
> "See Documentation/Contributing-On-Windows.md" so that the bulk of the
> text would not have to be git-for-windows specific.

That's a good idea. After this review stabilizes, I'll send a patch to 
add the windows-specific instructions as you recommend.

What precedent do we have for referencing forks like git-for-windows/git?

>
> [...]
>> +++ b/CONTRIBUTING.md
>> @@ -0,0 +1,401 @@
>> +How to Contribute to Git for Windows
>> +====================================
> Would it make sense for this to be checked in with LF instead of CRLF
> line endings, so that clones use the user's chosen / platform native
> line ending?  The .gitattributes file could include
>
> 	/CONTRIBUTING.md text
>
> so that line ending conversion takes place even if the user hasn't
> enabled core.autocrlf.

Oops! I turned off the CRLF munging in my repo because I had an issue 
with a script somewhere, but forgot to turn it back on again. Thanks for 
checking this.

>
> [...]
>> +    The SDK uses a different credential manager, so you may still want to use Visual Studio
>> +    or normal Git Bash for interacting with your remotes.  Alternatively, use SSH rather
>> +    than HTTPS and avoid credential manager problems.
> Where can I read more about the problems in question?

I'll try to see if we can elaborate here. The Git for Windows client 
ships with Git Credential Manager for Windows [1] but the SDK does not. 
At the very least, credential interactions are not the same and you do 
not have access to the credentials stored in Windows Credential Manager.

[1] https://github.com/Microsoft/Git-Credential-Manager-for-Windows

>
> [...]
>> +Many new contributors ask: What should I start working on?
>> +
>> +One way to win big with the maintainer of an open-source project is to look at the
>> +[issues page](https://github.com/git-for-windows/git/issues) and see if there are any issues that
>> +you can fix quickly, or if anything catches your eye.
> <shameless plug>You can also look at https://crbug.com/git for non
> Windows-specific issues.  And you can look at recent user questions
> on the mailing list: https://public-inbox.org/git
>
> [...]
>> +If you are adding new functionality, you may need to create low-level tests by creating
>> +helper commands that test a very limited action. These commands are stored in `t/helpers`.
>> +When adding a helper, be sure to add a line to `t/Makefile` and to the `.gitignore` for the
>> +binary file you add. The Git community prefers functional tests using the full `git`
>> +executable, so be sure the test helper is required.
> Maybe s/low-level/unit/?
>
> [...]
>> +Read [`t/README`](https://github.com/git/git/blob/master/t/README) for more details.
> Forgive my ignorance: does github flavored markdown allow relative
> links?  (I.e., could this say [`t/README`](t/README)?)
>
> [...]
>> +You can also set certain environment variables to help test the performance on different
>> +repositories or with more repetitions. The full list is available in
>> +[the `t/perf/README` file](https://github.com/git/git/blob/master/t/perf/README),
> Likewise.
>
> [...]
>> +Test Your Changes on Linux
>> +--------------------------
>> +
>> +It can be important to work directly on the [core Git codebase](https://github.com/git/git),
>> +such as a recent commit into the `master` or `next` branch that has not been incorporated
>> +into Git for Windows. Also, it can help to run functional and performance tests on your
>> +code in Linux before submitting patches to the Linux-focused mailing list.
> I'm surprised at this advice.  Does it actually come up?  When I was
> on Mac I never worried about this, nor when I was on Windows.
>
> I'm personally happy to review patches that haven't been tested on
> Linux, though it's of course even nicer if the patch author mentions
> what platforms they've tested on.
>
> Maybe this can be reframed to refer specifically to cases where you've
> modified some Linux platform-specific code (e.g. to add a new feature
> to run-command.c)?

I recently had a bug in my local copy of the commit-graph patch that was 
only caught by our Mac OSX automated builds: I was passing the 
edge-value for a parent into a lookup to get an octopus edge from the 
graph, but I forgot to drop the most-significant bit. This cast the 
"uint32_t" silently into an "int" but since we multiplied by 4 somehow 
the Windows and Linux compilers turned this into a left-shift while Mac 
did not and failed during my test.

Now this is an example of something that probably would have been caught 
in review, but stuff gets through.

The Windows/Linux boundary is usually enough to catch the platform 
differences, but they do catch things that you wouldn't think are 
platform-specific.

>
> [...]
>> +When preparing your patch, it is important to put yourself in the shoes of the maintainer.
> ... and in the shoes of other users and developers working with Git down
> the line who will interact with the patch later!
>
> Actually, the maintainer is one of the least important audiences for a
> commit message.  But may 'the maintainer' is a stand-in for 'the
> project' here?

Stand-in for "the community" yeah.

>
> [...]
>> +* Make sure the commits are signed off using `git commit (-s|--signoff)`. This means that you
>> +  testify to be allowed to contribute your changes, in particular that if you did this on company
>> +  time, said company approved to releasing your work as Open Source under the GNU Public License v2.
> Can this either point to or quote the relevant legal text from
> Documentation/SubmittingPatches?  It feels dangerous (in the sense of,
> potentially leading to misunderstandings and major future pain) to ask
> people to sign off without them knowing exactly what that means.

+1 thanks.

>
> The rest also looks nice.  Thanks for working on this.
>
> Sincerely,
> Jonathan

Thanks for the feedback.

-Stolee

