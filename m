Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC6B8202A0
	for <e@80x24.org>; Mon, 30 Oct 2017 02:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751639AbdJ3Cxs (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 22:53:48 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:50550 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751442AbdJ3Cxr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 22:53:47 -0400
Received: by mail-wm0-f48.google.com with SMTP id s66so12844312wmf.5
        for <git@vger.kernel.org>; Sun, 29 Oct 2017 19:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WgmKIdAhw4Qn7gkmPdIXq6RHPI48SEbcyWnDETKZC5Q=;
        b=L1VTr9OPIudTuH9T/qPRePgVZkcBP8W++JUW8ju04TrUuuU04WbdCXUeqIGpoeJJ07
         sD2hXhrYgqOrS4W1GPVbsAQPUyE62e69HR1k2M38WJaE2mxPkMqLw8FtmSTfmthcxOfe
         54p/vtYaVTUgq18wXxjXTScnrmsu2D1FB+O3GrsNKebfXCeqFVpqdKESm28KPnJRgUMY
         dVGmPdqYXUiRizWdaVhzP/6MTl/29wS8KKtectVEtLgnKN4F7valtBxC/AEFYGZxmhW5
         K353E4alzTUu6ckCFDmc8nmkq2ZgEt99iHCaAGPNIht2Eme4XB3Aek1aIDMo2iIv4PTF
         SsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WgmKIdAhw4Qn7gkmPdIXq6RHPI48SEbcyWnDETKZC5Q=;
        b=dgj1ii8SZV6hcUxm5T+RnrVGLDj20eF89HhWiAHoVwkKyhndtnho2dRFNUxU3TGLQf
         bFoIcx+Hy2Qk+T0eEpTw2V88sg1IChNTx1fcqw5ZwPxv6IOe4q2nOvl5h2phpgpj3nte
         im1BFfF9I9vMuI17iTMxU6uA4k970rT9gtMwPm3HvowAU5IKCPHIw2ffgphyB1Bbyn/H
         JbI3jJDfwnROTKqX4/8dljz9Kd8R7f5TgyLD3CPj9fv9DNJX65egn8hM9lwHanoivNBQ
         GZZLSNmg1nU+PrVsGlR0uvAjL7skaRRv8oCOTioUOBIAt0GiytkXQEBX+EOisUYFpRYm
         Bj0Q==
X-Gm-Message-State: AMCzsaWDld7J+FfrnaFCAV2y6HAcR45A0/SFcbLaNbw+pjiuT2MZ80C2
        xT8VzE+l+Ywu5h3zpxfUeAv3+yFqKPCedFyoCrE=
X-Google-Smtp-Source: ABhQp+Q4mikVQeD/LSGOX2Cu8LdtCxWqM2ovtXZxDbbNqmfbBNtp7JV6O0VJT5MUBCxUjy+dPOqzF+4Axt5jfmH5lK0=
X-Received: by 10.80.173.210 with SMTP id b18mr10265254edd.148.1509332026066;
 Sun, 29 Oct 2017 19:53:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Sun, 29 Oct 2017 19:53:25 -0700 (PDT)
In-Reply-To: <xmqq1sll8j6f.fsf@gitster.mtv.corp.google.com>
References: <20171028000152.2760-1-jacob.e.keller@intel.com>
 <alpine.DEB.2.21.1.1710281740070.6482@virtualbox> <4150d979-f653-e79b-563a-1dc43f12468d@talktalk.net>
 <xmqq1sll8j6f.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 29 Oct 2017 19:53:25 -0700
Message-ID: <CA+P7+xrXLcTQpPWgzLwt_yZo=QdfetF36jrc_TtXfqMKR2Hh3w@mail.gmail.com>
Subject: Re: [PATCH] rebase: exec leaks GIT_DIR to environment
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 7:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phillip Wood <phillip.wood@talktalk.net> writes:
>
>> Just clearing GIT_DIR does not match the behavior of the shell version
>> (tested by passing -p to avoid rebase--helper) as that passes GIT_DIR to
>> exec commands if it has been explicitly set. I think that users that set
>> GIT_DIR on the command line would expect it to be propagated to exec
>> commands.
>>
>> $ git rebase -px'echo $GIT_DIR' @
>>
>>                                                             Merge commit
>> '7c2f1abd64' into phil
>> Executing: echo $GIT_DIR
>>
>> Successfully rebased and updated refs/heads/phil.
>>
>> $ env GIT_DIR=.git git rebase -px'echo $GIT_DIR' @
>>
>>                                                             Merge commit
>> '7c2f1abd64' into phil
>> Executing: echo $GIT_DIR
>> /home/phil/Documents/src/git/.git/worktrees/git-next
>> Successfully rebased and updated refs/heads/phil.
>
> Hmmm, I do not mess with GIT_DIR at all in my workflow, so I am
> having a bit of hard time judging if this regression is serious
> enough to be a release blocker.
>

So, I don't directly mess with GIT_DIR in my use case either, I just
happened to run a build from a sub directory which relies on git
commands continuing to work. However, because GIT_DIR was set to a
relative path, it broke this Make in the subdirectory, which resulted
in the problem occurring, but *only* during the exec command, if I ran
the command manually after reach rebase step, it worked fine (since
GIT_DIR was no longer set).

I don't know how big a deal it is, since I didn't notice it for quite some time.

Thanks,
Jake

> I'd prefer to avoid reverting the whole js/rebase-i-final topic from
> 'master' this late in the game, even though I do not expect we would
> see the remainder of the system gets broken due to hidden dependency
> on the topic, because the changes on the topic are relatively well
> isolated.
>
>
> 570676e011
> d1114d87c7
> 2f0e14e649
> 5f3108b7b6

I am pretty confident we can fix it. I think the easiest solution
would be to just make sure GIT_DIR is an absolute path when passing it
to the exec command.

Thanks,
Jake
