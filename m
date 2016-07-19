Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31112018B
	for <e@80x24.org>; Tue, 19 Jul 2016 05:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbcGSFqr (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 01:46:47 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36194 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbcGSFqp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 01:46:45 -0400
Received: by mail-yw0-f173.google.com with SMTP id u134so6451905ywg.3
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 22:46:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tT5P9zG6+YSdfGSfJEoYdPJ3QyM4rmv1zISXZ0OKU9M=;
        b=Oe2sbDa/AKKb9STejmVP/Gu4c6nlhng6ive54J7eir+ekXu/zJfxhCdvDogoMPHZ/m
         TB6A7AoOZbuGqepifxNjDlnKL0mQDUc3IY76xOS5FjCW3V9egFWN9wDGmuR8MlSSIvLq
         1RHCRnDbkN485xjATqTCDZVe8zpgGX2T7dY2J1gc0L7kj8awiYoYDCmL1Zp6ZJNPAzeT
         IiKcoYlHioDCk+MyHQEOZPziI8i5ISJHxd4zAjx/TyMVY/hIZrV2B5cuz01Gyzi+2rNR
         SqGjeHPkK9+qRsAGluz3uoaRxwbWNHbLoqxXuxccFx8PkChzWz8d45L7352NckdrG9ob
         htdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tT5P9zG6+YSdfGSfJEoYdPJ3QyM4rmv1zISXZ0OKU9M=;
        b=P0XRb5t/G8CT4nPBK6x5LNhXhOKJKTkSagMkHcWC8liNhkirNTdHiLSSXYILEhDqx7
         dckaXr9AOVVKpbsyUwgfmMsmhlUbKawKgXknqJrEYsGemg6piUA6EPaEmWhrQHdHalaO
         q1TDoiMKH0Ego5gq4tAEUjPc3K2DfaeF86Ws0SXli1uqOPweo9gvnRURZT8PM+KNI55D
         zUFvZOUENXHhAOe3DpTQoVf9A38RtPHi4zlwvVYn7iTPJTZaABRvQg30ArZJ+VxC/ONm
         DEVilaZeZFy+8a8iwkV/jBcE+ZdCQLEhJ+JOgAczbr/je7PONBQkq4caM2dgTWuAmvdy
         SvMQ==
X-Gm-Message-State: ALyK8tJq9LZ6TpoOGNwAAg8x+Cel+WhcJu3KnChMkWVPSrWLTSRahXGRB0e/UloD8YGsj7gu2ODjt7vaeleR4w==
X-Received: by 10.129.130.195 with SMTP id s186mr26864523ywf.267.1468907205014;
 Mon, 18 Jul 2016 22:46:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.200 with HTTP; Mon, 18 Jul 2016 22:46:25 -0700 (PDT)
In-Reply-To: <xmqqpoqakd8s.fsf@gitster.mtv.corp.google.com>
References: <CADWjqk40KK=AuKqqdpKjkBuUvhQb4k4fMR4bPfdo8JkGRs-Y9w@mail.gmail.com>
 <xmqqpoqakd8s.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Mon, 18 Jul 2016 22:46:25 -0700
Message-ID: <CA+P7+xoeO43A+BdkdzeMpuKh=B7Ma+JVq3WR5bsX8XGYxPdmxg@mail.gmail.com>
Subject: Re: Feature request for automatic worktree checkout
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Ehsan Azarnasab <azarnasab@gmail.com>,
	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 11:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ehsan Azarnasab <azarnasab@gmail.com> writes:
>
>> Currently if I have a branch checked out in a work-tree, git-checkout
>> will show this error message when checking out that branch:
>>
>> $ git checkout master
>> fatal: 'master' is already checked out at '/home/dashesy/development/feature'
>>
>> It would be very useful to instead of this error just change the
>> current working directory, so git checkout would become a `cd` command
>
> That is an understandable thing to want from 10,000ft view, but it
> would not be something Git, or any external command that is spawned
> by the shell for that matter, can address.  You'd need to teach the
> shell to cooperate.
> --

You could implement this for yourself as a shell function sort of, by
wrapping git, but it's a bit crazy, something like:

function git() {
  # check if first argument is checkout, otherwise exec git
  # check second argument, and parse git-worktree to determine if it
is checked out
  # if so, just cd into the directory
  # else exec git normally.
}

I'll leave actual implementations to the user. Note at least for BASH,
you need to actually do this as a function alias.

Thanks,
Jake
