Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C270C1F404
	for <e@80x24.org>; Fri,  2 Mar 2018 16:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968069AbeCBQpW (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 11:45:22 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35270 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966382AbeCBQpT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 11:45:19 -0500
Received: by mail-wr0-f195.google.com with SMTP id l43so10762674wrc.2
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 08:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1nF4kmk8NM+Mq5lp5Tc84OydJkO1PZ2fLWSKw2baH/8=;
        b=SCNpAoJ9eDf5j8BOm5+Z2kKx124rVTdHRWEpyzk431o1wT8Il1D2gKqpngU9MZWdxz
         BRYHxTv0S6eW8AOCyfw+WIkZz4H5klzsdlWPyQIm9GRV62v09EoOo7DIswAQp6c5Ps6t
         o7xYduBzghLbUwpV0FBec/N6ROaNzZkvX79fAP31/e9VdeVTBIq73w1QDPw9vDhAmqT7
         25ihKgBtFQ+IBKu1Bst//vrSshNErC8+BSK029wkOpNXHE3gGs9XANnG1IUIk1GtRQbX
         GpXoAca4CScXoTcVmJnh+19h/4zyuYt0GwgYihg2IDSvQ7YRouJWM2EbEV98vyQqXyOL
         J96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1nF4kmk8NM+Mq5lp5Tc84OydJkO1PZ2fLWSKw2baH/8=;
        b=aPi9gdJH93d1ecxC42/PRpzc1wTMN89pxBDP8u8by/+F6t8riMnpDDYgASMP3m6llJ
         9bmTP4xHtqVkCPa+JA4eHwDh0cJTrr0ZNXhRygiiCAsJpi1V3JPVWshH4/qBvfz/J3XR
         jPG041Oa4GCdNoYw8ZZJrYz+fKNVPEuIv3lq9WZa+IToHgN+zv9lLSif5UnTE0bUoVdQ
         VQx3HgJbNKuSqKm82ZZjV4XeZNiAw1v6ZJljhIe0Vh7FDrzMyN1BKHISKT9WCuUjz4eR
         miFy9T3aIeRrXX/3QNNdKDZlewwBbwR2XRS+Mwx7DMwqePiD8O842+S5pbUc/Z7lYbtc
         cXGg==
X-Gm-Message-State: APf1xPBb0hVNg54Z22ZLmnrmSjxrHuecRsB/zLFWw5fON8ntw3GT3CmG
        GRNNjBazxTu0Oanek+qscaGp+7L0hr4=
X-Google-Smtp-Source: AG47ELuBrUBsdB+bFsidVFPYV8tDvGE/PlBKY8s7J0Idtur0pCeFktCsMxYlKFUO2qdLyXvpZEYlbQ==
X-Received: by 10.223.150.42 with SMTP id b39mr5241874wra.55.1520009117681;
        Fri, 02 Mar 2018 08:45:17 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 62sm6915676wrf.24.2018.03.02.08.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 08:45:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [RFC] Contributing to Git (on Windows)
References: <176408fc-3645-66d3-2aa3-30ca3fa723e7@gmail.com>
        <20180302044409.GC238112@aiede.svl.corp.google.com>
Date:   Fri, 02 Mar 2018 08:45:16 -0800
In-Reply-To: <20180302044409.GC238112@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Thu, 1 Mar 2018 20:44:09 -0800")
Message-ID: <xmqq606ee89v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> +When adding a helper, be sure to add a line to `t/Makefile` and to the `.gitignore` for the
>> +binary file you add. The Git community prefers functional tests using the full `git`
>> +executable, so be sure the test helper is required.
>
> Maybe s/low-level/unit/?

Yup.  

Also "be sure the test helper is required" at the end did not click
until I read it twice and realized it wanted to say that addition of
new test helper executable for function level unit testing is
discouraged and should be limited to cases where it is absolutely
necessary.

>> +Test Your Changes on Linux
>> +--------------------------
>> +
>> +It can be important to work directly on the [core Git codebase](https://github.com/git/git),
>> +such as a recent commit into the `master` or `next` branch that has not been incorporated
>> +into Git for Windows. Also, it can help to run functional and performance tests on your
>> +code in Linux before submitting patches to the Linux-focused mailing list.
>
> I'm surprised at this advice.  Does it actually come up?  When I was
> on Mac I never worried about this, nor when I was on Windows.
>
> I'm personally happy to review patches that haven't been tested on
> Linux, though it's of course even nicer if the patch author mentions
> what platforms they've tested on.

s/Linux/other platforms/, perhaps?  In fact, portability issues in a
patch originally written for a platform is rather quickly discovered
if the original platform is more minor than the others, so while it
is good advice to test your ware before you make it public, singling
out the portability issues may not add much value.  The fewer number
of obvious bugs remaining, the fewer number of iterations it would
take for a series to get in a good shape.

>> +When preparing your patch, it is important to put yourself in the shoes of the maintainer.
>
> ... and in the shoes of other users and developers working with Git down
> the line who will interact with the patch later!
>
> Actually, the maintainer is one of the least important audiences for a
> commit message.  But may 'the maintainer' is a stand-in for 'the
> project' here?

I tend to agree.  The reviewers all comment on the proposed log
messages and code changes to help making the patch understandable by
future readers (i.e. the most important audicences).  The maintainer
and senior reviewers may happen to be good at putting themselves in
the shoes of future readers to spot potential problems than other
reviewers can, simply because they have been working on the project
longer than others.  But we should stress that the patch should be
written for future readers of the code and history.

> [...]
>> +* Make sure the commits are signed off using `git commit (-s|--signoff)`. This means that you
>> +  testify to be allowed to contribute your changes, in particular that if you did this on company
>> +  time, said company approved to releasing your work as Open Source under the GNU Public License v2.
>
> Can this either point to or quote the relevant legal text from
> Documentation/SubmittingPatches?  It feels dangerous (in the sense of,
> potentially leading to misunderstandings and major future pain) to ask
> people to sign off without them knowing exactly what that means.

When you can point at an existing test in legal context, it is safer
to do so rather than attempting to "rephrase" it yourself (unless
you are a lawyer, of course, in which case you can assess the best
course of action yourself).
