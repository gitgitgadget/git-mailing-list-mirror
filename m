Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C30F20357
	for <e@80x24.org>; Tue, 11 Jul 2017 08:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755444AbdGKI2O (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 04:28:14 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:35398 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754510AbdGKI2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 04:28:10 -0400
Received: by mail-wr0-f169.google.com with SMTP id k67so172149167wrc.2
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 01:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5wjUcQhOQfJlj+y+ktdup/Ilw989zxTkDkyP4kHvo8w=;
        b=sUvfoD6THPTvKqZmA/+fMxMGwGEq3P4qw7GbarchUbiLE3AT/dqRoAM3I5LbELAt5W
         yICkjv8uN/QsG97HL36OhO8CNJm3v/1/QXsPQqXS8fSHS/QvkWAkDNKifzpClZMvHzzM
         c/kmxV3NBrY+R87X8V5FWtplDZ5Jp3QdNUiI6nE8UM6l4HUeiKFEQbB1lR/e3WgjnbWC
         tsKrKUa0cuv2dwWnJejsyKkBmAAbkoLTePvyG6fvhLymm22OVmiJCsEcN9K04/QSCm6n
         eJZuFwQOkVPjsNwWYu+se6Gx01+CyjrWRTqGcB1bzuwQV4P+ztrIa9c/lx4hs62Ftahw
         8K8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5wjUcQhOQfJlj+y+ktdup/Ilw989zxTkDkyP4kHvo8w=;
        b=RPan4ejzveFFnPcLuLbvd4O0WpVrOWTWTjyp6AZJhCJlXqCsL4eLHWJcPhbQgzkMKn
         Ie+xrraac/CsC9LN/Joxa2jbYs1GeuRZJO5IBE03rlg4fEu3OpsPWJ6Gcx1Oq6/4/oZ6
         mS0QFmrsVx8LM3gvrFI5m4uRFTot4WFdtt2mR5AIIUHWI/dQup7am9tImlrNrc9+9ouo
         OEthOtjnzH2/AJxQ1PmBMYMz6PWH3M3Ls7mMC15I/fyxdWpq++n5B3lrTR1IsBS/JEvQ
         eeHGB3ozpdcyHcQwwp1wAFOBUzIl6D2QfQvig+e+o0uzxUhS3DbK3OtZucN95h+pYRz9
         hL3w==
X-Gm-Message-State: AIVw110WTcaIaoK9rl5CWoOFnhK49BGW0r0tFHSRnqkUrhyYtwfvY3R9
        WhQgJQUESTIhW4PhitE=
X-Received: by 10.28.136.129 with SMTP id k123mr10612522wmd.14.1499761689184;
        Tue, 11 Jul 2017 01:28:09 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB4E2D.dip0.t-ipconnect.de. [93.219.78.45])
        by smtp.gmail.com with ESMTPSA id o131sm11374147wmd.26.2017.07.11.01.28.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 01:28:08 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 11 Jul 2017 10:28:08 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <99EB15B6-CAA1-4C78-88B6-C934C8FBD8F8@gmail.com>
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Jul 2017, at 00:48, Junio C Hamano <gitster@pobox.com> wrote:
> 
> * ls/filter-process-delayed (2017-06-30) 7 commits
>  (merged to 'next' on 2017-07-05 at a35e644082)
> + convert: add "status=delayed" to filter process protocol
> + convert: refactor capabilities negotiation
> + convert: move multiple file filter error handling to separate function
> + convert: put the flags field before the flag itself for consistent style
> + t0021: write "OUT <size>" only on success
> + t0021: make debug log file name configurable
> + t0021: keep filter log files on comparison
> 
> The filter-process interface learned to allow a process with long
> latency give a "delayed" response.
> 
> Will merge to 'master'.

Hi Junio,

can you already tell if this topic has still a chance to be part of 2.14?

Thanks,
Lars
