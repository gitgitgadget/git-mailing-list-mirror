Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8DA1F6BF
	for <e@80x24.org>; Sun,  4 Sep 2016 05:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbcIDFYd (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 01:24:33 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:38884 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbcIDFYb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 01:24:31 -0400
Received: by mail-it0-f47.google.com with SMTP id c198so103087413ith.1
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 22:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qQwcxpUCPS4fxhjqyogRG4wVdRCwHGQ8o9d9Tm0VCt4=;
        b=aYw02g03TffHGAenV8QXmKqqSYAj0Q9jNJoTHQ3tsKlKHPaPO4Vm76zM7n+i/Z2B8N
         euKh3tBt7orP9tEE3DB4K3h7IYXjTfbonanBhmLnnKlAsnG4AON1c7Ps3F6YcC54ZZHD
         F7X2dOAE7wolfoKOZentKG4ewPzWozTc6PaPLLdCxrpCT+mMCNff97NUoK4ZTKUi22BD
         xfttG45dS96mCw4kyJ9KgZFGhn8CULQ81hB49XwJLFGqVsCaa1T/c19BhuB0C0NZZRzf
         vctoTeSt4Grq8XIt2BThfoHOhtwsrl2MvvmWelikQckbYaZTxit4dauq2nTyeBihcI75
         wnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qQwcxpUCPS4fxhjqyogRG4wVdRCwHGQ8o9d9Tm0VCt4=;
        b=Os5n9w2el3NFBIC2hpAYpH2sZImh97xr16CFEkgCk0tQIsIpuMz0x83Ag5v2rK6/5q
         1wC9+gXnGWEg1E/CUgvbTC2/Rfw6prAXYgyn8bJgf4lfWGHw47NXVTzAg9/ECEyUqx7l
         ZojIjVg7EHeIz89MUN3oUkVPTuGvZungboGOstml1Wv6umVjenAXfKPNrpXt7c4QhZ7d
         /wpRHy+v14ItZRcGqaQaEsJBi2adYGs3AqhNsRTbDK85l4tCm3/zROJMrzI/+0hDQtP8
         +TqRaFp6CYvBvs1S+G+FeXIhW6HIfKq1fJmF7k/364IuaM3LY3jsxNfDnT8R71VQWMLm
         /xFA==
X-Gm-Message-State: AE9vXwMfXgGraXR4uqUr4xblJ1OumZYG2kYcXvHd9XzGwmxmLZlySExxKD71Es4/tkg4DIxPhJzebRVkn9v82kVx
X-Received: by 10.36.69.92 with SMTP id y89mr6394852ita.49.1472966616092; Sat,
 03 Sep 2016 22:23:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Sat, 3 Sep 2016 22:23:35 -0700 (PDT)
In-Reply-To: <xmqqtwdxqxh6.fsf@gitster.mtv.corp.google.com>
References: <20160903033120.20511-1-sbeller@google.com> <xmqqtwdxqxh6.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Sat, 3 Sep 2016 22:23:35 -0700
Message-ID: <CAGZ79kYGnkcOxviukj9a8gyaERip5aunXcvsdH-UpBCb=vrVeQ@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/2] Color moved code differently
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 3, 2016 at 12:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> A line is colored differently if that line and the surroundign 2 lines
>> appear as-is in the opposite part of the diff.
>>
>> Example:
>> http://i.imgur.com/ay84q0q.png
>>
>> Or apply these patches and
>>     git show e28eae3184b26d3cf3293e69403babb5c575342c
>>     git show bc9204d4ef6e0672389fdfb0d398fa9a39dba3d5
>>     git show 8465541e8ce8eaf16e66ab847086779768c18f2d
>
> I like this as a concept.  Two quick comments are

Great!

>
>  * On 1/2, you would also need to teach diff-color-slot the
>    correspondence between the name used by configuration and the
>    enum used as the index into the diff_colors[] array.

So I would need to add code to diff_parse_color_slot just below the
definition of the struct.

>    I think
>    these are not "DUPLICATE", but "MOVE", so I'd suggest renaming
>    dup-new and dup-old to some words or phrases that have "MOVED"
>    and "TO" or "FROM" in them (e.g. "DIFF_MOVED_FROM",
>    "DIFF_MOVED_TO").

Ok, sounds sensible.

>
>  * On 2/2, doing it at xdiff.c level may be limiting this good idea
>    to flourish to its full potential, as the interface is fed only
>    one diff_filepair at a time.

I realized that after I implemented it. I agree we would want to have
it function cross file.

So from my current understanding of the code,
* diffcore_std would call a new function diffcore_detect_moved(void)
   just before diffcore_apply_filter is called.
* The new function diffcore_detect_moved would then check if the
   diff is a valid textual diff (i.e. real files, not submodules, but
   deletion/creation of one file is allowed)
   If so we generate the diff internally and as in 2/2 would
   hash all added/removed lines with context and store it.
* Instead checking for a different symbol in fn_out_consume, we consult
   the hashmap whether we want to color the line as a "moved" line.

>     All the examples you pointed at
>    above have line movement within a single path because of this
>    design limitation.  I do not think 2/2 would serve as a small but
>    good first step to build on top of to enhance the feature to
>    notice line movements across files and the design (not the
>    implementation) needs rethinking.

After reading the code more closely I agree. I initially put it there
to see if it is feasible or just messing up the diff. And as I have
a bit of knowledge of the xdl internals due to the first version of
the diff slider heuristic, I went with that.

From a cursory look at the history, you seemed to be very involved in
the implementation of diff.c, so I'd appreciate strong guidance on
the design level.

>
> The idea has a potential to help reviewing inter-file movement of
> lines in 3b0c4200 ("apply: move libified code from builtin/apply.c
> to apply.{c,h}", 2016-08-08).  You can see what was _changed_ in the
> part that has been moved across files with "show -B -M", and
> sometimes that is useful, but at the same time, you cannot see what
> was moved without changing, which often is necessary to understand
> the changes and notice things like "you moved this across files
> without changing, but this and that you did not change need to be
> adjusted".
>
> The coloring of "these are moved verbatim" in the style this series
> gives would be very helpful for reviewing such a change.
>

Right, that is what triggered me to implement it.
Another such case that I reviewed was
https://git.eclipse.org/r/#/c/78645/
and I felt very insecure about reviewing thousands lines of code
that was "just moved".

Thanks,
Stefan
