Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DECE1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 18:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405178AbfBMSam (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 13:30:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36242 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732461AbfBMSal (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 13:30:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id o17so3676623wrw.3
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 10:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jbr/2DlEeQppHmFMUdZCYS1e2hMFp0Tg+1PHMO033UQ=;
        b=vYbgcIrsIGZdJ/pL36bERD1RGQE915NIoYGQ8PBszUf34gM5FnZ853rEdOzhcvTIfI
         2ksDW+UwrmpSNqz8d3W7RPmwGEwZzbJKgLvB6fXB7M5yqM4JLqcM9J6TGKOF6ACYv7pj
         CkD18t++lbQT1snJ78eaSIDgcXgTEPEAst3SZivmqpbEyuXaDS8GJfgqdUSjQ2ZrcqDA
         GDz7UJaY5D1VwQHzTyvm0VJ2KEwrXH3T7NgRWYtgK7mibJZnk232Le5mifHFQwcU2ZJu
         ByPnmRI3btKlaWHyFf8Cwqpu+LZ8BWrlMNPmQz1Y40+/hvpHpgFq8mImU2e5ijI/FdB8
         Zdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jbr/2DlEeQppHmFMUdZCYS1e2hMFp0Tg+1PHMO033UQ=;
        b=t8MVO/gacL+opYp4m40aS6CB56Ce5udXR9TcvNf+4KvB5z41Wk14vdk+EewLA1c10O
         tYOTUyDtqPGyQv1T2r0QBTol4bhkR3f+ISZ9UQqpy2kIJZk/O7IkXK7lSyMXADwakoME
         44fxqTqurcxrV7HDKMe+SXe1vhteVxtm5SSucKjiOBqt/OzSyhlrOIdDjDRobLWHSqeO
         R6Bt9QLy6B8EeHt9zyErTt3VlrK6AmAHQSjumijzAWlyMivad9imOawSjDVkDl5X6raG
         zTbLGLqgqSxNemXDu7pkhXIIB6MRN4RryfcfUntwRi5cHocVb5efumqhZbja2fxC2pJS
         KOKg==
X-Gm-Message-State: AHQUAuawoKktTYHfYMoSusxKBU1WaqLX4M7ajRSUZlWVhsVM09vHgV66
        8W7/9oA8WpbxPNBUsDcsOmU=
X-Google-Smtp-Source: AHgI3IZeYxBTHKL8gvMW4CvyQXE52P40uYy6zv/A92LyoWQ9GoTFbR8jSq1Lg2CQG0CvAWHWjrBPCQ==
X-Received: by 2002:adf:e9c2:: with SMTP id l2mr1063646wrn.315.1550082638494;
        Wed, 13 Feb 2019 10:30:38 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o2sm10109217wmo.33.2019.02.13.10.30.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 10:30:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v2 2/3] git-submodule.txt: make subcommands underlined
References: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
        <cover.1549965172.git.liu.denton@gmail.com>
        <b0c124d022bfa9a0bbe0c9494df24780b67c8a08.1549965172.git.liu.denton@gmail.com>
        <20190213081518.GA21926@archbookpro.localdomain>
Date:   Wed, 13 Feb 2019 10:30:37 -0800
In-Reply-To: <20190213081518.GA21926@archbookpro.localdomain> (Denton Liu's
        message of "Wed, 13 Feb 2019 00:15:18 -0800")
Message-ID: <xmqq4l97czhu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Tue, Feb 12, 2019 at 01:56:11AM -0800, Denton Liu wrote:
>> In git-remote.txt, the subcommands are underlined. Following that, we
>> also underline the subcommands in git-submodule.txt.
>
> I'd like to retract this patch. I realised that between git-remote,
> git-submodule, git-notes, git-stash, git-bisect, git-reflog, it's pretty
> inconsistent between whether it's formatted with the underline or not.
>
> Also, I missed the underlining of the subcommands in the body of the
> document.

I actually do not think using '<emph>' inside the SYNOPSIS section
is such a great idea to begin with.  We do want `<literal>` mark-up
in the body text to tell the users that it is something they need to
type literally (as opposed to what they can substitute with their
own).

In any case, consistent mark-up in the documentation is good.  But
you would probably want to make it a separate series, either a
preparatory one before real content changes are made, or a cleanup
one after.

Thanks.

