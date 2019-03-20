Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1F320248
	for <e@80x24.org>; Wed, 20 Mar 2019 22:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfCTWmm (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 18:42:42 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:45652 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfCTWmm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 18:42:42 -0400
Received: by mail-ed1-f44.google.com with SMTP id m16so3392001edd.12
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=z+HWGkxtsdPOURmazXZ1G8L3hAho/f6R89+hcIGeMYw=;
        b=sA/xbE8jtdT1pVnzz8AxsyT6tECr3YTFXdanP3Cifyz2+ODqAo44SuVB7gYgX8hZRs
         xHbyVkFcLJ3Nz+cb6ItohOtcwKvNRnSikbQ6i0mJh52IWHQHczUzXf1CrzJxtmOj+Wiq
         P5AGeCovjd1pkN773AAcDXi0Xj3POsSDQwMnyq5haf3EECjUKi0pId/5HZ8VmhcHGxYA
         SB4313Ti8c3UVk8aHZcik5tsRa09ZtBn8RN6Gdj0YRA5miyxtEGapwXKybTzSbYQa87H
         Bmk2g7PCfmzuTxstJ4hTuQ2Gfp5xtHTHCVbeRyDzeSlGmfJMSc7Dp5UThHal2IAraLHv
         DaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=z+HWGkxtsdPOURmazXZ1G8L3hAho/f6R89+hcIGeMYw=;
        b=ETkIzFfj7LjF3C5hQrZOR9RH2ujVLtdEbnhqRr8w6+feLNDWzlwjzL4PmzGYsO0p3Q
         F8GkEhcTnZt/TmJKZ2s3Zc8d+lwovGWkaF91f2Pu4a8Bl43+mWi/gJevUG+E2gJdWjNP
         koUb68mX0vrMDWguFE0IcAPvGw6M4YUdFsZpbWnLsP8UUm8RB3Ma6pNDMdnmDp+KzOKh
         nJyyCkIsH6UuOdhtpqefrZdnTFmnNE83xAQZjiLhfU7WWrVl5BoD8oxCjE5OKFSe7FYM
         0EmZcvnwWpcf/vPIZkBSPhUWIznvq3H3lfKdz3iJ2Fl5FusJGk9sUEjw8FRkGYdek1cO
         zZiA==
X-Gm-Message-State: APjAAAV+9pH5mCfoSd0nL82Ll3W/1dNMXGmElElwdtvgxhnIriSG68Oh
        J2yfYrp1v8LOUoztziNxb6upBsh+
X-Google-Smtp-Source: APXvYqzZtq4n3c322vhNGA2MTcpvl1xjClr5sk9uhKiZCVJI0VG7l0PYCvT+f8wsP+8RlRMqAXhW1Q==
X-Received: by 2002:a50:b7b6:: with SMTP id h51mr228850ede.277.1553121760317;
        Wed, 20 Mar 2019 15:42:40 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id k61sm1046540edc.24.2019.03.20.15.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 15:42:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 20 Mar 2019 23:42:39 +0100
Message-ID: <871s31dv6o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 20 2019, Junio C Hamano wrote:

> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.

I have re-rolls & re-submissions of some of my stuff as a WIP, but one
thing that's fallen between the cracks & should be ready for queuing is
my commit-graph segfault bugfix series:

https://public-inbox.org/git/20190314214740.23360-1-avarab@gmail.com/

Thanks!
