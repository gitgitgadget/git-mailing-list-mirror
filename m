Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C60201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753776AbdGCSUh (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:20:37 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34673 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753408AbdGCSUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 14:20:35 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so23849904pge.1
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 11:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=t5MHdEK0jZtlGRaNXCrFVjCBovZU23RRejzsijFW+NQ=;
        b=d0Bpl+ze1hWdr3b+Dc0DxVWZuIr7wqJ/XhGahnkKc7QkZSgIDO/3rEpMfDDzn96HZO
         +bGhewnqnjGSGLsA6oDa/tZ3rYk/pEi1Ld8WTsScM5bfqfaja4mRnV+NQegUFGxmmeAD
         K7G3Hwc4jbc4umN4se8/NYjAE5OHOSGE5G7zkb+NzaXdTwcKAUHgX0XBpHCMix9mtMS1
         EuHQ0UoIljcoLh04E4AK0THw+p+oi1G/PHlUpwa2EZQBfMZ5aJZxQ+MzCxomqUxyVnNb
         7kNMxFVw591YcQTSCZE+hTKMzd5AGz3IihLFPD7y+V++8UxoHPmlW2vdp9GIo/4WzBoS
         OdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=t5MHdEK0jZtlGRaNXCrFVjCBovZU23RRejzsijFW+NQ=;
        b=m4jQzm07sco/riKJpUsohLXSVphjb6UXq7uatcry3V9Lt6Cv4XV2aZZz3MWH+6y/2O
         6ytcyiodH3cFJiYuzr3hWfzBT1dLL6tgHKesLuXliZbvuJ5itjttFIX+ctN/u47AVmWg
         DH/4xK9BcO4NsoJKgqkb4jGnpLXYPO2jUYsY2DJ3YpF9Ua+JzkGcZbSQ7pVtP8fhnE8O
         t2YAIKrmUPlX6Nb6q8RCXlK0MB3pJbS+jasU0SuQwxRvepJOZdotrriCZhbj0AFkW0uE
         C0W9YddUSwaoyJxdskZOSziZC8wYCEaEZEETy1U4/oc79r3zXd3AkLGyM0NPXpxojkbO
         u19g==
X-Gm-Message-State: AIVw1133T1fYUclkX2R8HByZTwzHPQseK4lj/U8gy4oFBmRil/joPKE8
        IqzgrmP8HqbufA==
X-Received: by 10.101.91.137 with SMTP id i9mr11531445pgr.27.1499106034927;
        Mon, 03 Jul 2017 11:20:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:30:4739:ca21:b5b4])
        by smtp.gmail.com with ESMTPSA id b7sm40484825pfl.44.2017.07.03.11.20.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 11:20:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2017, #09; Fri, 30)
References: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com>
        <4374FA169AD7465AA39BDB477A348B02@PhilipOakley>
Date:   Mon, 03 Jul 2017 11:20:33 -0700
In-Reply-To: <4374FA169AD7465AA39BDB477A348B02@PhilipOakley> (Philip Oakley's
        message of "Sun, 2 Jul 2017 15:26:02 +0100")
Message-ID: <xmqqo9t1l6vi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> Junio,
> Is it possible to include a table of contents that lists the
> integration branches, split by your categories, to help find areas of
> interest?
>
> [Graduated to "master"]
> * topic list
> [New Topics]
> [Stalled]
> [Cooking]
> [Discarded]
>
> The TOC wouldn't need the [] or * markings if that's a problem.

I am not sure what you are asking.  Is this the command you are
looking for?

 $ grep -e "^[[*]" whats-cooking.txt

