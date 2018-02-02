Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9111F404
	for <e@80x24.org>; Fri,  2 Feb 2018 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeBBSFl (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 13:05:41 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46694 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753361AbeBBSFd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 13:05:33 -0500
Received: by mail-wr0-f195.google.com with SMTP id g21so23353617wrb.13
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 10:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3oN/H/4Gf/AJhxrm3TVOQ2y4ajLzLb+s/RalM0WtV0s=;
        b=IXsZRWtnmWzbyrngfDWq2X1vkymH8NdDSot+ayl2h5QHUcqzFT1x3gSLogUfTYXCoY
         FyLbyx+HgV3i7Gy8ZArjKn4bwj33mM2aItqE7uBzHFChcVFNkWSpNTRUI87lniLuCEYW
         P3HHJmUFNJgOsG7RXHkHx4KNdsjPAR2jMpx4mMy4FkR3GIF6FBhQmhjokCX7tQ12Czee
         aw74vstqJlPXGtRw9OekfxcjoNzZ4gtLilJMq6g+jZixHTT+hh+P9KQQn4O1wXlAMwex
         RUAMXTxgDEGz9ZnK0OEEnhUXWCMBUpXQOZWYjJ13VcrKSKLmUd6poeshmd0ryT+Uu4Vq
         +Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3oN/H/4Gf/AJhxrm3TVOQ2y4ajLzLb+s/RalM0WtV0s=;
        b=IB2uc7HjAEAbjamJSfM6FWSiO1aC20DH4Bn3E7eaFTiScuc+igmLtOAi8Y0WD0DZlh
         Zr7y+zIPLaZfqZSoazfLrbUj/OVmLtRCkpConAdo78JI/P3E7YlA4FJP/Ayyu0pnbDdu
         Fm6O/pteRCufLliUxPIaLLcJgMSMZzkP+MlLtwDDuIui73smvSaHw0qhPJQ1Ht7O6tIS
         qxWP3U84vrqcGnOJBAOS/ij+/EBkm+Ki1ItKFgM+U7RhXijIqBBaDtjBM/vVI4dPSTz9
         mahyxcsDeLPIL8fozc5JmAyJ7hRwCZl/WAZPtNJFzv0Qusoxg65qLtrcB6Jvgz/mMEtJ
         D+ug==
X-Gm-Message-State: AKwxytcW57VW21/nfZ+PSY/ySBnZruRswDQtNCzkx6MVo4cgy6HofNwX
        t/62OItdq4SIvXdOX6aV0f0=
X-Google-Smtp-Source: AH8x225Z8LomBMHara1EUVd45fzNleao9T7IwKoGdkHzvfELzBlmbtPYiifROxzYEHDQNJd3+48ESQ==
X-Received: by 10.223.156.131 with SMTP id d3mr29969017wre.184.1517594731415;
        Fri, 02 Feb 2018 10:05:31 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y90sm5278716wrc.24.2018.02.02.10.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 10:05:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com>
        <87lggcnc35.fsf@evledraar.gmail.com>
Date:   Fri, 02 Feb 2018 10:05:28 -0800
In-Reply-To: <87lggcnc35.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 01 Feb 2018 13:11:58 +0100")
Message-ID: <xmqq8tcbqnbr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 01 2018, Junio C. Hamano jotted:
>
>> * nd/fix-untracked-cache-invalidation (2018-01-24) 5 commits
>>  - dir.c: stop ignoring opendir() error in open_cached_dir()
>>  - update-index doc: note a fixed bug in the untracked cache
>>  - dir.c: fix missing dir invalidation in untracked code
>>  - dir.c: avoid stat() in valid_cached_dir()
>>  - status: add a failing test showing a core.untrackedCache bug
>>
>>  Some bugs around "untracked cache" feature have been fixed.
>>
>>  Will merge to 'next'.
>
> The "update-index doc: note a fixed bug in the untracked cache" needs to
> be amended so it doesn't say "Before 2.16, ":

True; we could just say "earlier", but I am inclined to suggest that
we get drop it altogether.  Description of historical bugs is of no
interest with the version that already fixes them, so the _only_
value the doc update adds is to tell readers that the untracked
cache feature is still not well proven, and core.untrackedCache may
serve as an escape hatch from its bugs by disabling the mechanism
added for the feature.  I am *not* opposed to a replacement of the
patch that just says something like "This feature has been cause of
bugs even in recent versions of Git, and you may want to disable it
as a workaround when you are hit by an otherwise undiscovered bug in
this area", though.
