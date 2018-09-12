Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76BD91F404
	for <e@80x24.org>; Wed, 12 Sep 2018 07:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbeILMQi (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 08:16:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33270 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeILMQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 08:16:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so820719wrc.0
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=60/vnX47m19IxIoSs1McgctdKvBxeXInjGHHWSPnXms=;
        b=QdCo6zsq8m/53VOO7mBtBcC3d/tNcV6/6BX8Ybhic1niI9CjD5JaGF6Lh0Wbe1u7Ll
         sG5NPdMEiKlE+ltY8UOp6XhfKjSrvopkWLlAnZfoc1OoosTFYkN2mWTajHqZkWvsGHNP
         pJlOat39IiZZ1egKlpRtes+hjzzQLvfBhJmJwRnEaleEkM55BEWBm8sCleuPbbvhd3ef
         GVzXA+lRTf2daLCUJf8l/wKDKFYtv4auIJkAVu//U7k2yHdm2UOo88BsZ4d+gLENnDGn
         q9lr45M8djwxzRM4m84+mFYgKeeURKJFh29jc6KoTcjDYoUrS/WvyLg4kBbrENjmmZa5
         U0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=60/vnX47m19IxIoSs1McgctdKvBxeXInjGHHWSPnXms=;
        b=OZf09VjaZnsjrNXwZo0OlQ7mr7eH5pLUnp0mGBaExoKru84OjXVxVmdniJyXIQVMWx
         CeRR2XoCiIkW2BOM5/xetgY9egAhx6M7mV1j85xLSVsWq62N5yVHoWwnACRsx2GlimLP
         En6Mp/VtqlLC7i2QzTzJmU4/NszfY3/79dgTuZKSZGs3OKsZVOeNOC1Wv0EwqWFpD0ao
         sKhKbrn0rdPKbq/Ja9FM3FVTDGP6E59Bggsd4IbIN4dnboXOFfP5Dz5/YAIIcazETCbH
         oiRf7To409Vy0JywJRTTypegsKZQZbOVztEtQ5sHjXUjD582rL6uOuNEucAACuQ9LmpZ
         mu/w==
X-Gm-Message-State: APzg51AeL7E7Aax+b+UGZwirBmV7EBsTh+nvX+Y9hwbO5cG17VLxE4Xs
        Hbq0W5g3NurX/k4urOL7uae7t5pn
X-Google-Smtp-Source: ANB0VdZhQH6JKU0lQtCQeEv3q4I46DjfQ/yL+MNxDElEW/2cfc1CzAv3jcOEDQF6FTHYK4YSXNyAXg==
X-Received: by 2002:a05:6000:108:: with SMTP id o8mr418818wrx.196.1536736405630;
        Wed, 12 Sep 2018 00:13:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z4-v6sm105636wrt.89.2018.09.12.00.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 00:13:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephen & Linda Smith <ischis2@cox.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2018, #02; Tue, 11)
References: <8951536.UanLVthjk7@thunderbird>
Date:   Wed, 12 Sep 2018 00:13:23 -0700
In-Reply-To: <8951536.UanLVthjk7@thunderbird> (Stephen & Linda Smith's message
        of "Tue, 11 Sep 2018 19:36:35 -0700")
Message-ID: <xmqqo9d3mbn0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen & Linda Smith <ischis2@cox.net> writes:

> On Tuesday, September 11, 2018 3:20:19 PM MST Junio C Hamano wrote:
>> 
>> * jc/wt-status-state-cleanup (2018-09-07) 1 commit
>>  - WIP: roll wt_status_state into wt_status and populate in the collect
>> phase (this branch uses ss/wt-status-committable.)
>> 
>> * ss/wt-status-committable (2018-09-07) 4 commits
>>  - wt-status.c: set the committable flag in the collect phase
>>  - t7501: add test of "commit --dry-run --short"
>>  - wt-status: rename commitable to committable
>>  - wt-status.c: move has_unmerged earlier in the file
>>  (this branch is used by jc/wt-status-state-cleanup.)
>> 
>
> I note that the jc/wt-status-state-cleanup branch is a patch "for illustration 
> purposes only" [1].
>
> I was about to update that patch to start dealing with the free() function 
> calls, but noted you added the patch.  Do you want me to take that patch and 
> continue on?  Or does someone else have something in progress?

I do not plan to.  In general, anything that is only in 'pu' is a
fair game---when a better alternative appears, or a discussion leads
to a conclusion that a change is unneeded, they are replaced and/or
discarded.  Just think of them as being kept slightly better record
of existence than merely being in the list archive, nothing more.
