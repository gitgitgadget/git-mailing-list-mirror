Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0172920248
	for <e@80x24.org>; Sun,  7 Apr 2019 13:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfDGNnv (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 09:43:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38376 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbfDGNnu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 09:43:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so11845963wmc.3
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=O+yoRZRKujHBEBfZ3Gd8WO16nAHBahYA9+MT8YOdLd0=;
        b=RMHma3Xe1rrkDZtORMy+21wGw6bo+++ko8QjaQcXSuz17GtUuKWFa9o87hdVuhMCZp
         1+BzsNOHVZ0NP77mkXDoe6xKlvuJHQpUxtiIhkWJ5DGVcclrSdEh931PNX4bHQNRlVCW
         fXHBSmUoiDhpPgymf1gvdnTFs6LlqFjiFUr8X3XVc9LX1Vq1M/yBb8bl9tS84X+/WWTD
         8OcOV81uxp93XFVU+u6m7Bps1wmXTaj3JiJbmT6s6Kb6rcDpRUYPR4JgPPCE1aRT2bdp
         D5WOYQWPZItN/isfmtmeKDI71HVNmgrcs1YelfMQrbk8RK/I2tbTbXaq726UTG4KvlqV
         Pteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=O+yoRZRKujHBEBfZ3Gd8WO16nAHBahYA9+MT8YOdLd0=;
        b=ugIPkMdolLeBhtjG3gHydVZNehDLkhBqFmSlmg2JqxEGsAalUm/rEfJXq1N5BSeQAG
         6nENAd94JXQDTlF3NCyLXrqNoN6Wqt+b/Qtv2VwBdf+Z8KFM32BEFBbkSG/a1IyD4G/W
         0E4tqsi1OcoxK9WdQwD6rgbA3G3fA/QlF0A22TZ+EwO4oVkqeb6E3NXUwuJQxKgWfnVj
         v7B/TVvdwxoGv3C/0PwL2GTl1Yp+33LHtb+CtalcJ9CkHDO1zzZt9lQXc3mOLgPc2UML
         GDUg4vbSTFDndOKDG8rxRHA1485a1odiGko05MA4obhTcGKjC2cFOUrGq4nRWkZg0kEs
         dO+w==
X-Gm-Message-State: APjAAAV4A/H3u0lOOSTbbhd1C+37/idH6A7GHtk8cnd41eOeQ/f3yu53
        X18aLDqe3UagP6e0ixSYydA=
X-Google-Smtp-Source: APXvYqzOvF1ZnPtrH26jU/gKu4aDdNlfPknKpaJR4MGMJ0Z5P8bhoGi7cQz8yd6/aVKBwSonqfrsbg==
X-Received: by 2002:a1c:6587:: with SMTP id z129mr14615855wmb.84.1554644628758;
        Sun, 07 Apr 2019 06:43:48 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x84sm9351402wmg.13.2019.04.07.06.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 06:43:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: git glossary --help ?
References: <05e6a0ad-36ea-e594-f253-ded3e5392375@iee.org>
        <CACsJy8DE4WfbU2y8+__4qD7V5FLodKjxX-bu+seE8mh65q8FYQ@mail.gmail.com>
Date:   Sun, 07 Apr 2019 22:43:47 +0900
In-Reply-To: <CACsJy8DE4WfbU2y8+__4qD7V5FLodKjxX-bu+seE8mh65q8FYQ@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 7 Apr 2019 10:20:28 +0700")
Message-ID: <xmqqlg0mc4mk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Phew... I didn't break anything!
>
> That behavior has been gone since 2c6b6d9f7d (help: make option --help
> open man pages only for Git commands, 2016-08-26). Ralf did not
> mention why he thought "git <concept> --help" was a bad idea. But it
> was considered a bug by Junio [1]
>
> [1] https://public-inbox.org/git/CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com/

I do not think you are reading me correctly.

Yes, I do consider that "git foo --help" that does not say "there is
no subcomand 'foo' in Git suite" is a bug.  But that is only for
'foo' that is clearly meant as a command.

I do not imagine anybody labelling "git help glossary" as a bug.

I am fairly neutral about "git glossary --help".  I personally would
not ask git like so, as "glossary" is clearly not a command name,
and the "--help" option is clearly meant as an option to the
subcommand, which means that the request logically does not make
much sense.

But unlike "git foo --help", if the word that ought to name a
subcommand instead names a known concept, e.g. "glossary", I do not
think it is too bad if we DWIMmed what the user meant to say,
i.e. turning "git glossary --help" into "git help glossary".


