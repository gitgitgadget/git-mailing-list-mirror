Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0C020989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750903AbcJJSfR (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:35:17 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35308 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbcJJSfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:35:16 -0400
Received: by mail-qk0-f173.google.com with SMTP id z190so113491281qkc.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w5utEr6Zj0aUN1IA5d4YxjFC1e0E6uwi4iMRJpbeNL0=;
        b=Ttfh8XgLRQ2AZKkzZLPOXaka/PnrebN6FEVOUcTVg3hnHdyAiodsll+jcc5qmn9nCs
         kjK5HO9cgt6M09uS8mTLbK/zL+GktaFYZzv2knCZ6rcct6Qeenxa4n2GZqiBYoV9xrrF
         mRqXzJ4sTgvCbnIvJ/u9mAeU+qUpPpthSxa353qCWSXL9SfUyv9+FfmLRXM6XDz4Ewj3
         6sI/RS7VasKhCu34jEjw87qnJDG5CNf7WpCzN7SaHHW4JKAbqayBrT/VrAOmUErmUeAE
         3g/lW/qh1YCczRE3N2tT5wAfoEYDtP6EV9ClICqZEkSvaQOOgrBpmpA9F00NNS+4CWZ/
         lSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w5utEr6Zj0aUN1IA5d4YxjFC1e0E6uwi4iMRJpbeNL0=;
        b=fkhyEXV7Rj/CEnh5gqMTQ6cC777VHZ8iyMi0GDakPszieEm6Xc4SlXbplQRUWNhiUV
         40Gff45Ver7tPL/JYFbJw9ChOtj2pMv9D4diCISySxV1VQ4lKt/ptusdcWXSF+DvijWN
         PCbDhR9rhZSbxa9IWpKVq7Bn7BJ97WcBpNSwDj+Htb2uL/e78/a34wTdNfThcmBSx8bx
         eeNUPdDeYuyW74PCtnvlOH3Ri62nXtggpEk2YyO6Q+hWxVwo2b0ZrJRFHlK91j9mp91E
         8kHxM6z9TOpORmsOr5VjI5RhgMNi+FF0LK8EKLTftosyqHfdmdPTM0LN5YZDV8rTrKZ6
         dQqA==
X-Gm-Message-State: AA6/9Rm/DLePWvltyR8AVKg0A0V5u9Q+cCjMupnADDkQfdHj+at5RnQUBg2F3vOAu3FGOp5bqyLUBU1A650qTABk
X-Received: by 10.55.82.195 with SMTP id g186mr31208628qkb.220.1476124515126;
 Mon, 10 Oct 2016 11:35:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 10 Oct 2016 11:35:14 -0700 (PDT)
In-Reply-To: <xmqqpon8f54i.fsf@gitster.mtv.corp.google.com>
References: <20161006235149.10232-1-sbeller@google.com> <xmqqpon8f54i.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Oct 2016 11:35:14 -0700
Message-ID: <CAGZ79kZiKwOTiJiw4X3uLit2LrBRe_Y1oVn0-HJT-ey15D49Qw@mail.gmail.com>
Subject: Re: [PATCH] documentation: clarify submodule.<name>.[url, path] variables
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 11:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>>  submodule.<name>.path::
>> +     The path within this project for a submodule. This variable is
>> +     kept in the .gitmodules file. See linkgit:git-submodule[1] and
>> +     linkgit:gitmodules[5] for details.
>
> What does it exactly mean to be "kept"?
>
> Does it mean "never appears in .git/config, and when it appears it
> will not be used at all"?  If so we shouldn't even list it here.

I meant:
Git wont put it into .git/config on its own. If you really wanted to have
it there, you need to do it yourself.

I assumed you can overwrite the path via the config. It turns out,
the value from the config is ignored, so it doesn't even make sense
to put it into the config. Only the value from the .gitmodules file counts.

So with that knowledge, I'll just remove it here, but I'll cross check if it
is referenced else where enough.

>
> I doubt there is any reason for .path to exist in .git/config; where
> each submodule appears in the working tree is what is recorded in
> the tree object, and the "identity" (i.e. that which links a
> submodule in a tree to one of the repositories kept in
> .git/modules/*) by reverse look-up of submodule.<name>.path from
> in-tree .gitmodules, not from configuration, and it is not something
> a per-repository configuration should be able to change at the
> conceptual level.

As said above, currently we'd only rely on the .gitmodules file.

However I think this may conceptually the wrong thing to do.
The name is set in stone and ought to never be changed, unlike
the path.  But as we only obtain this information from within the
repository at all times and not make a copy of it, upstream may
go crazy and change the names within the .gitmodules file.

Then the downstream user is left with a mess and they have no
way of fixing it except by modifying the data in the repository. So it
may be a sensible thing to allow the user to create their own
path -> name mapping in the config file.

We as the Git developers may even think about whether we'd
want to have the path -> name lookup all the time from upstream,
or rather on initialization want to make a copy of the path->name
mapping. Then we can never change the name locally, but we'd
need to track upstream for rename detection of submodule.

>
>>  submodule.<name>.url::
>> -     The path within this project and URL for a submodule. These
>> -     variables are initially populated by 'git submodule init'. See
>> -     linkgit:git-submodule[1] and linkgit:gitmodules[5] for
>> -     details.
>> +     The URL for a submodule. This variable is copied from the .gitmodules
>> +     file to the git config via 'git submodule init'. The user can change
>> +     the configured URL before obtaining the submodule via 'git submodule
>> +     update'. After obtaining the submodule, this variable is kept in the
>> +     config as a boolean flag to indicate whether the submodule is of
>> +     interest to git commands.  See linkgit:git-submodule[1] and
>> +     linkgit:gitmodules[5] for details.
>
> I think it is great that you are describing that this serves two
> purposes, but "as a boolean flag" is very misleading.  It sounds as
> if at some point "git submodule $something" command stores
> true/false there.
>
>  - It overrides the URL suggested by the project in .gitmodules and
>    replace it with another URL viewed from the local environment
>    (e.g. the project may suggest you to use http://github.com/ while
>    you may have a local mirror elsewhere).
>
>  - Its presence is also used as a sign that the user is interested in
>    the submodule.

I see, that makes it clearer, I'll reword this.
