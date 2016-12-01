Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2BC11FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 00:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755281AbcLAAHC (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 19:07:02 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36429 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755180AbcLAAHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 19:07:00 -0500
Received: by mail-pg0-f46.google.com with SMTP id f188so87170239pgc.3
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 16:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n3ugbW2nJFGv2YN2MMJN7Q0xBYQKyJd3nZPa52YgcK8=;
        b=ALFiykSXz/FUn+tWL4TYkKsb7eThxdQer1mAZ6cbPlI57Ms9+Hev854EKvihs928iL
         let5WQXkmIO6WghqZEShECqcUfZV5ZBQ/PhC+1DTtjwvGx62kEZs+gcqD/NmODRmO+I9
         Y9apXPQFWo8JYF9d2e0G9vOlFMPrzxgDEb/x5HsqQdUbJbI/VVowuePmqLhRYevRdC+6
         2HXjuuAveNSv6/4sXvQrA/k/ZC/elGZAe5A75P1wGjgUefCqYDsmluXSx+GyA4Grz/qb
         inGzATVEafcMQvIN40bKs4tPkoRb8R4/LZ0Khwsce1PJ/wBl4hTkO7zW2eTAkI4ypdDS
         AmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n3ugbW2nJFGv2YN2MMJN7Q0xBYQKyJd3nZPa52YgcK8=;
        b=hiX9l7+PwTF2daaoqx6rXao8BPvVP1M1IFFkrvjvoMnfQTKaWqUmxBKfrtx6ayDJQd
         gcf31Wbde9wwYWhUdxgAx0Qma05cQLp5UzNxaDPUGGfh/dLFBwUUvxoDl8O3RHpRT29Y
         IhVMMeeYkk5ghqf5oEXQouJmKbLlbGtqO9Ia66okZBzqBzWR/8C59faog7BgO54z962B
         wYssrJBWhGPNJomOX7fR7EfmvP56ZP8vlStMchgSww4hHGkq4o+KppFEJMVKRalAxiud
         THBt6Tu2h/ibEzKvRrmgkM2ngeskcfxXbzLXJW6/uZ6WsV87BRzu//lRaQXawTM3oNOb
         U4wQ==
X-Gm-Message-State: AKaTC03VafFw0rmbsKpdIVIhAWcCRpp5XqgcuOB1OlgkCAHhMEckj+6GqC31z0CcYn5e5CFH
X-Received: by 10.99.109.6 with SMTP id i6mr63534981pgc.139.1480550767998;
        Wed, 30 Nov 2016 16:06:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ddc5:5173:1b11:9434])
        by smtp.gmail.com with ESMTPSA id t21sm105411889pfa.1.2016.11.30.16.06.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 16:06:06 -0800 (PST)
Date:   Wed, 30 Nov 2016 16:06:05 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161201000605.GD192901@google.com>
References: <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
 <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
 <20161130234248.GB192901@google.com>
 <20161130234636.6az7xfywzprpn6ly@sigill.intra.peff.net>
 <20161130235952.4j63gkdlbobjitdb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161130235952.4j63gkdlbobjitdb@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/30, Jeff King wrote:
> So I think there is some other chdir(). I'm not sure if there is an easy
> way to get a backtrace on every call to chdir() in every thread. I'm
> sure somebody more clever than me could figure out how to make gdb do it
> automatically, but it might be workable manually. I think the chdir was
> in the main thread.
> 
> -Peff

Yeah maybe we're missing something else...

How did you run strace with your stress script?

-- 
Brandon Williams
