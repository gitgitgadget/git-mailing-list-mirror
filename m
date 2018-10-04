Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 377781F453
	for <e@80x24.org>; Thu,  4 Oct 2018 17:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeJEAXa (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Oct 2018 20:23:30 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:41854 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJEAX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Oct 2018 20:23:29 -0400
Received: by mail-lf1-f48.google.com with SMTP id q39-v6so7384635lfi.8
        for <git@vger.kernel.org>; Thu, 04 Oct 2018 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vZ/8HhM3vhnMBlc5c465Q1g11hmtSlk3XPZjuKEFzgs=;
        b=vHrBIXwmzYNlBuvIX+Gl7sv5u3EPhv1Lj4FEhRlOvbOx+X79GZigYg26g8Xda4/RvU
         53owrENo0VO9XxsO/AgRQAyCQmdSMKWvO/SHnFCzEYXjHBvE5ykgiQTKvaZTwWDgpgG0
         xxwFF/DBTywXY0MG3qHmfKnTmFGiCc5JjJdG/S0AYT+ry8YkDi0uDmY9nJjUiRtUxQ1y
         Fk/UHXVD4nX6Mq5L0Pj7nae9iGiI2V1SK+d0Ennmv0S/iWZHNHAS2L8Mc3j0gC0xdn4A
         naUMMglFn3XyCE4kXCNGJVJZmKdZ4tt5ih8Xmbe9bDJyyXoVw4HY51N/jH93OgtdK0A2
         A0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vZ/8HhM3vhnMBlc5c465Q1g11hmtSlk3XPZjuKEFzgs=;
        b=FTlSEyiFrg9Fa2RqUKA7UvUv42fNCYMV/pBRONv+0Nnsf6fiJmEH6TYSQSZvWLvj1b
         1Y8C8fdBxNoln2QFHdnPfx0H3CelOsbLzOMGkOLKdB9BTqw2Zhet2Gl7ACle3Vcg5kae
         gAOlSqtN0xzmbZrTr83a7iokXzG+JzZEstueJhL4aI2sj54UGeR3WTn6AnM86ds5OkjE
         Z+jWrKjmFdJ0IbKc13XbFrxgnA7ARMALePThr775jI6NE+hFxxPlG0RbkLDR3xaSFMC/
         aQMDZV85W74lvYSV71aop+QqWloStTBOxTdd6OFgit1gLfEFN1zydZ2Pt60ur0+PhL/j
         kw7Q==
X-Gm-Message-State: ABuFfoj6OBgX2HLI8nH5N8pZxWYYEItmthHWe1aJnkYTqwkCCg3B0B6J
        4Qa6CU1u0iFxoeXk55RQcW1mRZEF0LANMLEDXRSgGA==
X-Google-Smtp-Source: ACcGV63WiBJRPTko1CpK6If/xv+GGtxnb+xq8ZWDZ3Js/hbm8Qmhq0T1xpa4yhqMcErIP1dqyTsyPVdym0uaUJgpEGY=
X-Received: by 2002:a19:d7d6:: with SMTP id q83-v6mr4404140lfi.27.1538674152145;
 Thu, 04 Oct 2018 10:29:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:2e13:0:0:0:0:0 with HTTP; Thu, 4 Oct 2018 10:29:11 -0700 (PDT)
In-Reply-To: <86d0spzoi1.fsf@gmail.com>
References: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
 <xmqqbm8f952b.fsf@gitster-ct.c.googlers.com> <86d0spzoi1.fsf@gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Thu, 4 Oct 2018 10:29:11 -0700
Message-ID: <CAPL8ZitYycD=zZc9yK2ZWn6xSP2rtyviQnOYPFhBpsvQQHe09w@mail.gmail.com>
Subject: Re: Git Evolve
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gerrit uses notes and branches of meta-commits internally for its
database, but it still uses the change-id footers to associate an
uploaded commit with a change within its database.

On Thu, Oct 4, 2018 at 9:05 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Stefan Xenos <sxenos@google.com> writes:
>>
>>> What is the evolve command?
>>> ...
>>> - Systems like gerrit would no longer need to rely on "change-id" tags
>>> in commit comments to associate commits with the change that they
>>> edit, since git itself would have that information.
>>> ...
>>> Is anyone else interested in this? Please email me directly or on this
>>> list. Let's chat: I want to make sure that whatever we come up with is
>>> at least as good as any similar technology that has come before.
>>
>> As you listed in the related technologies section, I think the
>> underlying machinery that supports "rebase -i", especially with the
>> recent addition of redoing the existing merges (i.e. "rebase -i
>> -r"), may be enough to rewrite the histories that were built on top
>> of a commit that has been obsoleted by amending.
>>
>> I would imagine that the main design effort you would need to make
>> is to figure out a good way to
>>
>>  (1) keep track of which commits are obsoleted by which other ones
>>      [*1*], and
>>
>>  (2) to figure out what histories are still to be rebuilt in what
>>      order on top of what commit efficiently.
>>
>> Once these are done, you should be able to write out the sequence of
>> instructions to feed the same sequencer machinery used by the
>> "rebase -i" command.
>
> Well, that assumes that "rebase -i" can correctly recreate merges, if
> needed.
>
>> [Side note]
>>
>> *1* It is very desirable to keep track of the evolution of a change
>>     without polluting the commit object with things like Change-Id:
>>     and other cruft, either in the body or in the header.  If we
>>     lose the Change-Id: footer without adding any new cruft in the
>>     commit object header, that would be a great success.  It would
>>     be a failure if we end up touching the object header.
>
> Doesn't Gerrit use git-notes instead of 'Change-Id:' trailer nowadays?
> Notes transport is quite easily controlled; the problem with notes merge
> does not matter for this use.
>
> Best,
> --
> Jakub Nar=C4=99bski
