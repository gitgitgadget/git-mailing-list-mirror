Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F662202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 15:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752093AbdGMPW6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 11:22:58 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33343 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751267AbdGMPW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 11:22:57 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so7324731pgb.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BLeCGrXMp46GFxncQ0XrDv2VLscFBeZHYCK9P9CAFKs=;
        b=PqbSA8xoJ4wXlM8cNeiMpgChlK3RGEVQ5Q/p5vikgqLRjX7AnPHDu8KqheHGI+WWWP
         yMo/j36Uuoaf0LO1Q8I+dTwzReMWKDtXeyZYfdbZIiOiWxlFXt1823aoQOs47NYZAOSB
         Uc2zRULhaQjRyiLtdTyyWv2KqmvvfZDN1720PISbaqFwaFXckibBqUdooCamTS8rJmin
         mK6Q1J4vPmhuSwPMmbU7aC86QIcUvPMeJVH6FLlcj+FSaJoR3CIaxzThHNTJHvHzURhf
         5EfEEePr0DhYMKXtMvYYmq3cLvYcQqjU1MShCOw7mXMJorq2Dmml+h4VQi1Cy/2yMXAX
         mRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BLeCGrXMp46GFxncQ0XrDv2VLscFBeZHYCK9P9CAFKs=;
        b=dRQu8lbucjMWL+DcXfQMxI6JPwdwbBWhGTiyZPRFAuzjd7/SjEmRspptYUCrMMo17m
         SE3gLVUTnsY7Zb53POPGRreJSHuoh2ekBeyFw/wEGaUYP8SNfhMd8LhPGEUqK6kbg6oP
         3N34W5Ca7izMM+vzAhzMfZSSxipaJiQe8DpkK2nq56z5JMhL2ZKVio9+r6JGdlkKzzhy
         Nc3Lzr7HipKmdkdxsAZtl+CaDISwQKzSe6irq1UYqHawpyGTxpKdZW52duKx6yIzM9eC
         PeEdzb5/OS0EKbvxK8O6kRH89cqWLbgvyUjWsT1VkG5iEIsQ6xWeyvrJFkbqtBrgAtJ2
         Pflw==
X-Gm-Message-State: AIVw113cjzC3ujZUjLpqH7weO1qTBgoJAxK6E5Dpb7xzBvROmR0Q/No8
        b4O6Wrbc5EQgCg==
X-Received: by 10.84.217.220 with SMTP id d28mr11013203plj.218.1499959376032;
        Thu, 13 Jul 2017 08:22:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id t67sm12552569pfj.98.2017.07.13.08.22.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 08:22:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>
Date:   Thu, 13 Jul 2017 08:22:54 -0700
In-Reply-To: <alpine.DEB.2.21.1.1707131435220.4193@virtualbox> (Johannes
        Schindelin's message of "Thu, 13 Jul 2017 14:44:09 +0200 (CEST)")
Message-ID: <xmqqzic8xsxd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I wonder whether the --force-with-lease option would benefit (and counter
> the "unsafe because of behind-the-back operations" argument) from doing
> some kind of "reverse pull --rebase".
>
> In other words, --force-with-lease could verify that the upstream branch
> has no commits that weren't seen in the current branch's reflog, i.e. that
> `git rev-parse HEAD@{upstream}` is identical to `git merge-base
> --fork-point HEAD HEAD@{upstream}`.
>
> The assumption would be that you typically want to push with a lease only
> when following the `pull --rebase` workflow. Meaning that you would only
> want to force-push when your local branch had the upstream branch
> integrated at some stage [*1*].

I suspect that the problem "--force-with-lease" wants to solve does
not even appear in "pull --rebase" workflow, but let me think aloud
to see where this leads, as the idea sounds interesting, even though
I may have misunderstood what you meant by the above.

If you do a "pull --rebase", you first rewind to the upstream and
then reapply your changes on top, meaning that the result would
normally be based on what was once at the tip of the upstream and
should fast-forward.  The only situation that a result of "pull
--rebase" needs a non-ff push is when somebody else pushed there in
the meantime, adding commits that you haven't seen yet.  And you
do not want to force your push to lose their work with "--force",
with or without any lease.

It does not change if you do an extra "fetch" to update the tip of
your remote-tracking branch with their work.  Using the lazy
"--force-with-lease" is a wrong thing to do here, of course, but
using any "--force", with or without lease, is _unnecessary_ with
"pull --rebase".  The safety afforded by the bog standard push that
requires fast-forward is sufficient.

And the above will equally apply to a non rebasing "pull".

The problem "with-lease" part tries to solve is when you are
actively rewinding the history of the upstream.  Your upstream may
look like:

    o---A---B---C

and you fetch, squash B and C into one with some changes, to come up
with a local history:

          BC
         /
    o---A---B---C

and try to replace the upstream's tip (which is _supposed to be_ at
C) with BC; the resulting history leading to BC is supposed to be a
replacement of the upstream's history, and that is true only when
the upstream's tip is still at C when you do your push.  If somebody
else built D on top of C and pushed there, that would no longer be
true and you'd end up losing it by replacing the upstream's tip with
your BC.  Before the "with lease" option, when you want to fix the
"---B---C" segment of the history that is already published, the
only way to replace it with a single commit BC was with "--force"
and there is no mechanism other than inter-developer coordination to
make sure nobody will push D on top of C that will be lost with your
forced push.  "push --force-with-lease=<ref>:C BC:<ref>" is meant to
be a solution for that issue.
