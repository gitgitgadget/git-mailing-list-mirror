Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C58F61F9AF
	for <e@80x24.org>; Fri,  3 Feb 2017 04:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbdBCEqr (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 23:46:47 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:32803 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752272AbdBCEqp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 23:46:45 -0500
Received: by mail-qt0-f181.google.com with SMTP id v23so17052798qtb.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 20:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/DW0nJ3+TQE+WEzXxGEUd5f7mmKeDzv/fLnJTybzT04=;
        b=k4taEvCJNc5ktOWO4j/5OXA6vcd8kc3+zkqxNtLhCzyceCpZJGykz1Dn2cUZgmLBEs
         kO7q9hymMI0Di3tzSFz4fZM/mJNi1NIhIK4KhtlkltbT+hR0BvkdoomttlxDCBTmv8qQ
         tHIE5W7r6kZ63E/try9YpumZe5VY9u0uLwTtk3k70QC6zoh5cCfx/QeltVfb4gLSfU06
         KpEzqYta/ef+sit3Xt1KpsjPwzTu0xG9s2oQhmv55VSZ3X2F3GpSSTFHY7IF8NPUTySk
         aCZhs+y1tRQupusIq1r63V4ecdjTmg9VWPl+Vf8uWYUEDw9ufbaTM/9OosVkPfJ+wpuN
         U1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/DW0nJ3+TQE+WEzXxGEUd5f7mmKeDzv/fLnJTybzT04=;
        b=NFuTqTFS85mrFIa1ajFto5YTLZcO2t2DIW8XgSBajEl5bIrZQ98ycLlM1ER1vhu6AR
         j4OscCOEGzt06A3uDvyw8qVXT6R/R/geqqrsI0r5OMATedQjM342yIrEg8nvl9UCQxGx
         AGHrvbkp5yGgHmtKH72t806UI4MGZ9qE1Lg+Pz5xUopsMjl5/b4eZvD9vo9DIPkjsYyM
         AVjugZNzV0dzJS07vyPwiHDZyN7ppnY8HjgqXFCuIEXszVnkgW2kgMHXQ9L6p7MfypkG
         e9X7M4ljik8+jbdrTZj8n0q/rf6bH/AGPIwm7HOynT0sCeIizQXGqyD15eTVucRfT2ne
         zpNA==
X-Gm-Message-State: AIkVDXL9J7ddh/yrjRVPbLHJJfl2OIdiCiQYqzcNdQR3l3dB0e7Ca5DznyF1VgVjBKwaMsJqQC9Mn/6E0TSexQ==
X-Received: by 10.200.50.238 with SMTP id a43mr11313903qtb.23.1486097204880;
 Thu, 02 Feb 2017 20:46:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.45.226 with HTTP; Thu, 2 Feb 2017 20:46:44 -0800 (PST)
In-Reply-To: <CAOc6etYzAeD32oSjrvmv-PBJTdAGobsQ30iH8Q+Z9ShWOqiHfQ@mail.gmail.com>
References: <CAOc6etaCk=OEyarMNhorM94MBnYRscCkJBM-K08snv1ecmOaPQ@mail.gmail.com>
 <20170128035321.yrcqwkg2fiwadxj4@sigill.intra.peff.net> <xmqqd1f4uug6.fsf@gitster.mtv.corp.google.com>
 <20170130232559.krdxkt4dq4lfv4rj@sigill.intra.peff.net> <CAOc6etZZSgeBRwQA4C4Ag5A48W8tAAArdOaaKxkTOVvVGi+EpQ@mail.gmail.com>
 <CAOc6etYzAeD32oSjrvmv-PBJTdAGobsQ30iH8Q+Z9ShWOqiHfQ@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Thu, 2 Feb 2017 22:46:44 -0600
Message-ID: <CAOc6etabV=h6fEVee=N2-3ERUU7_w6eCM006mSMPqiwkRycQBw@mail.gmail.com>
Subject: Re: difflame
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have been "scripting around git blame --reverse" for some days now.
Mind taking a look? I've been working on blame-deletions for this.

22:41 $ ../difflame/difflame.py HEAD~5 HEAD
diff --git a/file b/file
index b414108..051c298 100644
--- a/file
+++ b/file
@@ -1,6 +1,9 @@
^1513353 (Edmundo 2017-02-02 22:41:45 -0600 1) 1
f20952eb (Edmundo 2017-02-02 22:41:45 -0600 2) 2
bb04dc7c (Edmundo 2017-02-02 22:41:45 -0600 3) 3
-de3c07b (Edmundo 2017-02-02 22:41:47 -060 4) 4
058ea125 (Edmundo 2017-02-02 22:41:45 -0600 4) 5
85fc6b81 (Edmundo 2017-02-02 22:41:45 -0600 5) 6
+2cd990a6 (Edmundo 2017-02-02 22:41:45 -0600 6) 7
+ab0be970 (Edmundo 2017-02-02 22:41:45 -0600 7) 8
+944452c0 (Edmundo 2017-02-02 22:41:45 -0600 8) 9
+6641edb0 (Edmundo 2017-02-02 22:41:45 -0600 9) 10


$ git show de3c07b
commit de3c07bc21a83472d5c5ddf172dcb742665924dd (HEAD -> master)
Author: Edmundo <eantoranz@gmail.com>
Date:   Thu Feb 2 22:41:47 2017 -0600

   drop 4

diff --git a/file b/file
index f00c965..051c298 100644
--- a/file
+++ b/file
@@ -1,7 +1,6 @@
1
2
3
-4
5
6
7


Next step: solve the
find-real-deletion-revision-when-there-are-multiple-child-nodes
problem.... and let me read the discussion around git blame --reverse.

Thanks in advance.

On Mon, Jan 30, 2017 at 8:37 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> Maybe a little work on blame to get the actual revision where some
> lines were "deleted"?
>
> Something like git blame --blame-deletion that could be based on --reverse?
>
> On Mon, Jan 30, 2017 at 7:35 PM, Edmundo Carmona Antoranz
> <eantoranz@gmail.com> wrote:
>> I'm thinking of something like this:
>>
>> Say I just discovered a problem in a file.... I want to see who worked
>> on it since some revision that I know is working fine (or even
>> something as generic as HEAD~100..). It could be a number of people
>> with different revisions. I would diff to see what changed.... and
>> blame the added lines (blame reverse to try to get as close as
>> possible with a single command in case I want to see what happened
>> with something that was deleted). If I could get blame information of
>> added/deleted lines in a single run, that would help a lot.
>>
>> Lo and behold: difflame.
>>
>>
>>
>> On Mon, Jan 30, 2017 at 5:26 PM, Jeff King <peff@peff.net> wrote:
>>> On Mon, Jan 30, 2017 at 01:08:41PM -0800, Junio C Hamano wrote:
>>>
>>>> Jeff King <peff@peff.net> writes:
>>>>
>>>> > On Tue, Jan 17, 2017 at 11:24:02PM -0600, Edmundo Carmona Antoranz wrote:
>>>> >
>>>> >> For a very long time I had wanted to get the output of diff to include
>>>> >> blame information as well (to see when something was added/removed).
>>>> >
>>>> > This is something I've wanted, too. The trickiest part, though, is
>>>> > blaming deletions, because git-blame only tracks the origin of content,
>>>> > not the origin of a change.
>>>>
>>>> Hmph, this is a comment without looking at what difflame does
>>>> internally, so you can ignore me if I am misunderstood what problem
>>>> you are pointing out, but I am not sure how "tracks the origin of
>>>> content" could be a problem.
>>>>
>>>> If output from "git show" says this:
>>>>
>>>>       --- a/file
>>>>       +++ b/file
>>>>       @@ -1,5 +1,6 @@
>>>>        a
>>>>        b
>>>>       -c
>>>>       +C
>>>>       +D
>>>>        d
>>>>        e
>>>>
>>>> in order to annotate lines 'a', 'b', 'd', and 'e' for their origin,
>>>> you would run 'blame' on the commit the above output was taken from
>>>> (or its parent---they are in the context so either would be OK).
>>>>
>>>> You know where 'C' and 'D' came from already.  It's the commit you
>>>> are feeding "git show".
>>>
>>> I think the point (or at least as I understand it) is that the diff is
>>> not "git show" for a particular commit. It could be part of a much
>>> larger diff that covers many commits.
>>>
>>> As a non-hypothetical instance, I have a fork of git.git that has
>>> various enhancements. I want to feed those enhancements upstream. I need
>>> to know which commits should be cherry-picked to get those various
>>> enhancements.
>>>
>>> Looking at "log origin..fork" tells me too many commits, because it
>>> includes ones which aren't useful anymore. Either because they already
>>> went upstream, or because they were cherry-picked to the fork and their
>>> upstream counterparts merged (or even equivalent commits made upstream
>>> that obsoleted the features).
>>>
>>> Looking at "git diff origin fork" tells me what the actual differences
>>> are, but it doesn't show me which commits are responsible for them.
>>>
>>> I can "git blame" each individual line of the diff (starting with "fork"
>>> as the tip), but that doesn't work for lines that no longer exist (i.e.,
>>> when the interesting change is a deletion).
>>>
>>>> In order to run blame to find where 'c' came from, you need to start
>>>> at the _parent_ of the commit the above output came from, and the
>>>> hunk header shows which line range to find the final 'c'.
>>>
>>> So perhaps that explains my comment more. "blame" is not good for
>>> finding which commit took away a line. I've tried using "blame
>>> --reverse", but it shows you the parent of the commit you are looking
>>> for, which is slightly annoying. :)
>>>
>>> "git log -S" is probably a better tool for finding that.
>>>
>>> -Peff
