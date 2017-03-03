Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1841120133
	for <e@80x24.org>; Fri,  3 Mar 2017 17:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbdCCRp6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:45:58 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:34342 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdCCRpj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:45:39 -0500
Received: by mail-lf0-f43.google.com with SMTP id k202so50533896lfe.1
        for <git@vger.kernel.org>; Fri, 03 Mar 2017 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=clyIAztAHDqO8APPGYuIqNgGwxUzBevSUdkB8FijI9I=;
        b=j7mtg2Zegc5jOrLRLwMGB3oI1TAzFKIJyXnV+vtOfHfKKnkpAQygljLtwK4B1McLPq
         +MsiohXH92ECoUrgqN8znCaJ7gPb+2HEzrVmD6VVVYinbVEfQlS1agWNc5OwDyOPyoPv
         7sj6hNGC/Fte4MQAhKKbNHks2GhzqkCLvXCR6/eKQh0B0R6C1xgbgqc4i1Io2el1ZbZp
         ykYvnufEjTFjrA9FW5cM2GCcQrBxB/iLMPuYcwwqoqcZcvWmqvuitG1gsDCldllActxV
         ShYtk9ImsonBuMHvEOnsCKeJjAgIE3+QS+FLhkAnPnAEtkKxEQfEVTX7rhV3ibi3k6ZV
         Tdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=clyIAztAHDqO8APPGYuIqNgGwxUzBevSUdkB8FijI9I=;
        b=KZsiqKCSL/UDr7hj2fDVNVIWCLyR2Ily5TAzvSywiDiNJqN2hvXmUb5w6tG97TVG9k
         4jH1qTINj85dpVSJKVEyOkzccbdsrL5cltMgIovZ4qMdfu6w1w0EK/Zw9eLGnx1jdxUC
         oyAPAg+mrrYQoPHPeM0Ep2ynJmqMo4qHEmJDmFfE6hEEM8eMZQ92DNQSp+qVDF6j3bkx
         filQlq9D7A/OWjjURg1jUKMKXuvJI6fMUAwiRk4OfTFt3K2HtpChUzHQuLaxJNwiCy7Y
         9n1/RAj7QlaYnvu8K5I6MEWvA8o60/1w7lgssNhSB7cH2/fr7Owyvsd4Fnjk5x7sSKHk
         LB4w==
X-Gm-Message-State: AMke39m8fsPrTPOUNJsJuPiUUi7vHpqWiqA0ss48D0Bp6HPL/EIM9ivPxekJmcIb/LFIH8xKMfeB3amxSUIpTw==
X-Received: by 10.46.5.2 with SMTP id 2mr1431120ljf.34.1488559182351; Fri, 03
 Mar 2017 08:39:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Fri, 3 Mar 2017 08:39:21 -0800 (PST)
In-Reply-To: <CAHd499CfJnPtLmi8qzr=_jrfCgMw85MOUv-wPKmAHFUyDFXhRA@mail.gmail.com>
References: <CAHd499CfJnPtLmi8qzr=_jrfCgMw85MOUv-wPKmAHFUyDFXhRA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 3 Mar 2017 08:39:21 -0800
Message-ID: <CA+P7+xr=RmPy45DL_Qc2LcWKS-3AzVcPXqQaosZdf4jhnRp1TQ@mail.gmail.com>
Subject: Re: Finding a tag that introduced a submodule change
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2017 at 7:40 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> I have a repository with a single submodule in it. Since the parent
> repository represents the code base for an actual product, I tag
> release versions in the parent repository. I do not put tags in the
> submodule since multiple other products may be using it there and I
> wanted to avoid ambiguous tags.
>

Hi,

I agree you shouldn't use tags in the submodules.

> Sometimes I run into a situation where I need to find out which
> release of the product a submodule change was introduced in. This is
> nontrivial, since there are no tags in the submodule itself. This is
> one thing I tried:
>

I've run into this exact problem at $DAYJOB.

> 1. Do a `git log` in the submodule to find the SHA1 representing the
> change I want to check for
> 2. In the parent repository, do a git log with pickaxe to determine
> when the submodule itself changed to the value of that SHA1.
> 3. Based on the result of #2, do a `git tag --contains` to see the
> lowest-version tag that contains the SHA1, which will identify the
> first release that introduced that change
>
> However, I was not able to get past #2 because apparently there are
> cases where when we move the submodule "forward", we skip over
> commits, so the value of the submodule itself never was set to that
> SHA1.
>
> I'm at a loss here on how to easily do this. Can someone recommend a
> way to do this? Obviously the easier the better, as I have to somehow
> train my team how to do this on their own.
>
> Thanks in advance.

So there's better ways to do this, but I do think there would be value
in adding some plumbing to make it easier.

Here is how I would do this, best if written into a shell script or
similar to automate the tricky part of #2

1. Do a git-log of the *parent* project, filtering out to show only
the path to the submodule

2. For each commit here, you find the new and old values of the
submodule pointer.

3. Use git merge-base --is-ancestor to ensure that "old" is an
ancestor of "submodule sha1id" and then

4. Use git-merge-base to ensure that "submodule sha1id" is an
anscestor of "new".

If both these are tree, then you know that the commit was included
into the parent project at this point.

I've had to do this once or twice, but I don't actually remember
exactly how I did 3. One sneaky way would be to add new tags for each
submodule change something like the following might work and be more
efficient. I'm not really sure but here's how I would go that route:

1. git log <limiting revision selection if you dont' want the entire
history> <path-to-submodule> --pretty=%h | parallel git ls-tree {}
path-to-submodule

The above more or less prints every submodule value as it changed over
time in the parent project.

Next, for each submodule change:

2. git -C <submodule> tag parent/<sha1id> <submodule change>

Create a new tag prefixed by "parent" that includes the sha1id of the
parent commit, and create it inside the submodule

3. git -C submodule describe --contains --match="parent/*" <submodule sha1id>

Once you're done you can also delete all the tags that are in the
"parent" prefix if you dont' really wanna see them again.

Basically, re-use the machinery to tag and then use describe
--contains to find the commit.

I *really* think a similar algorithm could be embedded as a plumbing
subcommand, since I think this is tedious to do by hand.

I'm not really sure if this is the "best" algorithm either, but it's
pretty much what I've used in the past. Either the tag way or the log
yourself one at a time way.
