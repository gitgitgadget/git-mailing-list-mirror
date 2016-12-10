Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 460B7203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 08:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbcLJItP (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 03:49:15 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:36859 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbcLJItO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 03:49:14 -0500
Received: by mail-io0-f176.google.com with SMTP id a81so88990117ioe.3
        for <git@vger.kernel.org>; Sat, 10 Dec 2016 00:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x0bZYPunD9BXomleTxOZvDJGUuDxYgmSQMZAUjcwSak=;
        b=BeKKX8k1CNhdVJcia7zzYimVYZ0lfSSFiTy6b26dOTNU3TUPQMoxz3jTkeL6AWUhm9
         ND4/4yJ/c45A5hvDfF7q1pu0YFMEsgBXud16pCFs7eQQlhqIpRQNwgbRgcXmfMBFoMHH
         aW4RIHgVPEF140J3CL61af8dJ4MOkfyFCe9S7hWO7kYl50HLOUgoNj+zweAzA3NNLFh7
         aRPw8v7a2WwjutMby+927cdX3NmgCdjq3w6sNUD5/uaOBA4+04TaazrJ2o0d6XRlz2nL
         alFG650rzUHFTpHiOlPJewynbVHDv5y59qJ/6BcZbh0DsMir3DtHfU3osibN6AjQOV0F
         76jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x0bZYPunD9BXomleTxOZvDJGUuDxYgmSQMZAUjcwSak=;
        b=JScAo95ZnTYqyompZNjPi3mbBrvxfs6fbJmjpR51MnPJtImeATZjDB2UfBhfn9EyTA
         gB1dPw8/C+h4ftDWROxDRlh6cWE+WyWuh1PodMWsQWT02ZVs1Svczye6UAKjavYXFwvo
         eXiSQs/8T1QA80av9hTzSaQ+L7meee9LDOZ7/HY/3qkLotLqATFXO4HMXEo1Awak8L0E
         21Kk1a/b2TT6PFHy/zwWI18YVihidGIR4jjLj3eIZoi48fV4OmLc0A9tWOQD6eh3xmlX
         kGOsOmkcGEado7umXjX77659rn6ZjaovYutpG9KvWzW80LtjZkn6EyCKMO6y/XfmbF74
         S4xQ==
X-Gm-Message-State: AKaTC00xgzXqA1/YhHri7DuxKok8QYb6mVFA84UsZVJfHSQV5wNtc0JW47set8TdoDnzsrXMQSQDxr/T+CA3vg==
X-Received: by 10.107.200.204 with SMTP id y195mr69367745iof.73.1481359753839;
 Sat, 10 Dec 2016 00:49:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.0.93 with HTTP; Sat, 10 Dec 2016 00:49:13 -0800 (PST)
In-Reply-To: <xmqqshpwrjyz.fsf@gitster.mtv.corp.google.com>
References: <CAFOYHZDs5rBt5+4D_ViMYfV04foq3h_UrsSMA3FfyMzLh9QdwA@mail.gmail.com>
 <20161209091127.sxxczhfslrqsqs3m@sigill.intra.peff.net> <xmqqshpwrjyz.fsf@gitster.mtv.corp.google.com>
From:   Chris Packham <judge.packham@gmail.com>
Date:   Sat, 10 Dec 2016 21:49:13 +1300
Message-ID: <CAFOYHZAsU_gNb=_K=iMFKFdt60SJ4Wm=Ag5=XMXuQgxNxCqWLA@mail.gmail.com>
Subject: Re: Any interest in 'git merge --continue' as a command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, GIT <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 8:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>>> They knew about git rebase --continue (and git am and git cherry-pick)
>>> but they were unsure how to "continue" a merge (it didn't help that
>>> the advice saying to use 'git commit' was scrolling off the top of the
>>> terminal). I know that using 'git commit' has been the standard way to
>>> complete a merge but given other commands have a --continue should
>>> merge have it as well?
>>
>> It seems like that would be in line with 35d2fffdb (Provide 'git merge
>> --abort' as a synonym to 'git reset --merge', 2010-11-09), whose stated
>> goal was providing consistency with other multi-command operations.
>>
>> I assume it would _just_ run a vanilla "git commit", and not try to do
>> any trickery with updating the index (which could be disastrous).
>
> If we were to have "merge --continue", I agree that it would be the
> logical implementation.
>
> There is nothing to "continue" in a stopped merge where Git asked
> for help from the user, and because of that, I view the final "git
> commit" as "concluding the merge", not "continuing".  "continue"
> makes quite a lot of sense with rebase and cherry-pick A..B that
> stopped; it concludes the current step and let it continue to
> process the remainder.  So from that point of view, it somewhat
> feels strange to call it "merge --continue", but it probably is just
> me.
>

Yeah I did think that --continue wasn't quite the right word. git
merge --conclude would probably be the most accurate.
