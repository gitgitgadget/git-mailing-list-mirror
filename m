Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 657831FD4F
	for <e@80x24.org>; Mon, 28 May 2018 05:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753229AbeE1FlA (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 01:41:00 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:50845 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753227AbeE1Fk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 01:40:59 -0400
Received: by mail-wm0-f41.google.com with SMTP id t11-v6so28869638wmt.0
        for <git@vger.kernel.org>; Sun, 27 May 2018 22:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cxC9WOi4p1KAEtXKI1F+2maibQQLOu4tNEjy1CcqFZU=;
        b=dN1oFCzYvwTHNoZguVjioXAgDUOnjSIPYVUFyG0oStG7/Fn3b+ltVuE3FGk7oXlINF
         5grjcSt+qnpcEYXXuxXC43pzjgtKq4YBJqFx8Y+Viuy9IxGPoYOjpyErZRNL2VdMGP21
         c8uS/wieXWhjOZs0MPQXPUTRjLYv1KLzZvmOqzg/fNCn7JyUhikCirIU8HrE+nun0sjD
         4kK5WUgF+/yQKhdpR1Rg62aTJzbKvmzhVd8rFK5yRGjKDV0Sv0Kn3oeKIwW4J6H3ERb6
         T6pV8mxg1CRt+g3VMyzDh8ErtYA1Jw7W5/cNFX0GyrtqLH+IU0uBXpUS5iPH4WYGYLYz
         aGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cxC9WOi4p1KAEtXKI1F+2maibQQLOu4tNEjy1CcqFZU=;
        b=FFYfI7iR4f+objm1R52O49XC9LQzdY5m7Q+fv5XyPCvOkjUl3pQhZ45f0eOvqrLoy/
         3wGKW7U5mlW/VSHP3ceEC/x3UlEGm9nG8xwAZ0hliZnTnqS6cUbXzuzxxRbD/M1j9wW8
         V9F6P4cDTplS3BLD8BrstpQWGMb6qfiNBQl1p7zIyH7qdX07fn4Hz2m4GO6vc8Z12DR3
         U6OQ9ijQTTrDu5Kjy43Fx3nCwbITCNuV301eWiIv9PwC1wd9SWnlaT+cJ6fBydgS/5b4
         ZKui5SgsFzF5tMMpR6n9dpsrYKkpQOjPTCan6mOu8zWaCOjMS8nE7E9xwPJVNF4knse4
         XDMg==
X-Gm-Message-State: ALKqPwcbPnam8NQclkjXqKazwg42xIIs4PEmnMfKL5GQKbLY0GwpontD
        d2Wj5IDjohi1jK+Ze68p21TE8ypx
X-Google-Smtp-Source: ADUXVKKILLbzGM1itfZuves+i2ZokWiYWJkHSnZVUbqM+WH6LXAJ1elLfKu1QhzW9vIY37G7hU5mew==
X-Received: by 2002:a1c:374f:: with SMTP id e76-v6mr6923329wma.141.1527486058240;
        Sun, 27 May 2018 22:40:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o2-v6sm10431999wmo.24.2018.05.27.22.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 May 2018 22:40:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/empty-config-section-fix, was Re: What's cooking in git.git (May 2018, #03; Wed, 23)
References: <xmqqwovtudia.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1805251430420.77@tvgsbejvaqbjf.bet>
Date:   Mon, 28 May 2018 14:40:57 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1805251430420.77@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 25 May 2018 14:31:13 +0200 (DST)")
Message-ID: <xmqq36ycl4ly.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Thu, 24 May 2018, Junio C Hamano wrote:
>
>> * js/empty-config-section-fix (2018-05-18) 1 commit
>>  - config: a user-provided invalid section is not a BUG
>> 
>>  Error codepath fix.
>> 
>>  Will merge to 'next'.
>
> As a hotfix, maybe we can fast-track it to master?

Hotfix is a proposed fix for an issue that is so important to be a
showstopper.  This one must be fixed before the final release, but I
do not think it's not that urgent to force us to drop everything
else and merge it to master immediately.

