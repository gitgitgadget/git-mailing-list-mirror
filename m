Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34AD41FF6D
	for <e@80x24.org>; Sun, 27 Nov 2016 13:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbcK0Nqn (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Nov 2016 08:46:43 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:34659 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbcK0Nqm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Nov 2016 08:46:42 -0500
Received: by mail-io0-f175.google.com with SMTP id c21so185368158ioj.1
        for <git@vger.kernel.org>; Sun, 27 Nov 2016 05:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hoRcHfFdoPpdCfms/nmMDqDfPg4LW4RTbdMn/QEd66g=;
        b=GjzOT9dl9EFGrEzqCLVJ59CAa4mrb2YgLY9Jos/nH1RaN4nrP+EV2z3WPnAZPLuRmE
         sVtyWSm9yGsyy4gUW9OE7/8w1G4LTR4QczJfw9xUUPzWuuLhJA28lMxW5yAwXg1WIYhD
         OJl8azXmkbknGOUhv8/NYo1HvpEsKJ8a5NiZ2dB7apItcFa7pyOtFKoWNPVhiJXUc+/9
         hqf8dMGX6HA5b5PaMZod6LdplXqR00MxzcHEW2t4i99qNSOvIJryeBrHAEWSHekfuibL
         00VE2jzzm4M9tPUSPFhC6cJPKR8AHkwrVw27txdysjFdCJDE6fQW90Y42zfrzjT5mayd
         RHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hoRcHfFdoPpdCfms/nmMDqDfPg4LW4RTbdMn/QEd66g=;
        b=BeHeOBHGzgx50b5pZvViQMhNMBC+zOpJb7UIu9gqtCI3NhkmcHQPCLLYDPzhivZHmD
         RWrlJp9ivm7SwtcMVdefA24eAMtFm+NW5YtOxO1FzHVi5wry6mZaIr41MAygrwxxaRC3
         s8AVES1ayCo5KI1z2J7/b73fT57IQePYYZ4w0N3UXWJQ47gl5+b4LbHWQC85QPlacJMM
         u70Bqz3z7MagcYJnfO2rJC26Fd/uzaK2R3N9EyopSVyeB+L5WTaVYaGhNPYFL78varJl
         0yRHhy0fLHx/+179aLuq724BnNgPsW3tuipSWLVGpUzFj5ww4lI9/RL8OU9wl1J2bwy3
         Lu5A==
X-Gm-Message-State: AKaTC01bvKZ0FdSPMQTqTJ6T0ljUl0gDah50ybozta0hzvybnOI72OsbqkhTsM6GMjhP6h31Ahjk+RhxfQJ2yA==
X-Received: by 10.107.20.77 with SMTP id 74mr14521440iou.66.1480254400916;
 Sun, 27 Nov 2016 05:46:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.160.199 with HTTP; Sun, 27 Nov 2016 05:46:40 -0800 (PST)
In-Reply-To: <20161127050818.rmjpvha64y4wosq2@sigill.intra.peff.net>
References: <CAD03jn5PAZcFeesaq2osjo7cYd1frWZeN0odNqTh+AMxSEmLgQ@mail.gmail.com>
 <20161127050818.rmjpvha64y4wosq2@sigill.intra.peff.net>
From:   Dun Peal <dunpealer@gmail.com>
Date:   Sun, 27 Nov 2016 08:46:40 -0500
Message-ID: <CAD03jn7gU9g7NyDk_3wYTKsYQUtRGg6msvumZqUDs44hMOVX7w@mail.gmail.com>
Subject: Re: trustExitCode doesn't apply to vimdiff mergetool
To:     Jeff King <peff@peff.net>
Cc:     Git ML <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, Jeff.

Ignoring a non-zero exit code from the merge tool, and assuming a
successful merge in that case, seems like the wrong default behavior
to me.

If your merge tool quit with an error, it is more sensible to assume
that the resolution you were working on has not been successfully
concluded.

In the rare case where one did successfully conclude the resolution,
you can always quickly mark the file resolved. I'm not even sure how
to do that short of `git checkout -m -- file`, which would lose any
work you've already done towards the merge.

Long story short, I hope the developers change this default, or at
least let us override it for the builtin invocations.

Finally, if you're not using mergetools, how do you resolve conflicts?

On Sun, Nov 27, 2016 at 12:08 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Nov 26, 2016 at 09:44:36PM -0500, Dun Peal wrote:
>
>> I'm using vimdiff as my mergetool, and have the following lines in
>> ~/.gitconfig:
>>
>> [merge]
>>     tool = vimdiff
>> [mergetool "vimdiff"]
>>     trustExitCode = true
>>
>>
>> My understanding from the docs is that this sets
>> mergetool.vimdiff.trustExitCode to true, thereby concluding that a
>> merge hasn't been successful if vimdiff's exit code is non-zero.
>>
>> Unfortunately, when I exit Vim using `:cq` - which returns code 1 -
>> the merge is still presumed to have succeeded.
>>
>> Is there a way to accomplish the desired effect, such that exiting
>> vimdiff with a non-zero code would prevent git from resolving the
>> conflict in the merged file?
>
> I don't use mergetool myself, but peeking at the code, it looks like
> trustExitCode is used only for a "user" tool, not for the builtin tool
> profiles. That sounds kind of confusing to me, but I'll leave discussion
> of that to people more interested in mergetool.
>
> However, I think you can work around it by defining your own tool that
> runs vimdiff:
>
>   git config merge.tool foo
>   git config mergetool.foo.cmd 'vimdiff "$LOCAL" "$BASE" "$REMOTE" "$MERGED"'
>   git config mergetool.foo.trustExitCode true
>
> Though note that the builtin vimdiff invocation is a little more
> complicated than that. You may want to adapt what is in git.git's
> mergetools/vimdiff to your liking.
>
> -Peff
